Rails.application.routes.draw do
  resources :locations
  devise_for :users

  resources :users do
    resources :vendas
    resources :bilhetes
  end

  resources :veiculos

  #root "users#index"
  root "locations#index"

end
