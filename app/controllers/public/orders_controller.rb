class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

 def confirm
    @order = Order.new(order_params)
    binding.pry
    @cart_items = current_customer.cart_items
    @total_payment = @cart_items.sum(&:subtotal)

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
        render :new, status: :unprocessable_entity
      end

      if @order.invalid?
        @addresses = current_customer.addresses
        render :new, status: :unprocessable_entity
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to thanks_orders_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
