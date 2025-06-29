require "test_helper"

class MemberReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member_report = member_reports(:one)
  end

  test "should get index" do
    get member_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_member_report_url
    assert_response :success
  end

  test "should create member_report" do
    assert_difference("MemberReport.count") do
      post member_reports_url, params: { member_report: { member_id: @member_report.member_id } }
    end

    assert_redirected_to member_report_url(MemberReport.last)
  end

  test "should show member_report" do
    get member_report_url(@member_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_member_report_url(@member_report)
    assert_response :success
  end

  test "should update member_report" do
    patch member_report_url(@member_report), params: { member_report: { member_id: @member_report.member_id } }
    assert_redirected_to member_report_url(@member_report)
  end

  test "should destroy member_report" do
    assert_difference("MemberReport.count", -1) do
      delete member_report_url(@member_report)
    end

    assert_redirected_to member_reports_url
  end
end
