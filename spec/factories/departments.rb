FactoryGirl.define do
  factory :department do
    name { Faker::Lorem.word }
    section { Section.first || FactoryGirl.create(:section) }
  end
end
