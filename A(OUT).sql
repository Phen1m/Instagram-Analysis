# Marketing Analysis:

#1 LOYAL USERS
SELECT * FROM users ORDER BY created_at LIMIT 5;

#2 INACTIVE USERS
SELECT username FROM users LEFT JOIN photos ON users.id=photos.user_id WHERE photos.id IS NULL;

#3 CONTEST WINNER
SELECT username, photos.id, photos.image_url, count(likes.user_id) AS total
FROM photos INNER JOIN likes ON likes.photo_id=photos.id INNER JOIN users ON photos.user_id = users.id
GROUP BY photos.id ORDER BY total DESC LIMIT 1; 

#4 MOST HASHTAG
SELECT tags.tag_name, COUNT(*) AS total
FROM photo_tags JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY tags.id ORDER BY total DESC LIMIT 5;

#5 MOST INSTAGRAM USER REGISTER
SELECT DAYNAME(created_at) AS day, count(*) AS total
FROM users GROUP BY day ORDER BY total DESC LIMIT 1;

# Investor Metrics:

#1 USERARANGEMENT
select *from photos,users;
with base as 
(select u.id as userid,COUNT(p.id) as photoid from users u left join photos p on p.user_id=u.id group by u.id)
select SUM(photoid) as totalphotos,COUNT(userid) as total_users,SUM(photoid)/count(userid) as photoperuser
from base;

#2  Identify users

SELECT u.username, COUNT(l.photo_id) AS likes
FROM users u
INNER JOIN likes l ON u.id = l.user_id
GROUP BY u.username;
WITH base AS (SELECT u.username, COUNT(l.photo_id) AS likes
FROM likes l
INNER JOIN users u ON u.id = l.user_id
GROUP BY u.username)
SELECT username, likes
FROM base
WHERE likes = (SELECT COUNT(*) FROM photos) ORDER BY username;

