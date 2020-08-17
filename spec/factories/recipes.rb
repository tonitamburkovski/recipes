FactoryBot.define do
  factory :recipe do
    user
    title { 'Basic Scrambled Eggs' }
    description { 'Spice up this easy egg' }
  end
end