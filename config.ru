require 'sinatra/base'

#controllers
require './controllers/ApplicationController'
require './controllers/UserAPIController'
require './controllers/ArticleAPIController'
require './controllers/CommentAPIController'

#models
require './models/UserModel'
require './models/UserArticleModel'
require './models/ArticleModel'
require './models/CommentModel'

#routes
map('/'){
	run ApplicationController
}
map('/api/user') {
	run UserAPIController
}
map('/api/article') {
	run ArticleAPIController
}
map('/api/comment') {
	run CommentAPIController
}