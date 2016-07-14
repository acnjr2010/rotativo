class BilhetesController < ApplicationController
  before_action :authenticate_user!

  def new
    @bilhete = current_user.bilhetes.build
    @veiculo = current_user.veiculos
    @setores = Setor.all
  end

  def create
    @setores = Setor.all

    params[:bilhete][:bilhete] = nro_bilhete
    params[:bilhete][:valor_bilhete] = calculo_bilhete(params[:bilhete][:periodo], params[:bilhete][:setor_id]) if params[:bilhete][:periodo] && params[:bilhete][:setor_id] != ""
    @bilhete = current_user.bilhetes.build(bilhete_params)

    respond_to do |format|
      if @bilhete.save
        format.html { redirect_to users_path, notice: "Bilhete gerado com sucesso" }
        format.json { render :show, status: :created, location: @bilhete }
      else
        format.html { render :new }
        format.json { render json: @bilhete.errors, status: :unprocessable_entity }
      end
    end
  end

  def ativar_bilhete
    @bilhete = Bilhete.find(params[:id])

    respond_to do |format|
      if @bilhete.update_attributes(status: 1, ativado_em: Time.current)
        format.html { redirect_to users_path, notice: "Bilhete ativado com sucesso" }
        format.json { render :show, status: :ok, location: @bilhete }
      else
        format.html { render :edit }
        format.json { render json: @bilhete.errors, status: :unprocessable_entity }
      end
    end
  end

  def renovar_bilhete
    @bilhete = Bilhete.find(params[:id])
    @horario = @bilhete.ativado_em

    respond_to do |format|
      if @bilhete.update_attributes(status: 1, ativado_em: @horario + 3600, periodo: 2)
        format.html { redirect_to users_path, notice: "Bilhete renovado com sucesso" }
        format.json { render :show, status: :ok, location: @bilhete }
      else
        format.html { render :edit }
        format.json { render json: @bilhete.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def bilhete_params
    params.require(:bilhete).permit(:valor_bilhete, :setor_id, :placa_veiculo, :bilhete, :periodo, :ativado_em, :vendido_por, :status, :user_id)
  end

  def nro_bilhete
    cod = "AAA" #comando para chamar o código do bilhete
    nro = rand(1..99999999)
    bilhete = cod+nro.to_s

    bilhetes = Bilhete.all.map{ |bilh| bilh.bilhete  }

    if bilhetes.include?(bilhete)
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
