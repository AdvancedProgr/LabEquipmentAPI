class MaintenanceRecord < ApplicationRecord
  belongs_to :equipment

  validates :description, presence: true
  validates :performed_at, presence: true

  validate :performed_at_cannot_be_in_future

  def performed_at_cannot_be_in_future
    return if performed_at.blank?
    errors.add(:performed_at, "cannot be in the future") if performed_at > Time.current
  end
end
