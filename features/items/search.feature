Feature: Search Items
  In order to find specific items
  A user
  Should be able to make a tag search request

  Scenario: User searches for items and gets result
      Given I exist as a user
        And I am logged in
        And There is some user with it's own item
      When I make search request with existing tag
      Then I should see at least one item with a searched tag

  Scenario: User searches for items and gets result
      Given I exist as a user
        And I am logged in
        And There is some user with it's own item
      When I make search request with not existing tag
      Then I should see a not found message
