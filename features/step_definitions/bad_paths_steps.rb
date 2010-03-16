When /^I visit the nonexistent "([^\"]*)" page$/ do |path|
  get path
end

Then /^I should see a helpful, accessible "Not Found" page$/ do
  assert_response :missing
  doc = Nokogiri::HTML(@response.body)
  actual_paragraphs = [['text']] | doc.xpath("//p/text()").collect { |node| [node.to_s] }
  assert_equal [['text'], ['Sorry, cannot display that page.']], actual_paragraphs
end



