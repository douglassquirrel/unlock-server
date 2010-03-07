Given /^(?:a|another) test site named "([^\"]*)" with short name "([^\"]*)"$/ do |name, short_name|
  Site.register Site.new(name, short_name)
end

Then /^I should see the title "([^\"]*)"$/ do |title|
  Then "I should see \"#{title}\" within \"h1\""
end

Then /^I should see a list with caption "([^\"]*)"$/ do |caption|
  assert_have_selector 'h2#caption + ul > li'
  Then "I should see \"#{caption}\" within \"h2#caption\""
end




