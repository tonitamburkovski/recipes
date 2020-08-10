Rails.application.routes.draw do
  get 'recipes/index'
  get '/recipes', to: 'recipes#index'

  root "recipes#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
