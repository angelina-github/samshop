require 'sinatra'
require 'sqlite3'

get '/' do

  # connect to the database
  db = SQLite3::Database.open('store.db')

  # configure results to be returned as as an array of hashes instead of nested arrays
  db.results_as_hash = true

  # query the products table and print the result
  puts "Database query results:"
  @products = db.execute("SELECT id, item, quantity, store, section FROM shopping;")
  #p db.execute("SELECT id, item, quantity, store, section FROM shopping;")
  p @products

  # close database connection
  db.close

  erb :home

end

get '/test' do
  "This is the test page."
end

get '/hello/:name' do |n|
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params['name'] is 'foo' or 'bar'
  # n stores params['name']
  "Hello #{n} #{n}!"
end

get '/hello/:name' do
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params['name'] is 'foo' or 'bar'
  "Hello #{params['name']}!"
end

get '/say/*/to/*' do
  # matches /say/hello/to/world
  params['splat'] # => ["hello", "world"]
end

get '/download/*.*' do
  # matches /download/path/to/file.xml
  params['splat'] # => ["path/to/file", "xml"]
end

#get '/success/:last4/:amount' do
get '/success' do
  "Your card ending in #{params['last4']} has been charged #{params['amount']} cents."
end

post '/pay' do
  "The data sent to the /pay POST route is: "
  p params
  redirect '/success'
end

post '/add' do
  "This is the add page."
  # connect to the database
  db = SQLite3::Database.open('store.db')

  # configure results to be returned as as an array of hashes instead of nested arrays
  db.results_as_hash = true
  p params
#  db.execute("INSERT INTO shopping (id, item, quantity, store, section) VALUES #{params['id']} #{params['item']}
  # @test = db.execute("INSERT INTO shopping (item, quantity, store, section) VALUES (#{params['item']},  #{params['quantity']}, #{params['store']}, #{params['section']})")
  # query the products table and print the result
  # db.execute("INSERT INTO shopping (item, quantity, store, section) VALUES ('#{params['item']}', '#{params['quantity']}', '#{params['store']}', '#{params['section']}')")
  puts "Database query results:"
  @products = db.execute("SELECT id, item, quantity, store, section FROM shopping;")
  p db.execute("SELECT id, item, quantity, store, section FROM shopping;")
  p @products
  p @test

  # close database connection
  db.close

  erb :home

end
