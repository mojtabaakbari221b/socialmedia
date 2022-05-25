CREATE TABLE public."user"
(
	id serial NOT NULL,
    username character varying(32),
    name character varying(56) NOT NULL,
    info character varying(512),
    phone_number character varying(13) NOT NULL UNIQUE,
    profile_photo character varying(128),
	PRIMARY KEY (id),
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
