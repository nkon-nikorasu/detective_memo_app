class Character < ApplicationRecord
  validates :name, length: { maximum: 10 }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9999, allow_nil: true }
  validates :role, length: { maximum: 10 }
  validates :body, length: { maximum: 5000 }
  enum gender: { man: 0, woman: 1, anonymous: 2,}
  belongs_to :incident
end
