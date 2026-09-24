class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :last_name, :first_name, :last_name_kana, :first_name_kana,
          :postal_code, :address, :telephone_number, presence: true

         has_many :addresses, dependent: :destroy
         has_many :cart_items, dependent: :destroy
         has_many :orders, dependent: :destroy
         def active_for_authentication?
  super && is_active
end
end
