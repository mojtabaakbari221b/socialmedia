-- دیدن تعداد پیام های ارسال شده در یک روم با آیدی خاص
select count(id) from "message" where room_receiver_id = 1;

-- دیدن تعداد پیام های ارسال شده در یک روم با یوزرنیم خاص
select * from "message" inner join "room"
ON "room".id="message".room_receiver_id where room_receiver_id=1;
