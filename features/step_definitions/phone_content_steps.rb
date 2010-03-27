require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "phone"))

Then /^I should hear the paragraphs$/ do |expected_paragraphs|
  actual_paragraphs = [['text']] | apply_xpath("/v:vxml/v:form/v:block[1]/v:prompt/v:prosody/text()", body).collect { |s| [s] }
  expected_paragraphs.diff! actual_paragraphs
end

Then /^I should hear a menu with this information:$/ do |expected_menu|
  actual_menu = [['text']] | apply_xpath("/v:vxml/v:form/v:field[@name='choice']/v:prompt/v:prosody/text()", body).collect { |s| [s] }
  expected_menu.diff! actual_menu

  expected_grammar_items = (1..expected_menu.rows.size).collect { |i| i.to_s }
  actual_grammar_items = apply_xpath("/v:vxml/v:form/v:field[@name='choice']/v:grammar/v:rule/v:one-of/v:item/text()", body)
  assert_equal expected_grammar_items, actual_grammar_items, "Grammar should list expected DTMF tones"
end

