class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    new_status = params[:order][:status].to_i
    if @order.update(order_params)
      flash[:notice] = "注文ステータスを更新しました。"
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status).tap do |whitelisted|
    whitelisted[:status] = whitelisted[:status].to_i if whitelisted[:status].present?
  end
  end
end
