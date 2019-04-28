FactoryBot.define do
  factory :ad do
    heading { nil }

    user { nil }

    text { FFaker::CheesyLingo.paragraph.first(200) }

    rate { 0 }
  end
end
