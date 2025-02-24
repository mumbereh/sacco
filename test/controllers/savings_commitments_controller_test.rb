require "test_helper"

class SavingsCommitmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @savings_commitment = savings_commitments(:one)
  end

  test "should get index" do
    get savings_commitments_url
    assert_response :success
  end

  test "should get new" do
    get new_savings_commitment_url
    assert_response :success
  end

  test "should create savings_commitment" do
    assert_difference("SavingsCommitment.count") do
      post savings_commitments_url, params: { savings_commitment: { member_id: @savings_commitment.member_id, monthly_contribution: @savings_commitment.monthly_contribution, status: @savings_commitment.status, target_amount: @savings_commitment.target_amount } }
    end

    assert_redirected_to savings_commitment_url(SavingsCommitment.last)
  end

  test "should show savings_commitment" do
    get savings_commitment_url(@savings_commitment)
    assert_response :success
  end

  test "should get edit" do
    get edit_savings_commitment_url(@savings_commitment)
    assert_response :success
  end

  test "should update savings_commitment" do
    patch savings_commitment_url(@savings_commitment), params: { savings_commitment: { member_id: @savings_commitment.member_id, monthly_contribution: @savings_commitment.monthly_contribution, status: @savings_commitment.status, target_amount: @savings_commitment.target_amount } }
    assert_redirected_to savings_commitment_url(@savings_commitment)
  end

  test "should destroy savings_commitment" do
    assert_difference("SavingsCommitment.count", -1) do
      delete savings_commitment_url(@savings_commitment)
    end

    assert_redirected_to savings_commitments_url
  end
end
