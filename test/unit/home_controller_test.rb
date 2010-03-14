require 'rubygems'
require 'test_helper'
require 'mocha'

class HomeControllerTest < ActiveSupport::TestCase
  def test_lists_all_sites
    receiver = Struct.new(:sites).new
    expected_sites = [Site.new("Long John Silver's Gym", "silvergym",  "http://example.com/silvergym"),
                      Site.new("Mary's Coffee Emporium", "marycoffee", "http://example.com/marycoffee")]
    site_fetcher = stub(:all => expected_sites)

    hcw = HomeController::Worker.new(receiver, site_fetcher)
    hcw.index("/", "")
    assert_equal expected_sites, receiver.sites
  end
end
