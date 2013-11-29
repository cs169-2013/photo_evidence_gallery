require 'spec_helper'

describe UsersController do
  before(:each) do
    sign_in_as_a_valid_admin
    @admin = FactoryGirl.create(:admin)
    @viewer = FactoryGirl.create(:viewer)
    @member = FactoryGirl.create(:member)
  end
  
  describe "GET #index" do
    before(:each) do
      get :index
    end
    
    it "awk" do
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "renders the :index view" do
      response.should render_template :index
    end
    
    it "populates @users with users" do
      assigns(:users).should_not be_nil
      assigns(:users).should have(4).users
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      post :destroy, id: @viewer.id
    end
    
    it "removes the user" do
      User.all.length.should eq(3)
    end
    
    it "notifies that a user has been destroyed" do
      flash[:notice].should_not be_nil
    end
    
    it "redirects to the users page" do
      response.should redirect_to users_path
    end
  end
end
