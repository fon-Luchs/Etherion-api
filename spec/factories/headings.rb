FactoryBot.define do
  factory :heading do
    name { FFaker::CheesyLingo.word }
    user { nil }
  end
end
