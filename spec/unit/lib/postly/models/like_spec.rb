require 'helper'

describe Postly::Like do
  include Postly

  before(:all) do
    @primary  = Site.find('primary')
    @post     = @primary.posts.all.first
  end

  describe "#all" do
    before(:all) do
      @likes = @post.likes.all
    end

    it "finds the likes" do
      @likes.should be_an Array
      @likes.each{|p| p.id.should_not be_nil }
    end
  end

  describe "CRUD" do
    before(:all) do
      @like     = @post.likes.create
      @like_id  = @like.id
    end

    describe "#create" do
      it "creates a like" do
        @like.id.should_not be_nil
      end
    end

    describe "#destroy" do
      it "deletes a like and raises a Connection error when not found" do
        @like.destroy
        lambda {
          @post.likes.find(@like.id)
        }.should raise_error Postly::Connection::ConnectionError
      end
    end
  end

end

