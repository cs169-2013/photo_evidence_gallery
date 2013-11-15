require 'factory_girl'

FactoryGirl.define do

  factory :photo do
    sequence(:file_name){ |n| "foo#{n}" }
    content_type "image/jpg"
    edited true
    image "Clearly faked"
    #image { fixture_file_upload("files/example.jpg", "image/jpeg") }
  end

  factory :user do

    email "example@example.com"
    password "example12"
    password_confirmation "example12"
  end

end
