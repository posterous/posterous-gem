require 'helper'

describe Postly::ManyProxy do
  include Postly

  before(:all)  do
    @primary  = Site.find('postertester')
    @posts    = @primary.posts.all
  end

  describe "#posts" do
    it "gets the posts for the site" do
      @posts.should be_an Array
    end
  end

  describe "#parsed_resource_url" do
    it "builds the resource url" do
      @posts.first.parsed_resource_url.should == "/sites/#{@primary.id}/posts"
    end
  end

  describe "when chained" do
    it "should forward the finder opts" do
      @primary.posts.all.first.comments.all.should be_an Array
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
