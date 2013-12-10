require 'spec_helper'
include ValidUserRequestHelper

describe PhotosController do

  before do
    sign_in_as_a_valid_admin
    get :index, { edited: 'true', :incident => 'All'} # this is the default params
  end

  describe "GET #index" do
    before(:each) do
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
  
  describe "GET #edit_queue" do
    it "renders the unedited index" do
      get :edit_queue
      response.should redirect_to(photos_path(:edited=>'false'))
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
    
    context "no photos passed in" do
      before(:each) do
        post :create, :photo => nil
      end
      
      it "redirects to the uploads page" do
        response.should redirect_to new_photo_path
      end
      
      it "notifies an error" do
        flash[:alert].should_not be_nil
      end
    end
    
    context "save failed" do
      before(:each) do
        Photo.any_instance.stub(:save).and_return(false)
        post :create, photo: FactoryGirl.attributes_for(:photo)
      end
      
      it "redirects to the uploads page" do
        response.should redirect_to new_photo_path
      end
      
      it "notifies an error" do
        flash[:alert].should_not be_nil
      end
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
  
  describe "GET #facebook_auth" do
    before(:each) do
      @image = FactoryGirl.create(:photo)
      get :facebook_auth, id: @image.id
    end
    
    it "saves photo id into session" do
      session["facebook_state"][0].should == @image.id.to_s
    end
    
    it "redirects to omniauth handler" do
      response.should redirect_to "/auth/facebook"
    end
  end
  
  describe "POST #facebook_upload" do
    before(:each) do 
      @image = FactoryGirl.create(:photo)
    end
    
    context "successful authentication" do
      before(:each) do
        allow_message_expectations_on_nil
        session["facebook_state"]=[@image.id, "message"]
        session["facebook_token"].stub_chain(:[],:[]).and_return("token")
        Photo.any_instance.stub(:image_url).and_return("fakeurl.com")
        FbGraph::User.any_instance.stub(:photo!)
        @controller.stub(:open)
        post :facebook_upload, id:@image.id
      end
      
      it "updates the flash" do
        flash[:notice].should == "Photo Uploaded to Facebook"
      end
      
      it "redirects to photo" do
        response.should redirect_to photo_path(@image.id)
      end
    end
  end
  
  describe "GET #flickr_auth" do
    before(:each) do
      @image = FactoryGirl.create(:photo)
    end
    
    context "successful authentication" do
      it "calls upload" do
        flickr.test.stub(:login).and_return(true)
        @controller.stub(:flickr_upload).and_return(true)
        session['flickr_authenticated'] = 'true'
        
        controller.should_receive(:flickr_upload)
        get :flickr_auth, id: @image.id
      end
      
    end
    context "unsuccessful authentication" do
      before(:each) do
        flickr.test.stub(:login).and_raise("error")
        flickr.stub(:get_request_token).and_return("token")
        get :flickr_auth, id: @image.id
      end
      
      it "saves the token in the session" do
        session['flickr_token'].should == "token"
      end
      
    end
  end
  
  describe "POST #flickr_upload" do
    before(:each) do
      @image = FactoryGirl.create(:photo)
    end
    
    context "successfully authenticated" do
      before(:each) do
        session['flickr_authenticated'] = 'true'
        FlickRaw::Flickr.any_instance.stub(:upload_photo)
        Photo.any_instance.stub(:image_url).and_return("fakeurl.com")
        post :flickr_upload, id: @image.id
      end
      
      it "updates the flash" do
        flash[:notice].should_not be_nil
      end
      
      it "redirects to photo's page" do
        response.should redirect_to photo_path(@image)
      end
    end
    context "unsuccessfully authenticated" do
      context "failed to login" do
        before(:each) do
          session['flickr_authenticated'] = 'false'
          session['flickr_token'] = "this token is legit"
          session['flickr_token'].stub(:[]).and_return(true)
          FlickRaw::Flickr.any_instance.stub(:upload_photo)
          post :flickr_upload, id: @image.id, code: "seemslegit"
        end
        
        it "updates the flash with an error" do
          flash[:error].should_not be_nil
        end
      end
      context "gets access token" do
        it "changes the session" do
          session['flickr_token'] = "this token is legit"
          session['flickr_token'].stub(:[]).and_return(true)
          FlickRaw::Flickr.any_instance.stub(:upload_photo)
          FlickRaw::Flickr.any_instance.stub(:get_access_token)
          #flickr.stub(:access_token).and_return('token')
          #flickr.stub(:access_secret).and_return('secret')
          FlickRaw::Flickr.any_instance.stub_chain("test.login").and_return(true)
          post :flickr_upload, id: @image.id, code: "seemslegit"
          
          session['flickr_authenticated'].should == 'true'
        end
      end
    end
  end
end
