require 'helper'

describe Postly::ExternalSite do
  include Postly

  before(:all) do
    @primary = Site.find('primary')
  end

  describe "#all" do
    before(:all) do
      @external_sites = @primary.external_sites.all
    end

    it "finds the external_sites" do
      @external_sites.should be_an Array
      @external_sites.each{|p| p.id.should_not be_nil }
    end
  end

  describe "CRUD" do
    before(:all) do
      @external_site     = @primary.external_sites.create({
        :site_url     => 'http://chrisburnett.tumblr.com', 
        :service_type => 'ExtTumblr',
        :username     => 'foo'
      })
      @external_site_id  = @external_site.id
    end

    describe "#create" do
      it "creates a external_site" do
        @external_site.site_url.should == 'http://chrisburnett.tumblr.com'
      end
    end

    #describe "#save" do 
      #it "updates a external_site" do
        #@external_site.site_url = 'http://chrisburnett.tumblr.com'
        #@external_site.save
        #@external_site.reload.blogid.should  == 'bar'
      #end
    #end

    describe "#destroy" do
      it "deletes a external_site and raises a Connection error when not found" do
        @external_site.destroy
        lambda {
          @primary.external_sites.find(@external_site.id)
        }.should raise_error Postly::Connection::ConnectionError
      end
    end
  end

end
