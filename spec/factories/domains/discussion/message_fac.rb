FactoryGirl.define do

  factory :message, class: Discussion::Message do
    body {Faker::Lorem.sentence}
  end

end
