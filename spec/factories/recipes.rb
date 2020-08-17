FactoryBot.define do
  factory :article do
    user
    title { 'Basic Scrambled Eggs' }
    description { 'Spice up this easy egg' }
  end
end