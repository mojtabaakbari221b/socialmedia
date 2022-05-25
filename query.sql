-- دیدن تعداد پیام های ارسال شده در یک روم با آیدی خاص
select count(id) from "message" where room_receiver_id = 1;

-- دیدن تعداد پیام های ارسال شده در یک روم با یوزرنیم خاص
select * from "message" inner join "room"
ON "room".id="message".room_receiver_id where room_receiver_id=1;

-- دیدن مخاطبان جدید مخاطبان یک یوزر خاص (دوستان جدید)
select T.from_id, T2.to_id from "contacts" as T inner join "contacts" as T2
ON T.to_id=T2.from_id where T.from_id=1
except
select * from "contacts" where from_id = 1;

