class OrdersController < ApplicationController

  def index
    if @user = current_user
      @orders = @user.orders
    else
      flash[:message] = "You must login to see your orders"
      redirect_to login_path
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
