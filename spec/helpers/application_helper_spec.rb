require "spec_helper"

describe ApplicationHelper do
  describe "#b_add" do
    it "returns image_tag add png" do
      helper.b_add.should eq('<img alt="Add" src="/assets/icons/add.png" title="Add" /> ')
    end
  end
end