class UsersController < ApplicationController
  before_action :authenticate_user!

  def home
    case current_user.perfil_id
    when 1
      user_home
    when 2
      ponto_venda_home
    end
  end

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
    @bilhetes_pendentes = current_user.bilhetes.where(status: 0).paginate(page: params[:page], per_page: 5)
    @bilhetes_ativos = current_user.bilhetes.where(status: 1).paginate(page: params[:page], per_page: 5)
    @bilhetes_finalizados = current_user.bilhetes.where(status: 2).paginate(page: params[:page], per_page: 5)
    @bilhetes_nao_finalizados = current_user.bilhetes.where(status: nil).paginate(page: params[:page], per_page: 5)
    @veiculos = current_user.veiculos.order(modelo: :asc)
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
    params.require(:user).permit(:nome, :endereco, :cpf, :telefone, :email, :perfil_id)
  end

  protected

  def user_home
    redirect_to users_path
  end

  def ponto_venda_home
    redirect_to new_user_order_path(current_user)
  end
end
