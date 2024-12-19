FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { :user }

    trait :admin do
      role { :admin }
    end

    trait :guest do
      role { :guest }
    end
  end
end
