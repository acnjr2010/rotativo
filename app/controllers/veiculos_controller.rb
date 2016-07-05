class VeiculosController < ApplicationController
  before_action :find_veiculo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @veiculos = Veiculo.all.order("created_at DESC")
  end

  def new
    @veiculo = Veiculo.new
  end

  def create
    @veiculo = Veiculo.create(veiculo_params)

    respond_to do |format|
      if @veiculo.save
        format.html { redirect_to @veiculo, notice: "Veículo salvo com sucesso" }
        format.json { render :show, status: :created, location: @veiculo }
      else
        format.html { render :new }
        format.json { render json: @veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @veiculo.update(veiculo_params)
        format.html { redirect_to @veiculo, notice: "Veículo atualizado com sucesso" }
        format.json { render :show, status: :ok, location: @veiculo }
      else
        format.html { render :edit }
        format.json { render json: @veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @veiculo.destroy

    respond_to do |format|
      format.html { redirect_to veiculos_path, notice: "Veículo removido com sucesso" }
      format.json { head :no_content }
    end
  end

  private

  def veiculo_params
    params.require(:veiculo).permit(:placa_veiculo, :tipo, :modelo, :cor)
  end

  def find_veiculo
    @veiculo = Veiculo.find(params[:id])
  end
end
