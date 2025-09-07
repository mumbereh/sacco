require "test_helper"

class LoanReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loan_report = loan_reports(:one)
  end

  test "should get index" do
    get loan_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_loan_report_url
    assert_response :success
  end

  test "should create loan_report" do
    assert_difference("LoanReport.count") do
      post loan_reports_url, params: { loan_report: { amount: @loan_report.amount, approval_status: @loan_report.approval_status, interest_rate: @loan_report.interest_rate, loan_id: @loan_report.loan_id, member_name: @loan_report.member_name, outstanding_balance: @loan_report.outstanding_balance, repayment_status: @loan_report.repayment_status, status: @loan_report.status, total_amount_after_deduction: @loan_report.total_amount_after_deduction, total_repaid: @loan_report.total_repaid } }
    end

    assert_redirected_to loan_report_url(LoanReport.last)
  end

  test "should show loan_report" do
    get loan_report_url(@loan_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_loan_report_url(@loan_report)
    assert_response :success
  end

  test "should update loan_report" do
    patch loan_report_url(@loan_report), params: { loan_report: { amount: @loan_report.amount, approval_status: @loan_report.approval_status, interest_rate: @loan_report.interest_rate, loan_id: @loan_report.loan_id, member_name: @loan_report.member_name, outstanding_balance: @loan_report.outstanding_balance, repayment_status: @loan_report.repayment_status, status: @loan_report.status, total_amount_after_deduction: @loan_report.total_amount_after_deduction, total_repaid: @loan_report.total_repaid } }
    assert_redirected_to loan_report_url(@loan_report)
  end

  test "should destroy loan_report" do
    assert_difference("LoanReport.count", -1) do
      delete loan_report_url(@loan_report)
    end

    assert_redirected_to loan_reports_url
  end
end
