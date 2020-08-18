require 'rails_helper'

RSpec.describe 'Recipes Ingredients' do
  describe 'GET recipes ingredients' do
    let(:expected_ingredient_qty) { "1" }
    let(:expected_ingredient_unit) { 'piece' }
    let(:expected_ingredient_ingredient) { 'egg' }
    let(:ingredient) { create(:ingredient, qty: expected_ingredient_qty, unit: expected_ingredient_unit, ingredient: expected_ingredient_ingredient) }

    it 'shows the recipe ingredients' do
      get recipe_path(ingredient.recipe)

      expect(response).to have_http_status(:ok)

      expect(response.body).to include expected_ingredient_qty, expected_ingredient_unit, expected_ingredient_ingredient
    end
  end
end
