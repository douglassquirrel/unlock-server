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

    def show
      content = {:title => "BigCo - For All Things Big",
                 :paragraphs => ["BigCo is super.", "Visit your local BigCo store!"] }
      @receiver.title      = content[:title]
      @receiver.paragraphs = content[:paragraphs]
    end
  end
end
