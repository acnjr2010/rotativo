Rails.application.routes.draw do
  devise_for :users
  resources :vendas do

  end
  resources :veiculos

  root "veiculos#index"

end
