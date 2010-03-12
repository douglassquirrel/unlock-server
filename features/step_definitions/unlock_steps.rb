Given /^there is an extractor running$/ do 
  @extractor = Extractor.new
end

Given /^the following sites:$/ do |site_table|
  site_table.hashes.each do |hash|
    Site.register Site.new(hash['name'], hash['short_name'])
  end
end

Given /^the following pages:$/ do |page_table|
  page_table.hashes.each do |page_data|
    @extractor.register_page page_data
  end
end

Then /^I should see the title "([^\"]*)"$/ do |title|
  Then "I should see \"#{title}\" within \"h1\""
end

Then /^I should see a list with caption "([^\"]*)"$/ do |caption|
  assert_have_selector 'h2#caption + ul > li'
  Then "I should see \"#{caption}\" within \"h2#caption\""
end

Then /^I should see these paragraphs:$/ do |expected_paragraphs|
  actual_paragraphs = [ ['text'], ['first para'], ['second para'] ]
  expected_paragraphs.diff! actual_paragraphs
end



