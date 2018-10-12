require 'sinatra'

get '/' do
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
