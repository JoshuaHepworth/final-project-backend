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
	get '/article/:id' do
		article = Article.find_by article_id: params[:id]
		puts '--------------'
		pp payload
		puts 'comments in article'
		{
			status: 200,
			message: "Found article comments",
			comments: article.comments
		}.to_json
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

		{
			status: 200,
			message: "Created Comment",
			comment: comment
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