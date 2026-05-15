class Incident < ApplicationRecord
  validates :book, presence: true, length: { maximum: 30 }
  validates :name, length: { maximum: 30 }
  validates :body, length: { maximum: 10_000 }
  enum tag: { murder: 0, solving: 1, theft: 2, accident: 3, suicide: 4, terrorism: 5, others: 6 }
  belongs_to :user
end
