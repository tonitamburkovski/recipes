class Ingredient < ApplicationRecord
  belongs_to :recipe
  validates :qty, :unit, :ingredient, presence: true
end
