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

select * from "room";
