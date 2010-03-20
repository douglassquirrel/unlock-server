Given /^the following sites:$/ do |site_table|
  Site.clear_all
  site_table.hashes.each do |hash|
    Site.register Site.new(hash['name'], hash['short_name'], "http://localhost:9999/" + hash['short_name'])
  end
end

