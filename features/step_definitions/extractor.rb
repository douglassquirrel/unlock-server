require 'net/http'
require 'uri'
require 'webrick'
require 'yaml'

class Extractor
  def initialize
    @server = WEBrick::HTTPServer.new(:Port => 9999)
    @server.mount "", ExtractorServlet
  end

  def start
    trap "INT" do @server.shutdown end
    @server.start
  end
end

class ExtractorServlet < WEBrick::HTTPServlet::AbstractServlet
  @@servlet = nil

  def self.get_instance(server, *options)
    if @@servlet.nil? then 
      @@servlet = self.new(server, *options) 
    end
    return @@servlet
  end

  def initialize(server)
    super(server)
    @pages = {}
  end

  def do_GET(request, response)
    response.status = 200 
    response['Content-Type'] = "application/x-yaml"

    path = request.path
    response.body = (!@pages[path].nil?) ? YAML::dump(@pages[path]) : "Bad path: #{path}"
  end

  def do_POST(request, response)
    @pages = {}
    pages = YAML::load(request.query['pages'])
    pages.each do |page|
      path = page.delete("path")
      page["paragraphs"] = page["paragraphs"].split(',')
      @pages[path] = page
    end
  end
end

if $0 == __FILE__ then
  p "Starting extractor - you will have to kill manually"
  e = Extractor.new
  server_pid = fork { e.start}
  p "Server pid is #{server_pid}"

  p "Configuring for BigCo site"
  pages = [{"title"=>"BigCo - For All Things Big", 
            "paragraphs"=>"BigCo is super.,Visit your local BigCo store!", 
            "path"=>"/bigco"}]
  Net::HTTP.post_form(URI.parse('http://localhost:9999/'),
                      {'pages' => YAML::dump(pages)})
end
