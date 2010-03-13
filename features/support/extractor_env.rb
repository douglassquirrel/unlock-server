require 'test/fake_extractor/fake_extractor'
require 'net/http'
require 'uri'
require 'yaml'

extractor = FakeExtractor.new 
server_pid = fork { extractor.start }
at_exit { Process.kill("INT", server_pid) }
