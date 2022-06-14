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
	INSERT INTO "room_users" (user_id, room_id)
	VALUES (NEW.creator, NEW.id);
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


