class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.first.cart_items
    @total_price = @cart_items.sum(&:subtotal)
  end

  def create
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def cart_item_params
    params.require(:item).permit(:amount)
  end
end
