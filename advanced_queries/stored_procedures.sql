-- متد برای اضافه کردن یک یوزر
CREATE OR REPLACE PROCEDURE add_new_user(
	user_name character varying,
	user_username character varying,
	user_phone_number character varying
)
LANGUAGE plpgsql    
AS 
$$
BEGIN
	INSERT INTO "user" (name, username, phone_number)
	VALUES (user_name, user_username, user_phone_number);
COMMIT;
END;
$$;

CALL add_new_user('mojtaba','sample','09119111245');
select * from "user";

-- متد برای اضافه کردن یک یوزر به یک روم
CREATE OR REPLACE PROCEDURE add_new_user_to_room(
	new_user_id integer,
	destination_room_id integer
)
LANGUAGE plpgsql    
AS 
$$
BEGIN
	INSERT INTO "room_users" (user_id, room_id)
	VALUES (new_user_id, destination_room_id);
COMMIT;
END;
$$;

CALL add_new_user_to_room(1 , 2);
select * from "room_users";