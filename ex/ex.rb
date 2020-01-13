require 'webrick'

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'ex.html.erb')
server.mount('/data1.cgi', WEBrick::HTTPServlet::CGIHandler, 'data1.rb')
server.mount('/data2.cgi', WEBrick::HTTPServlet::CGIHandler, 'data2.rb')

server.start
