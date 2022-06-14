--  تمامی پیامهای مخاطبین یک یوزر خاص در یک روم خاص در قالب ویو
CREATE VIEW messages_from_my_contacts_in_specific_room AS
select * from "message" where room_receiver_id = 1 and sender_id in (
	select to_id from "contacts" where from_id = 1
) ;

SELECT * FROM messages_from_my_contacts_in_specific_room;

-- پیامهای یک گروه با آیدی خاص که روی آنها ریپلای نشده است در قالب ویو
CREATE MATERIALIZED VIEW message_without_reply_in_group_materilized_view AS
select "message".id, text from "message" inner join "room"
on "message".room_receiver_id = "room".id
where type='group' and "room".id = 1 and parent_id is null ;

REFRESH MATERIALIZED VIEW message_without_reply_in_group_materilized_view;
SELECT * FROM message_without_reply_in_group_materilized_view;
