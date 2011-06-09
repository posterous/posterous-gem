require 'helper'

describe Posterous::ExternalSite do
  include Posterous

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
end
