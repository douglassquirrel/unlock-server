Given /^there is an extractor running with the following pages:$/ do |page_table|
  Net::HTTP.post_form(URI.parse('http://localhost:9999/'),
                      {'pages' => YAML::dump(page_table.hashes)})
end

