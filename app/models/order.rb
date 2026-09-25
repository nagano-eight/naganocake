class Order < ApplicationRecord
  attr_accessor :select_address, :address_id

  belongs_to :customer

  validates :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status, presence: true
  validates :shipping_cost, :total_payment, numericality: { greater_than_or_equal_to: 0 }

  has_many :order_details, dependent: :destroy

  enum :payment_method, { credit_card: 0, transfer: 1 }
  enum :status, { waiting_for_payment: 0, payment_confirmation: 1, in_production: 2, preparing_to_ship: 3, shipped: 4 }

  def status_i18n
    case status
    when "waiting_for_payment" then "入金待ち"
    when "payment_confirmation" then "入金確認"
    when "in_production" then "製作中"
    when "preparing_to_ship" then "発送準備中"
    when "shipped" then "発送済み"
    end
  end

  def subtotal
    order_details.sum { |detail| detail.price * detail.amount }
  end
end
