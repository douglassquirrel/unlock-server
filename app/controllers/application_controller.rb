# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  attr_accessor :status_code

  def method_missing(method)
    @worker.send(method, request.path, request.query_string)
    respond_to do |format|
      format.html { render :status => @status_code, :layout => true }
    end
  end
end
