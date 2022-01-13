FactoryBot.define do
  factory :subscription do
    title {Faker::Hipster.sentence(word_count: 1)}
    price {Faker::Number.decimal(l_digits: 2, r_digits: 2)}
    frequency {Faker::Subscription.subscription_term}
    status {0}
    customer_id {1}
  end
end
