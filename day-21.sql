-- SQL Advent Calendar - Day 21
-- Title: Fireside Story Running Total
-- Difficulty: hard
--
-- Question:
-- The Snow Queen hosts nightly fireside chats and records how many stories she tells each evening. Can you calculate the running total of stories she has shared over time, in the order they were told?
--
-- The Snow Queen hosts nightly fireside chats and records how many stories she tells each evening. Can you calculate the running total of stories she has shared over time, in the order they were told?
--

-- Table Schema:
-- Table: story_log
--   log_date: DATE
--   stories_shared: INT
--

-- My Solution:

WITH stories_per_day AS (
    SELECT
        log_date,
        SUM(stories_shared) AS total_stories_per_day
    FROM story_log
    GROUP BY log_date
)
SELECT
    log_date,
    total_stories_per_day,
    SUM(total_stories_per_day) OVER (
        ORDER BY log_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS total_stories_shared
FROM stories_per_day
ORDER BY log_date;
