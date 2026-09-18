class IncidentTime < ApplicationRecord
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9999, allow_nil: true }
  validates :month, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12, allow_nil: true }
  validates :date, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31, allow_nil: true }
  validates :hour, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 23, allow_nil: true }
  validates :minute, :second, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 59, allow_nil: true }
  validates :body, presence: true, length: { maximum: 30 }
  validate :complete_date_and_time_combination
  validate :valid_date_combination
  validate :valid_date_structure

  acts_as_list

  belongs_to :incident

  private

  def complete_date_and_time_combination
    date_info_present = year.present? || month.present? || date.present?
    time_info_present = hour.present? || minute.present? || second.present?

    return unless date_info_present && time_info_present

    errors.add(:date, "は時刻と組み合わせる場合に必要です") if date.nil?
    errors.add(:hour, "は日付と組み合わせる場合に必要です") if hour.nil?
  end

  def valid_date_combination
    return if month.nil? || date.nil?

    if year.present?
      errors.add(:date, "は存在しない日付です") unless Date.valid_date?(year, month, date)
    elsif date > Date.new(2000, month, -1).day
      errors.add(:date, "は存在しない日付です")
    end
  end

  def valid_date_structure
    if year.present? && date.present? && month.nil?
      errors.add(:month, "は年と日を組み合わせる場合に必要です")
    end
  end
end
