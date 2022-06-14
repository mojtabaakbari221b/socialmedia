-- یک تابع برای چک کردن اینکه آيا یک یوزر یک اجازه دسترسی خاص را در سایت دارد یا خیر
CREATE OR REPLACE FUNCTION is_user_have_specific_premission(usr_id integer, expected_label character varying) RETURNS bool
AS $$
DECLARE
	user_premission_counter integer;
BEGIN
	select count(*) into user_premission_counter from "user_premission" inner join "premission"
	on "user_premission".premission_id = "premission".id
	where label = expected_label and "user_premission".user_id = usr_id ;
	IF user_premission_counter > 0 THEN
		return TRUE;
	END IF ;
	return FALSE;
END; $$
LANGUAGE plpgsql;

SELECT is_user_have_specific_premission(1, 'user__show_profile');

-- برگرداندن اولین رومی که یک یوزر ساخته است با رکورد
CREATE OR REPLACE FUNCTION return_first_room_that_user_created(usr_id integer) RETURNS record AS 
$$
DECLARE
	t record;
BEGIN
		SELECT * INTO t FROM "room"
			where creator = usr_id
			order by (create_date,  id);
		RETURN t;
END;
$$ LANGUAGE plpgsql;

select return_first_room_that_user_created(1);
select return_first_room_that_user_created(4);
