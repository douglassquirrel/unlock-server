require 'open-uri'
require 'timeout'

class Site
  @@sites = []
  @@not_found_content = {"status_code" => 404, "title" => "Unknown page", "paragraphs" => ["Sorry - cannot display that page."], "links" => []}

  def self.clear_all
    @@sites = []
  end

  def self.register(site)
    @@sites << site
  end

  def self.all
    return @@sites
  end

  def self.find_by_short_name(short_name)
    site = @@sites.find { |site| site.short_name == short_name }
    return site.nil? ? NotFoundSite.new : site
  end

  attr_accessor :name, :short_name, :timeout

  def initialize(name, short_name, url)
    @name       = name
    @short_name = short_name
    @url        = url
    @timeout    = 30
  end

  def fetch(path, query_string)
    begin
      Timeout::timeout(@timeout) do
        YAML::load(open("#{@url}/#{path}?#{query_string}"))
      end
    rescue
      @@not_found_content
    end
  end
end

class NotFoundSite < Site
  def initialize
    super("Not Found", "notfound", "http://blindpages.com/notfound")
  end

  def fetch(path, query_string)
    @@not_found_content
  end
end
