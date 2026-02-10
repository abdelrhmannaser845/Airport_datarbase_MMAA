-- ++++++++++++++++++++++++
-- < Mohamed Khaled >--
-- ++++++++++++++++++++++++

-- Q1
/* The following query is used for displaying the bus number ,capacity and bus status for the buses 
which in hanger number '2' and sort them descendly according to their capacity */

SELECT bus_no as 'Bus Number',capacity,bus_status as 'Bus Status'
FROM bus
WHERE hanger_no='2' 
order by capacity desc;

-- --------------------------------------------------------------------------------------------------------------------------------
-- Q2
/* The following query is used for displaying the planes ID 
which has a malfunction ,its malfunction ,its start maintens date ,its end maintens date */

SELECT p_malfunction as Malfunction,P_start_mantains_date as 'Start Date',p_end_maintains_date as 'End Date',Plane_id as 'Plane ID'
FROM p_maintains 
group by plane_id ;

-- --------------------------------------------------------------------------------------------------------------------------------
-- Q3
/*The following query is used for displaying all mechanics names 
who maintening a bus, its phone, the bus malfunction, the bus number and the repair time */

SELECT f_name as Name,p.phone ,n.bus_malfunction as Malfunction,n.bus_no as 'Bus Number',n.repair_time as 'Repair Time'
FROM employee,employee_phone p,mechanic m,maintain n 
WHERE ssn=p.employee_ssn and ssn=m.employee_ssn and m.employee_ssn=n.employee_ssn ;

-- --------------------------------------------------------------------------------------------------------------------------------
-- Q4
/* The following query is used for displaying first name,last name,education,ssn for each mechanic 
who has the smallest salary and maintens the bus  */

SELECT concat(f_name, ' ', l_name) as 'Name',education,ssn
FROM employee,maintain
WHERE ssn=employee_ssn and
salary=(SELECT min(salary) 
FROM employee,maintain 
WHERE ssn=employee_ssn ) ;

-- --------------------------------------------------------------------------------------------------------------------------------
-- Q5
/* The following query is used for displaying the total salary for all security_employee */

SELECT sum(salary) as 'Total Salary',job_title as 'Job Title'
FROM employee inner join security_employee
on ssn=employee_ssn ;
-- --------------------------------------------------------------------------------------------------------------------------------
-- Q6
/*6 The following query is used for updating the status of the plane which had fixed */

UPDATE plane
SET status='A'
WHERE plane_id='1' ;

-- --------------------------------------------------------------------------------------------------------------------------------
-- Q7
/* The following query is used for displaying how many mechanic maintens a plane */

SELECT count(ssn) as 'Number of mechanic',job_title as 'Job Title '
FROM employee,mechanic m,p_maintains n
WHERE ssn=m.employee_ssn and m.employee_ssn=n.mechanic_ssn ;

-- --------------------------------------------------------------------------------------------------------------------------------
-- Q8
/* The following query is used for updating the status of the bus which had fixed */

UPDATE bus
SET bus_status='A'
WHERE bus_no='6' ;

-- --------------------------------------------------------------------------------------------------------------------------------
-- Q9
/* The following query is used for displaying all buses numbers , its malfunctions (if exist) */

SELECT m.bus_malfunction as 'Bus Malfunction',b.bus_no
FROM maintain m RIGHT OUTER JOIN bus b
ON m.bus_no=b.bus_no AND m_date < current_date group by bus_no ;

-- --------------------------------------------------------------------------------------------------------------------------------
