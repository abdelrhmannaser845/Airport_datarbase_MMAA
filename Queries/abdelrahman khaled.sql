-- ++++++++++++++++++++++++
-- < Abdelrahman khaled >--
-- ++++++++++++++++++++++++

-- Q1
/*we will increase the salary of the pilot and flight attendant 200$ 
if there flight hours is greater then 150
and if there flight hours is greater than 300 we will increase extra 200$ for them.*/
UPDATE employee e,
    pilot p,
    flight_attendant a 
SET 
    e.salary = CASE
        WHEN p.flight_hours > 300 THEN e.salary + 400
        WHEN p.flight_hours > 150 THEN e.salary + 200
        WHEN a.flight_hours > 300 THEN e.salary + 400
        WHEN a.flight_hours > 150 THEN e.salary + 200
        ELSE e.salary
    END
WHERE
    e.ssn = p.employee_ssn
        OR e.ssn = a.employee_ssn;

-- To Check 

SELECT e.salary, e.ssn, p.flight_hours
FROM pilot p , employee e
where p.employee_ssn = e.ssn and p.flight_hours > 150

union

SELECT e.salary, e.ssn, p.flight_hours
FROM flight_attendant p , employee e
where p.employee_ssn = e.ssn and p.flight_hours > 150

union 

SELECT e.salary, e.ssn, p.flight_hours
FROM pilot p , employee e
where p.employee_ssn = e.ssn and p.flight_hours > 300

union

SELECT e.salary, e.ssn, p.flight_hours
FROM flight_attendant p , employee e
where p.employee_ssn = e.ssn and p.flight_hours > 300;


-- --------------------------------------------------------------------------------------------------------------------    
-- Q2
/*we need to know the number of attendant in each flight */
SELECT 
    od.flight_no AS 'Flight Number',
    COUNT(fa.air_emp_id) AS 'Number of Attendant'
FROM
    flight_attendant fa,
    on_board od,
    air_employee ae
WHERE
    fa.air_emp_id = ae.id
        AND od.air_emp_id = ae.id
GROUP BY od.flight_no
ORDER BY COUNT(fa.air_emp_id) DESC;

-- -------------------------------------------------------------------------------------------------------------------
-- Q3
/*number of employees’phones for each employee*/
SELECT 
    CONCAT(e.f_name, ' ', e.minit, ' ', e.l_name) AS 'Name',
    COUNT(ph.phone) AS 'Phones Number'
FROM
    employee AS e
        JOIN
    employee_phone AS ph ON e.ssn = ph.employee_ssn
GROUP BY e.ssn
ORDER BY COUNT(ph.phone) DESC;

-- --------------------------------------------------------------------------------------------------------------------
-- Q4
/*we need to know the airline which Appointe the largest no of employee*/
SELECT 
	a.name as 'Name',
    ae.airline_icao as 'airline icao',
    COUNT(ae.id) AS 'number of employees'
FROM
    air_employee ae,
    airline a
WHERE
    ae.airline_icao = a.icao
GROUP BY airline_icao
ORDER BY COUNT(id) DESC
LIMIT 1;

-- --------------------------------------------------------------------------------------------------------------------
-- Q5
/*we need to know the employees who the date of issue is 2015 or less to renewal thier certification*/
SELECT 
    CONCAT(e.f_name, ' ', e.minit, ' ', e.l_name) AS 'Name',
    e.ssn as 'SSN'
FROM
    employee e,
    pilot p
WHERE
    (e.ssn = p.employee_ssn
        AND p.i_date < '2015-12-31')
GROUP BY e.ssn 

UNION 

SELECT 
    CONCAT(e.f_name, ' ', e.minit, ' ', e.l_name) AS 'Name',
    e.ssn
FROM
    employee e,
    mechanic m
WHERE
    (e.ssn = m.employee_ssn
        AND m.i_date < '2015-12-31')
GROUP BY e.ssn 

UNION 

SELECT 
    CONCAT(e.f_name, ' ', e.minit, ' ', e.l_name) AS 'Name',
    e.ssn
FROM
    employee e,
    ame am
WHERE
    (e.ssn = am.employee_ssn
        AND am.i_date < '2015-12-31')
GROUP BY e.ssn
;


-- --------------------------------------------------------------------------------------------------------------------
-- Q6
/*we will know the number of language for each attendant is speak*/

create view v1 as (select  l.employee_ssn , count(l.language) as "count"
from language l
where l.employee_ssn = l.employee_ssn group by employee_ssn);

drop view v1;

select *
from v1;

SELECT 
    SUM(count) / COUNT(employee_ssn) AS 'Average'
FROM
    v1;
    
-- -------------------------------------------------------------------------------------------------------------------
-- Q7
/* show the average of the flight hours for pilots and attendants*/
SELECT 
    AVG(p.flight_hours) AS 'Average of pilots',
    AVG(f.flight_hours) AS 'Average of flight_attendant'
FROM
    pilot p,
    flight_attendant f;

-- -------------------------------------------------------------------------------------------------------------------