class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	use Rack::Session::Cookie, :key =>'rack.session',:path => '/',:secret => 'my_secret'

	require './config/environments'

		register Sinatra::CrossOrigin

		configure do
			enable :cross_origin
		end

 allowed = ENV['RACK_ENV'] == "development" ?  'http://localhost:3000' : 'http://localhost:something'

	set :allow_origin, allowed
	set :allow_credentials, true
	set :allow_methods, [:get, :post, :put, :patch, :delete, :options]

	 ENV['RACK_ENV']




	options '*' do 
	    response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE, OPTIONS'
	    response.headers['Access-Control-Allow-Origin'] = allowed
	    response.headers['Access-Control-Allow-Credentials'] = 'true'
	    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Authorization, Content-Type, Cache-Control, Accept"
	    200 #this is the status code & also sends a response
  end

  get '/' do
  	binding.pry
  	{
  		status: 200, 
  		message: "This works"
  	}.to_json

  end

end