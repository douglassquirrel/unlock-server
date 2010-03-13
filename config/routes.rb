ActionController::Routing::Routes.draw do |map|
  map.root                           :controller => 'home',   :action => 'index'
  map.site ":site_short_name/*path", :controller => 'unlock', :action => 'show'
end
