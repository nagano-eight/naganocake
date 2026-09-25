class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.all
    @total_price = @cart_items.sum(&:subtotal)
    @total_payment = 0
    @cart_items.each do |cart_item|
      @total_payment += cart_item.subtotal
    end
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
    if @cart_item.present?
      new_amount = @cart_item.amount + cart_item_params[:amount].to_i
      @cart_item.update(amount: new_amount)
      redirect_to cart_items_path
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
      if @cart_item.save
        redirect_to cart_items_path
      else
        @item = Item.find(cart_item_params[:item_id])
        render "public/items/show"
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items
      @total_payment = 0
      @cart_items.each do |cart_item|
        @total_payment += cart_item.subtotal
      end
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
