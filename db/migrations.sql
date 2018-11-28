DROP DATABASE IF EXISTS news_app;
CREATE DATABASE news_app;

\c news_app

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	username VARCHAR(64),
	password_digest VARCHAR(60)
);

CREATE TABLE articles(
	id SERIAL PRIMARY KEY,
	source VARCHAR(64),
	author VARCHAR(64),
	title VARCHAR(64),
	description VARCHAR(260),
	imgUrl VARCHAR(512),
	apiId VARCHAR(64),
	articleUrl VARCHAR(512),
	user_id INTEGER REFERENCES users(id)
);

CREATE TABLE comments(
	id SERIAL PRIMARY KEY,
	message TEXT,
	user_id INTEGER REFERENCES users(id),
	article_id INTEGER REFERENCES articles(id)
);