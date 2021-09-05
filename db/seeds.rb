# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "admin@aaa",
  password: "aaaaaa")

10.times do |n|
  Customer.create!(
    email: "test#{n + 1}@test.com",
    first_name: "太郎#{n + 1}",
    last_name: "テスト",
    first_name_kana: "タロウ",
    last_name_kana: "テスト",
    password: "333333",
    postcode: "0123456",
    address: "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階#{n + 1}",
    phone_number: "09012345678"
  )
end

Genre.create!(
  [
    {name: "ケーキ"},
    {name: "焼き菓子"},
    {name: "プリン"},
    {name: "和菓子"},
    {name: "アイス"},
  ])

for i in 1..3 do
  Item.create!(
    [
      {
        genre_id: 1,
        name: "ケーキ#{i}",
        caption: "#{3*i-2}番目の商品です。",
        price: rand(1..10) * 100,
        image: File.open("./app/assets/images/cake#{i}.jpg"),
        is_active: true
      },
      {
        genre_id: 2,
        name: "クッキー#{i}",
        caption: "#{3*i-1}番目の商品です。",
        price: rand(1..10) * 200,
        image: File.open("./app/assets/images/cookies#{i}.jpg"),
        is_active: true
      },
      {
        genre_id: 3,
        name: "プリン#{i}",
        caption: "#{3*i}番目の商品です。",
        price: rand(1..10) * 300,
        image: File.open("./app/assets/images/pudding#{i}.jpg"),
        is_active: true
      }
    ])
end
