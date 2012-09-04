def valid_item_params
  {:name => 'Sombrero', :price => 5, :period => 'day', :description => 'This sombrero may be old, but it kicks some serious hats.', :tags => '#mexico, #hats #sansaparilla'}
end

def new_item_params
  {:name => 'Truck Cap', :price => 50, :period => 'moth', :description => 'Feel the wind.'}
end

def existing_tag
  Tag.create(:name => 'evil_hat')
end

When /^I create a new valid item$/ do
  visit '/items/new'
  fill_in "Name", :with => valid_item_params[:name]
  fill_in "Price", :with => valid_item_params[:price]
  fill_in "Period", :with => valid_item_params[:period]
  fill_in "Description", :with => valid_item_params[:description]
  fill_in "Tags", :with => valid_item_params[:tags]
  click_button "Create"
end

Then /^I should see an item created message$/ do
  page.should have_content 'successfully created'
end

When /^I create a new invalid item$/ do
  visit '/items/new'
  fill_in "Name", :with => ''
  fill_in "Price", :with => valid_item_params[:price]
  fill_in "Period", :with => valid_item_params[:period]
  fill_in "Description", :with => ''
  click_button "Create"
end

Then /^I should see an item not created message$/ do
  page.should have_content 'Something went wrong'
end

Given /^I have an existing item$/ do
  @item = FactoryGirl.create(:item, :user => @user)
end

When /^I update my item with valid params$/ do
  visit edit_item_path(@item)
  fill_in "Name", :with => new_item_params[:name]
  fill_in "Price", :with => new_item_params[:price]
  fill_in "Period", :with => new_item_params[:period]
  fill_in "Description", :with => new_item_params[:description]
  click_button "Update"
end

Then /^I should see an item updated message$/ do
  page.should have_content "#{new_item_params[:name]} was successfully updated"
end

When /^I update my item with invalid params$/ do
  visit edit_item_path(@item)
  fill_in "Name", :with => ''
  fill_in "Price", :with => new_item_params[:price]
  fill_in "Period", :with => new_item_params[:period]
  fill_in "Description", :with => new_item_params[:description]
  click_button "Update"
end

Then /^I should see an item not updated message$/ do
  page.should have_content 'Something went wrong'
end

When /^There is some user with it's own item$/ do
  @some_user = FactoryGirl.create(:user, :email => 'some_user@example.com')
  @some_item = FactoryGirl.create(:item, :name => 'Evil Hat', :user => @some_user)
  @some_item.tags << existing_tag
end

When /^I go to some user item page$/ do
  visit item_path(@some_item)
end

When /^I should see an item$/ do
  page.should have_content(@some_item.name)
end

Then /^I should not see an "(.*?)" link$/ do |link|
  page.should_not have_link(link)
end

When /^I go to my item show page$/ do
  visit item_path(@item)
end

Then /^I should see my item$/ do
  page.should have_content(@item.name)
end

When /^I go to items index page$/ do
  visit items_path
end

Then /^I should see list of items$/ do
  page.should have_content(@item.name)
  page.should have_content(@some_item.name)
end

Then /^I should see some user items$/ do
  page.should have_content(@some_item.name)
end

When /^I go to tag page$/ do
  visit tag_path(@some_item.tags.first.name)
end

When /^I go to some user page$/ do
  visit user_path(@some_user)
end

When /^I create a new valid item with image$/ do
  visit '/items/new'
  fill_in 'Name', :with => valid_item_params[:name]
  fill_in 'Price', :with => valid_item_params[:price]
  fill_in 'Period', :with => valid_item_params[:period]
  fill_in 'Description', :with => valid_item_params[:description]
  fill_in 'Tags', :with => valid_item_params[:tags]
  attach_file('item_image', "#{Rails.root}/features/fixtures/test.jpg")
  click_button 'Create'
end

Then /^I should see a created item with image$/ do
  page.should have_selector '.image'
end
