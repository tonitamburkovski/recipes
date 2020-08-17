require 'rails_helper'
RSpec.describe Ingredient do
  describe 'associations' do
    it { is_expected.to belong_to(:recipe) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:qty) }
    it { is_expected.to validate_presence_of(:unit) }
    it { is_expected.to validate_presence_of(:ingredient) }
  end
end
