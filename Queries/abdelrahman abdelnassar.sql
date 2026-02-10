-- ++++++++++++++++++++++++
-- < Abdelrahman Abdalnassar >--
-- ++++++++++++++++++++++++

-- Q1
/*Retrieve flight no and avrage price of it */

select b.flight_no as "Flight Number",avg(t.price) as 'Average Price' 
from book b left outer join ticket t on t.no=b.ticket_no 
group by b.flight_no;


-- -----------------------------------------------------------------------------------------
-- Q2
/*Retrieve name of passenger and his flight no*/

select concat(p.f_name,' ',p.minit,' ',l_name) as'Name',b.flight_no as "Flight Number"
from passenger p ,book b 
where b.passport_no=p.passport_no;

-- -----------------------------------------------------------------------------------------
-- Q3
/*Retrieve passenger name ,ticket class and ticket price*/

select concat(p.f_name,' ',p.minit,' ',l_name) as'Name',t.class,t.price
from passenger p ,book b , ticket t
where b.passport_no=p.passport_no and b.ticket_no=t.no;

-- -----------------------------------------------------------------------------------------
-- Q4
/*Retrieve flight no and plane capacity*/

select f.no  as "Flight Number" ,p.capacity
from flight f ,plane p 
where f.plane_id=p.plane_id;

-- -----------------------------------------------------------------------------------------
-- Q5
/*Retrieve passenger name and his Destination*/

select concat(p.f_name,' ',p.minit,' ',p.l_name) as'Name',b.flight_no  as "Flight Number",f.from,f.to
from passenger p ,book b ,flight f
where b.passport_no=p.passport_no and f.no=b.flight_no;

-- -----------------------------------------------------------------------------------------
-- Q6
/*Retrieve passenger and if he ride bus or not*/

select concat(p.f_name,' ',p.minit,' ',p.l_name) as'Name' , b.flight_no  as "Flight Number",
case 
when b.flight_no in (select distinct flight_no from flight_has_bus) then 'passenger get flight by bus'
else 'passenger deos not ride bus'
end as 'status'
from book b ,passenger p
where p.passport_no=b.passport_no ;

-- -----------------------------------------------------------------------------------------
-- Q7
/*Retrieve all flight and weather report*/

select f.no as "Flight Number",wd.* 
from flight f,weather_data wd,send s 
where f.no=s.flight_no and s.weather_data_cd=wd.cd;

-- -----------------------------------------------------------------------------------------
-- Q8
/*Retrieve flight no , controled airline and the plane of flight*/

select f.no as "Flight Number",a.name as 'Airline Name',concat(p.brand,' ',p.model) as'Plane'
from flight f ,airline a ,plane p
where p.plane_id=f.plane_id and f.airline_icao=a.icao;

-- -----------------------------------------------------------------------------------------
-- Q9
/*Retrieve flight no , gate no and gate location*/

select f.no as "Flight Number" ,f.gate_no as "Gate Number",g.location
from flight f ,gate g
where f.gate_no=g.no;

-- -----------------------------------------------------------------------------------------
-- Q10
/*Retrieve flight no ,the employee who work at this flight and his job title */

select o.flight_no as "Flight Number",concat(e.f_name,' ',e.minit,' ',e.l_name) as 'Employee Name',e.job_title as "Job Title"
from on_board o,air_employee ea,employee e,flight_attendant a
where o.air_emp_id=ea.id and ea.id=a.air_emp_id and a.employee_ssn=e.ssn
union
select o.flight_no,concat(e.f_name,' ',e.minit,' ',e.l_name) ,e.job_title
from on_board o,air_employee ea,employee e,pilot p
where o.air_emp_id=ea.id and ea.id=p.air_emp_id and p.employee_ssn=e.ssn;

-- -----------------------------------------------------------------------------------------
-- Q11
/*Retrieve number of flight which come in a day */

select DAY(arrival)as'Day' ,COUNT(arrival) as 'Number of arrival flight '
from flight f 
where f.to = 'HECA' GROUP BY DAY(arrival);

-- -----------------------------------------------------------------------------------------
-- Q12
/*Retrieve number of flight left in day*/

select DAY(departure)as'Day' ,COUNT(departure) as 'Number of Departure flight '
from flight f 
where f.from = 'HECA' GROUP BY DAY(departure);

-- -----------------------------------------------------------------------------------------
-- Q13 
/*Retrieve passenger name and his age*/

select concat(f_name,' ',minit,' ',l_name) as'Name' ,(datediff(current_date,b_date))/365.25 as'Age'
from passenger;

-- -----------------------------------------------------------------------------------------
-- Q14
/*update salary of employee whose age between 50 and 60*/

update employee 
set salary=(salary*.1)+salary
where ((datediff(current_date,b_date))/365.25) between 50 and 60;

-- -----------------------------------------------------------------------------------------
-- Q15
/*Retrieve flight no and name of employee who secures the gate which fligt come or left from it */

select f.no as "Flight Number",concat(e.f_name,' ',e.minit,' ',e.l_name) as'Name'
from employee e,flight f,security_employee se
where f.gate_no=se.gate_no and se.employee_ssn=ssn;
-- -----------------------------------------------------------------------------------------
