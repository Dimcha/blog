require 'spec_helper'

describe ForumCategory do

  it 'should create forum category' do
    category = ForumCategory.new({name: "General", category_start: Time.now, owner_id: 0})
    category.should be_valid
  end

  it 'should require forum category name' do
    category = ForumCategory.new({category_start: Time.now, owner_id: 0})
    category.should_not be_valid
  end
end