module ValidationHelpers
  def validate(body, doctype, schema_filename)
    assert_match /<\?xml version="1.0" encoding="UTF-8"\?>/, body, "Missing XML declaration"
    assert_match doctype, body, "Incorrect doctype"

    assert_nothing_raised(Nokogiri::XML::SyntaxError) {
      schema_file = open(File.join(File.dirname(__FILE__), "..", "support", schema_filename))
      doc = Nokogiri::XML(body) { |config| config.options = Nokogiri::XML::ParseOptions::STRICT }
      xsd = Nokogiri::XML::Schema(schema_file)
      assert xsd.valid?(doc), "XHTML not valid: #{xsd.validate(doc)}"
    }    
  end

  def check_present(body, xpath, message)
    doc = Nokogiri::XML(body)
    assert !doc.xpath(xpath, 'v' => 'http://www.w3.org/2001/vxml').empty?, message
  end

  def check_not_present(body, xpath, message)
    doc = Nokogiri::XML(body)
    assert doc.xpath(xpath, 'v' => 'http://www.w3.org/2001/vxml').empty?, message
  end
end

World(ValidationHelpers)
