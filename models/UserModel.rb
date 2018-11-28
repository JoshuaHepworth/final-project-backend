class User < ActiveRecord::Base
	has_secure_password
	has_many :articles, through: :user_articles
	has_many :comments
end