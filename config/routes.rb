Rails.application.routes.draw do
  resources :locations
  devise_for :users

  resources :users do
    resources :vendas
    resources :bilhetes
  end

  resources :veiculos

  get "bilhetes/ativar/:id", controller: 'bilhetes', action: 'ativar_bilhete', as: "ativar_bilhete"
  get "bilhetes/renovar/:id", controller: 'bilhetes', action: 'renovar_bilhete', as: "renovar_bilhete"
  root "users#index"

end
