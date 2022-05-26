-- insert sample data in "user" table
INSERT INTO "user" (id, name, username, phone_number)
VALUES (1, 'mojtaba', 'mojtabaakbari', '09111234567');

INSERT INTO "user" (id, name, username, phone_number)
VALUES (2, 'alireza', 'alireza', '09111234549');

INSERT INTO "user" (id, name, username, phone_number)
VALUES (3, 'pouya', 'pouya', '09111234149');

INSERT INTO "user" (id, name, username, phone_number)
VALUES (4, 'yousef', 'yousef', '09111254149');

INSERT INTO "user" (id, name, username, phone_number)
VALUES (5, 'navid', 'navid', '09211254149');

INSERT INTO "user" (id, name, username, phone_number)
VALUES (6, 'shayan', 'shayan', '09221254149');

INSERT INTO "user" (id, name, username, phone_number)
VALUES (7, 'sahar', 'sahar', '09221251149');

INSERT INTO "user" (id, name, username, phone_number)
VALUES (8, 'mahla', 'mahla', '09221251849');

select * from "user";

-- insert sample data in "contacts" table
INSERT INTO "contacts" (from_id, to_id)
VALUES (1, 2);

INSERT INTO "contacts" (from_id, to_id)
VALUES (1, 3);

INSERT INTO "contacts" (from_id, to_id)
VALUES (1, 4);

INSERT INTO "contacts" (from_id, to_id)
VALUES (1, 5);

INSERT INTO "contacts" (from_id, to_id)
VALUES (5, 2);

INSERT INTO "contacts" (from_id, to_id)
VALUES (5, 6);

select * from "contacts";

-- insert sample data in "room" table
INSERT INTO "room" (id, creator, type, username, create_date)
VALUES (1, 1, 'channel', 'varzesh3', '2018-05-06');

INSERT INTO "room" (id, creator, type, username, create_date)
VALUES (2, 1, 'group', 'poem', '2019-05-06');

INSERT INTO "room" (id, creator, type, username, create_date)
VALUES (3, 2, 'group', '212', '2020-05-06');

INSERT INTO "room" (id, creator, type, username, create_date)
VALUES (4, 1, 'channel', 'varzesh32', '2018-05-06');

select * from "room";

-- insert sample data in "message" table
INSERT INTO "message" (id, sender_id, room_receiver_id, text)
VALUES (1, 1, 1, 'Hello World !');

INSERT INTO "message" (id, parent_id, sender_id, room_receiver_id, text)
VALUES (2, 1, 1, 1, 'another Hello World to previous World !');

INSERT INTO "message" (id, sender_id, room_receiver_id, text)
VALUES (3, 2, 1, 'Stop it. Hello World? how many time yo wanna say ?!');

INSERT INTO "message" (id, sender_id, room_receiver_id, text)
VALUES (4, 3, 1, 'Stop it. both of you. ');

INSERT INTO "message" (id, sender_id, user_receiver_id, text)
VALUES (5, 3, 1, 'Stop it. both of you. i said this in your private room.');

INSERT INTO "message" (id, sender_id, room_receiver_id, text)
VALUES (6, 3, 2, 'Stop it. both of you. i said this in your private room.');

select * from "message";

-- insert sample data in "room_users" table
INSERT INTO "room_users" (user_id, room_id)
VALUES (1, 1);

INSERT INTO "room_users" (user_id, room_id)
VALUES (2, 1);

INSERT INTO "room_users" (user_id, room_id)
VALUES (3, 1);

INSERT INTO "room_users" (user_id, room_id)
VALUES (4, 1);

INSERT INTO "room_users" (user_id, room_id)
VALUES (1, 2);

INSERT INTO "room_users" (user_id, room_id)
VALUES (2, 2);

INSERT INTO "room_users" (user_id, room_id)
VALUES (3, 2);

INSERT INTO "room_users" (user_id, room_id)
VALUES (4, 2);

insert into "room_users" (user_id, room_id)
values (2,  4)

select * from "room_users";

-- insert sample data in "premission" table
INSERT INTO "premission" (id, label, description)
VALUES (1, 'user__show_profile', 'another users can see users or room profile ');

INSERT INTO "premission" (id, label, description)
VALUES (2, 'room__can_add_user', 'another users can add user to room');

INSERT INTO "premission" (id, label, description)
VALUES (3, 'user__can_add_to_room', 'another users can add one user to group (privacy in setting)');

select * from "premission";

-- insert sample data in "user_premission" table
INSERT INTO "user_premission" (user_id, premission_id)
VALUES (1, 1);

INSERT INTO "user_premission" (user_id, premission_id)
VALUES (2, 1);

INSERT INTO "user_premission" (user_id, premission_id)
VALUES (1, 3);

select * from "user_premission";

-- insert sample data in "room_premission" table
INSERT INTO "room_premission" (room_id, premission_id)
VALUES (1, 2);

INSERT INTO "room_premission" (room_id, premission_id)
VALUES (2, 2);

select * from "room_premission";