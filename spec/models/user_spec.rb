require 'spec_helper'
require 'factory_girl'

describe User do
  it "should create a new user given valid attributes" do
    Factory.create(:user)
  end

  it "should require an email address" do
    u = User.new(Factory.attributes_for(:user, :email => nil))
    u.valid?.should == false
  end

  it "should require an email address" do
    u = User.new(Factory.attributes_for(:user, :email => "dougvk@gmail.com", :title => nil))
    u.valid?.should == false
  end

  it "should authenticate with correct username and password" do
    user = Factory(:user, :email => "dougvk@gmail.com", :password => "password")
    User.authenticate('dougvk@gmail.com', 'password').should == user
  end

  it "should not authenticate with incorrect username and password" do
    user = Factory(:user, :email => "dougvk@gmail.com", :password => "password")
    User.authenticate('dougvk@gmail.com', 'incorrect').should be_nil
  end
end
