require "em-synchrony"
require "em-synchrony/em-http"

EM.synchrony do
    concurrency = 2
    urls = ['http://google.com', 'http://bing.com']

    # iterator will execute async blocks until completion, .each, .inject also work!
    results = EM::Synchrony::Iterator.new(urls, concurrency).map do |url, iter|

        # fire async requests, on completion advance the iterator
        http = EventMachine::HttpRequest.new(url).aget
        http.callback { iter.return(iter) }
        http.errback { iter.return(iter) }
    end

    p results # all completed requests
    EventMachine.stop
end
