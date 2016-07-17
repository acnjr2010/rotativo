Rails.application.routes.draw do
  resources :locations
  devise_for :users

  resources :users do
    resources :bilhetes
    resources :bilhetepvs
    resources :orders do
      resources :produtos
    end
    #resource :checkout, only: [:create]
  end

  resources :veiculos
  resource :notifications, only: [:create]

  get "bilhetes/ativar/:id", controller: 'bilhetes', action: 'ativar_bilhete', as: "ativar_bilhete"
  get "bilhetes/renovar/:id", controller: 'bilhetes', action: 'renovar_bilhete', as: "renovar_bilhete"
  get "bilhetepvs/bilhetes_ativos", controller: 'bilhetepvs', action: 'listar_bilhetes', as: "listar_bilhetes"
  get "bilhetepvs/bilhetes_renovaveis", controller: 'bilhetepvs', action: 'listar_bilhetes_renovaveis', as: "listar_bilhetes_renovaveis"
  get "bilhetepvs/lista_venda_geral", controller: 'bilhetepvs', action: 'listar_venda_geral', as: "listar_venda_geral"
  get "bilhetepvs/lista_venda_dinheiro", controller: 'bilhetepvs', action: 'listar_venda_dinheiro', as: "listar_venda_dinheiro"
  get "bilhetepvs/lista_venda_credito", controller: 'bilhetepvs', action: 'listar_venda_credito', as: "listar_venda_credito"
  get "bilhetepvs/lista_venda_debito", controller: 'bilhetepvs', action: 'listar_venda_debito', as: "listar_venda_debito"
  get "bilhetepvs/renovar/:id", controller: 'bilhetepvs', action: 'renovar_bilhetepv', as: "renovar_bilhetepv"
  get "users/:user_id/checkout/:id", controller: 'checkout', action: 'create'

  root "users#home"

end
