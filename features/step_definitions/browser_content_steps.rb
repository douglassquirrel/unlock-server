Then /^I should see the title "([^\"]*)"$/ do |title|
  Then "I should see \"#{title}\" within \"h1\""
end

Then /^I should see these paragraphs:$/ do |expected_paragraphs|
  doc = Nokogiri::HTML(body)
  actual_paragraphs = [['text']] | doc.xpath("//p/text()").collect { |node| [node.to_s] }
  expected_paragraphs.diff! actual_paragraphs
end

Then /^I should see no paragraphs$/ do
  doc = Nokogiri::HTML(body)
  assert doc.xpath("//p").empty?
end

Then /^I should see these links:$/ do |expected_links|
  doc = Nokogiri::HTML(body)
  actual_links = [['text', 'url']] | doc.xpath("//ul/li/a").collect { |node| [node.xpath("text()").to_s, node.xpath("@href").to_s] }
  expected_links.diff! actual_links
end

Then /^I should see no links$/ do
  doc = Nokogiri::HTML(body)
  assert doc.xpath("//a").empty?
end
