When /^I visit the nonexistent "([^\"]*)" page$/ do |path|
  get path
end

Then /^I should see a helpful, accessible "Not Found" page$/ do
  assert_response :missing
end



