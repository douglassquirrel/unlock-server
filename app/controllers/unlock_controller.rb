class UnlockController < ApplicationController
  attr_accessor :title
  attr_accessor :paragraphs

  def initialize
    @worker = Worker.new(self)
  end

  class Worker
    def initialize(receiver, site_fetcher = Site)
      @receiver = receiver
      @site_fetcher = site_fetcher
    end

    def show(path, query_string)
      ignored, short_name, site_path = path.split('/', 3)
      if site_path.nil? then site_path = "" end
  
      site = @site_fetcher.find_by_short_name(short_name)
      content = site.fetch(site_path, query_string)
      copy_to_receiver content
    end

  private
    def copy_to_receiver(content)
      content.each_pair { |key, value| @receiver.send(key.to_s+"=", value) }
    end
  end
end
