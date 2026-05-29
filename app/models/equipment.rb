class Equipment < ApplicationRecord
  belongs_to :category
  has_many :maintenance_records, dependent: :destroy

  STATUSES = %w[available in_use maintenance].freeze

  before_validation :set_default_status, on: :create

  validates :name, presence: true
  validates :name, length: { minimum: 3 }
  validate  :name_must_contain_letter

  def name_must_contain_letter
    return if name.to_s.match?(/[A-Za-z]/)

    errors.add(:name, "must contain at least one letter")
  end

  validates :serial_number,
    presence: true,
    uniqueness: true,
    format: { with: /\A[A-Z]{3}-\d{3}\z/, message: "must look like ABC-123" }

  validates :status,
    presence: true,
    inclusion: { in: STATUSES }

  private

  def set_default_status
    self.status ||= "available"
  end
end
