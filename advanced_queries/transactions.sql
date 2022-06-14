-- جلوگیری از ورود همزمان دو یوزر با یوزر نیم یکسان
BEGIN TRANSACTION ;
	INSERT INTO "user" (name, username, phone_number)
	VALUES ('alireza', 'alireza', '09111234549');
COMMIT;
ROLLBACK;

-- جلوگیری از ورود همزمان دو روم با یوزر نیم یکسان
BEGIN TRANSACTION ;
	INSERT INTO "room" (creator, type, username, create_date)
	VALUES (1, 'channel', 'varzesh32', '2018-05-06');
COMMIT;
ROLLBACK;
