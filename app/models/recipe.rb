class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :instructions
  validates :title, presence: true, length: { minimum: 5 }
end
