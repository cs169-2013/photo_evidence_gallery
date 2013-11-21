require 'spec_helper'

describe User do
  before(:all) do
    @user = User.new(email: 'example@example.com', 
    password: 'example12',
    password_confirmation: 'example12',
    role: 'admin',
    info: {:incident_name => 'incident faked',
    :taken_by => 'taken faked',
    :operational_period => 'operation faked',
    :team_number => 'team faked'})
  end
  
  subject { @user }

  it { should respond_to(:email) }  
  it { should respond_to(:password) }  
  it { should respond_to(:password_confirmation) }  
  it { should respond_to(:info) }  
  
  it { should be_valid }

  describe "has valid serialization" do
    it "for incident_name" do
      @user.info.to_hash[:incident_name].should == 'incident faked'
    end
    it "for taken_by" do
      @user.info.to_hash[:taken_by].should == 'taken faked'
    end
    it "for operational_period" do
      @user.info.to_hash[:operational_period].should == 'operation faked'
    end
    it "for team_number" do
      @user.info.to_hash[:team_number].should == 'team faked'
    end
  end

  describe "serialization updates" do
    before(:each) do
      @user.info = {:incident_name => 'incident real',
      :taken_by => 'taken real',
      :operational_period => 'operation real',
      :team_number => 'team real'}
      @user.save
    end

    it "for incident_name" do
      @user.info.to_hash[:incident_name].should == 'incident real'
    end
    it "for taken_by" do
      @user.info.to_hash[:taken_by].should == 'taken real'
    end
    it "for operational_period" do
      @user.info.to_hash[:operational_period].should == 'operation real'
    end
    it "for team_number" do
      @user.info.to_hash[:team_number].should == 'team real'
    end
  end
  


end
