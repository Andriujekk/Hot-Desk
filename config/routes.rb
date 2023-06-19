Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  post '/sessions', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  get '/desks', to: 'desks#index', as: 'desks'
  resources :users
  resources :rooms
  resources :sessions, only: [:new, :create, :destroy]
  resources :desks do
    patch 'book', on: :member
    patch 'unbook', on: :member
  end
  resources :rooms, only: [:index] do
    patch 'book', on: :member
    patch 'unbook', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
