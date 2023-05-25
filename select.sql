SELECT g.name, count(author_id) FROM genre g
JOIN genreauthor g2 ON g.id = g2.genre_id
JOIN author a ON g2.author_id = a.id
GROUP BY g.name;

SELECT count(t.id) FROM track t
JOIN album a ON t.album_id = a.id
WHERE YEAR BETWEEN 2019 AND 2020;

SELECT a.name, avg(duration) FROM album a
JOIN track t ON a.id = t.album_id
GROUP BY a.name;

SELECT a.name FROM author a
JOIN albumauthor a2 ON a.id = a2.author_id
JOIN album al ON a2.album_id = al.id 
WHERE YEAR !='2020'
GROUP BY a.name;

SELECT m.name FROM mixtape m
JOIN trackmixtape t2 ON m.id = t2.mixtape_id 
JOIN track t ON t2.track_id = t.id 
JOIN album al ON t.album_id = al.id 
JOIN albumauthor a2 ON al.id = a2.album_id
JOIN author a ON a2.author_id = a.id 
WHERE a.name LIKE 'OutKast'
GROUP BY m.name;

SELECT al.name FROM album al
JOIN albumauthor a2 ON al.id = a2.album_id 
JOIN author a ON a2.author_id = a.id 
JOIN genreauthor g ON a.id = g.author_id 
JOIN genre ON g.genre_id = genre.id
GROUP BY al.name 
HAVING count(DISTINCT genre.name) > 1
ORDER BY al.name;
 
SELECT t.name FROM track t
LEFT JOIN trackmixtape t2 ON t.id = t2.track_id
WHERE t2.mixtape_id is NULL;

SELECT a.name, t.duration FROM track t
LEFT JOIN album al ON al.id = t.album_id 
LEFT JOIN albumauthor a2 ON a2.album_id = al.id 
LEFT JOIN author a ON a.id = a2.author_id 
GROUP BY a.name, t.duration 
HAVING t.duration = (SELECT min(duration) FROM track)
ORDER BY a.name;

SELECT DISTINCT al.name FROM album al
LEFT JOIN track t ON t.album_id = al.id 
WHERE t.album_id IN 
	(SELECT album_id FROM track
	GROUP BY album_id
	HAVING count(id) = 
		(SELECT count(id) FROM track
		GROUP BY album_id 
		ORDER BY count 
		LIMIT 1
		)
	)
ORDER BY al.name
