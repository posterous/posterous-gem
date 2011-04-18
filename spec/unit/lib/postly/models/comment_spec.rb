require 'helper'

describe Postly::Comment do
  include Postly

  before(:all) do
    @primary  = Site.find('primary')
    @post     = @primary.posts.all.first
  end

  describe "#all" do
    before(:all) do
      @comments = @post.comments.all
    end

    it "finds the comments" do
      @comments.should be_an Array
      @comments.each{|p| p.id.should_not be_nil }
    end
  end

  describe "CRUD" do
    before(:all) do
      @comment     = @post.comments.create({:body => 'kittens are rad!'})
      @comment_id  = @comment.id
    end

    describe "#create" do
      it "creates a comment" do
        @comment.body.should == 'kittens are rad!'
      end
    end

    describe "#save" do 
      it "updates a comment" do
        @comment.body = 'updated via commently'
        @comment.save
        @comment.reload.body.should  == 'updated via commently'
      end
    end

    describe "#destroy" do
      it "deletes a comment and raises a Connection error when not found" do
        @comment.destroy
        lambda {
          @post.comments.find(@comment.id)
        }.should raise_error Postly::Connection::ConnectionError
      end
    end
  end

end

