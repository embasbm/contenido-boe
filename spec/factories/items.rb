FactoryGirl.define do
  factory :item do
    item_id { Faker::Lorem.word }
    title { Faker::Lorem.word }
    pdf_url { Faker::Lorem.word }
    epigraph { Epigraph.first || FactoryGirl.create(:epigraph) }
    department { Department.first || FactoryGirl.create(:department) }
  end
end
