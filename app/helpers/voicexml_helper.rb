module VoicexmlHelper
  def add_prompt(xml, text)
    xml.prompt do
      xml.prosody({"rate" => "-20%"}, text)
      xml.break "time" => "500ms"
    end
  end

  def add_grammar(xml, number)
    xml.grammar "xml:lang"=>"en-GB", "root"=>"top", "mode"=>"dtmf" do
      xml.rule "id"=>"top" do
        xml.__send__('one-of'.to_sym) do
          (1..number).each do |i| 
            xml.item i
          end
        end
      end
    end
  end
end

