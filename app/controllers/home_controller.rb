class HomeController < ApplicationController
  def index
    @sites = Site.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
