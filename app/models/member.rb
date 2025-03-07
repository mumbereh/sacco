class Member < ApplicationRecord
  has_one_attached :passport_photo
  has_one_attached :id_document_photo
  has_one :account, dependent: :destroy

  REQUIRED_FIELDS = %i[
    surname given_name date_of_birth phone email id_number membership_type
    marital_status physical_address gender identification_type
    mother_name mother_nationality father_name father_nationality
    kin_surname kin_given_name kin_date_of_birth
    kin_gender kin_relationship kin_phone kin_address
    declaration_name signature declaration_date
  ].freeze

  ALLOWED_IMAGE_TYPES = %w[image/png image/jpg image/jpeg].freeze
  MAX_IMAGE_SIZE = 5.megabytes

  validates *REQUIRED_FIELDS, presence: true
  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :gender, inclusion: { in: %w[male female others],
                                  message: "must be a valid gender" }
  validates :mother_nationality, :father_nationality,
            inclusion: { in: %w[Uganda Others],
                         message: "must be Uganda or Others" }
  validates :membership_type, inclusion: { in: %w[Share Loan],
                                            message: "must be either Share or Loan" }
  validates :marital_status, inclusion: { in: %w[single married widow widowed others],
                                           message: "must be a valid marital status" }
  validates :identification_type, inclusion: { in: ["National Id", "Driver’s License", "Passport"],
                                                message: "must be a valid ID type" }

  validate :validate_passport_photo
  validate :validate_id_document_photo

  def name
    [surname, given_name, other_name].reject(&:blank?).join(" ")
  end

  private

  def validate_passport_photo
    if passport_photo.attached?
      validate_image(passport_photo, "Passport photo")
    else
      errors.add(:passport_photo, "is required for membership")
    end
  end

  def validate_id_document_photo
    if id_document_photo.attached?
      validate_image(id_document_photo, "ID document photo")
    else
      errors.add(:id_document_photo, "is required as an identification document")
    end
  end

  def validate_image(image, name)
    return unless image.attached?

    if image.blob.byte_size > MAX_IMAGE_SIZE
      errors.add(name, "should be less than 5MB")
    end

    unless ALLOWED_IMAGE_TYPES.include?(image.blob.content_type)
      errors.add(name, "must be a PNG, JPG, or JPEG file")
    end
  end
end
