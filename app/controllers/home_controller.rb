class HomeController < ApplicationController
  Site = Struct.new(:name, :link)

  def index
    @sites = [Site.new("BigCo", "/bigco"), Site.new("MeTailer", "/metailer")]
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
