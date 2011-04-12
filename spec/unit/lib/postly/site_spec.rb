require 'helper'

describe Postly::Site do
  include Postly

  before do
    @site = Site.create(:hostname => "postly#{Time.now.to_i}")
  end

  it "should find a site" do
    Site.find('dethray').name.should =~ /dethray/
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
      @site.save(:is_private => true)
      @site.is_private.should be_true
    end
  end

end
