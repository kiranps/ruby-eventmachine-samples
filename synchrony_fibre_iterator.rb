require "em-synchrony"
require "em-synchrony/em-http"
require "em-synchrony/fiber_iterator"

EM.synchrony do
  concurrency = 2
  urls = ['http://google.com', 'http://google.com']
  results = []

  EM::Synchrony::FiberIterator.new(urls, concurrency).each do |url|
    p "start"
    resp = EventMachine::HttpRequest.new(url).get
    results.push resp.response
    p "end"
  end

  p results # all completed requests
  EventMachine.stop
end
