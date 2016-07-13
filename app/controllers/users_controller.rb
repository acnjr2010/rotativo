class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user

    @locations = Location.all
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      info = "#{location.nome} <br> #{location.endereco} <br> #{location.titulo}"
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow info
    end
    @bilhete = current_user.bilhetes.build
    @bilhetes_pendentes = Bilhete.where(status: 0)
    @bilhetes_ativos = Bilhete.where(status: 1)
    @bilhetes_finalizados = Bilhete.where(status: 2)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "Informações atualizadas com sucesso" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:nome, :endereco, :cpf, :telefone, :email, :password)
  end


end
