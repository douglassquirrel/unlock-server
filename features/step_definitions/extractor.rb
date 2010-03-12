require 'webrick'

class Extractor
  def initialize(pages)
    @server = WEBrick::HTTPServer.new(:Port => 9999)
    @server.mount "", ExtractorServlet, pages
  end

  def start
    trap "INT" do @server.shutdown end
    @server.start
  end
end

class ExtractorServlet < WEBrick::HTTPServlet::AbstractServlet
  def initialize(server, pages)
    super(server)
    @pages = pages
  end

  def do_GET(request, response)
    response.status = 200 
    response['Content-Type'] = "application/xml; charset=utf-8"
    response.body = "<test><path>#{request.path}</path><pages>#{@pages.to_s}</pages></test>"
  end
end

if $0 == __FILE__ then
  p "Starting extractor - you will have to kill manually"
  e = Extractor.new([{"title"=>"BigCo - For All Things Big", 
                      "paragraphs"=>"BigCo is super.,Visit your local BigCo store!", 
                      "path"=>"/bigco"}])
  server_pid = fork { e.start}
  p "Server pid is #{server_pid}"
end
