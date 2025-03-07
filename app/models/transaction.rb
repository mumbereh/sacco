class Transaction < ApplicationRecord
  belongs_to :account, optional: false
  belongs_to :member
  belongs_to :recipient_account, class_name: "Account", optional: true

  # Virtual attribute to capture manual recipient entry
  attr_accessor :manual_recipient_account

  validates :account_id, presence: { message: "Account must be selected" }
  validates :transaction_type, inclusion: { in: ["deposit", "withdraw", "transfer"], message: "must be a valid transaction type" }
  validates :amount, numericality: { greater_than: 0, message: "must be a positive amount" }
  
  # For withdraw and transfer, check that sufficient funds remain (including a non-withdrawable 20,000)
  validate :sufficient_funds_for_withdrawal, if: -> { transaction_type.in?(["withdraw", "transfer"]) }
  validate :valid_recipient_for_transfer, if: -> { transaction_type == "transfer" }

  after_create :update_balance
  after_create :send_transaction_email

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
        if recipient_account.present?
          recipient_account.increment!(:balance, amount)
        elsif manual_recipient_account.present?
          Rails.logger.info "Manual recipient account provided: #{manual_recipient_account}"
        end
      end
    end
  end

  def sufficient_funds_for_withdrawal
    # Ensure that after subtracting the transaction amount, at least 20,000 remains in the account.
    if account.nil? || (account.balance - amount) < 20000
      errors.add(:amount, "Insufficient funds. A minimum balance of 20,000 must remain in the account.")
    end
  end

  def valid_recipient_for_transfer
    if recipient_account.nil? && manual_recipient_account.blank?
      errors.add(:recipient_account, "Recipient account must be specified for transfers")
    elsif recipient_account.present? && account == recipient_account
      errors.add(:recipient_account, "Cannot transfer to the same account")
    end
  end

  def send_transaction_email
    TransactionMailer.transaction_email(member, self).deliver_later
  end
end
