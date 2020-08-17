require 'rails_helper'

RSpec.describe Recipe do
  describe 'associations' do
    it { is_expected.to have_many(:ingredients) }
    it { is_expected.to have_many(:instructions) }
    it { is_expected.to belong_to(:user) }

    describe 'dependency' do
      let(:ingredients_count) { 1 }
      let(:instructions_count) { 1 }
      let(:recipe) { create(:recipe) }

      it 'destroys ingredients' do
        create_list(:ingredient, ingredients_count, recipe: recipe)

        expect { recipe.destroy }.to change { Ingredient.count }.by(-ingredients_count)
      end

      it 'destroys instructions' do
        create_list(:instruction, instructions_count, recipe: recipe)

        expect { recipe.destroy }.to change { Instruction.count }.by(-instructions_count)
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(Recipe::MINIMUM_TITLE_LENGTH) }
  end
end