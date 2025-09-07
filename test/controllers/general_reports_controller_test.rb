require "test_helper"

class GeneralReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @general_report = general_reports(:one)
  end

  test "should get index" do
    get general_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_general_report_url
    assert_response :success
  end

  test "should create general_report" do
    assert_difference("GeneralReport.count") do
      post general_reports_url, params: { general_report: { cleared_loans: @general_report.cleared_loans, deposit_balance: @general_report.deposit_balance, total_deposits: @general_report.total_deposits, total_transfers: @general_report.total_transfers, total_withdrawals: @general_report.total_withdrawals, uncleared_loans: @general_report.uncleared_loans } }
    end

    assert_redirected_to general_report_url(GeneralReport.last)
  end

  test "should show general_report" do
    get general_report_url(@general_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_general_report_url(@general_report)
    assert_response :success
  end

  test "should update general_report" do
    patch general_report_url(@general_report), params: { general_report: { cleared_loans: @general_report.cleared_loans, deposit_balance: @general_report.deposit_balance, total_deposits: @general_report.total_deposits, total_transfers: @general_report.total_transfers, total_withdrawals: @general_report.total_withdrawals, uncleared_loans: @general_report.uncleared_loans } }
    assert_redirected_to general_report_url(@general_report)
  end

  test "should destroy general_report" do
    assert_difference("GeneralReport.count", -1) do
      delete general_report_url(@general_report)
    end

    assert_redirected_to general_reports_url
  end
end
