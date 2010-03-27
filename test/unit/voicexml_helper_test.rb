include VoicexmlHelper

class VoicexmlHelperTest < ActiveSupport::TestCase
  def test_add_prompt
    xml = Builder::XmlMarkup.new
    add_prompt(xml, "Hello, nice to talk to you")
    assert_equal '<prompt><prosody rate="-20%">Hello, nice to talk to you</prosody><break time="500ms"/></prompt>', xml.target!
  end
end
