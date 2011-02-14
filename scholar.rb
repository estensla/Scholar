require 'rubygems'
require 'sinatra'
require 'haml'

get '/' do
  haml :login
end

post '/profile' do
  @profile = params["profile"]
  haml :profile
end


