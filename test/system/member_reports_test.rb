require "application_system_test_case"

class MemberReportsTest < ApplicationSystemTestCase
  setup do
    @member_report = member_reports(:one)
  end

  test "visiting the index" do
    visit member_reports_url
    assert_selector "h1", text: "Member reports"
  end

  test "should create member report" do
    visit member_reports_url
    click_on "New member report"

    fill_in "Member", with: @member_report.member_id
    click_on "Create Member report"

    assert_text "Member report was successfully created"
    click_on "Back"
  end

  test "should update Member report" do
    visit member_report_url(@member_report)
    click_on "Edit this member report", match: :first

    fill_in "Member", with: @member_report.member_id
    click_on "Update Member report"

    assert_text "Member report was successfully updated"
    click_on "Back"
  end

  test "should destroy Member report" do
    visit member_report_url(@member_report)
    click_on "Destroy this member report", match: :first

    assert_text "Member report was successfully destroyed"
  end
end
