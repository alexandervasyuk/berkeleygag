FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@berkeley.edu"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :post do
    sequence(:title) { |n| "Some title#{n}" }
    user
  end
end