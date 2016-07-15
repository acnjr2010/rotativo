class BilhetepvsController < ApplicationController
  before_action :authenticate_user!

  def new
    @bilhetepv = current_user.bilhetepvs.build
  end

  def create
    @setores = Setor.all

    params[:bilhetepv][:bilhete] = nro_bilhete
    params[:bilhetepv][:valor_bilhete] = calculo_bilhete(params[:bilhetepv][:periodo], params[:bilhetepv][:setor_id]) if params[:bilhetepv][:periodo] && params[:bilhetepv][:setor_id] != ""
    @bilhetepv = current_user.bilhetepvs.build(bilhetepv_params)

    respond_to do |format|
      if @bilhetepv.save
        format.html { redirect_to user_bilhetepv_path(id: @bilhetepv), notice: "Bilhete gerado com sucesso" }
        format.json { render :show, status: :created, location: @bilhetepv }
      else
        format.html { render :new }
        format.json { render json: @bilhetepv.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @bilhetepv = Bilhetepv.find(params[:id])
  end

  def listar_venda_geral
    @bilhete_valor = current_user.bilhetepvs.all
    @bilhetepvs = current_user.bilhetepvs.all.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def listar_venda_dinheiro
    @bilhete_valor = current_user.bilhetepvs.where(forma_pagamento: 1)
    @bilhetepvs = current_user.bilhetepvs.where(forma_pagamento: 1).order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def listar_venda_credito
    @bilhete_valor = current_user.bilhetepvs.where(forma_pagamento: 2)
    @bilhetepvs = current_user.bilhetepvs.where(forma_pagamento: 2).order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def listar_venda_debito
    @bilhete_valor = current_user.bilhetepvs.where(forma_pagamento: 3)
    @bilhetepvs = current_user.bilhetepvs.where(forma_pagamento: 3).order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def listar_bilhetes
    @bilhetepvs = current_user.bilhetepvs.where(status: 1).order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def listar_bilhetes_renovaveis
    @bilhetepvs = current_user.bilhetepvs.where(status: 1, periodo: 1).order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def renovar_bilhetepv
    @bilhetepv = Bilhetepv.find(params[:id])
    @horario = @bilhetepv.ativado_em

    respond_to do |format|
      if @bilhetepv.update_attributes(status: 1, ativado_em: @horario + 3600, periodo: 2)
        format.html { redirect_to listar_bilhetes_renovaveis_path, notice: "Bilhete renovado com sucesso" }
        format.json { render :show, status: :ok, location: @bilhetepv }
      else
        format.html { render :edit }
        format.json { render json: @bilhetepv.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def bilhetepv_params
    params.require(:bilhetepv).permit(:valor_bilhete, :placa_veiculo, :telefone, :setor_id, :periodo, :forma_pagamento, :vendido_por, :status, :ativado_em, :cnpj, :user_id, :bilhete)
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

  def calculo_bilhete(periodo, setor_id)
    preco = Setor.find(setor_id).preco_periodo

    valor_bilhete = periodo.to_i * preco
  end


end
