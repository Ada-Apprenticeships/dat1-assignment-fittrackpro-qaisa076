-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA FOREIGN_KEY = ON;

-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance
SELECT
    equipment_id,
    name,
    type,
    next_maintenance_date
FROM
    equipment
WHERE
    next_maintenance_date <= Date('now');


-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock
SELECT 
    type,
    COUNT(*) AS equipment_count
FROM 
    equipment
GROUP BY 
    type;


-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)
SELECT
    e.type,
    AVG(JULIANDAY('now') - JULIANDAY(e.purchase_date)) AS average_age_days
FROM
    equipment AS e
GROUP BY
    e.type;
