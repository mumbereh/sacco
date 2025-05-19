require "test_helper"

class IndividualAccountReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @individual_account_report = individual_account_reports(:one)
  end

  test "should get index" do
    get individual_account_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_individual_account_report_url
    assert_response :success
  end

  test "should create individual_account_report" do
    assert_difference("IndividualAccountReport.count") do
      post individual_account_reports_url, params: { individual_account_report: { member_id: @individual_account_report.member_id, total_deposits: @individual_account_report.total_deposits, total_loans: @individual_account_report.total_loans, total_transfers: @individual_account_report.total_transfers, total_withdrawals: @individual_account_report.total_withdrawals } }
    end

    assert_redirected_to individual_account_report_url(IndividualAccountReport.last)
  end

  test "should show individual_account_report" do
    get individual_account_report_url(@individual_account_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_individual_account_report_url(@individual_account_report)
    assert_response :success
  end

  test "should update individual_account_report" do
    patch individual_account_report_url(@individual_account_report), params: { individual_account_report: { member_id: @individual_account_report.member_id, total_deposits: @individual_account_report.total_deposits, total_loans: @individual_account_report.total_loans, total_transfers: @individual_account_report.total_transfers, total_withdrawals: @individual_account_report.total_withdrawals } }
    assert_redirected_to individual_account_report_url(@individual_account_report)
  end

  test "should destroy individual_account_report" do
    assert_difference("IndividualAccountReport.count", -1) do
      delete individual_account_report_url(@individual_account_report)
    end

    assert_redirected_to individual_account_reports_url
  end
end
