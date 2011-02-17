require 'rubygems'
require 'sinatra'
require 'haml'
require 'mongo'
require 'sass'
require 'uri'


enable :sessions

get '/' do
    #session["user"] ||= nil
    haml :index
end

get '/profile/login' do
  haml :login
end

get '/stylesheet.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :stylesheet
end

post '/profile' do
  session["user"] = params[:profile]
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

get '/profile/logout' do
  session[:user] = nil
 # flash("Logout successful")
  redirect '/'
end