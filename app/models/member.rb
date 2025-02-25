class Member < ApplicationRecord
  validates :surname, :given_name, :date_of_birth, :phone, :id_number, :membership_type, presence: true

  validates :gender, inclusion: { in: %w[male female others] }
  # Remove or correct the nationality validation:
  validates :mother_nationality, :father_nationality, inclusion: { in: %w[Uganda Others] }
  validates :membership_type, inclusion: { in: %w[Share Loan] }
  validates :marital_status, inclusion: { in: %w[single married widow widowed others] }
  validates :identification_type, inclusion: { in: ["National Id", "Driver’s License", "Passport"] }

  def full_name
    [surname, given_name, other_name].compact.join(" ")
  end

  def formatted_address
    "#{physical_address}, #{phone}"
  end
end

  