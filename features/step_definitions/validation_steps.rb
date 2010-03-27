require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "validation"))

Then /^the page should be valid XHTML$/ do
  validate(body, %r|<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">|, 'xhtml1-strict.xsd')
end

Then /^the service should provide valid VoiceXML with correct settings$/ do
  validate(body, %r|<!DOCTYPE vxml PUBLIC "-//W3C//DTD VOICEXML 2.1//EN" "http://www.w3.org/TR/voicexml21/vxml.dtd"|, 'vxml.xsd')
  check_present(body, "/v:vxml/v:property[@name='inputmodes' and @value='dtmf']", "Should limit input to DTMF tones")
  check_present(body, "/v:vxml/v:form/v:block/v:prompt[1]/v:break[@time='1000ms']", "Should pause before speaking")
  check_not_present(body, "//v:prompt[v:prosody and not(v:break[@time='500ms'])]", "Should pause after each prompt")
end


