require 'helper'

describe Posterous::Page do
  include Posterous

  before(:all) do
    @primary = Site.find('primary')
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
      @page     = @primary.pages.create({:title => 'from posterous', :body => 'kittens are rad!'})
      @page_id  = @page.id
    end

    describe "#create" do
      it "creates a post" do
        @page.title.should == 'from posterous'
      end
    end

    describe "#save" do 
      it "updates a page" do
        @page.title = 'updated via posterous'
        @page.save
        @page.reload.title.should  == 'updated via posterous'
      end
    end

    describe "#destroy" do
      it "deletes a page and raises a Connection error when not found" do
        @count = @primary.pages.all.count
        @page.destroy
        lambda {
          @primary.pages.find(@page.id)
        }.should raise_error Posterous::Connection::ConnectionError
      end
    end
  end

end
