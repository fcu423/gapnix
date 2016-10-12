Rails.application.routes.draw do 
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'sessions#new'
  resources :sessions, only: :index
  resource :dashboard, only: :show
  
  get "/auth/:provider/callback" => 'sessions#create'
  get 'tasks/index'
  get 'tasks/create'

  root to: "pages#index"

  resources :users do
    resources :categories, controller: "users/categories"
    resources :projects, controller: "users/projects"
  end
  
end
