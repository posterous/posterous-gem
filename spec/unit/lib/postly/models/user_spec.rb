require 'helper'

describe Postly::Site do
  include Postly

  before(:all) do
    @user = User.me
  end

  it "should find me" do
    @user.nickname.should =~ /postertester/
  end
  
  describe "#favorites" do
    it "finds all the users favorites" do
      @user.favorites.should be_an Array
    end
  end

end
