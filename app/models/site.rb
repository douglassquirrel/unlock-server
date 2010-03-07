class Site
  @@sites = []

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
    return @@sites.find { |site| site.short_name == short_name }
  end

  attr_accessor :name, :short_name

  def initialize(name, short_name)
    @name       = name
    @short_name = short_name
  end
end
