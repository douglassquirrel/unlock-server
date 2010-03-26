Feature: View site
  In order to use the Internet more independently
  As a visually-impaired person
  I want to get data from an inaccessible site using my browser

  Background:
    Given there is an extractor running with the following pages:
      |path         |title                      |paragraphs                                   |links                                                     |
      |/bigco/      |BigCo - For All Things Big |BigCo is super.,Visit your local BigCo store!|                                                          |
      |/bigco/stores|Find A Store               |                                             |Margate Road+/bigco/store1,Towcester Central+/bigco/store2|
      |/bigco/store1|Margate Road Store         |Open 24 hours,Deli and Bakery                |Back to stores+/bigco/stores                              |
      |/bigco/store2|Towcester Central Store    |Open Monday-Friday,Home Furnishings          |Back to stores+/bigco/stores                              |

    Given the following sites:
      |name |short_name|
      |BigCo|bigco     |

  Scenario: Visit simple home page with just text
    Given I am on the accessible "bigco" page
    Then the page should be valid XHTML
    And I should see the title "BigCo - For All Things Big"
    And I should see these paragraphs: 
      |text                         | 
      |BigCo is super.              |
      |Visit your local BigCo store!|
    And I should see no links

  Scenario: Visit page with just links
    Given I am on the accessible "bigco/stores" page
    Then the page should be valid XHTML
    And I should see the title "Find A Store"
    And I should see no paragraphs
    And I should see these links:
      |text             |url          |
      |Margate Road     |/bigco/store1|
      |Towcester Central|/bigco/store2|

  Scenario: Visit page with text and links
    Given I am on the accessible "bigco/store1" page
    Then the page should be valid XHTML
    And I should see the title "Margate Road Store"
    And I should see these paragraphs: 
      |text           | 
      |Open 24 hours  |
      |Deli and Bakery|
    And I should see these links:
      |text             |url          |
      |Back to stores   |/bigco/stores|
