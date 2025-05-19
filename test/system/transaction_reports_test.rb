require "application_system_test_case"

class TransactionReportsTest < ApplicationSystemTestCase
  setup do
    @transaction_report = transaction_reports(:one)
  end

  test "visiting the index" do
    visit transaction_reports_url
    assert_selector "h1", text: "Transaction reports"
  end

  test "should create transaction report" do
    visit transaction_reports_url
    click_on "New transaction report"

    fill_in "Total balance", with: @transaction_report.total_balance
    fill_in "Total deposits", with: @transaction_report.total_deposits
    fill_in "Total transfers", with: @transaction_report.total_transfers
    fill_in "Total withdrawals", with: @transaction_report.total_withdrawals
    click_on "Create Transaction report"

    assert_text "Transaction report was successfully created"
    click_on "Back"
  end

  test "should update Transaction report" do
    visit transaction_report_url(@transaction_report)
    click_on "Edit this transaction report", match: :first

    fill_in "Total balance", with: @transaction_report.total_balance
    fill_in "Total deposits", with: @transaction_report.total_deposits
    fill_in "Total transfers", with: @transaction_report.total_transfers
    fill_in "Total withdrawals", with: @transaction_report.total_withdrawals
    click_on "Update Transaction report"

    assert_text "Transaction report was successfully updated"
    click_on "Back"
  end

  test "should destroy Transaction report" do
    visit transaction_report_url(@transaction_report)
    click_on "Destroy this transaction report", match: :first

    assert_text "Transaction report was successfully destroyed"
  end
end
