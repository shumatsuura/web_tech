require 'webrick'

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'ex.html.erb')
server.mount('/data1.cgi', WEBrick::HTTPServlet::CGIHandler, 'data1.rb')
server.mount('/data2.cgi', WEBrick::HTTPServlet::CGIHandler, 'data2.rb')

server.start
