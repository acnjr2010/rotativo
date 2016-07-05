Rails.application.routes.draw do


  resources :vendas do

  end
  resources :veiculos
  
  root "veiculos#index"

end
