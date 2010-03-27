module PhoneHelpers
  def apply_xpath(xpath_expression, body)
    doc = Nokogiri::XML(body)
    nodes = doc.xpath(xpath_expression, 'v' => 'http://www.w3.org/2001/vxml')
    return nodes.collect { |node| node.to_s }
  end
end

World(PhoneHelpers)
