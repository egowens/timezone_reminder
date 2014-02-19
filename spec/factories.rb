FactoryGirl.define do
  factory :user do
    name  "Person1"
    email "person1@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :reminder do
    content "Lorem ipsum"
    user
  end
end
