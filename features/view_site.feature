Feature: View site
  In order to use the Internet more independently
  As a visually-impaired person
  I want to get data from an inaccessible site using my browser

  Background:
    Given there is an extractor running with the following pages:
      |path   |title                      |paragraphs                                   |
      |/bigco/|BigCo - For All Things Big |BigCo is super.,Visit your local BigCo store!|

    Given the following sites:
      |name |short_name|
      |BigCo|bigco     |

  Scenario: Visit simple home page
    Given I am on the accessible "bigco" page
    Then I should see the title "BigCo - For All Things Big"
    And I should see these paragraphs: 
      |text                         | 
      |BigCo is super.              |
      |Visit your local BigCo store!|
