FactoryGirl.define do
  factory :diary do
    date_pub          { Faker::Lorem.word }
    nbo               { Faker::Number.number(1) }
    pdf_url   { Faker::Lorem.word }
  end
end
