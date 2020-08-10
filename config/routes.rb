Rails.application.routes.draw do
  root 'recipes#index'
  get 'recipes/index'
  get '/recipes', to: 'recipes#index'
  get '/recipes/new', to: 'recipes#new', as: :new_recipe
  get '/recipes/:id', to: 'recipes#show', as: :recipe
  post '/recipes', to: 'recipes#create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
