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

  describe "POST #create" do
    context "with valid attributes" do
      it "creates new photo" do
        expect{
          post :create, photo: FactoryGirl.attributes_for(:photo)
        }.to change(Photo, :count).by(1)
      end
      
      it "redirects to the new photo's page" do
        post :create, photo: FactoryGirl.attributes_for(:photo)
        response.should redirect_to photo_path(Photo.last)
      end
      
      it "notifies that photo has been created" do
        post :create, photo: FactoryGirl.attributes_for(:photo)
        flash[:notice].should_not be_nil
      end
    end
    
    context "save failed" do
    end
  end
  
  describe "PATCH/PUT #update" do    
    before(:each) do
      @photo1 = Photo.create!()
      get :index
    end
    
    context "with valid attributes" do
      it "updates photo" do
        expect{
          put :update, id: @photo1.id, photo: FactoryGirl.attributes_for(:photo)
        }.to_not change(Photo, :count)
        @photo1.filename.should_not == Photo.last.filename
        @photo1.binaryData.should_not == Photo.last.binaryData
      end
      
      it "redirects to the updated photo's page" do
        put :update, id: @photo1.id, photo: FactoryGirl.attributes_for(:photo)
        response.should redirect_to photo_path(Photo.last)
      end
      
      it "notifies that photo has been created" do
        put :update, id: @photo1.id, photo: FactoryGirl.attributes_for(:photo)
        flash[:notice].should_not be_nil
      end
    end
    
    context "update failed" do
    end
  end
  
end
