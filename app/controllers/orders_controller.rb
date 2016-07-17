class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
  end

  def create
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

    params.require(:order).permit(:produto_id)
  end
end
