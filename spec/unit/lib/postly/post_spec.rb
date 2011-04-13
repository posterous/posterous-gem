require 'helper'

describe Postly::Post do
  include Postly

  before(:all) do
    @primary  = Site.find('primary')
    @posts    = Post.all(@primary.id)
  end

  it "should find the posts" do
    @posts.should be_an Array
  end

  describe "creating and updating a post" do
    before(:all) do
      @post = Post.create(@primary.id, {:title => 'from postly', :body => 'kittens are rad!'})
    end

    it "should create a post" do
      @post.title.should == 'from postly'
    end

    it "should update a post" do
      @post.title = 'updated via postly'
      @post.save
      @post.reload.title.should  == 'updated via postly'
    end

    it "should delete a post" do
      @post.destroy.should be_nil
    end
  end

end
