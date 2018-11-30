class ArticleAPIController < ApplicationController

	#index for articles
	get '/' do
		articles = UserArticles.find_by session[:username]
		{
			status: 200,
			articles: user_articles.order(:id)
		}.to_json
	end


	#save article
	post '/' do
		payload_body = request.body.read
		payload = JSON.parse(payload_body).symbolize_keys

		puts "------payload: "
		pp payload
		puts "" 

		puts "hitting route"
		user = User.find_by username: session[:username]
		
		article = Article.find_by article_url: payload[:url]
		if !article
			# then create an article
			# then store it in user
			article = Article.new
			# set the fields
			article.source = payload[:source]["name"]
			article.author = payload[:author]
			article.title = payload[:title]
			article.description = payload[:description]
			article.img_url = payload[:urlToImage]
			article.published_at = payload[:publishedAt]
			article.article_url = payload[:url]
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