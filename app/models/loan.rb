class Loan < ApplicationRecord
  belongs_to :member

  REQUIRED_FIELDS = %i[amount status loan_type payment_period].freeze

  before_validation :set_interest_rate, on: :create
  before_save :calculate_totals
  before_save :update_approval_status

  validates :amount, numericality: { greater_than: 0, message: "must be greater than zero" }
  validates :interest_rate, numericality: { equal_to: 3, message: "must be exactly 3%" }
  validates :status, inclusion: { in: %w[pending approved rejected repaid processing], message: "must be a valid loan status" }
  validates :loan_type, inclusion: { in: ["Business Loan", "School Loan", "Land/House Purchase", "Salary Loan", "Emergency Loan", "Others"], message: "must be a valid loan type" }
  validates :payment_period, numericality: { greater_than: 0, message: "must be greater than zero" }

  enum approval_status: { pending: 0, loan_officer: 1, secretary: 2, chairperson: 3, approved: 4, rejected: 5 }

  after_update :send_notification, if: :saved_change_to_status?

  # Public helper methods for the view
  def loan_officer_approved?
    approval_status == "loan_officer"
  end

  def secretary_approved?
    approval_status == "secretary"
  end

  def chairperson_approved?
    approval_status == "chairperson"
  end

  def approve_by_officer(officer)
    case officer
    when :loan_officer
      update(approval_status: :loan_officer) unless loan_officer_approved?
    when :secretary
      update(approval_status: :secretary) if loan_officer_approved?
    when :chairperson
      if secretary_approved?
        update(approval_status: :chairperson)
        finalize_approval if chairperson_approved?
      end
    end
  end

  private

  def finalize_approval
    update(status: "approved", approval_status: :approved)
  end

  def send_notification
    MemberMailer.loan_status_updated(self.member).deliver_now
  end

  def calculate_totals
    return if amount.nil? || payment_period.nil? || interest_rate.nil?

    interest_amount = (amount * interest_rate / 100.0) * (payment_period / 12.0)
    self.total_amount_after_deduction = amount + interest_amount
    self.monthly_installment_payment = total_amount_after_deduction / payment_period
  end

  def set_interest_rate
    self.interest_rate ||= 3
  end

  def update_approval_status
    self.status = "processing" if approval_status_changed? && approval_status == "loan_officer"
  end
end
