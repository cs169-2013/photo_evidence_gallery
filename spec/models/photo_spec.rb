require 'spec_helper'

describe Photo do
  before(:all) do
    @photo = Photo.new(caption: 'Default Caption', tags: 'Multiple tags', incident_name: 'Incident', operational_period: 'Period', team_number: '12345', taken_by: 'KC', edited: true)
  end
  
  subject { @photo }

  it { should respond_to(:caption) }  
  it { should respond_to(:tags) }  
  it { should respond_to(:incident_name) }  
  it { should respond_to(:operational_period) }  
  it { should respond_to(:team_number) }  
  it { should respond_to(:taken_by) }  
  it { should respond_to(:time_taken) }  
  it { should respond_to(:image) }  
  it { should respond_to(:created_at) }  
  it { should respond_to(:updated_at) }  
  it { should respond_to(:edited) }
  it { should respond_to(:lat) }
  it { should respond_to(:lng) }
  
  it { should be_valid }

  it "has a to_frac method that works" do
    @photo.to_frac("1/2").should be == 0.5
    @photo.to_frac("6/2").should_not be == 2.9
  end
=begin
  it "sets its own fields with information" do
    mockphoto = mock_model(Photo)
    mockphoto.stub(:original_filename).and_return("orig")
    mockphoto.stub(:content_type).and_return(".png")
    mockphoto.stub(:read).and_return("binaryData")
    @photo.image_file = mockphoto
    @photo.filename.should eq(mockphoto.original_filename)
    @photo.contentType.should eq(mockphoto.content_type)
    @photo.image.should eq(mockphoto.read)
  end
=end



end
