FactoryBot.define do
  factory :account, class: Account do
    name { Faker::Name.name }
    balance {9.99}
    user 
  end
end
