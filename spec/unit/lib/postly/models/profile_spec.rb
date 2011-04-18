require 'helper'

describe Postly::Profile do
  include Postly

  before(:all) do
    @site    = Site.find('primary')
    @site.profile.load.destroy
    @profile = @site.profile.create(:group_profile_name => 'some profile name')
  end

  describe "#load" do
    it "should get the profile" do
      @profile.group_profile_name.should == 'some profile name'
    end
  end

  describe "#save" do
    it "should update the profile" do
      @profile.body = 'updated'
      @profile.save
      @profile.body.should == 'updated'
    end
  end
  
end
