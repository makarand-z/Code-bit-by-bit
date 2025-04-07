/*
Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

p.s. If you've read the Ace the Data Science Interview and liked it, consider writing us a review?

posts Table:
Column Name	Type
user_id	integer
post_id	integer
post_content	text
post_date	timestamp
posts Example Input:
user_id	post_id	post_content	post_date
151652	599415	Need a hug	07/10/2021 12:00:00
661093	624356	Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that's gonna fly by. I miss my girlfriend	07/29/2021 13:00:00
004239	784254	Happy 4th of July!	07/04/2021 11:00:00
661093	442560	Just going to cry myself to sleep after watching Marley and Me.	07/08/2021 14:00:00
151652	111766	I'm so done with covid - need travelling ASAP!	07/12/2021 19:00:00
Example Output:
user_id	days_between
151652	2
661093	21

*/

-- solution 1 

SELECT user_id, 
MAX(CAST(post_date AS DATE)) - MIN(CAST(post_date AS DATE)) AS days_between
FROM posts
WHERE DATE_PART('year', post_date) = 2021 
GROUP BY user_id
HAVING COUNT(post_id) > 1;

-- solution 2

-- step 1 - using LEAD window function on post_date to get subsequent row as next_post_date and then filtering for year 2021

SELECT 
  user_id, 
  post_id, 
  post_date, 
  LEAD(post_date) OVER (PARTITION BY user_id ORDER BY post_date) AS next_post_date
FROM posts
WHERE DATE_PART('year', post_date) = 2021
ORDER BY 1, 3

--step 2 - using previous query as inline query and calculating sum (between next_post_date and post_date) and filtering for next_post_date is not null (atleast 2 posts in the same year)

SELECT user_id,
SUM(DATE_PART('day', next_post_date - post_date)) AS days_between
FROM (
  SELECT 
    user_id, 
    post_id, 
    post_date, 
    LEAD(post_date) OVER (PARTITION BY user_id ORDER BY post_date) AS next_post_date
  FROM posts
  WHERE DATE_PART('year', post_date) = 2021
  ORDER BY 1, 3) AS user_post_2021
WHERE next_post_date IS NOT NULL
GROUP BY 1