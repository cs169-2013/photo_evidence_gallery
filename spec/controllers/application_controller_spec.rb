require 'spec_helper'

describe ApplicationController do
=begin
  describe "#authenticate_admin!" do
    it "errors if the user is invalid" do
      controller.stub(:authenticate_user!).and_return(false)
      controller.authenticate_admin!
      flash[:error].should_not be_nil
    end
    
    it "errors if the current user is not an admin" do
    end
  end
  describe "#authenticate_member!" do
  end
=end
end
