require 'test/fake_extractor/fake_extractor'
require 'net/http'
require 'test_helper'
require 'uri'
require 'yaml'

class SiteTest < ActiveSupport::TestCase
  def test_fetches_content
    begin
      server_pid = start_extractor([{"path"=>"/ralphs/", "status_code"=>200,
                                     "title"=>"Ralph's Car Repair", "paragraphs"=>"You crash it.,We fix it.",
                                     "links"=>"Hours+/hours,Location+/location"}])

      site = Site.new("Ralph's Car Repair", "ralphs", "http://localhost:9999/ralphs")
      expected_content = {"status_code" => 200, "title" => "Ralph's Car Repair", "paragraphs" => ["You crash it.", "We fix it."], 
                          "links" => [{"text" => "Hours", "url" => "/hours"}, {"text" => "Location", "url" => "/location"}]}
      assert_equal expected_content, site.fetch("", "")
    ensure
       Process.kill("INT", server_pid)
    end
  end

  def test_gives_useful_error_when_extractor_down
    site = Site.new("Ralph's Car Repair", "ralphs", "http://localhost:9999/ralphs")
    site.timeout = 1
    expected_content = {"status_code" => 404, "title" => "Unknown page", "paragraphs" => ["Sorry - cannot display that page."], "links"=>[]}
    assert_equal expected_content, site.fetch("", "")
  end

  private
  def start_extractor(pages)
      extractor = FakeExtractor.new 
      server_pid = fork { extractor.start }
      Net::HTTP.post_form(URI.parse('http://localhost:9999/'),
                          {'pages' => YAML::dump(pages)})
      return server_pid    
  end
end
