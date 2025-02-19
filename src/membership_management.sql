-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA FOREIGN_KEY = ON;
-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships
SELECT
    member_id,
    type,
    start_date,
    end_date
FROM
    memberships
WHERE
    status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type
SELECT
    m.type AS membership_type,
    AVG((JULIANDAY(a.check_out_time) - JULIANDAY(a.check_in_time)) * 24 * 60) AS average_duration_minutes
FROM
    memberships AS m
JOIN
    attendance AS a ON m.member_id = a.member_id
WHERE a.check_out_time IS NOT NULL
GROUP BY
    m.type;

-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
SELECT
    member_id,
    type,
    start_date,
    end_date,
    status
FROM
    memberships
WHERE
    STRFTIME('%Y', end_date) = '2025' AND status = 'Active';
