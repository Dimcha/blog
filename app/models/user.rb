# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base

  attr_accessible :username, :password, :email, :phone, :first_name, :last_name
  attr_writer :current_step

  validates :username, presence: { message: 'Username cannot be blank' },
            uniqueness: { message: 'Username has already been taken' },
            if: lambda { |o| o.current_step == 'login' }
  validates :password, presence: { message: 'Password cannot be blank' },
            if: lambda { |o| o.current_step == 'login' }
  validates :email, presence: { message: 'Email cannot be blank' },
            uniqueness: { message: 'Email is already in use' },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Wrong email format"},
            if: lambda { |o| o.current_step == 'contacts' }
  validates :phone, presence: { message: 'Phone number cannot be blank' },
            numericality: { message: 'Phone number must be numeric' },
            if: lambda { |o| o.current_step == 'contacts' }

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[login details contacts]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end