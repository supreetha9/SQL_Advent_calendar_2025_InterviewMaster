-- SQL Advent Calendar - Day 24
-- Title: New Year Goals - User Type Analysis
-- Difficulty: hard
--
-- Question:
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--

-- Table Schema:
-- Table: user_goals
--   user_id: INT
--   user_type: VARCHAR
--   goal_id: INT
--   goal_status: VARCHAR
--

-- My Solution:

WITH per_user_completed AS (
    SELECT
        user_type,
        user_id,
        SUM(CASE WHEN goal_status = 'Completed' THEN 1 ELSE 0 END) AS completed_goals
    FROM user_goals
    GROUP BY user_type, user_id
)
SELECT
    user_type,
    AVG(completed_goals) AS avg_completed_goals_per_user
FROM per_user_completed
GROUP BY user_type
ORDER BY user_type;
