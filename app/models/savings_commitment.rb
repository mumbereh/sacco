class SavingsCommitment < ApplicationRecord
  belongs_to :member

  REQUIRED_FIELDS = %i[target_amount total_contributed].freeze

  validates *REQUIRED_FIELDS, numericality: { greater_than_or_equal_to: 0, message: "must be a positive amount" }

  def progress
    (total_contributed.to_f / target_amount) * 100
  end

  def contribute(amount)
    if amount.positive?
      update(total_contributed: total_contributed + amount)
      update(status: "completed") if total_contributed >= target_amount
    else
      errors.add(:total_contributed, "Invalid contribution amount")
    end
  end
end