class Account < ApplicationRecord
  belongs_to :member

  REQUIRED_FIELDS = %i[account_type principal_amount deposit account_number balance].freeze

  validates :account_type, presence: true
  validates :principal_amount, numericality: { equal_to: 20_000, message: "must be exactly 20,000/=" }
  validates :deposit, numericality: { greater_than_or_equal_to: 0, message: "must be a positive amount" }
  validates :account_number, presence: true, uniqueness: true
  validate :validate_deposit_against_principal

  before_validation :generate_account_number, on: :create
  before_create :set_initial_balance

  private

  def generate_account_number
    self.account_number ||= "KUDGS" + rand(100_000..999_999).to_s
  end

  def validate_deposit_against_principal
    errors.add(:deposit, "must be at least 20,000/= to open an account") if deposit < principal_amount
  end

  def set_initial_balance
    self.balance ||= deposit
  end
end
