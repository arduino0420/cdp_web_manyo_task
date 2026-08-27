FactoryBot.define do
  factory :user do
    name { 'テストユーザ' }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
