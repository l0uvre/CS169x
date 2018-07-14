Feature: Add or edit categories
  As a blog administrator
  In order to manage my categories
  I want to be able to create new categories and modify the categories

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    Then I am on the admin page
    
  Scenario: Successfully enter the categories page
    Given I follow "Categories"
    Then I should see "Categories"
    And I should see "Keywords"
    And I should see "Description"
    
  Scenario: Successfully create a new category
    Given I follow "Categories"
    And I fill in "Name" with "Travel"
    And I fill in "Keywords" with "Life"
    And I fill in "Description" with "A travel category blog"
    And I press "Save"
    Then I should see "Travel"
    And I should see "A travel category blog"
    
  Scenario: Successfully edit an existent category
    Given I follow "Categories"
    And I follow "General"
    And I fill in "Keywords" with "Life"
    And I fill in "Description" with "A travel category blog"
    And I press "Save"
    Then I should see "Life"
    And I should see "A travel category blog"
    