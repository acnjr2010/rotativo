class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
    @setores = Setor.all
  end

  def create
    params[:order][:valor_bilhete] = calculo_bilhete(params[:order][:periodo], params[:order][:setor_id]) if params[:order][:periodo] && params[:order][:setor_id] != ""
    params[:order][:description] = Setor.find(params[:order][:setor_id]).cor
    @order = current_user.orders.build(order_params)
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to controller: 'checkout', action: 'create', user_id: current_user, id: @order }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:setor_id, :periodo, :user_id, :valor_bilhete, :description, :transaction_id)
  end

  def calculo_bilhete(periodo, setor_id)
    preco = Setor.find(setor_id).preco_periodo

    valor_bilhete = periodo.to_i * preco
  end
end
