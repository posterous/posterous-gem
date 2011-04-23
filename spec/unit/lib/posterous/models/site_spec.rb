require 'helper'

describe Posterous::Site do
  include Posterous

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
      @site     = Site.create(:hostname => "newposterous#{Time.now.to_i}")
      @site_id  = @site.id
    end
  
    describe "#create" do
      it "creates the site" do
        @site.name.should =~ /posterous/
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
        }.should raise_error Posterous::Connection::ConnectionError
      end
    end
    
  end

end
