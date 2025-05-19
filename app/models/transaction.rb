class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :member
  belongs_to :recipient_account, class_name: "Account", optional: true
  has_many :reports, as: :reportable

  attr_accessor :manual_recipient_account

  validates :account_id, presence: true
  validates :transaction_type, inclusion: { in: %w[deposit withdraw transfer] }
  validates :amount, numericality: { greater_than: 0 }, presence: true

  validate :sufficient_funds_for_withdrawal, if: -> { withdraw? || transfer? }
  validate :valid_recipient_for_transfer, if: :transfer?

  after_create :process_transaction
  after_create :send_transaction_email

  before_update :prevent_update

  def deposit?
    transaction_type == "deposit"
  end

  def withdraw?
    transaction_type == "withdraw"
  end

  def transfer?
    transaction_type == "transfer"
  end

  def sufficient_funds_for_withdrawal
    return if account.nil? || amount.nil?

    if (account.balance.to_d - amount.to_d) < 20_000
      errors.add(:amount, "Insufficient funds. Minimum balance of UGX 20,000 must remain after the transaction.")
    end
  end

  def valid_recipient_for_transfer
    if recipient_account.nil? && manual_recipient_account.blank?
      errors.add(:recipient_account_id, "Please select or provide a recipient account.")
    elsif recipient_account.present? && recipient_account == account
      errors.add(:recipient_account_id, "You cannot transfer to the same account.")
    end
  end

  def process_transaction
    case transaction_type
    when "deposit"
      process_deposit!
    when "withdraw"
      process_withdraw!
    when "transfer"
      process_transfer!
    end

    update_column(:balance_after_transaction, account.reload.balance)
  end

  def process_deposit!
    account.increment!(:balance, amount)
  end

  def process_withdraw!
    account.decrement!(:balance, amount)
  end

  def process_transfer!
    ActiveRecord::Base.transaction do
      sender = account
      receiver = recipient_account

      raise ActiveRecord::Rollback, "Sender or Receiver account missing" unless sender && receiver

      # Decrease sender balance
      sender_new_balance = sender.balance.to_d - amount.to_d
      sender.update!(balance: sender_new_balance)
      update_column(:balance_after_transaction, sender_new_balance)

      # Increase receiver balance (only update balance directly)
      receiver_new_balance = receiver.balance.to_d + amount.to_d
      receiver.update!(balance: receiver_new_balance)

      # Create mirror transaction WITHOUT triggering callbacks
      Transaction.skip_callback(:create, :after, :process_transaction)
      Transaction.skip_callback(:create, :after, :send_transaction_email)

      Transaction.create!(
        account: receiver,
        member: receiver.member,
        transaction_type: "deposit",
        amount: amount,
        balance_after_transaction: receiver_new_balance,
        manual_recipient_account: nil
      )

      Transaction.set_callback(:create, :after, :process_transaction)
      Transaction.set_callback(:create, :after, :send_transaction_email)
    end
  end

  def prevent_update
    raise ActiveRecord::ReadOnlyRecord, "Transactions cannot be modified after creation"
  end

  def send_transaction_email
    TransactionMailer.transaction_email(self).deliver_later
  end
end
