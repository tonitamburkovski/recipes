class Recipe < ApplicationRecord
  MINIMUM_TITLE_LENGTH = 5

  has_many :ingredients, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :ingredients
  has_many :instructions, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :instructions
  validates :title, presence: true, length: { minimum: MINIMUM_TITLE_LENGTH }

  belongs_to :user
end
