require 'net/http'
require 'uri'
require 'yaml'

extractor = Extractor.new 
server_pid = fork { extractor.start }
at_exit { Process.kill("INT", server_pid) }
