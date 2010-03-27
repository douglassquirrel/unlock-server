module VoicexmlHelper
  def add_prompt(xml, text)
    xml.prompt do
      xml.prosody({"rate" => "-20%"}, text)
      xml.break "time" => "500ms"
    end
  end
end
