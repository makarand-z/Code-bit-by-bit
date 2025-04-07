/*
Assume you have an events table on Facebook app analytics. Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.

Definition and note:

Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
To avoid integer division, multiply the CTR by 100.0, not 100.

events Table:
Column Name	Type
app_id	integer
event_type	string
timestamp	datetime

events Example Input:
app_id	event_type	timestamp
123	impression	07/18/2022 11:36:12
123	impression	07/18/2022 11:37:12
123	click	07/18/2022 11:37:42
234	impression	07/18/2022 14:15:12
234	click	07/18/2022 14:16:12

Example Output:
app_id	ctr
123	50.00
234	100.00

Explanation
Let's consider an example of App 123. This app has a click-through rate (CTR) of 50.00% because out of the 2 impressions it received, it got 1 click.

To calculate the CTR, we divide the number of clicks by the number of impressions, and then multiply the result by 100.0 to express it as a percentage. In this case, 1 divided by 2 equals 0.5, and when multiplied by 100.0, it becomes 50.00%. So, the CTR of App 123 is 50.00%.

*/

-- step 1 - calculating cliacks and impressions for 2022

SELECT app_id,
SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) AS clicks, 
SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END) AS impressions
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY app_id;

-- step 2 - using above query as subquery to find ctr

SELECT app_id,
ROUND(100 * SUM(clicks) / SUM (impressions),2) AS ctr 
FROM (
  SELECT app_id,
  SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) AS clicks, 
  SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END) AS impressions
  FROM events
  WHERE EXTRACT(YEAR FROM timestamp) = 2022
  GROUP BY app_id  
) AS event_types
GROUP BY app_id;