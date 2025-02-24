require "application_system_test_case"

class SavingsCommitmentsTest < ApplicationSystemTestCase
  setup do
    @savings_commitment = savings_commitments(:one)
  end

  test "visiting the index" do
    visit savings_commitments_url
    assert_selector "h1", text: "Savings commitments"
  end

  test "should create savings commitment" do
    visit savings_commitments_url
    click_on "New savings commitment"

    fill_in "Member", with: @savings_commitment.member_id
    fill_in "Monthly contribution", with: @savings_commitment.monthly_contribution
    fill_in "Status", with: @savings_commitment.status
    fill_in "Target amount", with: @savings_commitment.target_amount
    click_on "Create Savings commitment"

    assert_text "Savings commitment was successfully created"
    click_on "Back"
  end

  test "should update Savings commitment" do
    visit savings_commitment_url(@savings_commitment)
    click_on "Edit this savings commitment", match: :first

    fill_in "Member", with: @savings_commitment.member_id
    fill_in "Monthly contribution", with: @savings_commitment.monthly_contribution
    fill_in "Status", with: @savings_commitment.status
    fill_in "Target amount", with: @savings_commitment.target_amount
    click_on "Update Savings commitment"

    assert_text "Savings commitment was successfully updated"
    click_on "Back"
  end

  test "should destroy Savings commitment" do
    visit savings_commitment_url(@savings_commitment)
    click_on "Destroy this savings commitment", match: :first

    assert_text "Savings commitment was successfully destroyed"
  end
end
