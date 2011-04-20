require 'helper'

describe Postly::AssociationProxy do
  include Postly

  before(:all)  do
    @site  = Site.find('primary')
  end

  describe "#posts" do
    it "without params should be a Postly::Post" do
      @site.posts.should == Postly::Post
    end

    it "should load posts with params" do
      @site.posts(:page => 1).length.should be > 0
    end
  end

  #describe "#parsed_resource_url" do
    #it "builds the resource url" do
      #@posts.first.parsed_resource_url.should == "/sites/#{@primary.id}/posts"
    #end
  #end

  #describe "when chained" do
    #it "should forward the finder opts" do
      #@primary.posts.all.first.comments.all.should be_an Array
    #end
  #end

  #describe "#posts.create" do
    #it "creates a post for the site" do
      ##post = @primary.posts.create(:title => 'from proxy')
      ##post.title.should == 'from proxy'
      ##post.destroy
    #end
  #end

end
