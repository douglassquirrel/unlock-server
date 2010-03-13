Feature: Get error for bad paths
  In order to use the Internet more independently
  As a visually-impaired person
  I want to get helpful browser errors when I enter incorrect URLs

  ######### Need to make extractor on-the-fly configurable
  #Background:
    #Given there is an extractor running with the following pages:
    #  |path         |title            |paragraphs                        |
    #  |/atlantisbank|Bank Of Atlantis |Serving Atlanteans for 5000 years.|

    #Given the following sites:
    #  |name            |short_name  | 
    #  |Bank Of Atlantis|atlantisbank|

  Scenario: Visit nonexistent site
    When I visit the nonexistent "not-here" page
    Then I should see a helpful, accessible "Not Found" page

  Scenario: Visit nonexistent path on valid site
    When I visit the nonexistent "atlantisbank/not-here" page
    Then I should see a helpful, accessible "Not Found" page
