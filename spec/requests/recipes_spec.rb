require 'rails_helper'

RSpec.describe "Recipes" do
  describe 'Creating an recipe' do
    context "when no user is logged in" do
      it 'redirects back to login path' do
        post_params = {
          params: {
            recipe: {
              title: 'New recips'
            }
          }
        }

        post '/recipes', post_params

        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq 'Please sign in to continue.'
      end
    end
  end

  describe 'Editing an recipe' do
    context "when the recipe's user is the same as the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }
      let(:ingredient) { create(:ingredient, recipe: recipe) }
      let(:instrution) { create(:instruction, recipe: recipe) }

      it 'can edit the recipe' do
        get '/login'
        expect(response).to have_http_status(:ok)

        post_params = {
          params: {
            session: {
              email: user.email,
              password: user.password
            }
          }
        }

        post '/login', post_params

        follow_redirect!

        get "/recipes/#{recipe.id}"
        expect(response).to have_http_status(:ok)

        get "/recipes/#{recipe.id}/edit"
        expect(response).to have_http_status(:ok)

        patch_params = {
          params: {
            recipe: {
              title: recipe.title,
              description: 'Description'
            },
            ingredient: {
              qty: 1,
              unit: 'piece',
              ingredient: 'egg'
            },
            instruction: {
              step: 1,
              instruction: 'beat'
            }
          }
        }

        patch "/recipes/#{recipe.id}", patch_params

        expect(response).to have_http_status(:found)

        follow_redirect!

        expect(response.body).to include(recipe.title)
      end
    end

    context "when the recipe's user is different then the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }
      let(:ingredient) { create(:ingredient, recipe: recipe) }
      let(:instrution) { create(:instruction, recipe: recipe) }

      let(:login_user) { create(:user) }

      it 'redirect back when GET edit' do
        get '/login'

        post_params = {
          params: {
            session: {
              email: login_user.email,
              password: login_user.password
            }
          }
        }

        post '/login', post_params

        get "/recipes/#{recipe.id}/edit"

        expect(flash[:danger]).to eq 'Wrong User'
        expect(response).to redirect_to(root_path)
      end

      it 'redirect back when PATCH edit' do
        get '/login'

        post_params = {
          params: {
            session: {
              email: login_user.email,
              password: login_user.password
            }
          }
        }
        post '/login', post_params

        patch_params = {
          params: {
            recipe: {
              title: recipe.title,
              description: 'Description'
            },
            ingredient: {
              qty: 1,
              unit: 'piece',
              ingredient: 'egg'
            },
            instruction: {
              step: 1,
              instruction: 'beat'
            }
          }
        }
        patch "/recipes/#{recipe.id}", patch_params

        expect(flash[:danger]).to eq 'Wrong User'
        expect(response).to redirect_to(root_path)
      end
    end

    context "when no user is logged in" do
      let(:recipe) { create(:recipe) }
      let(:ingredient) { create(:ingredient, recipe: recipe) }
      let(:instrution) { create(:instruction, recipe: recipe) }

      it 'redirect back to root path' do
        get "/recipes/#{recipe.id}/edit"

        expect(flash[:danger]).to eq 'Please sign in to continue.'
        expect(response).to redirect_to(login_path)
      end

      it 'redirect back to root when updating an recipe' do
        patch_params = {
          params: {
            recipe: {
              title: recipe.title,
              description: 'Description'
            },
            ingredient: {
              qty: 1,
              unit: 'piece',
              ingredient: 'egg'
            },
            instruction: {
              step: 1,
              instruction: 'beat'
            }
          }
        }

        patch "/recipes/#{recipe.id}", patch_params

        expect(flash[:danger]).to eq 'Please sign in to continue.'
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'Deleting an recipe' do
    context "when the recie's user is the same as the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }
      let(:ingredient) { create(:ingredient, recipe: recipe) }
      let(:instrution) { create(:instruction, recipe: recipe) }

      it 'can delete the recipe' do
        get '/login'

        post_params = {
          params: {
            session: {
              email: user.email,
              password: user.password
            }
          }
        }

        post '/login', post_params

        follow_redirect!

        delete "/recipes/#{recipe.id}"

        expect(response).to redirect_to(recipes_path)
      end
    end

    context "when the recipe's user is different then the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }
      let(:ingredient) { create(:ingredient, recipe: recipe) }
      let(:instrution) { create(:instruction, recipe: recipe) }

      let(:login_user) { create(:user) }

      it 'redirect back to root path' do
        get '/login'

        post_params = {
          params: {
            session: {
              email: login_user.email,
              password: login_user.password
            }
          }
        }

        post '/login', post_params

        follow_redirect!

        delete "/recipes/#{recipe.id}"

        expect(flash[:danger]).to eq 'Wrong User'
        expect(response).to redirect_to(root_path)
      end
    end

    context "when no user is logged in" do
      let(:recipe) { create(:recipe) }
      let(:ingredient) { create(:ingredient, recipe: recipe) }
      let(:instrution) { create(:instruction, recipe: recipe) }

      it 'redirect back to root path' do
        delete "/recipes/#{recipe.id}"

        expect(flash[:danger]).to eq 'Please sign in to continue.'
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
