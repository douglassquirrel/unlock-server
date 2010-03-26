require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "validation"))

Then /^the page should be valid XHTML$/ do
  validate(body, %r|<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">|, 'xhtml1-strict.xsd')
end

Then /^the service should provide valid VoiceXML$/ do
  validate(body, %r|<!DOCTYPE vxml PUBLIC "-//W3C//DTD VOICEXML 2.1//EN" "http://www.w3.org/TR/voicexml21/vxml.dtd"|, 'vxml.xsd')
end


