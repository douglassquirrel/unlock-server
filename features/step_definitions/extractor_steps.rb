Given /^there is an extractor running with the following pages:$/ do |page_table|
  @extractor = Extractor.new page_table.hashes
  server_pid = fork { @extractor.start }
  at_exit { Process.kill("INT", server_pid) }
end

