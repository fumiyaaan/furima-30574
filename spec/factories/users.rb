FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { 'abc1234' }
    password_confirmation { password }
    sur_name { Gimei.name.last.kanji }
    first_name { Gimei.name.first.kanji }
    sur_name_reading { Gimei.name.last.katakana }
    first_name_reading { Gimei.name.first.katakana }
    birthday { '1997-07-12' }
  end
end
