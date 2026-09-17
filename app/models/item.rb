class Item < ApplicationRecord
  belongs_to :genre
  validates :name, :introduction, :price, presence: true
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_one_attached :image
end
