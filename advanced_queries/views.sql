--  تمامی پیامهای مخاطبین یک یوزر خاص در یک روم خاص در قالب ویو
CREATE VIEW messages_from_my_contacts_in_specific_room AS
select * from "message" where room_receiver_id = 1 and sender_id in (
	select to_id from "contacts" where from_id = 1
) ;

SELECT * FROM messages_from_my_contacts_in_specific_room;

-- 
