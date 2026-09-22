class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = current_customer.addresses.new(address_params)

    if @address.save
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])

    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    address = current_customer.addresses.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end