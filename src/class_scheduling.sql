-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA FOREIGN_KEY = ON;
-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors
SELECT
    c.name AS class_name,
    s.first_name || ' ' || s.last_name AS instructor_name
FROM
    classes AS c
JOIN
    class_schedule AS cs ON c.class_id = cs.class_id
JOIN
    staff AS s ON cs.staff_id = s.staff_id;


-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date
SELECT
    c.name AS class_name,
    c.description,
    c.capacity,
    c.duration,
    l.name AS location_name,
    cs.start_time,
    cs.end_time,
    s.first_name || ' ' || s.last_name AS instructor_name
FROM
    classes AS c
JOIN
    class_schedule AS cs ON c.class_id = cs.class_id
JOIN
    locations AS l ON c.location_id = l.location_id
JOIN
    staff AS s ON cs.staff_id = s.staff_id
WHERE
    DATE(cs.start_time) = '2025-02-01'; -- Replace with the desired date


-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (
    7,2,'Registered'
);


-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration
DELETE FROM class_attendance
WHERE schedule_id = 7  -- Replace with the schedule_id of the class to cancel
  AND member_id = 2;    -- Replace with the member_id of the member to cancel


-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes
SELECT
    c.name AS class_name,
    COUNT(ca.member_id) AS attendance_count
FROM
    classes AS c
JOIN
    class_schedule AS cs ON c.class_id = cs.class_id
JOIN
    class_attendance AS ca ON cs.schedule_id = ca.schedule_id
WHERE ca.attendance_status = 'Attended'
GROUP BY
    c.name
ORDER BY
    attendance_count DESC
LIMIT 5;


-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member

SELECT
    CAST(COUNT(DISTINCT ca.schedule_id) AS REAL) / COUNT(DISTINCT m.member_id) AS average_classes_per_member
FROM
    members AS m
LEFT JOIN
    class_attendance AS ca ON m.member_id = ca.member_id;
