class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @total_price = @cart_items.sum(&:subtotal)
  end

  def create
  end

  private

  def cart_item_params
    params.require(:item).permit(:amount)
  end
end
