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
	id serial NOT NULL,
	creator bigint not null,
	info character varying(512),
	profile_photo character varying(128),
	type character varying(8) not null,
	create_date date,
	username character varying(56) not null UNIQUE,
	CONSTRAINT proper_username CHECK (username ~* '^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$'),
	foreign key (creator) references "user" (id)
);
