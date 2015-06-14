Rails.application.routes.draw do
  root 'static_pages#home'

  resources :users do 
    resources :searches
  end

  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get "help" => "static_pages#help"
  delete "logout" => "sessions#destroy"
end
