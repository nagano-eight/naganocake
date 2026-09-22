class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, except: [:new, :confirm, :thanks]

  def new
    @order = Order.new
  end

 

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to thanks_orders_path
  end

  private
  
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status, :created_at, :update_at)
  end

end
