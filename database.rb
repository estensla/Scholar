require 'sinatra'
require 'haml'
require 'sass'
require 'uri'
require 'mongo'


get '/' do
  haml :index
end

get '/stylesheet.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :stylesheet
end

post '/erik' do
	put "erik"
end

post '/notify' do
  email = params[:email]
  db = Mongo::Connection.new("localhost", 27017).db("emails")
  auth = db.authenticate("admin", "admin")
  coll = db.collection("emails")
  doc = {"email" => email}
  coll.insert(doc)
  if request.xhr?
    "true"
  else
    "Thanks! We've got your email and will be in touch as soon as we're ready :)"
  end
end
