require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  def setup
    Site.clear_all
  end

  def test_registers_a_site
    Site.register Site.new("East Grimsbane Council", "grimsbane")
    site = Site.find_by_short_name "grimsbane"
    assert_not_nil site
    assert check_attributes site, "East Grimsbane Council", "grimsbane"
  end

  def test_returns_nil_for_nonexistent_site
    assert_nil Site.find_by_short_name "nonexistent"
  end

  def test_will_return_all_sites
    Site.register Site.new("Spatula City",            "spatulacity")
    Site.register Site.new("Dewey, Cheatham, & Howe", "dch"        )
    sites = Site.all
    assert_not_nil sites.find { |site| check_attributes site, "Spatula City",            "spatulacity" }, "Could not find site Spatula City"
    assert_not_nil sites.find { |site| check_attributes site, "Dewey, Cheatham, & Howe", "dch"         }, "Could not find site Dewey, Cheatham, & Howe"
  end

  def check_attributes(s, name, short_name)
    s.name == name && s.short_name = short_name
  end
end
