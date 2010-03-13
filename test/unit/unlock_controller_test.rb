require 'rubygems'
require 'test_helper'
require 'mocha'

class UnlockControllerTest < ActiveSupport::TestCase
  def test_looks_up_site_and_fetches_data
    receiver = Struct.new(:title, :paragraphs).new
    expected_title = "Mortgages R Us"
    expected_paragraphs = ["Borrow now!", "For a car or a family holiday!"]
    site = mock('site') do
      expects(:fetch).once.with("", "").returns({:title => expected_title, :paragraphs => expected_paragraphs})
    end
    site_fetcher = stub('site_fetcher') do
      expects(:find_by_short_name).with("mortgagesrus").returns(site)
    end

    ucw = UnlockController::Worker.new(receiver, site_fetcher)
    ucw.show("/mortgagesrus/", "")
    assert_equal expected_title,      receiver.title
    assert_equal expected_paragraphs, receiver.paragraphs
  end
end
