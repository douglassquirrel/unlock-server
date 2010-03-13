Given /^the following sites:$/ do |site_table|
  site_table.hashes.each do |hash|
    Site.register Site.new(hash['name'], hash['short_name'])
  end
end

