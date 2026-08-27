FactoryBot.define do
  factory :user do
    name { 'テストユーザ' }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'TestUser_8xK4pQ9m!' }
    password_confirmation { 'TestUser_8xK4pQ9m!' }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
