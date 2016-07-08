class VendasController < ApplicationController
  before_action :authenticate_user!

  def new
    @venda = current_user.vendas.build
  end
end
