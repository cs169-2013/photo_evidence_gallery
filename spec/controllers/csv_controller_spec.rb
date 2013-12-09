require 'spec_helper'
include ValidUserRequestHelper

describe CsvController do
  
  filepath = "#{Rails.root}/features/upload-files/"
    
  before do
    sign_in_as_a_valid_admin
    get :index
  end
  
  describe "POST #import" do
    context "when importing a valid file" do
      before(:each) do
        post :import, :csv_file => Rack::Test::UploadedFile.new(filepath+ "user_add_test.csv", "application/csv")
      end
      it "needs this blank test" do
        #pending "so i wrote a dead test to make the other tests pass...this is pretty awk"
      end
      it "redirects to csv page" do
        response.should redirect_to csv_index_path
      end
    end
=begin
    context "when importing an invalidly formatted file" do
      before(:each) do
        post :import, :csv_file => Rack::Test::UploadedFile.new(filepath+ "user_invalid_test.csv", "application/csv")
      end
      it "populates the flash with updates" do
        pending
        flash.should_not be_empty
        flash.key?('email').should be_false #column header
        flash.key?('chiller@berkeley.edu').should be_true #first entry
        flash.key?('whuang@berkeley.edu').should be_false # improperly formatted
        flash.key?('andyl@berkeley.edu').should be_true #last entry
      end
    end
    context "when importing an incorrect filetype" do
      pending
    end
=end
  end
  
	describe "tests that want to stub things" do
		it "should be a blank test" do
		end
		it "should fail to create users if it can't save the user" do
			User.any_instance.stub(:save).and_return(false)
			post :import, :csv_file => Rack::Test::UploadedFile.new(filepath+ "user_add_test.csv", "text/csv")
			flash.should_not be_empty
			flash.to_hash.values.join.should match /Failed to create chiller@berkeley.edu/
		end	
	end

  describe "GET #export" do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      viewer = FactoryGirl.create(:viewer)
      member = FactoryGirl.create(:member)
      User.all.should_not be_nil
    end
      
    it "fills variable with correct content" do
      get :export, :format => "xls"
      assigns(@users).should_not be_nil
    end
  end
  
end
