class BilhetesController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.where(user: current_user).last
    @bilhete = current_user.bilhetes.build(transaction_id: @order.transaction_id, user_id: current_user, gerado: false, placa_veiculo: "AAA-1111", valor_bilhete: @order.valor_bilhete, setor_id: @order.setor_id)
    @bilhete.save!
    @veiculo = current_user.veiculos
    @setores = Setor.all
  end

  def create
    @order = Order.where(user: current_user).last
    params[:bilhete][:bilhete] = nro_bilhete
    @bilhete = current_user.bilhetes.where(user_id: current_user).last
    @bilhete.update_attributes(:setor_id, :placa_veiculo, :bilhete, :periodo, :ativado_em, :vendido_por, :status, :gerado)

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

  def edit
    @bilhete = Bilhete.find(params[:id])
    @order = Order.where(transaction_id: @bilhete.transaction_id).last
  end

  def update
    @order = Order.where(user: current_user).last
    params[:bilhete][:bilhete] = nro_bilhete
    @bilhete = Bilhete.find(params[:id])
    if @bilhete.gerado == false && @bilhete.transaction_id != ""
      respond_to do |format|
        if @bilhete.update(params.require(:bilhete).permit(:valor_bilhete, :setor_id, :placa_veiculo, :bilhete, :periodo, :ativado_em, :vendido_por, :status, :gerado))
          format.html { redirect_to users_path, notice: "Bilhete gerado com sucesso" }
          format.json { render :show, status: :ok, location: @bilhete }
        else
          format.html { render :edit }
          format.json { render json: @bilhete.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to bilhete_gerado_path
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

  def bilhete_gerado
    @bilhete = Bilhete.find(params[:id])
  end

  private

  def bilhete_params
    params.require(:bilhete).permit(:valor_bilhete, :setor_id, :placa_veiculo, :bilhete, :periodo, :ativado_em, :vendido_por, :status, :user_id, :gerado, :transaction_id)
  end

  def nro_bilhete
    cod = "AAA" #comando para chamar o código do bilhete
    nro = rand(1..99999999)
    bilhete = cod+nro.to_s

    bilhetes = Bilhete.all.map{ |bilh| bilh.bilhete }
    bilhetespv = Bilhetepv.all.map{ |bilh| bilh.bilhete }

    if bilhetes.include?(bilhete) || bilhetespv.include?(bilhete)
      nro_bilhete
    else
      bilhete
    end
  end
end
