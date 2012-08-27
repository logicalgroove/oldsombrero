require 'spec_helper'

describe Item do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @valid_item_attr = {:name => 'Sombrero', :price => 5, :period => 'day', :description => 'This sombrero may be old, but it kicks some serious hats.'}
  end

  it "should be created given a valid attribute" do
    item = @user.items.new(@valid_item_attr)
    item.should be_valid
  end

end
