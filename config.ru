require 'sinatra/base'

#controllers
require './controllers/ApplicationController'
require './controllers/UserAPIController'
require './controllers/ArticleAPIController'

#models
require './models/UserModel'
require './models/ArticleModel'

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