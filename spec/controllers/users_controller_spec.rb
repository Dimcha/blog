require 'spec_helper'

describe UsersController do
  def attr
    {
      username: "Test user",
      password: "test_user1",
      first_name: "Vardenis",
      last_name: "Pavardenis",
      email: "user@example.com",
      phone: "37061234567"
    }
  end

  valid_session = {
    :user_params => {}
  }

  describe "GET index" do
    it "assigns all users as @users" do
      user = User.create! attr
      get :index, {}, valid_session
      assigns(:users).should eq([user])
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! attr
      get :show, {:id => user.id}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "GET registration" do
    it "assigns a new user as @user" do
      get :registration, {}, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new User" do
        valid_session[:user_step] = "contacts"
        expect {
          post :create, {:user => attr}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        valid_session[:user_step] = "contacts"
        post :create, {:user => attr}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the user list" do
        valid_session[:user_step] = "contacts"
        post :create, {:user => attr}, valid_session
        response.should redirect_to(:root)
      end

      it "redirects to the user list on cancel" do
        valid_session[:user_step] = "login"
        post :create, {:user => attr, :cancel => "Cancel"}, valid_session
        response.should redirect_to(:root)
      end

      it "redirects to the previous step on back" do
        valid_session[:user_step] = "contacts"
        post :create, {:user => attr, :back_button => "Back"}, valid_session
        response.inspect.should include('"user_step"=>"details"')
      end

      it "redirects to the user next step on back" do
        valid_session[:user_step] = "details"
        post :create, {:user => attr}, valid_session
        response.inspect.should include('"user_step"=>"contacts"')
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        valid_session[:user_step] = "contacts"
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => {}}, valid_session
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        valid_session[:user_step] = "contacts"
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => {}}, valid_session
        response.should render_template("registration")
      end
    end
  end

end