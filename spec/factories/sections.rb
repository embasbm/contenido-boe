FactoryGirl.define do
  factory :section do
    name { Faker::Lorem.word }
    number { Faker::Lorem.word }
    diary { Diary.first || FactoryGirl.create(:diary) }
  end
end
