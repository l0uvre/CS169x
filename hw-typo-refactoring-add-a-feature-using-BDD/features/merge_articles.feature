Feature: Merge two articles
  As a blog administrator
  In order to reduce the redundancy of contents.
  I want to be able to merge two similar articles into one.

  Background: A blog set up
      Given the blog is set up
      
      Given the following users:
        | login  | password | email | profile_id | name | state | 
        | user_a | 12345678 | test@westworld.org | 2 | UserA | active |
        | user_b | 12345678 | test2@westworld.org | 3 | UserB | active |
      And the following articles:
        |id | type    | title     | author | body      | user_id | published_at | allow_comments | state | published |
        | 3 | Article | westworld_title | user_a | westworld | 2 | 2018-07-11 13:24:43 | true | published | true |
        | 4 | Article | eastworld_title | user_b | eastworld | 3 | 2018-07-11 13:24:59 | true | published | true |
      And the following comments:
        | id | type | author | body | article_id | user_id | created_at |
        | 1 | Comment | user_a | Comment1 | 3 | 2 | 2018-07-11 21:31:00 |
        | 2 | Comment | user_b | Comment2 | 4 | 3 | 2018-07-11 22:01:00 |
 
    
  Scenario: A non-admin user should not be able to merge articles
    Given I sign in with login "user_a" and password "12345678"
    And I am on the edit page of an artice whose id is 3
    Then I should not see "Merge Articles"
    
  Scenario: Admin should see all artices
    Given I am logged into the admin panel
    And I follow "All Articles"
    Then I should see "westworld"
    And I should see "UserA"
    And I am on the edit page of an artice whose id is 3
    And I should see "Merge Articles"

  Scenario: Successfully merge two articles into one
    Given I am logged into the admin panel
    And I am on the edit page of an artice whose id is 3
    Then I should see "westworld"
    And I merge the artice with the other's id 4
    Then I should see "Merge"
    And I am on the edit page of an artice whose id is 3
    Then I should see "westworld" 
    And I should see "eastworld"
  
    
  Scenario: The merged artice should have only one author
    Given I am logged into the admin panel
    And I am on the edit page of an artice whose id is 3
    And I merge the artice with the other's id 4
    And I am on the admin content page
    Then I should see "UserA" 

  Scenario: The merged artice should inherit all comments from the previous two
    Given I am logged into the admin panel
    And I am on the edit page of an artice whose id is 3
    And I merge the artice with the other's id 4
    And I am on the home page
    And I should not see "eastworld_title"
    When I follow "westworld_title"
    Then I should see "Comment1" 
    And I should see "Comment2"
    
  Scenario: The merged artice should inherit either of the previous two's titles
    Given I am logged into the admin panel
    And I am on the edit page of an artice whose id is 3
    And I merge the artice with the other's id 4
    And I am on the home page
    Then I should see "westworld_title"
    When I follow "westworld_title"
    And I should not see "eastworld_title"
