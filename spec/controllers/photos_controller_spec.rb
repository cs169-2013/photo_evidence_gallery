require 'spec_helper'

describe PhotosController do
  let(:factphoto) { FactoryGirl.create(:photo) }
    
  describe "GET #index" do
    before(:each) do
      photo1 = Photo.create!(:edited => true)
      get :index
    end
    
    it "populates an array of photos" do
      assigns(:photos).should_not be_nil
      assigns(:photos).length.should == 1
      assigns(:photo_pack).length.should == 1
    end
    
    it "leaves @binsize number of photos in each row" do
      @counter = 0
      while @counter < assigns(:bin_size)
        @counter+=1
        Photo.create!(:filename => "name_#{@counter}", :edited => true)
      end
      get :index
      
      assigns(:photos).length.should == assigns(:bin_size) + 1
      assigns(:photo_pack).length.should == 2
    end
    
    it "renders the :index view" do
      get :index 
      response.should render_template :index
    end 
  end
  
  describe "GET #new" do
    it "renders the :new view" do
      get :new 
      response.should render_template :new
    end 
  end
  
  
end
