require 'rubygems'
require 'sinatra'
require 'haml'
require 'mongo'
require 'sass'
require 'uri'

get '/' do
	haml:index
end

get '/login' do
  haml :login
end

get '/stylesheet.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :stylesheet
end

post '/profile' do
  @profile = params[:profile]
  @passwd = params[:passwd]
  db = Mongo::Connection.new("localhost", 27017).db("emails")
  auth = db.authenticate("admin", "admin")
  coll = db.collection("emails")
  doc = {"profile" => @profile, "passwd" => @passwd}
  coll.insert(doc)
  if request.xhr?
    "true"
  else
  haml:profile
  end
end
