FactoryBot.define do  
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password123' }
    username { Faker::Alphanumeric.unique.alphanumeric(number: 10) }
    admin { true }
  end
end