class Site
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  @@sites = []

  def self.register(site)
    @@sites << site
  end

  def self.all
    return @@sites
  end
end
