-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH first_recorded AS (
    SELECT
        subject,
        quiz_date,
        score AS initial_score,
        ROW_NUMBER() OVER (
            PARTITION BY subject
            ORDER BY quiz_date ASC
        ) AS rn
    FROM daily_quiz_scores
),
last_recorded AS (
    SELECT
        subject,
        quiz_date,
        score AS final_score,
        ROW_NUMBER() OVER (
            PARTITION BY subject
            ORDER BY quiz_date DESC
        ) AS rn
    FROM daily_quiz_scores
)
SELECT
    f.subject,
    f.quiz_date AS first_quiz_date,
    f.initial_score,
    l.quiz_date AS last_quiz_date,
    l.final_score,
    (l.final_score - f.initial_score) AS score_improvement
FROM first_recorded f
JOIN last_recorded l
    ON f.subject = l.subject
WHERE f.rn = 1
  AND l.rn = 1
ORDER BY f.subject;
