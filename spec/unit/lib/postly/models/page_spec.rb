require 'helper'

describe Postly::Page do
  include Postly

  before(:all) do
    @primary = Site.find('postertester')
  end

  describe "#all" do
    before(:all) do
      @pages = @primary.pages.all
    end

    it "finds the pages" do
      @pages.should be_an Array
      @pages.each{|p| p.id.should_not be_nil }
    end
  end

  describe "CRUD" do
    before(:all) do
      @page     = @primary.pages.create({:title => 'from postly', :body => 'kittens are rad!'})
      @page_id  = @page.id
    end

    describe "#create" do
      it "creates a post" do
        @page.title.should == 'from postly'
      end
    end

    describe "#save" do 
      it "updates a page" do
        @page.title = 'updated via postly'
        @page.save
        @page.reload.title.should  == 'updated via postly'
      end
    end

    describe "#destroy" do
      it "deletes a page and raises a Connection error when not found" do
        @count = @primary.pages.all.count
        @page.destroy
        lambda {
          @primary.pages.find(@page.id)
        }.should raise_error Postly::Connection::ConnectionError
      end
    end
  end

end
