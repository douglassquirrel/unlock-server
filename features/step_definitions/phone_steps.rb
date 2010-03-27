require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "phone"))

Given /^I have called the service$/ do
  visit '/?format=voicexml'
end

When /^I select choice ([0-9*#])$/ do |choice|
  urls = apply_xpath("/v:vxml/v:form/v:filled/v:if[@cond=\"choice == '#{choice}'\"]/v:submit/@next", body)
  assert (!urls.nil? and urls.size == 1), "Choice #{choice} not available"
  url = "#{urls[0]}?format=voicexml"
  visit url
end

