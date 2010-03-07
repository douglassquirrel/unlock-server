class Site
  attr_accessor :name, :short_name

  def initialize(name, short_name)
    @name       = name
    @short_name = short_name
  end

  @@sites = []

  def self.register(site)
    @@sites << site
  end

  def self.all
    return @@sites
  end
end
