class IncidentTime < ApplicationRecord
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9999, allow_nil: true }
  validates :month, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12, allow_nil: true }
  validates :date, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31, allow_nil: true }
  validates :hour, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 24, allow_nil: true }
  validates :minute, :second, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 60, allow_nil: true }
  validates :body, presence: true, length: { maximum: 30 }

  belongs_to :incident
end
