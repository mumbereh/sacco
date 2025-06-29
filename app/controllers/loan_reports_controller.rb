require 'ostruct'

class LoanReportsController < ApplicationController
  def index
    @loan_reports = Loan.includes(:member).map do |loan|
      OpenStruct.new(
        id: loan.id,
        loan: loan,
        member_name: loan.member.full_name,
        amount: loan.amount,
        interest_rate: loan.interest_rate,
        total_amount_after_deduction: loan.total_amount_after_deduction,
        repayment_status: loan.repayment_status,
        approval_status: loan.approval_status,
        status: loan.status,
        total_repaid: loan.total_repaid,
        outstanding_balance: loan.outstanding_balance
      )
    end
  end
end
