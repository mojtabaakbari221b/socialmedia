--  دیدن اینکه هر روم بطور میانگین چند یوزر دارد
select cast(avg(count) as int) avg_users_in_room from 
(
	select room_id, count(user_id) from "room_users" left outer join "room"
	on "room_users".room_id = "room".id
	group by room_id
) as T

-- روم های با تایپ خاص (کانال) مشترک بین یوزر و مخاطبانش
select id, username from "room" right outer join "room_users"
on "room_users".room_id = "room".id where type='channel' and user_id = 1
intersect
select id,username from "room" right outer join "room_users"
on "room_users".room_id = "room".id where type='channel'
and user_id in (
	select to_id as intersectes from "contacts" where from_id = 1
)

-- بیشترین تعداد روم که یوزر ها عضو هستند
select max(count)
from (
	select user_id, count(room_id) from "room_users"
	group by user_id
) as T

-- مشخصات روم که تعداد پیام هایش از همه روم هایی که بعد از سال ۲۰۱۹ ثبت نام کرده است
select id , username, type from "room" inner join (
	select room_receiver_id from "message"
	where room_receiver_id is not null
	group by room_receiver_id
	having count(id) > ALL (
		select count("message".id) from "message" inner join "room"
		on "room".id = "message".room_receiver_id
		where create_date > '2019-01-01'
		group by room_receiver_id
	)
) as T
on T.room_receiver_id = "room".id

-- اطلاعات روم که زودتر از همه در سایت ثبت نام کرده است
select * from "room"
where create_date = (
	select min(create_date) from "room"
)

-- لیست کسانیکه در یک روم خاص عضو هستند
select * from "user"
where exists (
	select user_id from "room_users"
	where room_id = 1 and room_id = "user".id
)

-- دیدن تعداد پیام های ارسال شده در یک روم با آیدی خاص
select count(id) from "message" where room_receiver_id = 1;

-- دیدن تعداد پیام های ارسال شده یک یوزر خاص در یک روم با آیدی خاص
select count(id) from "message" where room_receiver_id = 1 and sender_id = 1;

-- دیدن تعداد پیام های ارسال شده در یک روم با یوزرنیم خاص
select count("room".id) from "message" inner join "room"
ON "room".id="message".room_receiver_id where room_receiver_id=1;

-- دیدن مخاطبان جدید مخاطبان یک یوزر خاص (دوستان جدید)
select T.from_id, T2.to_id from "contacts" as T inner join "contacts" as T2
ON T.to_id=T2.from_id where T.from_id=1
except
select * from "contacts" where from_id = 1;

-- مجموع پیام هایی که یک کاربر خاص در دو روم خاص ارسال کرده است
select count(*) from
(
	select * from "message" inner join "room"
	on "message".room_receiver_id = "room".id
	where room_receiver_id=1 and sender_id = 3
	union
	select * from "message" inner join "room"
	on "message".room_receiver_id = "room".id
	where room_receiver_id=2 and sender_id = 3
) as T

-- ترتیب نزولی کسانیکه بیشترین پیام را در یک روم داده اند
select sender_id , count(id) as number_of_messages from "message"
where room_receiver_id=1
group by sender_id
order by number_of_messages desc;

-- لیست کسانیکه در بیشتر از ۲ روم عضو هستند
select user_id , count(*) from "room_users"
group by user_id
having( count(*) >= 2);

-- لیست کسانیکه حداقل در یک روم عضو هستند
select * from "user"
where id in (select user_id from "room_users");

-- تعداد روم هایی که هیچ عضوی ندارند
select count(*) as number_of_unmembered_room from (
	select id from "room"
	except
	select distinct(room_id) from "room_users"
) as T;

-- دیدن اینکه هر یوزر در یک بازه زمانی چند روم تشکیل داده است
select "user".username, count("room".id) as number_of_rooms from "room" inner join "user"
on "user".id="room".creator
where create_date >= '2018-05-06' and create_date <= '2020-05-06'
group by "user".username;

-- مشخصات یوزری که تمامی اجازه دسترسی به افراد دیگر را داده است برای تعامل
select * from "user" 
where id in
	(
		select user_id as number_of_premission from "user_premission" 
		group by user_id
		having count(premission_id) = (
			select count(*) from "premission" where label like 'user__%'
		)
	)

-- درست کردن ایندکس روی روم
CREATE INDEX idx_room_username 
ON "room"(username);

-- درست کردن ایندکس روی یوزر
CREATE INDEX idx_user_phone_number 
ON "user"(phone_number);

-- برای چک کردن قبل و بعد اعمال ایندکس
EXPLAIN SELECT *
FROM "user"
WHERE phone_number = '09111234567';

-- دستورات حذف و بروزرسانی

-- پاک سازی یوزر با آیدی خاص
DELETE FROM "user" WHERE id=11;

-- پاک سازی روم با آیدی خاص
DELETE FROM "room_users" WHERE id=1 or id=2;

-- پاک سازی کل افراد موجود در یک روم
DELETE FROM "room_users";

-- بروزرسانی اطلاعات یک یوزر خاص
UPDATE "user"
set name='hg', username='hg'
where id=1;

-- بروزرسانی اطلاعات یک روم خاص
UPDATE "room"
set name='fz', username='fz'
where id=1;