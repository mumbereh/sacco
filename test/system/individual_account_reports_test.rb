require "application_system_test_case"

class IndividualAccountReportsTest < ApplicationSystemTestCase
  setup do
    @individual_account_report = individual_account_reports(:one)
  end

  test "visiting the index" do
    visit individual_account_reports_url
    assert_selector "h1", text: "Individual account reports"
  end

  test "should create individual account report" do
    visit individual_account_reports_url
    click_on "New individual account report"

    fill_in "Member", with: @individual_account_report.member_id
    fill_in "Total deposits", with: @individual_account_report.total_deposits
    fill_in "Total loans", with: @individual_account_report.total_loans
    fill_in "Total transfers", with: @individual_account_report.total_transfers
    fill_in "Total withdrawals", with: @individual_account_report.total_withdrawals
    click_on "Create Individual account report"

    assert_text "Individual account report was successfully created"
    click_on "Back"
  end

  test "should update Individual account report" do
    visit individual_account_report_url(@individual_account_report)
    click_on "Edit this individual account report", match: :first

    fill_in "Member", with: @individual_account_report.member_id
    fill_in "Total deposits", with: @individual_account_report.total_deposits
    fill_in "Total loans", with: @individual_account_report.total_loans
    fill_in "Total transfers", with: @individual_account_report.total_transfers
    fill_in "Total withdrawals", with: @individual_account_report.total_withdrawals
    click_on "Update Individual account report"

    assert_text "Individual account report was successfully updated"
    click_on "Back"
  end

  test "should destroy Individual account report" do
    visit individual_account_report_url(@individual_account_report)
    click_on "Destroy this individual account report", match: :first

    assert_text "Individual account report was successfully destroyed"
  end
end
