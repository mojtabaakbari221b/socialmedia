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


