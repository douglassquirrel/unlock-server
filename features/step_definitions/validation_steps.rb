Then /^the page should be valid (.*)$/ do |type|
  doctype, schema_filename = case type
  when "XHTML"
    [%r|<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">|, 'xhtml1-strict.xsd']
  else
    flunk "Unknown type #{type}"
  end
  assert_match /<\?xml version="1.0" encoding="UTF-8"\?>/, body, "Missing XML declaration"
  assert_match doctype, body, "Incorrect doctype"

  assert_nothing_raised(Nokogiri::XML::SyntaxError) {
    schema_file = open(File.join(File.dirname(__FILE__), "..", "support", schema_filename))
    doc = Nokogiri::XML(body) { |config| config.options = Nokogiri::XML::ParseOptions::STRICT }
    xsd = Nokogiri::XML::Schema(schema_file)
    assert xsd.valid?(doc), "XHTML not valid: #{xsd.validate(doc)}"
  }    
end
