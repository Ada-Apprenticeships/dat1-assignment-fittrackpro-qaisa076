-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA FOREIGN_KEY = ON;
-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role
SELECT
    position,
    first_name,
    last_name
FROM
    staff
ORDER BY
    position, last_name, first_name;

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days
SELECT DISTINCT
    s.first_name,
    s.last_name
FROM
    staff AS s
JOIN
    personal_training_sessions AS pts ON s.staff_id = pts.staff_id
WHERE
    s.position = 'Trainer'
    AND pts.session_date BETWEEN DATE('now') AND DATE('now', '+30 days');
