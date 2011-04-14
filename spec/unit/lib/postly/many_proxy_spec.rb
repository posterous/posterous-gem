require 'helper'

describe Postly::ManyProxy do
  include Postly

  before(:all) do
    @primary  = Site.find('postertester')
  end

  describe "#posts" do
    it "gets the posts for the site" do
      @primary.posts.all.should be_an Array
    end
  end

  describe "#posts.create" do
    it "creates a post for the site" do
      post = @primary.posts.create(:title => 'from proxy')
      post.title.should == 'from proxy'
      post.destroy
    end
  end

end
