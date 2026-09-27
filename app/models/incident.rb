class Incident < ApplicationRecord
  validates :name, length: { maximum: 30 }
  validates :body, length: { maximum: 10_000 }

  enum tag: { murder: 0, solving: 1, theft: 2, accident: 3, suicide: 4, terrorism: 5, others: 6 }

  belongs_to :user
  belongs_to :book, optional: true
  has_many :incident_times, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :memos, dependent: :destroy
end
