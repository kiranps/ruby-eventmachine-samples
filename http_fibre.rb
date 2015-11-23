require 'eventmachine'
require 'em-http'
require 'fiber'

def http_get(url)
  f = Fiber.current
  http = EventMachine::HttpRequest.new(url).get
  http.callback { f.resume(http) }
  http.errback  { f.resume(http) }
  Fiber.yield
end

EventMachine.run do
  Fiber.new{
    page = http_get('http://www.google.com/')
    p "hello world"
    puts "Fetched page: #{page.response_header.status}"
    if page
      page = http_get('http://wwwgoglecom/search?q=eventmachine')
      puts "Fetched page 2: #{page.response_header.status}"
    end
  }.resume
end
