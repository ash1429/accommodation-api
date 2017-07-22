# spec/factories/accommodations.rb
FactoryGirl.define do
  factory :accommodation do
    typo { Faker::Lorem.word }
  end
end