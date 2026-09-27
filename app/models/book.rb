class Book < ApplicationRecord
  validates :google_books_id, presence: true, uniqueness: true
  validates :title, presence: true

  has_many :incidents
end
