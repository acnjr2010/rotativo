Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :vendas
    resources :bilhetes
  end

  resources :veiculos

  root "users#index"

end
