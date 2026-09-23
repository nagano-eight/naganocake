class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  validates :amount, presence: true, numericality: { greater_than: 0 }

  SHIPPING_COST = 800

  def subtotal
    item.with_tax_price * amount
  end

  def total_payment
    (subtotal * amount) + SHIPPING_COST
  end
end
