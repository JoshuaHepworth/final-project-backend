class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	use Rack::Session::Cookie, :key =>'rack.session',:path => '/',:secret => 'my_secret'

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'news_app'
		)
		register Sinatra::CrossOrigin

		configure do
			enable :cross_origin
		end

	set :allow_origin, :any
	set :allow_credentials, true
	set :allow_methods, [:get, :post, :put, :patch, :delete, :options]

	options '*' do 
	    response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE, OPTIONS'
	    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
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