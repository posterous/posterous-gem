require 'helper'

describe Postly::Comment do
  include Postly

  before(:all) do
    @primary  = Site.find('postertester')
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

  #describe "CRUD" do
    #before(:all) do
      #@comment     = Comment.create(@primary.id, {:title => 'from commently', :body => 'kittens are rad!'})
      #@comment_id  = @comment.id
    #end

    #describe "#create" do
      #it "creates a comment" do
        #@comment.title.should == 'from commently'
      #end
    #end

    #describe "#save" do 
      #it "updates a comment" do
        #@comment.title = 'updated via commently'
        #@comment.save
        #@comment.reload.title.should  == 'updated via commently'
      #end
    #end

    #describe "#destroy" do
      #it "deletes a comment and raises a Connection error when not found" do
        #@comment.destroy
        #lambda {
          #Comment.find(@primary.id, @comment.id)
        #}.should raise_error Commently::Connection::ConnectionError
      #end
    #end
  #end

end

