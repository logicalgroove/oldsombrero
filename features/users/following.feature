Feature: Following
  In order to get items from following tags or users
  A user
  Should be able to follow tags or users

    Scenario: User is following tag
      Given I exist as a user
        And I am logged in
        And There is some user with it's own item
      When I go to tag page
       And I click follow link
      Then I should see following tag message

    Scenario: User is following some user
      Given I exist as a user
        And I am logged in
        And There is some user with it's own item
      When I go to some user page
       And I click follow link
      Then I should see following user message

    Scenario: User can not follow tag again
      Given I exist as a user
        And I am logged in
        And There is some user with it's own item
        And I follow that tag already
      When I go to tag page
      Then I don't see a follow link

    Scenario: User can not follow some user again
      Given I exist as a user
        And I am logged in
        And There is some user with it's own item
        And I follow that user already
      When I go to some user page
      Then I don't see a follow link

    Scenario: Visitor can not follow tag
      Given I do not exist as a user
        And There is some user with it's own item
      When I go to tag page
      Then I don't see a follow link

    Scenario: Visitor can not follow user
      Given I do not exist as a user
        And There is some user with it's own item
      When I go to some user page
      Then I don't see a follow link
