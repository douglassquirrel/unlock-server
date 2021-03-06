require 'rubygems'
require 'test_helper'
require 'mocha'

class UnlockControllerTest < ActiveSupport::TestCase
  def test_looks_up_site_and_fetches_data
    visit_page_and_verify "/mortgagesrus"
    visit_page_and_verify "/mortgagesrus/"
    visit_page_and_verify "/mortgagesrus/home"
    visit_page_and_verify "/mortgagesrus/home/"
    visit_page_and_verify "/mortgagesrus/home/1"
    visit_page_and_verify "/mortgagesrus",              "user=me"
    visit_page_and_verify "/mortgagesrus/home/",        "user=me&location=uk"
    visit_page_and_verify "/mortgagesrus/doesnotexist", "",                   404
  end

  def visit_page_and_verify(path, query_string = "", expected_status_code = 200)
    expected_title = "Mortgages R Us"
    expected_paragraphs = ["Borrow now!", "For a car or a family holiday!"]
    ignored, short_name, site_path = path.split('/', 3)
    if site_path.nil? then site_path = "" end

    content = {"status_code" => expected_status_code,
               "title"       => expected_title, 
               "paragraphs"  => expected_paragraphs}
    site = mock('site') do
      expects(:fetch).once.with(site_path, query_string).returns(content)
    end
    site_fetcher = stub('site_fetcher') do
      expects(:lookup).with(short_name).returns(site)
    end

    receiver = Struct.new(:status_code, :title, :paragraphs).new
    ucw = UnlockController::Worker.new(receiver, site_fetcher)
    ucw.show(path, query_string)

    assert_equal expected_status_code, receiver.status_code      
    assert_equal expected_title,       receiver.title
    assert_equal expected_paragraphs,  receiver.paragraphs
  end
end
