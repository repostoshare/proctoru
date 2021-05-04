FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
  end

  factory :assessment_request, class: Hash do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    exam_id  { Faker::Number.number(digits: 6) }
    college_id  { Faker::Number.number(digits: 6) }
    start_time { Time.now }

    initialize_with { attributes }
  end

  factory :college do
    name { Faker::University.name }
  end

  factory :exam do
    name  { Faker::ProgrammingLanguage.name }
    level { 1 }
    association :college

    factory :level_2_exam do
      level { 2 }
    end

    exam_windows do 
      [ association(:exam_window, exam: instance) ]
    end

    factory :exam_with_expired_window do
      exam_windows do 
        [ association(:exam_window, :expired, exam: instance) ]
      end
    end
  end

  factory :exam_window do
    window_start { Time.now - 1.week }
    window_end { Time.now + 1.day }
    status { "active" }
    association :exam

    trait :expired do
      window_end { Time.now - 2.day }
    end
  end
end
