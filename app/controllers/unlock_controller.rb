# Controller for all content made accessible
class UnlockController < ApplicationController
  helper VoicexmlHelper
  attr_accessor :title, :paragraphs, :links, :status_code

  def initialize
    @worker = Worker.new(self)
  end

  def show
    @worker.show(request.path, request.query_string)
    respond_to do |format|
      format.html { render :status => @status_code, :layout => true } # show.html.erb
      format.voicexml                                                 # show.voicexml.rxml
    end
  end

  # Does the actual work of the controller. A "good citizen" with injected dependencies: a receiver on which data is set,
  # and a site_fetcher that looks up sites.
  class Worker
    def initialize(receiver, site_fetcher = Site)
      @receiver = receiver
      @site_fetcher = site_fetcher
    end

    def show(path, query_string)
      ignored, short_name, site_path = path.split('/', 3)
      if site_path.nil? then site_path = "" end
  
      site = @site_fetcher.lookup(short_name)
      content = site.fetch(site_path, query_string)
      copy_to_receiver content
    end

    private
    def copy_to_receiver(content)
      content.each_pair { |key, value| @receiver.send(key+"=", value) }
    end
  end
end
