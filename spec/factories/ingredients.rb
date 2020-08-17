FactoryBot.define do
  factory :ingredient do
    recipe
    qty { 4 }
    unit { 'pieces' }
    ingredient { 'egg' }
  end
end
