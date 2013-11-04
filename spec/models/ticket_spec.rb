require 'spec_helper'

describe Ticket do

  it 'should create new ticket' do
    ticket = Ticket.new({summary: "Test Ticket", ticket_start: Time.now, category_id: 0, resolution: "new", last_update: Time.now})
    ticket.should be_valid
  end

  it 'should create new ticket without any information' do
    ticket = Ticket.new
    ticket.should be_valid
  end
end