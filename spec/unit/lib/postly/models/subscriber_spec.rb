require 'helper'

FAKE_USER_ID = 637118

describe Postly::Subscriber do
  include Postly

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

  describe "CRUD" do
    before(:all) do
      @subscriber     = @primary.subscribers.create({:user_id => FAKE_USER_ID})
    end

    describe "#create" do
      it "creates a subscriber" do
        @primary.subscribers.all.first.id.should == FAKE_USER_ID
      end
    end

    describe "#destroy" do
      it "deletes a subscriber and raises a Connection error when not found" do
        @primary.subscribers.destroy(FAKE_USER_ID)
        lambda {
          @primary.subscribers.find(FAKE_USER_ID)
        }.should raise_error Postly::Connection::ConnectionError
      end
    end
  end

end
