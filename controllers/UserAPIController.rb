class UserAPIController < ApplicationController



	#get user
	get '/' do 

		user = User.find_by username: session[:username]
		if !user 
			{
				status: 403,
				message: "user not logged in"
			}
		else
		{
			status: 200,
			message: "found user",
			user: user
		}.to_json
		end
	end

	# get user articles
	get '/articles' do
		user = User.find_by username: session[:username]
		# userArticle = UserArticle.find_by user_id: user.id
		{
			status: 200,
			message: "Found users articles",
			articles: user.articles
		}.to_json
	end


#login
	post '/login' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys

		user = User.find_by username: payload[:username]
		pw = payload[:password]

		if user && user.authenticate(pw)
			session[:logged_in] = true
			session[:username] = user.username
			puts ""
			puts "Here's the session right now after we logged in"
			pp session
			{
				status: 200,
				message: "#{user.username} has logged in!"
			}.to_json

		else
			{
				status: 403,
				message: "Invalid username or password"
			}.to_json
		end
	end

#register
	post '/register' do
			# {
			# 	status: 200, 
			# 	message: "hitting the register route"
			# }.to_json
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys
		username = payload[:username]
		user_exists = User.find_by username: payload[:username]

		if user_exists 
			{
				status: 421, 
				message: "Username already taken"
			}.to_json
		else 
			user = User.new
			user.username = payload[:username]
			user.password = payload[:password]
			user.save
			session[:logged_in] = true
			session[:username] = user.username
			{
				status: 200,
				message: "#{user.username} created!",
				logged_in_as: user.username
			}.to_json
		end
	end

#logout
	get '/logout' do
		username = session[:username]
		session.destroy
		{
			status: 200,
			message: "Logged out user #{username}"
		}.to_json
	end	

	delete '/article/:id' do
		article = UserArticle.find_by article_id: params[:id]
		article.destroy
		# userArticle = UserArticle.find_by user_id: user.id
		{
			status: 200,
			message: "deleted article",
			article: article
		}.to_json
	end

end