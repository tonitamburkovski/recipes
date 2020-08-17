FactoryBot.define do
  factory :instruction do
    recipe
    step { 1 }
    instruction { 'beat eggs' }
  end
end
