require 'eventmachine'
require 'em-http'

EventMachine.run {
  p "start"
  page = EventMachine::HttpRequest.new('http://google.com/').get
  page.errback { p "Google is down! terminate?" }
  page.callback {
    p "first callback"
    about = EventMachine::HttpRequest.new('http://google.com/search?q=eventmachine').get
    about.callback { 
      p "second callback" 
      EventMachine.stop
    }
    about.errback  { }
  }
  p "end"
}
