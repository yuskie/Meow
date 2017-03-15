DROP TABLE IF EXISTS user_picture;
DROP TABLE IF EXISTS picture_tag;
DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS seq_user_id;
DROP TABLE IF EXISTS picture;
DROP SEQUENCE IF EXISTS seq_picture_id;
DROP TABLE IF EXISTS tag;
DROP SEQUENCE IF EXISTS seq_tag_id;

CREATE SEQUENCE seq_user_id;

CREATE TABLE users(
	id INTEGER PRIMARY KEY DEFAULT NEXTVAL('seq_user_id'),
	email VARCHAR(256) NOT NULL,
	password VARCHAR(256) NOT NULL,
	created_date timestamp with time zone
);

CREATE SEQUENCE seq_picture_id;

CREATE TABLE picture(
	id INTEGER PRIMARY KEY DEFAULT NEXTVAL('seq_picture_id'),
	picture_location VARCHAR(256) NOT NULL,
	source VARCHAR(256) NOT NULL,
	created_date timestamp with time zone
	
);

CREATE SEQUENCE seq_tag_id;

CREATE TABLE tag(
	id INTEGER PRIMARY KEY DEFAULT NEXTVAL('seq_tag_id'),
	tag VARCHAR(256) NOT NULL
);

CREATE TABLE user_picture(
	user_id INTEGER NOT NULL,
	picture_id INTEGER NOT NULL,
	
	CONSTRAINT pk_user_picture PRIMARY KEY (user_id, picture_id),
	CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_picture_id FOREIGN KEY (picture_id) REFERENCES picture(id)
);

CREATE TABLE picture_tag(
	picture_id INTEGER NOT NULL,
	tag_id INTEGER NOT NULL,
	
	CONSTRAINT pk_picture_tag PRIMARY KEY (picture_id, tag_id),
	CONSTRAINT fk_picture_id FOREIGN KEY (picture_id) REFERENCES picture(id),
	CONSTRAINT fk_tag_id FOREIGN KEY (tag_id) REFERENCES tag(id)
);