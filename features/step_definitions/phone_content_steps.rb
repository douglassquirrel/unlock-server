Then /^I should hear the paragraphs$/ do |expected_paragraphs|
  doc = Nokogiri::XML(body)
  nodes = doc.xpath("/v:vxml/v:form/v:block[1]/v:prompt/v:prosody/text()", 'v' => 'http://www.w3.org/2001/vxml')
  actual_paragraphs = [['text']] | nodes.collect { |node| [node.to_s] }
  expected_paragraphs.diff! actual_paragraphs
end

Then /^I should hear a menu with this information:$/ do |expected_menu|
  doc = Nokogiri::XML(body)
  menu_nodes = doc.xpath("/v:vxml/v:form/v:field[@name='choice']/v:prompt/v:prosody/text()", 'v' => 'http://www.w3.org/2001/vxml')
  actual_menu = [['text']] | menu_nodes.collect { |node| [node.to_s] }
  expected_menu.diff! actual_menu

  expected_grammar_items = (1..expected_menu.rows.size).to_a.collect { |i| i.to_s }
  grammar_item_nodes = doc.xpath("/v:vxml/v:form/v:field[@name='choice']/v:grammar[@xml:lang='en-GB' and @root='top' and @mode='dtmf']/v:rule[@id='top']/v:one-of/v:item/text()", 
                                 'v' => 'http://www.w3.org/2001/vxml')
  actual_grammar_items = grammar_item_nodes.collect { |node| node.to_s }
  assert_equal expected_grammar_items, actual_grammar_items, "Grammar should list expected DTMF tones"
end

