require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "phone"))

Given /^I have called the service$/ do
  visit '/?format=voicexml'
end

When /^I select choice ([0-9*#])$/ do |choice|
  doc = Nokogiri::XML(body)
  nodes = doc.xpath("/v:vxml/v:form/v:filled/v:if[@cond=\"choice == '#{choice}'\"]/v:submit/@next", voicexml_namespace)
  assert (!nodes.nil? and nodes.size == 1), "Choice #{choice} not available"
  url = nodes[0].to_s + '?format=voicexml'
  visit url
end

