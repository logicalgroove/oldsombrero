Feature: Show Items
  In order to view items
  A User
  Should be able to see one item and list of items

    Scenario: User can see an item
      Given I exist as a user
        And I am logged in
        And I have an existing item
      When I go to item show page
      Then I should see an item

    Scenario: User can see list of items
      Given I exist as a user
        And I am logged in
        And I have an existing item
        And There is another user with it's own item
      When I go to items index page
      Then I should see list of items
