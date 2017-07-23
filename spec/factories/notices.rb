# spec/factories/notices.rb
FactoryGirl.define do
  factory :notice do
    notice_for { Faker::Lorem.word }
    details { Faker::Lorem.word }
    important_dates { Faker::Lorem.word }
    attachments_needed { Faker::Lorem.word }
  end
end