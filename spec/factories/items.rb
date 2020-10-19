FactoryBot.define do
  factory :item do
    name { 'テスト' }
    description { 'テストに関する説明です。 This is the descriotion of test.' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/item-sample.png'), filename: 'item-sample.png')
    end
  end
end
