require 'helper'

describe Postly::Link do
  include Postly

  before(:all) do
    @primary        = Site.find('postertester')
    @link_category  = @primary.link_categories.all.first
  end

  describe "#all" do
    before(:all) do
      @links = @link_category.links.all
    end

    it "finds the links" do
      @links.should be_an Array
      @links.each{|p| p.id.should_not be_nil }
    end
  end

  describe "CRUD" do
    before(:all) do
      @link     = @link_category.links.create({:title => 'kittens are rad!', :url => 'http://google.com'})
      @link_id  = @link.id
    end

    describe "#create" do
      it "creates a link" do
        @link.title.should == 'kittens are rad!'
      end
    end

    describe "#save" do 
      it "updates a link" do
        @link.title = 'updated via postly'
        @link.save
        @link.reload.title.should  == 'updated via postly'
      end
    end

    describe "#destroy" do
      it "deletes a link and raises a Connection error when not found" do
        @link.destroy
        lambda {
          @link_category.links.find(@link.id)
        }.should raise_error Postly::Connection::ConnectionError
      end
    end
  end

end

