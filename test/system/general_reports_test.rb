require "application_system_test_case"

class GeneralReportsTest < ApplicationSystemTestCase
  setup do
    @general_report = general_reports(:one)
  end

  test "visiting the index" do
    visit general_reports_url
    assert_selector "h1", text: "General reports"
  end

  test "should create general report" do
    visit general_reports_url
    click_on "New general report"

    fill_in "Cleared loans", with: @general_report.cleared_loans
    fill_in "Deposit balance", with: @general_report.deposit_balance
    fill_in "Total deposits", with: @general_report.total_deposits
    fill_in "Total transfers", with: @general_report.total_transfers
    fill_in "Total withdrawals", with: @general_report.total_withdrawals
    fill_in "Uncleared loans", with: @general_report.uncleared_loans
    click_on "Create General report"

    assert_text "General report was successfully created"
    click_on "Back"
  end

  test "should update General report" do
    visit general_report_url(@general_report)
    click_on "Edit this general report", match: :first

    fill_in "Cleared loans", with: @general_report.cleared_loans
    fill_in "Deposit balance", with: @general_report.deposit_balance
    fill_in "Total deposits", with: @general_report.total_deposits
    fill_in "Total transfers", with: @general_report.total_transfers
    fill_in "Total withdrawals", with: @general_report.total_withdrawals
    fill_in "Uncleared loans", with: @general_report.uncleared_loans
    click_on "Update General report"

    assert_text "General report was successfully updated"
    click_on "Back"
  end

  test "should destroy General report" do
    visit general_report_url(@general_report)
    click_on "Destroy this general report", match: :first

    assert_text "General report was successfully destroyed"
  end
end
