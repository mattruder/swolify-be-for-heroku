FactoryBot.define do
  factory :activity do
    name { Faker::Verb.base }
    category { Faker::Number.between(from: 0, to: 3) }
    duration { Faker::Lorem.sentence(word_count: 3) }
    video { "video.com" }
    description { Faker::TvShows::NewGirl.quote }
  end
end
