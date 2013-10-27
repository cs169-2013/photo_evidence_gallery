require 'spec_helper'

describe Photo do
  it "sets its own fields with information" do
    photo = FactoryGirl.create(:photo)
    photo2 = FactoryGirl.create(:photo, :filename => "pic", :contentType => "png", :binaryData => "randomdata")
    photo = photo2
    assigns(photo.filename).should eq(photo2.filename)
  end
end
