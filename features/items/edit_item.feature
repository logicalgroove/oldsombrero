Feature: Edit Item
  In order to edit an item
  An owner
  Should be able to update an item

    Scenario: Owner updates his item with valid params
      Given I exist as a user
        And I am logged in
        And I have an existing item
      When I update my item with valid params
      Then I should see an item updated message

    Scenario: Owner updates his item with invalid params
      Given I exist as a user
        And I am logged in
        And I have an existing item
      When I update my item with invalid params
      Then I should see an item not updated message

    Scenario: User updates another's item
      Given I exist as a user
        And I am logged in
        And There is some user with it's own item
      When I go to some user item page
      Then I should not see an "Edit" link
