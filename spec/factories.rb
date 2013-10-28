require 'factory_girl'

FactoryGirl.define do

  factory :photo do
    sequence(:filename){ |n| "foo#{n}" }
    contentType "image/jpg"
    sequence(:binaryData){ |n| "some_data#{n}"}
  end

end
