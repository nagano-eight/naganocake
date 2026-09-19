class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.find(order_params)
    @cart_items = current_customer.cart_items
    @total_payment = @cart_items.sum(&:subtotal)
    case params[:order][:address_option] 
    when "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    when "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    when "2"
      if @order.postal_code.blank? || @order.address.blank? || @order.name.blank?
        flash.now[:alert] = "新しいお届け先を入力してください。"
        @address = current_customer.addresses
        render :new, statsus: :unprocessable_entity and return
      end

      if @order.inbalid?
        @addresses = current_customer.address
        render :new, status: :unprocessable_entity
      end
    end
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

  private
  
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status, :created_at, :update_at)
  end

end
