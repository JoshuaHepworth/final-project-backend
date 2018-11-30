class ArticleAPIController < ApplicationController

	#index for articles
	get '/' do
		user = User.find_by username: session[:username]
		{
			status: 200,
			articles: user.articles.order(:id)
		}.to_json
	end

	get '/' do
		article = Article.find_by params[:id]
		{
			status: 200,
			article: article
		}
	end

	#save article
	post '/' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys

		pp "hitting route"
		user = User.find_by username: session[:username]
		
		article = Article.find_by article_url: payload[:url]
		if !article
			# then create an article
			# then store it in user
			article = Article.new
			# set the fields
			article.save
		end

		userArticle = UserArticle.new
		userArticle.article_id = article.id
		userArticle.user_id = user.id
		userArticle.save

		{
			status: 200,
			message: "Saved Article!",
			article: userArticle
		}.to_json

	end



end