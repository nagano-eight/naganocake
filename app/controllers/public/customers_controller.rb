class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def unsubscribe
  end

  def withdraw
    current_customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end
end
