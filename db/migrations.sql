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
	title VARCHAR(255),
	description VARCHAR(512),
	img_url VARCHAR(512),
	published_at TIMESTAMP,
	article_url VARCHAR(512)
);

CREATE TABLE comments(
	id SERIAL PRIMARY KEY,
	message TEXT,
	ts TIMESTAMP DEFAULT NOW(),
	upvotes INTEGER,
	downvotes INTEGER,
	article_id INTEGER REFERENCES articles(id),
	user_id INTEGER REFERENCES users(id)
);

CREATE TABLE user_articles(
	id SERIAL PRIMARY KEY,
	user_id INTEGER REFERENCES users(id),
	article_id INTEGER REFERENCES articles(id)
);


