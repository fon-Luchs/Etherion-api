FactoryBot.define do
  factory :comment do
    user { nil }

    ad { nil }

    text { FFaker::CheesyLingo.paragraph.first(128) }

    parent_id { 0 }

    rate { 0 }
  end
end
