class MemberReport < ApplicationRecord
  belongs_to :member

  def transactions
    member.transactions.order(created_at: :desc)
  end

  def loans
    member.loans.includes(:loan_repayments).order(created_at: :desc)
  end
end
