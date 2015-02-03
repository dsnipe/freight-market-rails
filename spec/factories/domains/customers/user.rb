FactoryGirl.define do

  factory :user, class: Customer::User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
  end

end
