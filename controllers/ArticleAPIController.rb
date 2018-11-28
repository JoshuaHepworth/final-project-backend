class ArticleAPIController < ApplicationController

	#index for articles
	user = User.find_by username: session[:username]
	{
		status: 200,
		articles: user.articles.order(:id)
	}.to_json
end