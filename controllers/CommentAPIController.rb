class CommentAPIController < ApplicationController
	
	# index for comments
	get '/' do
		user = User.find_by username: session[:username]
		{
			status: 200,
			comments: user.comments.order(:id)
		}.to_json
	end


	# create route
	post '/' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys
		# binding.pry
		pp "hitting route"
		
		user = User.find_by username: session[:username]
		article = Article.find params[:id]
		comment = Comment.new
		comment.message = payload[:message]
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