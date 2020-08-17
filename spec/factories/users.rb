FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testing#{n}@test.com" }
    name { 'Johny' }
    first_name { 'John' }
    last_name { 'Brown' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
