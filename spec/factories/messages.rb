FactoryBot.define do
  factory :message do
    messageable { nil }
    user { nil }
    text { FFaker::LoremPL.paragraph }
  end
end
