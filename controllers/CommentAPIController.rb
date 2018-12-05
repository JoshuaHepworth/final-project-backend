class CommentAPIController < ApplicationController
	
	# index for comments 
	get '/' do
		user = User.find_by username: session[:username]
		{
			status: 200,
			comments: user.comments.order(:id)
		}.to_json
	end

	# take an article URL and show comments associated with that article
	# get articles comments
	post '/article' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys

		user = User.find_by username: session[:username]
		article = Article.find_by article_url: payload[:url]
		if !article
			{
				status: 200,
				message: "Article comments don't exist",
				comments: []
			}.to_json
		else
			# use .map to create an array that has the username attached to each comment hash
			comment_author = article.comments.map do |comment|
				{
					username: comment.user.username,
					comment: comment
				}
			end
			puts "=-------"
			pp comment_author
			puts "--this is the comennt author"
			puts '--------------'
			pp article.comments
			puts "this is article comments"
			{
				status: 200,
				message: "Found article comments",
				comments: comment_author
			}.to_json
		end
	end


	# posting comment route
	post '/' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys

		# binding.pry

		puts "hitting route, here is payload -- check the article url we are use"
		pp payload
		
		user = User.find_by username: session[:username]
		# check if it's there
		article = Article.find_by article_url: payload[:article]["url"]

		puts ""
		pp article 
		puts " ^ theres the article we found"

		if !article
			# if its not there Add it
			article = Article.new
				# set the fields
			article.source = payload[:article]["source"]["name"]
			article.author = payload[:article]["author"]
			article.title = payload[:article]["title"]
			article.description = payload[:article]["description"]
			article.img_url = payload[:article]["urlToImage"]
			article.published_at = payload[:article]["publishedAt"]
			article.article_url = payload[:article]["url"]
			article.save
		end
		comment = Comment.new
		comment.message = payload[:comment]
		# comment.ts = #
		comment.upvotes = 0
		comment.downvotes = 0
		comment.user_id = user.id
		comment.article_id = article.id
		comment.save

		puts ""
		puts "here's the comment we're about to send back"
		pp comment

		{
			status: 200,
			message: "Created Comment",
			comment: comment,
			user: comment.user
		}.to_json
	end


	#update
	put '/:id' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys

		comment = Comment.find params[:id]
		comment.message = payload[:message]
		comment.save
		{
			status: 200,
			message: "Updated Comment",
			comment: comment
		}.to_json
	end
	
	# delete
	delete '/:id' do
		comment = Comment.find params[:id]
		comment.destroy
		{
			status: 200,
			message: "Destroyed Comment"
		}.to_json
	end

end