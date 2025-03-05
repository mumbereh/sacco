class Account < ApplicationRecord
  belongs_to :member
  has_many :deposits, dependent: :destroy

  REQUIRED_FIELDS = %i[account_type principal_amount deposit account_number balance].freeze

  validates :account_type, presence: true
  validates :principal_amount, numericality: { equal_to: 20_000, message: "must be exactly 20,000/=" }
  validates :deposit, numericality: { greater_than_or_equal_to: 0, message: "must be a positive amount" }
  
  validates :account_number, presence: true, uniqueness: { message: "This account number is already assigned to a member" }
  validates :member_id, uniqueness: { message: "Each member can have only one account" }

  before_validation :generate_account_number, on: :create
  before_create :set_initial_balance

  private

  def generate_account_number
    return if account_number.present? # Ensure the account number remains fixed once assigned
    # Find the highest account number and increment it
    last_account = Account.order(account_number: :desc).first
    last_number = last_account.present? ? last_account.account_number.split('-').last.to_i : 0
    next_number = last_number + 1
    self.account_number = "KUDS-" + next_number.to_s.rjust(3, '0')
  end

  def validate_deposit_against_principal
    if deposit < principal_amount
      errors.add(:deposit, "must be at least 20,000/= to open an account")
    end
  end

  def set_initial_balance
    self.balance ||= deposit
  end
end

