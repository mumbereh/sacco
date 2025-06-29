require "application_system_test_case"

class LoanReportsTest < ApplicationSystemTestCase
  setup do
    @loan_report = loan_reports(:one)
  end

  test "visiting the index" do
    visit loan_reports_url
    assert_selector "h1", text: "Loan reports"
  end

  test "should create loan report" do
    visit loan_reports_url
    click_on "New loan report"

    fill_in "Amount", with: @loan_report.amount
    fill_in "Approval status", with: @loan_report.approval_status
    fill_in "Interest rate", with: @loan_report.interest_rate
    fill_in "Loan", with: @loan_report.loan_id
    fill_in "Member name", with: @loan_report.member_name
    fill_in "Outstanding balance", with: @loan_report.outstanding_balance
    fill_in "Repayment status", with: @loan_report.repayment_status
    fill_in "Status", with: @loan_report.status
    fill_in "Total amount after deduction", with: @loan_report.total_amount_after_deduction
    fill_in "Total repaid", with: @loan_report.total_repaid
    click_on "Create Loan report"

    assert_text "Loan report was successfully created"
    click_on "Back"
  end

  test "should update Loan report" do
    visit loan_report_url(@loan_report)
    click_on "Edit this loan report", match: :first

    fill_in "Amount", with: @loan_report.amount
    fill_in "Approval status", with: @loan_report.approval_status
    fill_in "Interest rate", with: @loan_report.interest_rate
    fill_in "Loan", with: @loan_report.loan_id
    fill_in "Member name", with: @loan_report.member_name
    fill_in "Outstanding balance", with: @loan_report.outstanding_balance
    fill_in "Repayment status", with: @loan_report.repayment_status
    fill_in "Status", with: @loan_report.status
    fill_in "Total amount after deduction", with: @loan_report.total_amount_after_deduction
    fill_in "Total repaid", with: @loan_report.total_repaid
    click_on "Update Loan report"

    assert_text "Loan report was successfully updated"
    click_on "Back"
  end

  test "should destroy Loan report" do
    visit loan_report_url(@loan_report)
    click_on "Destroy this loan report", match: :first

    assert_text "Loan report was successfully destroyed"
  end
end
