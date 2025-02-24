class SavingsCommitment < ApplicationRecord
  belongs_to :member

  def progress
    (total_contributed / target_amount) * 100
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
