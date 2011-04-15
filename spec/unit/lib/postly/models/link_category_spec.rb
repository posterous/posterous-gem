require 'helper'

describe Postly::LinkCategory do
  include Postly

  before(:all) do
    @primary = Site.find('postertester')
  end

  describe "#all" do
    before(:all) do
      @link_categories = @primary.link_categories.all
    end

    it "finds the link_categories" do
      @link_categories.should be_an Array
      @link_categories.each{|p| p.id.should_not be_nil }
    end
  end
  
  describe "CRUD" do
    before(:all) do
      @link_category     = @primary.link_categories.create({:title => 'from postly', :display_order => 1 })
      @link_category_id  = @link_category.id
    end

    describe "#create" do
      it "creates a post" do
        @link_category.title.should == 'from postly'
      end
    end

    describe "#save" do 
      it "updates a link_category" do
        @link_category.title = 'updated via postly'
        @link_category.save
        @link_category.reload.title.should  == 'updated via postly'
      end
    end

    describe "#destroy" do
      it "deletes a link_category and raises a Connection error when not found" do
        @count = @primary.link_categories.all.count
        @link_category.destroy
        lambda {
          @primary.link_categories.find(@link_category.id)
        }.should raise_error Postly::Connection::ConnectionError
      end
    end
  end

end
