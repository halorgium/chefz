require File.dirname(__FILE__) + '/spec_helper'

describe "A node being deployed" do
  it "works" do
    node = Chefz::Node.run(["main"], File.dirname(__FILE__) + "/fixtures/simple")
    node.data.should == {:test => 1}
  end
end
