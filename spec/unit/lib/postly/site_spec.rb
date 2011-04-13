require 'helper'

#VCR.use_cassette('site') do

describe Postly::Site do
  include Postly

  before(:all) do
    VCR.use_cassette('site_create_and_find') do
      @site     = Site.create(:hostname => "newpostly#{Time.now.to_i}")
      @primary  = Site.find('postertester')
    end
  end

  it "should find the primary site" do
    @primary.name.should =~ /postertester/
  end

  it "should have posts" do
    @primary.posts.should be_an Array
  end

  it "should find all sites" do
    VCR.use_cassette('site_all') do
      @sites = Site.all(:page => 1)
    end
    @sites.should be_an Array
  end

  describe "creating and updating a site" do
  
    it "should create a site" do
      @site.name.should =~ /postly/
    end

    it "should update a site" do
      @site.is_private = true
      VCR.use_cassette('site_save_and_reload') do
        @site.save
        @site.reload.is_private.should be_true
      end
    end

    it "should delete a site" do
      VCR.use_cassette('site_destroy') do
        @site.destroy.should be_true
      end
    end
  end

end

#end
