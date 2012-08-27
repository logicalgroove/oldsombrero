def valid_item_params
  {:name => 'Sombrero', :price => 5, :period => 'day', :description => 'This sombrero may be old, but it kicks some serious hats.'}
end

def invalid_item_params
  {:price => 5, :period => 'day'}
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
