class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :member
  belongs_to :recipient_account, class_name: "Account", optional: true

  attr_accessor :manual_recipient_account

  validates :account_id, presence: true
  validates :transaction_type, inclusion: { in: %w[deposit withdraw transfer] }
  validates :amount, numericality: { greater_than: 0 }

  validate :sufficient_funds_for_withdrawal, if: -> { withdraw? || transfer? }
  validate :valid_recipient_for_transfer, if: :transfer?

  after_create :process_transaction
  after_create :send_transaction_email

  private

  ## Transaction type checks
  def deposit?
    transaction_type == "deposit"
  end

  def withdraw?
    transaction_type == "withdraw"
  end

  def transfer?
    transaction_type == "transfer"
  end

  ## Ensure minimum remaining balance of 20,000 UGX
  def sufficient_funds_for_withdrawal
    if account.nil? || (account.balance - amount) < 20_000
      errors.add(:amount, "Insufficient funds. Minimum balance of UGX 20,000 must remain after the transaction.")
    end
  end

  ## Validate recipient account (manual or selected)
  def valid_recipient_for_transfer
    if recipient_account.nil? && manual_recipient_account.blank?
      errors.add(:recipient_account_id, "Please select or provide a recipient account.")
    elsif recipient_account.present? && recipient_account == account
      errors.add(:recipient_account_id, "You cannot transfer to the same account.")
    end
  end

  ## Process transaction based on type
  def process_transaction
    case transaction_type
    when "deposit"
      process_deposit!
    when "withdraw"
      process_withdraw!
    when "transfer"
      process_transfer!
    end
  end

  ## Deposit logic
  def process_deposit!
    account.increment!(:balance, amount)
  end

  ## Withdrawal logic
  def process_withdraw!
    account.decrement!(:balance, amount)
  end

  ## Transfer logic (with fallback for manual)
  def process_transfer!
    ActiveRecord::Base.transaction do
      account.decrement!(:balance, amount)

      if recipient_account.present?
        recipient_account.increment!(:balance, amount)
      elsif manual_recipient_account.present?
        Rails.logger.info("Manual recipient provided: #{manual_recipient_account}")
        # Optionally create a pending/manual review record here
      end
    end
  end

  ## Send confirmation email to member
  def send_transaction_email
    TransactionMailer.transaction_email(member, self).deliver_later
  end
end
