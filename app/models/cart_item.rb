class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def subtotal
    item.price * amount
  end
end
