require 'spec_helper'

describe UsersHelper do
  it "raises an error" do
    @admin = FactoryGirl.create(:admin)
    expect{current_user? @admin}.to raise_error #local variable not set
  end
end
