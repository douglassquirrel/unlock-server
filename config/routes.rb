ActionController::Routing::Routes.draw do |map|
  map.root                           :controller => 'unlock', :action => 'show'
  map.site ":site_short_name/*path", :controller => 'unlock', :action => 'show'
end
