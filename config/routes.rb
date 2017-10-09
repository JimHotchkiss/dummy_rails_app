Rails.application.routes.draw do
  resources :categories
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'projects#index'

  resources :categories, only: [:show] do
    resources :projects, only: [:show, :index]
    # this will give the user the ability to search
    # categories/:id/projects or categories/:id/projects/:id
    # nested resource for posts
  end

  resources :users, :only => [:new, :create]
  resources :projects, :only =>[:index, :new, :create, :show, :edit, :updated, :delete]

  # Authentication routes
  get 'session/login' => 'sessions#new'
  post 'session/login' => 'sessions#create'
  delete 'session/logout' => 'sessions#destroy'
end
