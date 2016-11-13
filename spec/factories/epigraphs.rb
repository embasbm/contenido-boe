FactoryGirl.define do
  factory :epigraph do
    name { Faker::Lorem.word }
    department { Department.first || FactoryGirl.create(:department) }
  end
end
