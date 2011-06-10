require 'helper'
ENV['POSTEROUS_DEBUG'] = '1'
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

  describe "#save" do
    before do
      @user.profile_pic = SAMPLE_IMAGE
      @user.save
    end

    it "sets the profile image" do
      @user.reload.profile_pic.should =~ /metal.png/
    end
  end

end
