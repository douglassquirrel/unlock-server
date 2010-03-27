Feature: View site
  In order to use the Internet more independently
  As a visually-impaired person
  I want to get data from an inaccessible site using my phone

  Background:
    Given there is an extractor running with the following pages:
      |path         |title                      |paragraphs                                   |links                                                     |
      |/bigco/      |BigCo - For All Things Big |BigCo is super.,Visit your local BigCo store!|Find A Store+/bigco/stores                                |
      |/bigco/stores|Find A Store               |                                             |Margate Road+/bigco/store1,Towcester Central+/bigco/store2|
      |/bigco/store1|Margate Road Store         |Open 24 hours,Deli and Bakery                |Back to stores+/bigco/stores                              |
      |/bigco/store2|Towcester Central Store    |Open Monday-Friday,Home Furnishings          |Back to stores+/bigco/stores                              |

    Given the following sites:
      |name |short_name|
      |BigCo|bigco     |

  Scenario: Visit home page 
    Given I have called the service
    And I have selected choice 1
    Then the service should provide valid VoiceXML with correct settings
    And I should hear the paragraphs
      |text                         |
      |BigCo - For All Things Big   |
      |BigCo is super.              |
      |Visit your local BigCo store!|
    And I should hear a menu with this information:
      |text                         |
      |Press 1 for Find A Store     |

  Scenario: Visit store locator page 
    Given I have called the service
    And I have selected choice 1
    And then I have selected choice 1
    Then the service should provide valid VoiceXML with correct settings
    And I should hear the paragraphs
      |text                         |
      |Find A Store                 |
    And I should hear a menu with this information:
      |text                         |
      |Press 1 for Margate Road     |
      |Press 2 for Towcester Central|

  Scenario: Visit store page 
    Given I have called the service
    And I have selected choice 1
    And then I have selected choice 1
    And then I have selected choice 2
    Then the service should provide valid VoiceXML with correct settings
    And I should hear the paragraphs
      |text                         |
      |Towcester Central Store      |
      |Open Monday-Friday           |
      |Home Furnishings             |
    And I should hear a menu with this information:
      |text                         |
      |Press 1 for Back to stores   |
