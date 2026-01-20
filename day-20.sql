-- SQL Advent Calendar - Day 20
-- Title: Hot Cocoa Break Logs
-- Difficulty: medium
--
-- Question:
-- Jack Frost wants to review all the cocoa breaks he actually took — including the cocoa type and the location he drank it in. How would you combine the necessary tables to show each logged break with its matching cocoa details and location?
--
-- Jack Frost wants to review all the cocoa breaks he actually took — including the cocoa type and the location he drank it in. How would you combine the necessary tables to show each logged break with its matching cocoa details and location?
--

-- Table Schema:
-- Table: cocoa_logs
--   log_id: INT
--   break_id: INT
--   cocoa_id: INT
--
-- Table: break_schedule
--   break_id: INT
--   location_id: INT
--
-- Table: cocoa_types
--   cocoa_id: INT
--   cocoa_name: VARCHAR
--
-- Table: locations
--   location_id: INT
--   location_name: VARCHAR
--

-- My Solution:

WITH Break_Locations AS(
  select b.break_id,b.location_id,d.location_name
  from break_schedule b JOIN locations d ON b.location_id = d.location_id),
Cocoa_log_types AS(
  select a.log_id,a.break_id,a.cocoa_id,c.cocoa_id,c.cocoa_name
  from cocoa_logs a JOIN cocoa_types c ON a.cocoa_id = c.cocoa_id
)

SELECT f.break_id,f.cocoa_name,e.location_name
FROM Break_Locations e JOIN Cocoa_log_types f
ON e.break_id = f.break_id;
