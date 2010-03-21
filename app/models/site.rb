require 'open-uri'
require 'timeout'

# Represents a site that has an accessible version. Has a name (human-readable; appears on home page), a short name (urls start with this),
# a url (where the site data can be retrieved from an extractor), and a timeout (how long to wait for the extractor before giving up)
class Site < ActiveRecord::Base
  NOT_FOUND_CONTENT = {"status_code" => 404, "title" => "Unknown page", "paragraphs" => ["Sorry - cannot display that page."], "links" => []}

  def self.lookup(short_name)
    if short_name.empty? then return HomeSite.new end
    Site.find_by_short_name(short_name) || StaticSite.new(NOT_FOUND_CONTENT)
  end

  validates_presence_of :name, :short_name, :url
  validates_uniqueness_of :name, :short_name

  def fetch(path, query_string)
    target = "#{url}/#{path}?#{query_string}"
    begin
      Timeout::timeout(timeout) do
        return YAML::load(open(target))
      end
    rescue StandardError, Timeout::Error
      return NOT_FOUND_CONTENT
    end
  end
end

# A site that returns static content, without visiting an extractor.
class StaticSite 
  def initialize(content)
    @content = content
  end

  def fetch(path, query_string)
    @content
  end 
end

# A site that returns static content for the home page, with links to all supported sites.
class HomeSite < StaticSite
  def initialize
    links = Site.all.collect { |site| {"text" => site.name, "url" => "/#{site.short_name}"} }.sort_by { |site| site["text"] }
    @content = {"status_code" => 200, "title" => "Welcome to BlindPages", "paragraphs" => [], "links" => links }
  end
end
