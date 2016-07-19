Rails.application.routes.draw do
  resources :locations
  devise_for :users

  resources :users do
    resources :bilhetes
    resources :bilhetepvs
    resources :orders
    #resource :checkout, only: [:create]
  end

  resources :veiculos
  resource :notifications, only: [:create]

  get "bilhetes/ativar/:id", controller: 'bilhetes', action: 'ativar_bilhete', as: "ativar_bilhete"
  get "bilhetes/renovar/:id", controller: 'bilhetes', action: 'renovar_bilhete', as: "renovar_bilhete"
  get "bilhetes/new/:transaction_id", controller: 'bilhetes', action: 'novo_bilhete', as: 'novo_bilhete'
  get "bilhetes/edit/:id", controller: 'bilhetes', action: 'bilhete_gerado', as: "bilhete_gerado"
  get "bilhetepvs/bilhetes_ativos", controller: 'bilhetepvs', action: 'listar_bilhetes', as: "listar_bilhetes"
  get "bilhetepvs/bilhetes_renovaveis", controller: 'bilhetepvs', action: 'listar_bilhetes_renovaveis', as: "listar_bilhetes_renovaveis"
  get "bilhetepvs/lista_venda_geral", controller: 'bilhetepvs', action: 'listar_venda_geral', as: "listar_venda_geral"
  get "bilhetepvs/lista_venda_dinheiro", controller: 'bilhetepvs', action: 'listar_venda_dinheiro', as: "listar_venda_dinheiro"
  get "bilhetepvs/lista_venda_credito", controller: 'bilhetepvs', action: 'listar_venda_credito', as: "listar_venda_credito"
  get "bilhetepvs/lista_venda_debito", controller: 'bilhetepvs', action: 'listar_venda_debito', as: "listar_venda_debito"
  get "bilhetepvs/renovar/:id", controller: 'bilhetepvs', action: 'renovar_bilhetepv', as: "renovar_bilhetepv"
  get "users/:user_id/checkout/:id", controller: 'checkout', action: 'create'
  get "users/:user_id/consulta", controller: 'checkout', action: 'consulta_venda'
  get "users/:user_id/tela_erro", controller: 'checkout', action: 'tela_erro', as: "tela_erro"

  root "users#home"

end
