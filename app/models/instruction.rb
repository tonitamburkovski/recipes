class Instruction < ApplicationRecord
  belongs_to :recipe
  validates :step, :instruction, presence: true
end
