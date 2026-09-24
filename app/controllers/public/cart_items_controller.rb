class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.all
    @total_price = @cart_items.sum(&:subtotal)
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
    if @cart_item.present?
      new_amount = @cart_item.amount + cart_item_params[:amount].to_i
      @cart_item.update(amount: new_amount)
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    flash[:notice] = "カート内の商品をすべて削除しました。"
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
