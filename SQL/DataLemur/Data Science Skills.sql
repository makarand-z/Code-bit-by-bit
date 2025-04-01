/*
Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.

Assumption:

There are no duplicates in the candidates table.
candidates Table:
Column Name	Type
candidate_id	integer
skill	varchar
candidates Example Input:
candidate_id	skill
123	Python
123	Tableau
123	PostgreSQL
234	R
234	PowerBI
234	SQL Server
345	Python
345	Tableau
Example Output:
candidate_id
123
Explanation
Candidate 123 is displayed because they have Python, Tableau, and PostgreSQL skills. 345 isn't included in the output because they're missing one of the required skills: PostgreSQL.

*/

--step 1 - filtering all candidates that have skills in Python, Tableau and PostgreSQL

SELECT *
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
ORDER BY candidate_id;

--step 2 - using above query as an inline query, grouping on candidate_id and using HAVING clause on filtered data to filter out candidates with all skills (3 skills)

SELECT candidate_id
FROM (SELECT *
      FROM candidates
      WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
      ORDER BY candidate_id) AS skillset
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

