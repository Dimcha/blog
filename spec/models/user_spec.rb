require "spec_helper"

describe User do

  before(:each) do
    @attr = {
      username: "Test user",
      password: "test_user1",
      first_name: "Vardenis",
      last_name: "Pavardenis",
      email: "user@example.com",
      phone: "37061234567"
    }
  end

  it "should create a new valid user" do
    User.create!(@attr)
  end

  it "should require a username" do
    no_username_user = User.new(@attr.merge(username: ""))
    no_username_user.should_not be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(email: ""))
    no_email_user.all_valid?
    no_email_user.should_not be_valid
  end

  it "should require valid email address" do
    bad_email_user = User.new(@attr.merge(email: "aaaaaa.lt"))
    bad_email_user.all_valid?
    bad_email_user.should_not be_valid
  end

  it "should require unique email address" do
    User.create!(@attr.merge(email: "aaa@aaa.lt"))
    not_unique_email_user = User.new(@attr.merge(email: "aaa@aaa.lt"))
    not_unique_email_user.all_valid?
    not_unique_email_user.should_not be_valid
  end

  it "should include steps" do
    steps = User.new(@attr).steps
    steps.should include("login", "details", "contacts")
  end

  it "should not include unknown steps" do
    steps = User.new(@attr).steps - ["login", "details", "contacts"]
    steps.should be_blank
  end

  it "should check current first step" do
    step = User.new(@attr).current_step
    step.should eq("login")
  end

  it "should get next step" do
    next_step = User.new(@attr).next_step
    next_step.should eq("details")
  end

  it "should get previous step" do
    u = User.new(@attr)
    u.next_step
    previous_step = u.previous_step
    previous_step.should eq("login")
  end

  it "should be first step" do
    first_step = User.new(@attr).first_step?
    first_step.should be_true
  end

  it "should be last step" do
    u = User.new(@attr)
    u.next_step
    u.next_step
    last_step = u.last_step?
    last_step.should be_true
  end

end