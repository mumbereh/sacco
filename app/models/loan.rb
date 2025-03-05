class Loan < ApplicationRecord
  belongs_to :member

  # Fields that must be provided
  REQUIRED_FIELDS = %i[amount status loan_type payment_period].freeze

  # Callbacks to set default interest rate and calculate totals
  before_validation :set_interest_rate, on: :create
  before_save :calculate_totals

  # Validations to ensure correct data
  validates :amount, numericality: { greater_than: 0, message: "must be greater than zero" }
  validates :interest_rate, numericality: { equal_to: 3, message: "must be exactly 3%" }
  validates :status, inclusion: { in: %w[pending approved rejected repaid], message: "must be a valid loan status" }
  validates :loan_type, inclusion: { in: ["Business Loan", "School Loan", "Land/House Purchase", "Salary Loan", "Emergency Loan", "Others"], message: "must be a valid loan type" }
  validates :payment_period, numericality: { greater_than: 0, message: "must be greater than zero" }

  # Approve a loan
  def approve!
    update(status: "approved")
  end

  # Reject a loan
  def reject!
    update(status: "rejected")
  end

  # Repay a portion of the loan
  def repay(payment_amount)
    if payment_amount.positive? && payment_amount <= amount
      update(amount: amount - payment_amount)
      update(status: "repaid") if amount.zero?
    else
      errors.add(:amount, "Invalid repayment amount")
    end
  end

  private

  # Set the default interest rate to 3%
  def set_interest_rate
    self.interest_rate ||= 3
  end

  # Calculate total loan repayment details
  def calculate_totals
    return if amount.nil? || payment_period.nil? || interest_rate.nil?

    interest_amount = (amount * interest_rate / 100.0) * (payment_period / 12.0)
    self.total_amount_after_deduction = amount + interest_amount
    self.monthly_installment_payment = total_amount_after_deduction / payment_period
  end
end
