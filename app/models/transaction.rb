class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :member
  belongs_to :recipient_account, class_name: "Account", optional: true

  REQUIRED_FIELDS = %i[transaction_type amount].freeze

  validates *REQUIRED_FIELDS, presence: true
  validates :transaction_type, inclusion: { in: ["deposit", "withdraw", "transfer"], message: "must be a valid transaction type" }
  validates :amount, numericality: { greater_than: 0, message: "must be a positive amount" }
  validate :sufficient_funds_for_withdrawal, if: -> { transaction_type.in?(["withdraw", "transfer"]) }
  validate :valid_recipient_for_transfer, if: -> { transaction_type == "transfer" }

  after_create :update_balance

  private

  def update_balance
    case transaction_type
    when "deposit"
      account.increment!(:balance, amount)
    when "withdraw"
      account.decrement!(:balance, amount)
    when "transfer"
      ActiveRecord::Base.transaction do
        account.decrement!(:balance, amount)
        recipient_account.increment!(:balance, amount)
      end
    end
  end

  def sufficient_funds_for_withdrawal
    errors.add(:amount, "Insufficient funds") if account.balance < amount
  end

  def valid_recipient_for_transfer
    if recipient_account.nil?
      errors.add(:recipient_account, "Recipient account must be specified for transfers")
    elsif recipient_account == account
      errors.add(:recipient_account, "Cannot transfer to the same account")
    end
  end
end
