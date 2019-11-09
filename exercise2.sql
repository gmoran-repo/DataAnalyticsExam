-- 2

WITH events AS(
	SELECT
		device_id,
		time_stamp,
		LEAD(time_stamp) OVER (PARTITION BY device_id ORDER BY time_stamp) as next_time_stamp
	FROM events_table
	WHERE month = '201908'
	AND app_id = 1
	AND event_id = 4
),
per_event AS (
	SELECT
		device_id,
		DATE_DIFF('second', time_stamp, next_time_stamp) as time_diff
	FROM events
)
SELECT
	device_id,
	AVG(time_diff) as avg_per_user
FROM per_event
GROUP BY 1

/*
The query calculate, for the client 1 on august 2019, how long it taked on average to each users to do again 
the action type 4. And returns the result ordered by user.
Could be used as a trigger to send discounts. For example, if a user had an average of purchase every 5 days, 
then if in this month near fifth day doesnt have items add to the cart we can send to the user a discount to
persuede to make a new purchase. On the other hand, can make actions to lower time average between purchases
of those how had show the biggests avg_per_user.
*/

WITH events AS(
	SELECT
		e.device_id,
		e.time_stamp,
		min(n.time_stamp) as next_time_stamp
	FROM events_table e
	LEFT JOIN events_table n
	n.app_id = e.app_id
	n.event_id = e.event_id
	n.month = e.month
	n.device_id = e.device_id
	n.time_stamp > e.time_stamp		
	WHERE e.month = '201908'
	AND e.app_id = 1
	AND e.event_id = 4
	GROUP BY e.device_id, e.time_stamp
),
per_event AS (
	SELECT
		device_id,
		DATE_DIFF('second', time_stamp, next_time_stamp) as time_diff
	FROM events
)
SELECT
	device_id,
	AVG(time_diff) as avg_per_user
FROM per_event
GROUP BY 1
    