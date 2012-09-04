Feature: Show Items
  In order to view items
  A User
  Should be able to see one item and list of items

    Scenario: User can see an item
      Given I exist as a user
        And I have an existing item
      When I go to my item show page
      Then I should see my item

    Scenario: User can see list of items
      Given I exist as a user
        And I have an existing item
        And There is some user with it's own item
      When I go to items index page
      Then I should see list of items

    Scenario: Visitor can see list of items
      Given I am not logged in
        And There is some user with it's own item
      When I go to items index page
      Then I should see some user items

    Scenario: Visitor can see an item
      Given I am not logged in
        And There is some user with it's own item
      When I go to some user item page
      Then I should see an item

    Scenario: Visitor can see list of tag items
      Given I am not logged in
        And There is some user with it's own item
      When I go to tag page
      Then I should see some user items
