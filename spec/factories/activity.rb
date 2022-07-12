FactoryBot.define do
  factory :activity do
    name { Faker::Verb.base }
    category { Faker::Number.between(from: 0, to: 3) }
    duration { Faker::Lorem.words(number: 3) }
    video { "video.com" }
    description { Faker::TvShows::NewGirl.quote }
  end
end
