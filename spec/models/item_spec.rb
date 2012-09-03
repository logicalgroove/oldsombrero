require 'spec_helper'

describe Item do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @sombrero_tag = FactoryGirl.create(:tag, :name => 'sombrero')
    @mexico_tag = FactoryGirl.create(:tag, :name => 'mexico')
    @valid_item_attr = {:name => 'Sombrero', :price => 5, :period => 'day', :description => 'This sombrero may be old, but it kicks some serious hats.'}
  end

  it "should be created given a valid attribute" do
    item = @user.items.new(@valid_item_attr)
    item.should be_valid
  end

  it "should not be created with blank name" do
    item = @user.items.new(@valid_item_attr.merge(:name => ''))
    item.should_not be_valid
  end

  it "should not be created with blank price" do
    item = @user.items.new(@valid_item_attr.merge(:price => ''))
    item.should_not be_valid
  end

  it "should not be created with blank period" do
    item = @user.items.new(@valid_item_attr.merge(:period => ''))
    item.should_not be_valid
  end

  it "should have tags if created with tags" do
    item = @user.items.create(@valid_item_attr)
    item.tags << @sombrero_tag
    item.tags << @mexico_tag
    item.tags.count.should equal 2
  end

  it "should belongs to tag if created with tag" do
    item = @user.items.create(@valid_item_attr)
    item.tags << @sombrero_tag
    @sombrero_tag.items.count.should equal 1
  end

  it "should return search result with existing tag" do
    item = @user.items.create(@valid_item_attr)
    item.tags << @sombrero_tag
    items = Item.search_by_tags_name(['sombrero'])
    items.count.should_not equal 0
  end

  it "should not return search result with not existing tag" do
    item = @user.items.create(@valid_item_attr)
    item.tags << @sombrero_tag
    items = Item.search_by_tags_name(['this_hat_never_existed'])
    items.should be_nil
  end

end
