When /^I make search request with existing tag$/ do
  fill_in 'search', :with => 'Evil Hat'
  click_button 'Search'
end

Then /^I should see at least one item with a searched tag$/ do
  within('.items') do
    page.should have_content existing_tag.name
  end
end

When /^I make search request with not existing tag$/ do
  fill_in 'search', :with => 'This Hat Was Never Existed'
  click_button 'Search'
end

Then /^I should see a not found message$/ do
  page.should have_content 'Not found'
end
