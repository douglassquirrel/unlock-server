Feature: Navigate available sites
  In order to find out how to use the Internet more independently
  As a visually-impaired person
  I want to discover what accessible sites are available using my telephone

  Background:
    Given there is an extractor running with the following pages:
      |path      |title            |paragraphs                 |
      |/metailer/|MeTailer, Limited|MeTailer is great!,Buy now!|

    Given the following sites:
      |name             |short_name|
      |BigCo            |bigco     |
      |MeTailer, Limited|metailer  |

  Scenario: Hear menu
    Given I have called the service
    Then the service should provide valid VoiceXML with correct settings
    And I should hear the paragraphs
      |text                 |
      |Welcome to BlindPages|
    And I should hear a menu with this information:
      |text                         |
      |Press 1 for BigCo            |
      |Press 2 for MeTailer, Limited|    

  Scenario: Visit site
    Given I have called the service
    When I select choice 2
    Then the service should provide valid VoiceXML with correct settings
