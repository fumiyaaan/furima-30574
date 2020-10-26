FactoryBot.define do
  factory :purchase_address do
    postal_number { '012-4567' }
    prefecture_id { 5 }
    city { '秋田市' }
    house_number { '1丁目2番3' }
    building_name { '柳ビル' }
    phone_number { '09012345678' }
  end
end
