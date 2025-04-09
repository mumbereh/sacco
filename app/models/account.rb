class Account < ApplicationRecord
  belongs_to :member

  REQUIRED_DEPOSIT = 200_000
  MEMBERSHIP_FEE = 50_000
  T_SHIRT_FEE = 30_000
  WELFARE_FEE = 20_000
  SHARE_PRICE = 100_000

  validates :account_type, presence: true
  validates :deposit, numericality: { equal_to: REQUIRED_DEPOSIT, message: "Total deposit must be exactly UGX 200,000" }  # Changed to deposit
  validates :account_number, presence: true, uniqueness: { message: "This account number is already assigned" }
  validates :member_id, uniqueness: { message: "Each member can have only one account" }

  before_validation :generate_account_number, on: :create
  before_create :set_initial_balance

  private

  def generate_account_number
    return if account_number.present?

    last_account = Account.order(account_number: :desc).first
    last_number = last_account.present? ? last_account.account_number.split('-').last.to_i : 0
    next_number = last_number + 1
    self.account_number = "KUDS-" + next_number.to_s.rjust(3, '0')
  end

  def set_initial_balance
    self.balance ||= deposit  # Changed to deposit
  end
end
