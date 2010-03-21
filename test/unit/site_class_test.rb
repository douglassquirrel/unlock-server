require 'test_helper'

class SiteClassTest < ActiveSupport::TestCase
  def setup
    Site.all.each { |site| site.destroy }
  end

  def test_looks_up_by_short_name
    Site.new(:name => "East Grimsbane Council", :short_name => "grimsbane", :url => "http://example.com/grimsbane").save
    site = Site.lookup "grimsbane"
    assert_not_nil site
    assert attributes_match site, "East Grimsbane Council", "grimsbane"
  end

  def test_returns_error_page_when_site_does_not_exist
    site = Site.lookup "nonexistent"
    expected_content = {"status_code" => 404, "title" => "Unknown page", "paragraphs" => ["Sorry - cannot display that page."], "links" => []}
    assert_equal expected_content, site.fetch("", "")
    assert_equal expected_content, site.fetch("about/team", "")
    assert_equal expected_content, site.fetch("users", "name=Fred&location=London")
  end

  def test_returns_home_site_for_empty_short_name
    Site.new(:name => "Smithson Hospital", :short_name => "smithson", :url => "http://example.com/smithson").save
    Site.new(:name => "Banana Computers",  :short_name => "banana",   :url => "http://example.com/banana")  .save
    site = Site.lookup ""
    expected_content = {"status_code" => 200, "title" => "Welcome to BlindPages", "paragraphs" => [], 
                        "links" => [{"text" => "Banana Computers", "url" => "/banana"},
                                    {"text" => "Smithson Hospital", "url" => "/smithson"}]}
    assert_equal expected_content, site.fetch("", "")
  end

  private
  def attributes_match(s, name, short_name)
    s.name == name && s.short_name = short_name
  end
end
