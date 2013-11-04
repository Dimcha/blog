require 'spec_helper'

def category
  @category = ForumCategory.create!({name: "General", owner_id: 0, category_start: Time.now()})
end

def ticket
  @ticket = Ticket.create!({summary: "Test Ticket", ticket_start: Time.now, category_id: @category.id, resolution: "new", last_update: Time.now})
end

def comment
  @comment = Comment.create!({content: "Hello World!!!", ticket_id: @ticket.id, user_id: 0, comment_time: Time.now})
end

describe ForumController do
  describe "GET categories" do
    it "assigns all categories as @categories" do
      category
      get :categories
      assigns(:categories).should eq([@category])
    end
    it "renders the :categories view" do
      get :categories
      response.should render_template :categories
    end
  end

  describe "GET category_new" do
    it "renders the :category_new template" do
      get :category_new
      response.should render_template :category_new
    end
  end

  describe "POST category_create" do
    context "with valid attributes" do
      it "saves the new category in the database" do
        expect {
          post :category_create, category: {name: "General", owner_id: 0, category_start: Time.now()}
        }.to change(ForumCategory,:count).by(1)
      end
      it "redirects to :categories" do
        post :category_create, category: {name: "General", owner_id: 0, category_start: Time.now()}
        response.should redirect_to :action => :categories
      end
    end
    context "with invalid attributes" do
      it "does not save the new category in the database" do
        expect {
          post :category_create, category: {owner_id: 0, category_start: Time.now()}
        }.to_not change(ForumCategory,:count)
      end
      it "redirect back to the :category_new template" do
        post :category_create, category: {owner_id: 0, category_start: Time.now()}
        response.should redirect_to :action => :category_new
      end
    end
  end

  describe "POST category_destroy" do
    it "redirect back to the :categories template" do
      category
      post :category_destroy, id: @category.id
      response.should redirect_to :action => :categories
    end
    it "drops chosen category from the database" do
      category
      expect {
        post :category_destroy, id: @category.id
      }.to change(ForumCategory,:count).by(-1)
    end
  end

  describe "GET ticket_list" do
    it "assigns all tickets as @tickets" do
      category
      ticket
      get :ticket_list, {:id => @category.id}
      assigns(:tickets).should eq([@ticket])
    end
    it "renders the :ticket_list view" do
      category
      get :ticket_list, {:id => @category.id}
      response.should render_template :ticket_list
    end
  end

  describe "GET ticket_new" do
    it "renders the :ticket_new template" do
      category
      get :ticket_new, {:id => @category.id}
      response.should render_template :ticket_new
    end
  end

  describe "POST ticket_create" do
    context "with valid attributes" do
      it "saves the new ticket in the database" do
        category
        expect {
          post :ticket_create, category_id: @category.id, ticket: {summary: "Test Ticket"}
        }.to change(Ticket,:count).by(1)
      end
      it "redirects to :ticket_list" do
        category
        post :ticket_create, category_id: @category.id, ticket: {summary: "Test Ticket"}
        response.should redirect_to :action => :ticket_list, :id => @category.id
      end
    end
    context "with invalid attributes" do
      # so far ticket is valid in any condition
    end
  end

  describe "POST ticket_destroy" do
    it "redirect back to the :ticket_list template" do
      category
      ticket
      post :ticket_destroy, id: @ticket.id
      response.should redirect_to :action => :ticket_list, :id => @category.id
    end
    it "drops chosen ticket from the database" do
      category
      ticket
      expect {
        post :ticket_destroy, id: @ticket.id
      }.to change(Ticket,:count).by(-1)
    end
  end

  describe "GET ticket" do
    it "assigns all comments as @comments" do
      category
      ticket
      comment
      get :ticket, {:id => @ticket.id}
      assigns(:comments).should eq([@comment])
    end
    it "renders the :ticket template" do
      category
      ticket
      get :ticket, {:id => @ticket.id}
      response.should render_template :ticket
    end
  end

  describe "POST comment_create" do
    context "with valid attributes" do
      it "saves the new comment in the database" do
        category
        ticket
        expect {
          post :comment_create, id: @ticket.id, comment: {content: "Hello World!!!"}
        }.to change(Comment,:count).by(1)
      end
      it "redirect back to the :ticket template" do
        category
        ticket
        post :comment_create, id: @ticket.id, comment: {content: "Hello World!!!"}
        response.should redirect_to :action => :ticket, :id => @ticket.id
      end
    end
    context "with invalid attributes" do
      # so far comment is valid in any condition
    end
  end

  it "redirect to :categories template when ticket not found" do
    post :ticket_destroy, id: 0
    response.should redirect_to :action => :categories
  end

  it "redirect to :categories template when category not found" do
    category
    ticket
    post :category_destroy, id: 0
    response.should redirect_to :action => :categories
  end
end