-- اضافه کردن تریگر چک کردن یوزر نیم روم کمتر از ۵ نباشد
CREATE OR REPLACE FUNCTION trigger_check_room_username_that_must_be_longer_than_four_char() 
RETURNS trigger AS $$ 
BEGIN  
    IF length(TRIM(new.username)) < 5
    THEN RAISE EXCEPTION 'username must longer than four characters.'; RETURN NULL;
    END IF; 	
    RETURN new; 
   END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_room_username
BEFORE INSERT OR UPDATE 
ON "room"
FOR EACH ROW 
EXECUTE PROCEDURE trigger_check_room_username_that_must_be_longer_than_four_char(); 

DROP TRIGGER trigger_room_username ON "room" CASCADE;
INSERT INTO "room" (creator, type, username, create_date)
VALUES (1, 'channel', 'var', '2018-05-06');

-- تبدیل فیلد نیم به حروف بزرگ برای یوزر با استفاده از تریگر
CREATE OR REPLACE FUNCTION convert_to_uppercase_name_field_for_user() RETURNS TRIGGER AS $$
BEGIN
	NEW.name = UPPER(NEW.name);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER  upgrade_name_field_for_user
BEFORE INSERT ON "user"
FOR EACH ROW
EXECUTE PROCEDURE convert_to_uppercase_name_field_for_user();

INSERT INTO "user" (name, username, phone_number)
VALUES ('mojtaba', 'mojtaba', '09111234561');
select * from "user";

-- اضافه کردن خودکار یوزر به لیست یوزر های یک اتاق با تریگر
CREATE OR REPLACE FUNCTION add_user_to_list_of_room_member_when_room_is_create() 
RETURNS trigger AS $$ 
BEGIN  
	IF NEW is not null THEN
		INSERT INTO "room_users" (user_id, room_id)
		VALUES (NEW.creator, NEW.id);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_add_user_to_list_of_room_member_when_room_is_create
AFTER INSERT
ON "room"
FOR EACH ROW 
EXECUTE PROCEDURE add_user_to_list_of_room_member_when_room_is_create(); 

select * from "room_users";
INSERT INTO "room" (creator, type, username, create_date)
VALUES (1, 'channel', 'varzesh', '2018-05-06');


CREATE OR REPLACE FUNCTION delete_user_message_in_group_when_lefted() 
RETURNS TRIGGER AS $$
BEGIN
	delete from "message" where sender_id = OLD.user_id and room_receiver_id = OLD.room_id;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER  trigger_delete_user_message_in_group_when_lefted
AFTER DELETE ON "room_users"
FOR EACH ROW
EXECUTE PROCEDURE delete_user_message_in_group_when_lefted();

INSERT INTO "room_users" (user_id, room_id)
VALUES (28, 1);
INSERT INTO "message" (sender_id, room_receiver_id, text)
VALUES (28, 1, 'Hey.');
delete from "room_users" where room_id = 1 and user_id = 28;
select * from "message" where sender_id = 28;
select * from "room_users";

-- پاک کردن پیام هایی که یک کاربر حذف شده در یک روم ارسال کرده است
CREATE OR REPLACE FUNCTION delete_user_message_in_group_when_lefted() 
RETURNS TRIGGER AS $$
BEGIN
	delete from "message" where sender_id = OLD.user_id and room_receiver_id = OLD.room_id;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER  trigger_delete_user_message_in_group_when_lefted
AFTER DELETE ON "room_users"
FOR EACH ROW
EXECUTE PROCEDURE delete_user_message_in_group_when_lefted();

INSERT INTO "room_users" (user_id, room_id)
VALUES (28, 1);
INSERT INTO "message" (sender_id, room_receiver_id, text)
VALUES (28, 1, 'Hey.');
delete from "room_users" where room_id = 1 and user_id = 28;
select * from "message" where sender_id = 28;
select * from "room_users";

-- بروز کردن ویوی پیامهای بدون ریپلای وقتی که یک پیام حذف میشود
CREATE OR REPLACE FUNCTION refresh_message_without_reply_in_group_materilized_view() 
RETURNS TRIGGER AS $$
BEGIN
	REFRESH MATERIALIZED VIEW message_without_reply_in_group_materilized_view;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER  trigger_refresh_message_without_reply_in_group_materilized_view
AFTER DELETE ON "message"
FOR EACH ROW
EXECUTE PROCEDURE refresh_message_without_reply_in_group_materilized_view();

SELECT * FROM message_without_reply_in_group_materilized_view;
INSERT INTO "message" (sender_id, room_receiver_id, text)
VALUES (3, 1, 'Hey Bro.');
delete from "message" where id = 10;
select * from "message";

