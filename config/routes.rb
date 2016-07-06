Rails.application.routes.draw do
  devise_for :users

  resources :users
  resources :vendas do

  end
  resources :veiculos

  root "users#index"

end
