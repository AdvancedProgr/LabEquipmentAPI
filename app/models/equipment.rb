class Equipment < ApplicationRecord
  belongs_to :category
  has_many :maintenance_records, dependent: :destroy

  STATUSES = %w[available in_use maintenance].freeze

  validates :name, presence: true

  validates :serial_number,
    presence: true,
    uniqueness: true,
    format: { with: /\A[A-Z]{3}-\d{3}\z/ }

  validates :status,
    presence: true,
    inclusion: { in: STATUSES }
end
