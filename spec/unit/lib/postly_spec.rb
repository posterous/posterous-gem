require 'helper'

describe Postly do
  describe "#config=" do
    describe "with hash" do
      before do
        Postly.config = {'user' => 'me@foo.com','passsword' => 'foobar'}
      end
      it "should set the config" do
        Postly.config.should be_a Hash
      end
    end
    describe "with file" do
      before do
        Postly.config = SAMPLE_CONFIG
      end
      it "should set the config" do
        Postly.config.should be_a Hash
      end
    end
  end
end
