Then /^I should see the title "([^\"]*)"$/ do |title|
  Then "I should see \"#{title}\" within \"h1\""
end

Then /^I should see a list with caption "([^\"]*)"$/ do |caption|
  assert_have_selector 'h2#caption + ul > li'
  Then "I should see \"#{caption}\" within \"h2#caption\""
end

Then /^I should see these paragraphs:$/ do |expected_paragraphs|
  doc = Nokogiri::HTML(body)
  actual_paragraphs = [['text']] | doc.xpath("//p/text()").collect { |node| [node.to_s] }
  expected_paragraphs.diff! actual_paragraphs
end

