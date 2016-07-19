class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
    @setores = Setor.all
  end

  def create
    if current_user.perfil_id == 1
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

    elsif current_user.perfil_id == 2 && params[:order][:forma_pagto] == "1"
      params[:order][:valor_bilhete] = calculo_bilhete(params[:order][:periodo], params[:order][:setor_id]) if params[:order][:periodo] && params[:order][:setor_id] != ""
      params[:order][:description] = Setor.find(params[:order][:setor_id]).cor

      @order = current_user.orders.build(params.require(:order).permit(:setor_id, :periodo, :user_id, :valor_bilhete, :description, :transaction_id, :placa_veiculo, :telefone, :status, :forma_pagto, :vendido_por, :ativado_em, :cnpj))

      @bilhetepv = current_user.bilhetepvs.build
      @bilhetepv.update_attributes(valor_bilhete: @order.valor_bilhete, placa_veiculo: @order.placa_veiculo, telefone: @order.telefone, setor_id: @order.setor_id, periodo: @order.periodo, forma_pagamento: @order.forma_pagto, vendido_por: @order.vendido_por, status: @order.status, ativado_em: @order.ativado_em, cnpj: @order.cnpj, bilhete: nro_bilhete)

      respond_to do |format|
        if @bilhetepv.save && @order.save
          format.html { redirect_to user_bilhetepv_path(current_user, @bilhetepv), notice: "Pagamento realizado a dinheiro" }
          format.json { render :show, status: :created, location: @bilhetepv }
        else
          format.html { render :new }
          format.json { render json: @bilhetepv.errors, status: :unprocessable_entity }
        end
      end

    elsif current_user.perfil_id == 2 && params[:order][:forma_pagto] == "2"
      params[:order][:valor_bilhete] = calculo_bilhete(params[:order][:periodo], params[:order][:setor_id]) if params[:order][:periodo] && params[:order][:setor_id] != ""
      params[:order][:description] = Setor.find(params[:order][:setor_id]).cor

      @order = current_user.orders.build(order_params_pv)

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
  end

  def show
    @bilhetepv = Bilhetepv.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:setor_id, :periodo, :user_id, :valor_bilhete, :description, :transaction_id)
  end

  def order_params_pv
    params.require(:order).permit(:setor_id, :periodo, :user_id, :valor_bilhete, :description, :transaction_id, :placa_veiculo, :telefone, :status, :forma_pagto, :vendido_por, :ativado_em, :cnpj)
  end

  def calculo_bilhete(periodo, setor_id)
    preco = Setor.find(setor_id).preco_periodo

    valor_bilhete = periodo.to_i * preco
  end

  def nro_bilhete
    cod = "AAA" #comando para chamar o código do bilhete
    nro = rand(1..99999999)
    bilhete = cod+nro.to_s

    bilhetes = Bilhete.all.map{ |bilh| bilh.bilhete  }
    bilhetespv = Bilhetepv.all.map{ |bilh| bilh.bilhete }

    if bilhetes.include?(bilhete) || bilhetespv.include?(bilhete)
      nro_bilhete
    else
      bilhete
    end
  end
end
