Then /^I should hear the paragraphs$/ do |expected_paragraphs|
  doc = Nokogiri::XML(body)
  nodes = doc.xpath("/v:vxml/v:form/v:block[1]/v:prompt/v:prosody/text()", 'v' => 'http://www.w3.org/2001/vxml')
  actual_paragraphs = [['text']] | nodes.collect { |node| [node.to_s] }
  expected_paragraphs.diff! actual_paragraphs
end

Then /^I should hear a menu with this information:$/ do |expected_menu|
  doc = Nokogiri::XML(body)
  nodes = doc.xpath("/v:vxml/v:form/v:field[@name='choice']/v:prompt/v:prosody/text()", 'v' => 'http://www.w3.org/2001/vxml')
  actual_menu = [['text']] | nodes.collect { |node| [node.to_s] }
  expected_menu.diff! actual_menu
end

