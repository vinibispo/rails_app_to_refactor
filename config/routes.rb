Rails.application.routes.draw do
  namespace :users do
    resources :registrations, only: :create
  end

  get '/todos/', to: 'todos/item#index', as: 'todos'
  post '/todos/', to: 'todos/item#create'
  get '/todos/:id', to: 'todos/item#show', as: 'todo'
  put '/todos/:id', to: 'todos/item#update'
  delete '/todos/:id', to: 'todos/item#destroy'
  put '/todos/:id/complete', to: 'todos/item/complete#update', as: 'complete_todo'
  put '/todos/:id/uncomplete', to: 'todos/item/uncomplete#update', as: 'uncomplete_todo'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
