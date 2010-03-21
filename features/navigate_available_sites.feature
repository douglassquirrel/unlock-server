Feature: Navigate available sites
  In order to find out how to use the Internet more independently
  As a visually-impaired person
  I want to discover what accessible sites are available using my browser

  Background:
    Given there is an extractor running with the following pages:
      |path      |title          |paragraphs                 |
      |/metailer/|MeTailer, Ltd. |MeTailer is great!,Buy now!|

    Given the following sites:
      |name          |short_name|
      |BigCo         |bigco     |
      |MeTailer, Ltd.|metailer  |

  Scenario: Visit home page
    Given I am on the home page
    Then the page should be valid XHTML
    And I should see the title "Welcome to BlindPages"
    And I should see no paragraphs
    And I should see these links:
      |text          |url      |
      |BigCo         |/bigco   |
      |MeTailer, Ltd.|/metailer|     

  Scenario: Visit site
    Given I am on the home page
    When I follow "MeTailer, Ltd."
    Then I should be on the accessible "metailer" page
    And the page should be valid XHTML

