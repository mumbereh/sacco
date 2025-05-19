require "application_system_test_case"

class LoansGeneralReportsTest < ApplicationSystemTestCase
  setup do
    @loans_general_report = loans_general_reports(:one)
  end

  test "visiting the index" do
    visit loans_general_reports_url
    assert_selector "h1", text: "Loans general reports"
  end

  test "should create loans general report" do
    visit loans_general_reports_url
    click_on "New loans general report"

    fill_in "Account number", with: @loans_general_report.account_number
    fill_in "Cleared loans", with: @loans_general_report.cleared_loans
    fill_in "Member name", with: @loans_general_report.member_name
    fill_in "Uncleared loans", with: @loans_general_report.uncleared_loans
    click_on "Create Loans general report"

    assert_text "Loans general report was successfully created"
    click_on "Back"
  end

  test "should update Loans general report" do
    visit loans_general_report_url(@loans_general_report)
    click_on "Edit this loans general report", match: :first

    fill_in "Account number", with: @loans_general_report.account_number
    fill_in "Cleared loans", with: @loans_general_report.cleared_loans
    fill_in "Member name", with: @loans_general_report.member_name
    fill_in "Uncleared loans", with: @loans_general_report.uncleared_loans
    click_on "Update Loans general report"

    assert_text "Loans general report was successfully updated"
    click_on "Back"
  end

  test "should destroy Loans general report" do
    visit loans_general_report_url(@loans_general_report)
    click_on "Destroy this loans general report", match: :first

    assert_text "Loans general report was successfully destroyed"
  end
end
