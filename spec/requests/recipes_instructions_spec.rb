require 'rails_helper'

RSpec.describe 'Recipes Instructions' do
  describe 'GET recipes instructions' do
    let(:expected_instruction_step) { "1" }
    let(:expected_instruction_instruction) { 'beat' }
    let(:instruction) { create(:instruction, step: expected_instruction_step,  instruction: expected_instruction_instruction ) }

    it 'shows the recipe instructions' do
      get recipe_path(instruction.recipe)

      expect(response).to have_http_status(:ok)

      expect(response.body).to include expected_instruction_step, expected_instruction_instruction
    end
  end
end
