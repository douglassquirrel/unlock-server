include VoicexmlHelper

class VoicexmlHelperTest < ActiveSupport::TestCase
  def test_add_prompt
    xml = Builder::XmlMarkup.new
    add_prompt(xml, "Hello, nice to talk to you")
    assert_equal '<prompt><prosody rate="-20%">Hello, nice to talk to you</prosody><break time="500ms"/></prompt>', xml.target!
  end

  def test_add_grammar
    xml = Builder::XmlMarkup.new
    add_grammar(xml, 3)
    assert_equal '<grammar mode="dtmf" xml:lang="en-GB" root="top"><rule id="top"><one-of><item>1</item><item>2</item><item>3</item></one-of></rule></grammar>', xml.target!
  end
end
