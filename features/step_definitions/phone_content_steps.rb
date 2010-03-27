require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "phone"))

Then /^I should hear the paragraphs$/ do |expected_paragraphs|
  doc = Nokogiri::XML(body)
  nodes = doc.xpath("/v:vxml/v:form/v:block[1]/v:prompt/v:prosody/text()", voicexml_namespace)
  actual_paragraphs = [['text']] | nodes.collect { |node| [node.to_s] }
  expected_paragraphs.diff! actual_paragraphs
end

Then /^I should hear a menu with this information:$/ do |expected_menu|
  doc = Nokogiri::XML(body)
  menu_nodes = doc.xpath("/v:vxml/v:form/v:field[@name='choice']/v:prompt/v:prosody/text()", voicexml_namespace)
  actual_menu = [['text']] | menu_nodes.collect { |node| [node.to_s] }
  expected_menu.diff! actual_menu

  expected_grammar_items = (1..expected_menu.rows.size).collect { |i| i.to_s }
  grammar_item_nodes = doc.xpath("/v:vxml/v:form/v:field[@name='choice']/v:grammar/v:rule/v:one-of/v:item/text()", voicexml_namespace)
  actual_grammar_items = grammar_item_nodes.collect { |node| node.to_s }
  assert_equal expected_grammar_items, actual_grammar_items, "Grammar should list expected DTMF tones"
end

