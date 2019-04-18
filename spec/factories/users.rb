FactoryBot.define do
  factory :user do
    nickname { FFaker::Internet.user_name }

    login    { '@' + FFaker::InternetSE.login_user_name }

    email    { FFaker::Internet.email }

    password { FFaker::Internet.password }

    trait :with_auth_token do
      association :auth_token
    end
  end
end
