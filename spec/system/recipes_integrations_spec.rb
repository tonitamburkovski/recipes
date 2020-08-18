require 'rails_helper'

RSpec.describe "RecipesIntegrations", type: :system do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before do
    driven_by(:rack_test)

    log_in(user)
  end

  describe 'Creating an recipe' do
    it 'creates and shows the newly created recipe' do
      title = 'Create new system spec'
      description = 'This is the description'
      ingredient = 'This is the ingredient'
      instruction = 'This is the instruction'

      click_on('New Recipe')

      within('form') do
        fill_in 'Title', with: title
        fill_in 'Description', with: description
        fill_in 'Ingredient', with: ingredient
        fill_in 'Instruction', with: instruction

        click_on 'Submit'
      end

      expect(page).to have_content(title)
      expect(page).to have_content(description)
      expect(page).to have_content(ingredient)
      expect(page).to have_content(instruction)
    end
  end

  describe 'Editing an recipe' do
    it 'edits and shows recipe' do
      title = 'New recipe'
      description = 'New description'

      visit recipe_path(recipe)

      click_on('Edit')

      within('form') do
        fill_in 'Title', with: title
        fill_in 'Description', with: description


        click_on 'Submit'
      end

      expect(page).to have_content(title)
      expect(page).to have_content(description)
    end
  end

  describe 'Deleting an recipe' do
    it 'delete recipe and redirect to index ' do
      visit recipe_path(recipe)

      click_on('Delete')

      expect(page).to have_content('Recipes')
    end
  end

  describe 'Going backto the recip index page' do
    it 'goes back to the recipe index page ' do
      visit recipe_path(recipe)

      click_on('Back')

      expect(page).to have_content('Recipes')
    end
  end

end
