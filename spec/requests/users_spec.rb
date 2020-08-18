require 'rails_helper'

RSpec.describe 'Users' do
  it "creates a User and redirects to the User's page" do
    get '/users/signup'

    post_params = {
      params: {
        user: {
          name: 'Toni',
          first_name: 'Toni',
          last_name: 'Tamburkovski',
          email: 'toni@recipes.com',
          password: 'testtest',
          password_confirmation: 'testtest'
        }
      }
    }
    post '/users', post_params

    expect(session[:user_id]).not_to be_nil

    follow_redirect!

    expect(response.body).to include('Toni')
    expect(response.body).to include('Toni')
    expect(response.body).to include('Tamburkovski')
    expect(response.body).to include('toni@recipes.com')
  end

  it 'renders New when User params are empty' do

    get '/users/signup'

    post_params = {

      params: {
        user: {
          name: '',
          first_name: '',
          last_name: '',
          email: '',
          password: '',
          password_confirmation: ''
        }
      }
    }

    post '/users', post_params

    expect(session[:user_id]).to be_nil
    expect(response.body).to include('New User')
  end
end
