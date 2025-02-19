-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA FOREIGN_KEY = ON;
-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (
    1,  -- Replace with the actual member_id
    1,  -- Replace with the actual location_id
    '2025-02-19 13:15:00' -- Replace with the actual check-in time
);

-- To record the check-out time later:
UPDATE attendance
SET check_out_time = '2025-02-19 14:45:00' -- Replace with the actual check-out time
WHERE member_id = 1
  AND check_in_time = '2025-02-19 13:15:00'
  AND check_out_time IS NULL;


-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history
SELECT
    a.check_in_time,
    a.check_out_time,
    l.name AS location_name
FROM
    attendance AS a
JOIN
    locations AS l ON a.location_id = l.location_id
WHERE
    a.member_id = 1 -- Replace with the desired member_id
ORDER BY
    a.check_in_time DESC;

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits
SELECT
    STRFTIME('%w', check_in_time) AS day_of_week,
    COUNT(*) AS visit_count
FROM
    attendance
GROUP BY
    day_of_week
ORDER BY
    visit_count DESC
LIMIT 1;

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location
SELECT
    l.name AS location_name,
    AVG(daily_attendance) AS average_daily_attendance
FROM
    locations AS l
JOIN
    (SELECT
        location_id,
        DATE(check_in_time) AS visit_date,
        COUNT(DISTINCT member_id) AS daily_attendance  -- Count distinct members for each day
    FROM
        attendance
    GROUP BY
        location_id,
        visit_date) AS daily_data ON l.location_id = daily_data.location_id
GROUP BY
    l.name;
