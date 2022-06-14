-- این تابع تمامی کاربرانی که بلاک هستند را میگیرند
-- سپس یک عدد بین ۰ تا ۱ تولید میکند، اگر عدد از ۰.۵ کمتر بود
-- کاربر را از حالت بلاک در می آورد
CREATE OR REPLACE PROCEDURE deblock_user_if_randomnumber_less_than_half() 
AS $$
DECLARE c_row RECORD;
DECLARE randomnumber REAL;
DECLARE blocked_user_cursor CURSOR FOR (
	select user_id , premission_id from "user_premission" inner join "premission"
	on "user_premission".premission_id = "premission".id
	where label = 'user__blocked'
);
BEGIN
	OPEN blocked_user_cursor;
	LOOP
		FETCH blocked_user_cursor INTO c_row;
		randomnumber = random();
		IF NOT FOUND THEN EXIT; END IF;
		IF (randomnumber < 0.5) THEN
			delete from "user_premission" 
				where user_id = c_row.user_id and premission_id = c_row.premission_id;
		END IF;
	END LOOP;
	CLOSE blocked_user_cursor;
END;
$$ LANGUAGE plpgsql;

INSERT INTO "premission" (id, label, description)
VALUES (4, 'user__blocked', 'this user cant send message to another users.');

INSERT INTO "user_premission" (user_id, premission_id)
VALUES (1, 4);
INSERT INTO "user_premission" (user_id, premission_id)
VALUES (2, 4);
INSERT INTO "user_premission" (user_id, premission_id)
VALUES (3, 4);

select * from "user_premission" inner join "premission"
on "user_premission".premission_id = "premission".id
where label = 'user__blocked';

call deblock_user_if_randomnumber_less_than_half();


