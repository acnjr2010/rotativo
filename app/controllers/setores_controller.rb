class SetoresController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @setores = Setor.all.order(cor: :asc)
  end

end
