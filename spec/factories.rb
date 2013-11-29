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
    password 'example12'
    password_confirmation 'example12'
    info = {:incident_name => 'incident faked',
    :taken_by => 'taken faked',
    :operational_period => 'operation faked',
    :team_number => 'team faked'}
    
    factory :admin do
      sequence(:email){ |n| "admin#{n}@example.com"}
      role 'admin'
    end
    
    factory :member do
      sequence(:email){ |n| "member#{n}@example.com"}
      role 'member'
    end
    
    factory :viewer do
      sequence(:email){ |n| "viewer#{n}@example.com"}
      role 'viewer'
    end
  end
end
