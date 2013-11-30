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
      post :destroy, id: @viewer
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
  
  describe "PATCH #update" do
  
    new_test_pass = 'password123'  
    
    context "as an admin" do
      it "updates its own password" do
        patch :update, :id => @admin, :current_user => @admin, :user => {:current_password => @admin.password, :password => new_test_pass, :password_confirmation => new_test_pass}
        response.should redirect_to edit_user_path(@admin)
        flash[:notice].should eq("User updated.")
      end
      
      it "updates other's passwords (if known)" do
        patch :update, :id => @viewer, :current_user => @admin, :user => {:current_password => @viewer.password, :password => new_test_pass, :password_confirmation => new_test_pass}
        response.should redirect_to edit_user_path(@viewer)
        flash[:notice].should eq("User updated.")
      end
      
      it "doesn't do anything if new password not specified" do
        patch :update, :id => @admin, :current_user => @admin, :user => {:current_password => @admin.password}
        response.should redirect_to edit_user_path(@admin)
      end
    end
    
    context "as a member" do
      before(:each) do
        sign_in(:user, @member)
      end
      
      it "updates its own password" do
        patch :update, :id => @member, :current_user => @member, :user => {:current_password => @member.password, :password => new_test_pass, :password_confirmation => new_test_pass}
        response.should redirect_to edit_user_path(@member)
        flash[:notice].should eq("User updated.")
      end
      
      it "errors if current password is incorrect" do
        patch :update, :id => @member, :current_user => @member, :user => {:current_password => "wrongpass", :password => new_test_pass, :password_confirmation => new_test_pass}
        response.should redirect_to edit_user_path(@member)
        flash[:alert].should eq("Current password incorrect.")
      end
      
      it "errors if the two passwords don't match" do
        patch :update, :id => @member, :current_user => @member, :user => {:current_password => @member.password, :password => new_test_pass, :password_confirmation => "not the same"}
        response.should redirect_to edit_user_path(@member)
        flash[:alert].should eq("Passwords do not match.")
      end
      
      it "doesn't allow simple passwords" do
        patch :update, :id => @member, :current_user => @member, :user => {:current_password => @member.password, :password => "short", :password_confirmation => "short"}
        response.should redirect_to edit_user_path(@member)
        flash[:alert].should eq("Couldn't update user. Try a more complicated password.")
      end
    end
  end
end
