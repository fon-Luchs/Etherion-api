FactoryBot.define do
  factory :commune do
    name { FFaker::CheesyLingo.word.first(5) }

    polit_bank { 0 }

    creator { nil }
  end
end
