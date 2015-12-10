require "em-synchrony"
require "em-synchrony/mysql2"
require "em-synchrony/fiber_iterator"
require "em-synchrony/activerecord"


ActiveRecord::Base.establish_connection(
  :adapter => 'em_mysql2',
  :username => 'root',
  :password => 'foo',
  :host => 'localhost',
  :database => 'test',
  :pool => 60
)

class Users < ActiveRecord::Base
end


EM.synchrony do
  concurrency = 2
  ids = [1 , 2, 3]
  results = []

  EM::Synchrony::FiberIterator.new(ids, concurrency).each do |id|
    resp = Users.all
    results.push resp
  end

  p results
  EM.stop
end
