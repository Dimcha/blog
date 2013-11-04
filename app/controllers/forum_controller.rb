class ForumController < ApplicationController

  before_filter :find_category, :only => [:ticket_list, :category_destroy, :ticket_list, :ticket_new]
  before_filter :find_ticket, :only => [:ticket_destroy, :ticket, :comment_create]

  def categories
    @categories = ForumCategory.select("forum_categories.*, count(tickets.id) AS ticket_number").
                                joins("LEFT JOIN tickets ON tickets.category_id = forum_categories.id").
                                group("forum_categories.id")
  end

  def category_new
  end

  def category_create
    @category = ForumCategory.new
    @category.name = params[:category][:name]
    @category.owner_id = 0
    @category.category_start = Time.now()
    if @category.save
      flash[:status] = "Category was successfully created"
      redirect_to :action => :categories
    else
      flash[:status] = "Category was not created"
      redirect_to :action => :category_new
    end
  end

  def category_destroy
    @category.destroy

    flash[:status] = "Category was successfully deleted"
    redirect_to :action => :categories
  end

  def ticket_list
    @tickets = @category.tickets.select("tickets.*, count(comments.id) AS comment_number").
                         joins("LEFT JOIN comments ON comments.ticket_id = tickets.id").
                         group("tickets.id")
  end

  def ticket_new
  end

  def ticket_create
    @ticket = Ticket.new
    @ticket.category_id = params[:category_id].to_i
    @ticket.ticket_start = Time.now
    @ticket.summary = params[:ticket][:summary]
    if @ticket.save
      flash[:status] = "Ticket was successfully created"
      redirect_to :action => :ticket_list, :id => @ticket.category_id
    else
      flash[:status] = "Ticket was not created"
      redirect_to :action => :ticket_new, :id => @ticket.category_id
    end
  end

  def ticket_destroy
    category_id = @ticket.category_id
    @ticket.destroy

    flash[:status] = "Category was successfully deleted"
    redirect_to :action => :ticket_list, :id => category_id
  end

  def ticket
    @category = ForumCategory.find(@ticket.category_id)
    @comments = @ticket.comments
  end

  def comment_create
    @comment = Comment.new
    @comment.content = params[:comment][:content].to_s
    @comment.ticket_id = @ticket.id
    @comment.comment_time = Time.now()
    if @comment.save
      flash[:status] = "Comment was successfully created"
    else
      flash[:status] = "Comment was not created"
    end
    redirect_to :action => :ticket, :id => @ticket.id
  end

  private

  def find_category
    @category = ForumCategory.where(id: params[:id].to_i).first
    if @category.nil?
      redirect_to :action => :categories and return false
    end
  end

  def find_ticket
    @ticket = Ticket.where(id: params[:id].to_i).first
    if @ticket.nil?
      redirect_to :action => :categories and return false
    end
  end
end