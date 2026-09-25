class Public::OrdersController < ApplicationController
  
  before_action :authenticate_customer! 

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def index
    @orders = Order.all  
  end

 def confirm
   @order = Order.new(order_params)
   @order.customer_id = current_customer.id
   @order.shipping_cost = 800
   @cart_items = current_customer.cart_items
   cart_total = @cart_items.present? ? @cart_items.sum(&:subtotal) : 0
   @order.total_payment = cart_total.to_i + @order.shipping_cost.to_i
   @total_payment = cart_total
   @order.payment_method = order_params[:payment_method]
   case params[:order][:select_address].to_s
   when "0"
     @order.postal_code = current_customer.postal_code
     @order.address = current_customer.address
     @order.name = current_customer.last_name + current_customer.first_name
   when "1"
     @address = Address.find(params[:order][:address_id])
     @order.postal_code = @address.postal_code
     @order.address = @address.address
     @order.name = @address.name
   when "2"
     @order.postal_code = params[:order][:postal_code]
     @order.address = params[:order][:address]
     @order.name = params[:order][:name]      
   end
   if @order.invalid?
     @addresses = current_customer.addresses
     render :new, status: :unprocessable_entity
   end
 end

  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item_id
        @order_detail.price = cart_item.item.with_tax_price
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
      @cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      @addresses = current_customer.addresses
      @cart_items = current_customer.cart_items
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :payment_method,      
      :postal_code,
      :address,
      :name,
      :select_address,
      :address_id,
      :shipping_cost,
      :total_payment,
      :payment_method
    )
  end
end
