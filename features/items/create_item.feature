Feature: Create Item
  In order to add a new item
  A user
  Should be able to create an item

    Scenario: User creates a valid item
      Given I exist as a user
        And I am logged in
      When I create a new valid item
      Then I should see an item created message

    Scenario: User creates a valid item with image
      Given I exist as a user
        And I am logged in
      When I create a new valid item with image
      Then I should see a created item with image

    Scenario: User creates an invalid item
      Given I exist as a user
        And I am logged in
      When I create a new invalid item
      Then I should see an item not created message
