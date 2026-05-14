class Incident < ApplicationRecord
  validates :book, presence: true, length: { maximum: 200 }
  validates :name, length: { maximum: 200 }
  validates :body, length: { maximum: 65_535 }
  enum tag: { murder: 0, solving: 1, theft: 2, accident: 3, suicide: 4, terrorist: 5 }
  belongs_to :user
end
