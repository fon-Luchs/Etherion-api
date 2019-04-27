FactoryBot.define do
  factory :heading do
    name { FFaker::CheesyLingo.word.first(5) }
    user { nil }
  end
end
