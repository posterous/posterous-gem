require 'helper'

describe Postly::Site do
  include Postly

  before(:all) do
    @site     = Site.create(:hostname => "newpostly#{Time.now.to_i}")
    @primary  = Site.find('primary')
  end

  it "should find the primary site" do
    @primary.name.should =~ /dethray/
  end

  it "should have posts" do
    @primary.posts.should be_an Array
  end

  it "should find all sites" do
    @sites = Site.all(:page => 1)

    @sites.should be_an Array
  end

  describe "creating and updating a site" do
  
    it "should create a site" do
      @site.name.should =~ /postly/
    end

    it "should update a site" do
      @site.is_private = true
      @site.save
      @site.reload.is_private.should be_true
    end

    it "should delete a site" do
      @site.destroy.should be_true
    end
  end

end
