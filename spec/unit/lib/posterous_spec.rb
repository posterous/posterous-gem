require 'helper'

describe Posterous do
  describe "#config=" do
    describe "with hash" do
      before do
        Posterous.config = {'user' => 'me@foo.com','passsword' => 'foobar'}
      end
      it "should set the config" do
        Posterous.config.should be_a Hash
      end
    end
    describe "with file" do
      before do
        Posterous.config = SAMPLE_CONFIG
      end
      it "should set the config" do
        Posterous.config.should be_a Hash
      end
    end
  end
end
