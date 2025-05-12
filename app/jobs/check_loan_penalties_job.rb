class CheckLoanPenaltiesJob < ApplicationJob
  queue_as :default

  def perform
    LoanRepayment.where(status: "pending").find_each do |repayment|
      repayment.apply_penalty_if_overdue!
    end
  end
end
