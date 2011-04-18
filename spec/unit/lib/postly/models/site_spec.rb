require 'helper'

describe Postly::Site do
  include Postly

  before(:all) do
    @primary  = Site.find('primary')
  end

  it "should find the primary site" do
    @primary.name.should =~ /postertester/
  end
  
  describe "#all" do
    it "finds all the users sites" do
      @sites = Site.all(:page => 1)
      @sites.should be_an Array
    end
  end

  describe "CRUD" do

    before(:all) do
      @site     = Site.create(:hostname => "newpostly#{Time.now.to_i}")
      @site_id  = @site.id
    end
  
    describe "#create" do
      it "creates the site" do
        @site.name.should =~ /postly/
      end
    end
      
    describe "#save" do
      it "updates a site" do
        @site.is_private = true
        @site.save
        @site.reload.is_private.should be_true
      end
    end

    describe "#destroy" do
      it "deletes the site" do
        @site.destroy.should be_nil
        lambda {
          Site.find(@site_id)
        }.should raise_error Postly::Connection::ConnectionError
      end
    end
    
  end

end
