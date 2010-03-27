require 'net/http'
require 'uri'
require 'webrick'
require 'yaml'

class FakeExtractor
  def initialize
    @server = WEBrick::HTTPServer.new(:Port => 9999, :Logger => WEBrick::Log.new(nil, WEBrick::BasicLog::WARN), :AccessLog=>[])
    @server.mount "", FakeExtractorServlet
  end

  def start
    trap "INT" do @server.shutdown end
    @server.start
  end
end

class FakeExtractorServlet < WEBrick::HTTPServlet::AbstractServlet
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
      if !page["paragraphs"].nil?
        page["paragraphs"] = page["paragraphs"].split(',')
      else
        page["paragraphs"] = []
      end
      if !page["links"].nil? then
        page["links"] = page["links"].split(",").collect { |s| {"text" => s.split("+")[0], "url" => s.split("+")[1]} }
      else
        page["links"] = []
      end
      if page["status_code"].nil? then page["status_code"] = 200 end
      @pages[path] = page
    end
  end
end

if $0 == __FILE__ then
  p "Starting extractor - you will have to kill manually"
  e = FakeExtractor.new
  server_pid = fork { e.start}
  p "Server pid is #{server_pid}"

  p "Configuring for BigCo site"
  pages = [{"title"=>"BigCo - For All Things Big", "links"=>"", "paragraphs"=>"BigCo is super.,Visit your local BigCo store!", "path"=>"/bigco/"},
           {"title"=>"Find A Store", "links"=>"Margate Road+/bigco/store1,Towcester Central+/bigco/store2", "paragraphs"=>"", "path"=>"/bigco/stores"},
           {"title"=>"Margate Road Store", "links"=>"Back to stores+/bigco/stores", 
                                           "paragraphs"=>"Open 24 hours,Deli and Bakery", "path"=>"/bigco/store1"}, 
           {"title"=>"Towcester Central Store", "links"=>"Back to stores+/bigco/stores", 
                                                "paragraphs"=>"Open Monday-Friday,Home Furnishings", "path"=>"/bigco/store2"}]
  Net::HTTP.post_form(URI.parse('http://localhost:9999/'),
                      {'pages' => YAML::dump(pages)})
end
