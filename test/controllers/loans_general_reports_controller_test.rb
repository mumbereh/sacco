require "test_helper"

class LoansGeneralReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loans_general_report = loans_general_reports(:one)
  end

  test "should get index" do
    get loans_general_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_loans_general_report_url
    assert_response :success
  end

  test "should create loans_general_report" do
    assert_difference("LoansGeneralReport.count") do
      post loans_general_reports_url, params: { loans_general_report: { account_number: @loans_general_report.account_number, cleared_loans: @loans_general_report.cleared_loans, member_name: @loans_general_report.member_name, uncleared_loans: @loans_general_report.uncleared_loans } }
    end

    assert_redirected_to loans_general_report_url(LoansGeneralReport.last)
  end

  test "should show loans_general_report" do
    get loans_general_report_url(@loans_general_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_loans_general_report_url(@loans_general_report)
    assert_response :success
  end

  test "should update loans_general_report" do
    patch loans_general_report_url(@loans_general_report), params: { loans_general_report: { account_number: @loans_general_report.account_number, cleared_loans: @loans_general_report.cleared_loans, member_name: @loans_general_report.member_name, uncleared_loans: @loans_general_report.uncleared_loans } }
    assert_redirected_to loans_general_report_url(@loans_general_report)
  end

  test "should destroy loans_general_report" do
    assert_difference("LoansGeneralReport.count", -1) do
      delete loans_general_report_url(@loans_general_report)
    end

    assert_redirected_to loans_general_reports_url
  end
end
