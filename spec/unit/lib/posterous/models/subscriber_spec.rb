require 'helper'

FAKE_USER_ID = 637118

describe Posterous::Subscriber do
  include Posterous

  before(:all) do
    @primary = Site.find('primary')
  end

  describe "#all" do
    before(:all) do
      @subscribers = @primary.subscribers.all
    end

    it "finds the subscribers" do
      @subscribers.should be_an Array
      @subscribers.each{|p| p.id.should_not be_nil }
    end
  end

end
