class UsersController < ApplicationController

  def index
    @users = User.all
    session.delete(:user_step)
    session.delete(:user_params)
  end

  def show
    @user = User.find(params[:id])
  end

  def registration
    @user = User.new
    session[:user_params] ||= {}
    @user = User.new(session[:user_params])
    @user.current_step = session[:user_step]
  end

  def create
    session[:user_params].deep_merge!(params[:user]) if params[:user].present?
    @user = User.new(session[:user_params])
    @user.current_step = session[:user_step]
    if @user.valid? or params[:back_button].present?
      if params[:back_button].present?
        @user.previous_step
        @user.errors.clear
      elsif @user.last_step?
        @user.save if @user.all_valid?
      else
        @user.next_step
      end
      session[:user_step] = @user.current_step
    end
    if @user.new_record?
      render "registration"
    else
      session.delete(:user_step)
      session.delete(:user_params)
      flash[:notice] = "User saved!"
      redirect_to :root
    end
  end
end