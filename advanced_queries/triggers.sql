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

