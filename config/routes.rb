Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'projects#index'

  resources :users, :only => [:new, :create]
  resources :projects, :only =>[:new]

  # Authentication routes
  get 'session/login' => 'sessions#new'
  post 'session/login' => 'sessions#create'
  delete 'session/logout' => 'sessions#destroy'
end
