require 'factory_girl'

FactoryGirl.define do

  factory :photo do
    sequence(:taken_by){ |n| "foo#{n}" }
    time_taken "not today"
    edited true
    image "Clearly faked"
    #image { fixture_file_upload("files/example.jpg", "image/jpeg") }
  end

  factory :user do

    email 'example@example.com'
    password 'example12'
    password_confirmation 'example12'
    role 'admin'
    info = {:incident_name => 'incident faked',
    :taken_by => 'taken faked',
    :operational_period => 'operation faked',
    :team_number => 'team faked'}
  end

end
