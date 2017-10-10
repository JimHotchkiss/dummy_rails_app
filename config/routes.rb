Rails.application.routes.draw do
  root 'projects#index'

  resources :projects, only: [:show, :index] do
    resources :comments, only: [:index, :show, :new]
  end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html




  resources :users, :only => [:new, :create]
  resources :projects, :only =>[:index, :new, :create, :show, :edit, :updated, :delete]
  resources :categories, :only => [:show]
  resources :comments
  # Authentication routes
  get 'session/login' => 'sessions#new'
  post 'session/login' => 'sessions#create'
  delete 'session/logout' => 'sessions#destroy'
end
