FactoryGirl.define do
  factory :user do
    sequence(:name) { "Person1" }
    sequence(:email) { "person1@example.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end
