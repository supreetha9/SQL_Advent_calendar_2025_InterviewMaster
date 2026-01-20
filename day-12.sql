-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH daily_message_counts AS (
    SELECT
        CAST(m.sent_at AS DATE) AS each_day,
        m.sender_id AS user_id,
        COUNT(*) AS messages_sent
    FROM npn_messages m
    GROUP BY
        CAST(m.sent_at AS DATE),
        m.sender_id
),
ranked_daily AS (
    SELECT
        each_day,
        user_id,
        messages_sent,
        RANK() OVER (
            PARTITION BY each_day
            ORDER BY messages_sent DESC
        ) AS rnk
    FROM daily_message_counts
)
SELECT
    r.each_day,
    r.user_id,
    u.user_name,
    r.messages_sent
FROM ranked_daily r
JOIN npn_users u
    ON u.user_id = r.user_id
WHERE r.rnk = 1
ORDER BY
    r.each_day,
    r.user_id;
