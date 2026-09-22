# ジャンル
cake = Genre.find_or_create_by!(name: "ケーキ")
baked_sweets = Genre.find_or_create_by!(name: "焼き菓子")

# 商品
items = [
  {
    genre: cake,
    name: "いちごのショートケーキ",
    introduction: "いちごを使ったショートケーキです",
    price: 500
  },
  {
    genre: cake,
    name: "チョコレートケーキ",
    introduction: "濃厚なチョコレートケーキです",
    price: 550
  },
  {
    genre: baked_sweets,
    name: "クッキー",
    introduction: "サクサク食感のクッキーです",
    price: 300
  },
  {
    genre: baked_sweets,
    name: "フィナンシェ",
    introduction: "バターの風味を楽しめる焼き菓子です",
    price: 350
  }
]

items.each do |item_data|
  item = Item.find_or_initialize_by(name: item_data[:name])

  item.assign_attributes(
    genre: item_data[:genre],
    introduction: item_data[:introduction],
    price: item_data[:price],
    is_active: true
  )

  item.save!
end

# テスト用会員
customer = Customer.find_or_initialize_by(email: "test@example.com")

customer.assign_attributes(
  last_name: "山田",
  first_name: "太郎",
  last_name_kana: "ヤマダ",
  first_name_kana: "タロウ",
  postal_code: "1234567",
  address: "東京都新宿区1-1-1",
  telephone_number: "09012345678",
  is_active: true,
  password: "password",
  password_confirmation: "password"
)

customer.save!
