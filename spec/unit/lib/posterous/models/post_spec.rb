require 'helper'

describe Posterous::Post do
  include Posterous

  before(:all) do
    @primary = Site.find('primary')
  end

  describe "#all" do
    before(:all) do
      @posts = @primary.posts.all
    end

    it "finds the posts" do
      @posts.should be_an Array
      @posts.each{|p| p.id.should_not be_nil }
    end
  end

  describe "CRUD" do
    before(:all) do
      @post     = @primary.posts.create({:title => 'from posterous', :body => 'kittens are rad!'})
      @post_id  = @post.id
    end

    describe "#create" do
      it "creates a post" do
        @post.title.should == 'from posterous'
      end
    end

    describe "#save" do 
      it "updates a post" do
        @post.title = 'updated via posterous'
        @post.save
        @post.reload.title.should  == 'updated via posterous'
      end
    end

    describe "#destroy" do
      it "deletes a post and raises a Connection error when not found" do
        @count = @primary.posts.all.count
        @post.destroy
        lambda {
          @primary.posts.find(@post.id)
        }.should raise_error Posterous::Connection::ConnectionError
      end
    end
  end

end
