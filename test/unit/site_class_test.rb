require 'test_helper'

class SiteClassTest < ActiveSupport::TestCase
  def setup
    Site.clear_all
  end

  def test_registers_a_site_and_finds_by_short_name
    Site.register Site.new("East Grimsbane Council", "grimsbane", "http://example.com/grimsbane")
    site = Site.find_by_short_name "grimsbane"
    assert_not_nil site
    assert attributes_match site, "East Grimsbane Council", "grimsbane"
  end

  def test_returns_error_page_when_site_does_not_exist
    site = Site.find_by_short_name "nonexistent"
    expected_content = {"status_code" => 404, "title" => "Unknown page", "paragraphs" => ["Sorry, cannot display that page."]}
    assert_equal expected_content, site.fetch("", "")
  end

  def test_will_return_all_sites
    Site.register Site.new("Spatula City",            "spatulacity", "http://example.com/spatulacity")
    Site.register Site.new("Dewey, Cheatham, & Howe", "dch"        , "http://example.com/dch")
    sites = Site.all
    assert_not_nil sites.find { |site| attributes_match site, "Spatula City",            "spatulacity" }, "Could not find site Spatula City"
    assert_not_nil sites.find { |site| attributes_match site, "Dewey, Cheatham, & Howe", "dch"         }, "Could not find site Dewey, Cheatham, & Howe"
  end

  def attributes_match(s, name, short_name)
    s.name == name && s.short_name = short_name
  end
end
