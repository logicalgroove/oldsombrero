def valid_item_params
  {:name => 'Sombrero', :price => 5, :period => 'day', :description => 'This sombrero may be old, but it kicks some serious hats.'}
end

def new_item_params
  {:name => 'Truck Cap', :price => 50, :period => 'moth', :description => 'Feel the wind.'}
end

When /^I create a new valid item$/ do
  visit '/items/new'
  fill_in "Name", :with => valid_item_params[:name]
  fill_in "Price", :with => valid_item_params[:price]
  fill_in "Period", :with => valid_item_params[:period]
  fill_in "Description", :with => valid_item_params[:description]
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

When /^There is another user with it's own item$/ do
  @another_user = FactoryGirl.create(:user, :email => 'another_user@example.com')
  @another_item = FactoryGirl.create(:item, :name => 'Evil Hat', :user => @another_user)
end

When /^I go to another's item page$/ do
  visit item_path(@another_item)
end

Then /^I should not see an "(.*?)" link$/ do |link|
  page.should_not have_link(link)
end

When /^I go to item show page$/ do
  visit item_path(@item)
end

Then /^I should see an item$/ do
  page.should have_content(@item.name)
end

When /^I go to items index page$/ do
  visit items_path
end

Then /^I should see list of items$/ do
  page.should have_content(@item.name)
  page.should have_content(@another_item.name)
end
