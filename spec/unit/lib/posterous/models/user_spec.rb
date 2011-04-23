require 'helper'

describe Posterous::Site do
  include Posterous

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
