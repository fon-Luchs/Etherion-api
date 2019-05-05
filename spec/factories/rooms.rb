FactoryBot.define do
  factory :room do
    commune { nil }

    name { FFaker::CheesyLingo.word.first(5) }
  end
end
