# spec/factories/students_halls.rb
FactoryGirl.define do
  factory :students_hall do
    names { Faker::Lorem.word }
    contact_no { Faker::Number.number(11) }
  end
end