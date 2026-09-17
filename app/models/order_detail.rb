class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :price, :amount, :making_status, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :amount, numericality: { greater_than: 0 }
  
  enum :making_status, { cannot_start: 0, waiting_for_production: 1, in_production: 2, production_complete: 3 }
end
