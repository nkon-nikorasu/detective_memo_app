class Memo < ApplicationRecord
  validates :body, presence: true, length: { maximum: 10_000 }
  enum tag: { deduction: 0, clue: 1 }

  belongs_to :incident
end
