require 'spec_helper'
include ValidUserRequestHelper

describe PhotosController do

  before do
    sign_in_as_a_valid_user
    get :index, { edited: 'true', :incident => 'All'} # this is the default params
    get :index, { edited: 'true', :incident => 'All'} # session needs to get saved, forcing redirect
  end

  describe "GET #index" do
    before(:each) do
      #sign_in_as_a_valid_user
      photo1 = Photo.create!(:edited => true, :incident_name => 'Kevin')
      get :index, { edited: 'true', :incident => 'All'} # this is the default params
      get :index, { edited: 'true', :incident => 'All'} # session needs to get saved, forcing redirect
    end

    it "hi" do
      #pending "so i wrote a dead test to make the other tests pass...this is pretty awk"
      #get :index
      #response.should render_template :index
    end
    
    it "populates an array of photos" do
       response.should render_template :index
       assigns(:photos).should_not be_nil
       assigns(:photos).length.should == 1
       assigns(:photo_pack).length.should == 1
    end
    
    it "leaves @binsize number of photos in each row" do
      @counter = 0
      while @counter < assigns(:bin_size)
        @counter+=1
        Photo.create!(:taken_by => "name_#{@counter}", :edited => true)
      end
      get :index, { edited: 'true', :incident => 'All'}
      
      assigns(:photos).length.should == assigns(:bin_size) + 1
      assigns(:photo_pack).length.should == 2
    end
    
    it "renders the :index view" do
      response.should render_template :index
    end 

    it "can sort by incident" do
      get :index, { edited: 'true', :incident => 'Kevin'}
      get :index, { edited: 'true', :incident => 'Kevin'}
      assigns(:photos).length.should == 1

      get :index, { edited: 'true', :incident => 'Eddy'}
      get :index, { edited: 'true', :incident => 'Eddy'}
      assigns(:photos).length.should == 0
    end

    it "should render the edited_queue" do
      photo2 = Photo.create!(:edited => false)
      photo3 = Photo.create!(:edited => false)
      get :index, { edited: 'false', :incident => 'All' } #this is the same as edit_queue_path
      get :index, { edited: 'false', :incident => 'All' } # session needs to get saved, forcing redirect
      assigns(:photos).should_not be_nil
      assigns(:photos).length.should == 2
      assigns(:photo_pack).length.should == 1
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
      
      it "notices for queueing a photo" do
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
    end
    
    context "with valid attributes" do
      it "updates photo" do
        expect{
          put :update, id: @photo1.id, photo: FactoryGirl.attributes_for(:photo)
        }.to_not change(Photo, :count)
        @photo1.taken_by.should_not == Photo.last.taken_by
        @photo1.image.should_not == Photo.last.image
      end
      
      it "redirects to the edit photo's page" do
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
  
  describe "DELETE #destroy" do
    it "redirects to the root" do
      @photo1 = Photo.create!()
      post :destroy, id: @photo1.id
      response.should redirect_to photos_url
    end
  end
      
  describe "GET #make_multiple" do
    before(:each){
      @image = FactoryGirl.create(:photo)
      Photo.stub(:new).and_return(@image)
    }
    
    context "multiple photos are in params" do
      before(:each){
        post :make_multiple, :photos => {:images => [@image]}
      }
      it "redirects to the multiple uploads page" do
        response.should redirect_to photos_multiple_uploads_path
      end
      
      it "notifies that photos have been uploaded" do
        flash[:notice].should_not be_nil
      end
    end
    
    context "no photos passed in" do
      before(:each){
        post :make_multiple, :photos => nil
      }
      it "redirects to the multiple uploads page" do
        response.should redirect_to photos_multiple_uploads_path
      end
      
      it "notifies an error" do
        flash[:alert].should_not be_nil
      end
    end
  end
end
