require 'open-uri'
require 'timeout'

# Represents a site that has an accessible version. Has a name (human-readable; appears on home page), a short name (urls start with this),
# a url (where the site data can be retrieved from an extractor), and a timeout (how long to wait for the extractor before giving up)
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
    if short_name.empty? then return HomeSite.new end
    @@sites.find { |site| site.short_name == short_name } || NotFoundSite.new
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
        return YAML::load(open("#{@url}/#{path}?#{query_string}"))
      end
    rescue StandardError, Timeout::Error
      return @@not_found_content
    end
  end
end

# Represents a site that does not exist. Always returns the same content, with status code 404.
class NotFoundSite < Site
  def initialize
    super("Not Found", "notfound", "http://blindpages.com/notfound")
  end

  def fetch(path, query_string)
    @@not_found_content
  end
end

# Represents the home page. Returns a list of links to sites.
class HomeSite < Site
  def initialize
    super("Home", "", "http://blindpages.com")
  end

  def fetch(path, query_string)
     links = Site.all.collect { |site| {"text" => site.name, "url" => "/#{site.short_name}"} }
     links.sort! { |first_site, second_site| first_site["text"] <=> second_site["text"] }
     {"status_code" => 200, "title" => "Welcome to BlindPages", "paragraphs" => [], "links" => links }
  end
end
