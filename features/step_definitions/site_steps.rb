Given /^the following sites:$/ do |site_table|
  Site.all.each { |site| site.destroy }
  site_table.hashes.each do |hash|
    Site.new({:name => hash['name'], :short_name => hash['short_name'], :url => "http://localhost:9999/" + hash['short_name']}).save
  end
end

