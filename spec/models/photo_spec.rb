require 'spec_helper'

describe Photo do
  it "sets its own fields with information" do
    photo = Factory.create(:photo)
    photo2 = Factory.create(:photo, :filename => "pic", :contentType => "png", :binaryData => "randomdata")
    photo = photo2
    assigns(photo.filename).should eq(photo2.filename)
  end
end
