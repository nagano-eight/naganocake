class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def create
    @order = order.new
    @order.save
    redirect_to orders_path
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(current_user.id)
  end

  def confirm
    
  end
  
  private
  
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status, :created_at, :update_at)
  end

end
