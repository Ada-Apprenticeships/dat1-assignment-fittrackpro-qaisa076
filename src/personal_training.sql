-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA FOREIGN_KEY = ON;
-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer
SELECT
    pts.session_date,
    pts.start_time,
    pts.end_time,
    m.first_name AS member_first_name,
    m.last_name AS member_last_name
FROM
    personal_training_sessions AS pts
JOIN
    staff AS s ON pts.staff_id = s.staff_id
JOIN
    members AS m ON pts.member_id = m.member_id
WHERE
    s.first_name = 'David' AND s.last_name = 'Brown';

