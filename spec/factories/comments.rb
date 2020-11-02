FactoryBot.define do
  factory :comment do
    text { 'もう少し商品状態について詳しく教えてください' }
    association :user
    association :item
  end
end
