FactoryBot.define do
  factory :item do
    name { 'テスト' }
    description { 'テストに関する説明です。 This is the description of test.' }
    category_id { 2 }
    condition_id { 2 }
    postage_payer_id { 2 }
    prefecture_id { 1 }
    transport_day_id { 2 }
    price { 5000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/item-sample.png'), filename: 'item-sample.png')
    end
  end
end
