require 'spec_helper'

describe Comment do

  it 'should create new comment' do
    comment = Comment.new({content: "Hello World!!!", ticket_id: 1, user_id: 0, comment_time: Time.now})
    comment.should be_valid
  end

  it 'should create new ticket without any information' do
    comment = Comment.new
    comment.should be_valid
  end
end