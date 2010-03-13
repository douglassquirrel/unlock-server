class HomeController < ApplicationController
  attr_accessor :sites
  def initialize
    @worker = Worker.new(self)
  end

  class Worker
    def initialize(receiver, site_fetcher = Site)
      @receiver = receiver
      @site_fetcher = site_fetcher
    end

    def index(path, query_string)
      @receiver.sites = @site_fetcher.all
    end
  end
end
