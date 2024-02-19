FactoryBot.define do
  factory :color do
    trait :red_color do
      name { '赤' }
    end

    trait :yellow_color do
      name { '黄' }
    end

    trait :green_color do
      name { '緑' }
    end

    trait :white_color do
      name { '白' }
    end
  end
end