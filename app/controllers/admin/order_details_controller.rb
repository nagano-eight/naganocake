class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      order = @order_detail.order
      if order.order_details.all? { |detail| detail.production_complete? }
        order.update(status: :preparing_to_ship)
      end
      redirect_to admin_order_path(@order_detail.order)
    else
      redirect_to admin_order_path(@order_detail.order)
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
