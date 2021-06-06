use social_net;

#selection of users with the number of likes received, likes placed and mutual likes
select `user`.id_user, `user`.user_name as 'Имя пользователя', count(`like`.like_to_id) as 'Получено лайков', (
select count(`like`.like_from_id)
from `like`
where like_from_id = `user`.id_user
) as 'Поставлено лайков', (
select count(*)
from `like` as l_from
inner join `like` as l_to on  l_to.like_from_id = l_from.like_to_id
where l_from.like_from_id = `user`.id_user and l_to.like_to_id = `user`.id_user and l_from.entity_id = '1' and l_to.entity_id = '1'
) as 'Взаимных лайков'
from `user`
left join `like` on  `user`.id_user = `like`.like_to_id
group by `user`.id_user;

# selection of users who set like user 3 and 4 but didn't set like user 10
select `user`.id_user , `user`.user_name as 'Имя пользователя' from `user`
inner join `like` as like_a on `user`.id_user = like_a.like_from_id
inner join `like` as like_b on `user`.id_user = like_b.like_from_id
where `user`.id_user = like_a.like_from_id and `user`.id_user = like_b.like_from_id
and like_a.like_to_id = 3 and like_b.like_to_id = 4
and like_a.like_to_id != 10 and like_b.like_to_id != 10
and like_a.entity_id = '1' and like_b.entity_id = '1';
