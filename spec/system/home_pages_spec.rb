require 'rails_helper'

RSpec.describe "HomePages", type: :system do
  before do
    driven_by(:rack_test)
    # driven_by :selenium, using: :chrome
    visit root_path
  end

  it 'shows the home link' do
    expecting = page.has_link?('Recipes')

    expect(expecting).to be true
  end

  context 'when no user is signed in' do
    it 'shows the Log In link' do
      expecting = page.has_link?('Log In')

      expect(expecting).to be true
    end

    it 'shows the Sign Up link' do
      expecting = page.has_link?('Sign Up')

      expect(expecting).to be true
    end
  end

  context 'when a user is signed in into the app' do
    before do
      log_in(create(:user))

      visit root_path
    end

    it 'shows the New Recipe link' do
      expecting = page.has_link?('New Recipe')

      expect(expecting).to be true
    end

    it 'shows the Log Out link' do
      expecting = page.has_link?('Log Out')

      expect(expecting).to be true
    end
  end

  context 'when an recipe is present' do
    let!(:recipe) { create(:recipe, title: 'Testing with RSpec', description: 'Recipe description') }
      before do
        visit root_path
      end

    it 'shows the recipe title' do
      expecting = page.has_content?(recipe.title)

      expect(expecting).to be true
    end

    it 'shows the recipe description' do
      expecting = page.has_content?(recipe.description)

      expect(expecting).to be true
    end

    it 'shows the link to the recipe' do
      expecting = page.has_link?('Show')

      expect(expecting).to be true
    end
  end
end
