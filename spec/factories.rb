require 'factory_girl'

FactoryGirl.define do

  factory :photo do
    sequence(:filename){ |n| "foo#{n}" }
    contentType "image/jpg"
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
