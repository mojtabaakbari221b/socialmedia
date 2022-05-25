CREATE TABLE public."user"
(
	id serial NOT NULL,
    username character varying(32) UNIQUE,
    name character varying(56) NOT NULL,
    info character varying(512),
    phone_number character varying(13) NOT NULL UNIQUE,
    profile_photo character varying(128),
	PRIMARY KEY (id),
	CONSTRAINT proper_phone_number CHECK (phone_number ~* '^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$'),
	CONSTRAINT proper_username CHECK (username ~* '^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$')
);

CREATE TABLE public."contacts" 
(
	from_id bigint NOT NULL,
	to_id bigint NOT NULL,
	foreign key (from_id) references "user" (id),
	foreign key (to_id) references "user" (id),
	PRIMARY KEY (from_id, to_id)
);

CREATE TABLE public."room" 
(
	id serial NOT NULL UNIQUE,
	creator bigint not null,
	info character varying(512),
	profile_photo character varying(128),
	type character varying(8) not null,
	create_date date,
	username character varying(56) not null UNIQUE,
	CONSTRAINT proper_username CHECK (username ~* '^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$'),
	PRIMARY KEY (id),
	foreign key (creator) references "user" (id)
);

CREATE TABLE public."message" 
(
	parent_id bigint UNIQUE,
	id serial NOT NULL,
	sender_id bigint not null,
	room_receiver_id bigint not null,
	user_receiver_id bigint not null,
	text character varying(1024),
	sended_time date,
	PRIMARY KEY (id),
	foreign key (sender_id) references "user" (id),
	foreign key (user_receiver_id) references "user" (id),
	foreign key (room_receiver_id) references "room" (id),
	foreign key (parent_id) references "message" (id),
	CONSTRAINT check_receiver check (room_receiver_id is not null or user_receiver_id is not null)
);

CREATE TABLE public."room_users" 
(
	user_id bigint NOT NULL,
	room_id bigint NOT NULL,
	foreign key (user_id) references "user" (id),
	foreign key (room_id) references "room" (id),
	PRIMARY KEY (user_id, room_id)
);

CREATE TABLE public."premission"
(
	id serial NOT NULL UNIQUE,
	label character varying(56) not null,
	description character varying(512) not null,
	PRIMARY KEY (id)
);

CREATE TABLE public."user_premission"
(
	user_id bigint NOT NULL,
	premission_id bigint NOT NULL,
	foreign key (user_id) references "user" (id),
	foreign key (premission_id) references "premission" (id),
	PRIMARY KEY (user_id, premission_id)
);

CREATE TABLE public."room_premission"
(
	room_id bigint NOT NULL,
	premission_id bigint NOT NULL,
	foreign key (room_id) references "room" (id),
	foreign key (premission_id) references "premission" (id),
	PRIMARY KEY (room_id, premission_id)
);
