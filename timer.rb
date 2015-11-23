require 'eventmachine'

EventMachine.run {
  EventMachine.add_periodic_timer(10) {
    puts "Hello world"
  }
}
