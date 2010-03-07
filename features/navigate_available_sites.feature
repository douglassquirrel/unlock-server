Feature: Navigate available sites
  In order to find out how to use the Internet more independently
  As a visually-impaired person
  I want to discover what accessible sites are available

  Background:
    Given a test site named "BigCo"
      And another test site named "MeTailer"

  Scenario: Visit home page
    Given I am on the home page
    Then I should see the title "Welcome to BlindPages"
      And I should see a list with caption "Sites available through BlindPages"

  Scenario: Visit site
    Given I am on the home page
    When I follow "BigCo"
    Then I should be on the accessible "BigCo" page with path "/bigco"
