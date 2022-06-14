---------------------------------------------Day 1---------------------------------------------------------
create database Think;

create table Student(
Stud_Id int,
Stud_Name varchar(100),
Stud_Class varchar(10)
)

insert into Student values(1,'Harshad','12th');
insert into Student(Stud_Id,Stud_Name) values(2,'Shubham');
select * from Student;

create table Employee(
Eid int primary key,
Ename varchar(30) not null,
Email varchar(30) not null,
City varchar(20) default 'Pune',
MobileNumber bigint unique,
Age int check(Age>18)
)

insert into Employee values(1,'omkar','om@gmail.com','mumbai',123456789,20);

insert into Employee(Eid,Ename,Email) values(2,'dhanya','dhan@gmail.com')

insert into Employee values(3,'Kishor','kishor@gmail.com','kolkata',67253462,19)

--insert into Employee(Eid,Ename) values(2,'dhanya')  --Throws error Bcoz Email not allow null values

--insert into Employee values(3,'jitan','jatin@gmail.com','delhi',123456789,20); --we cannot put duplicate value if column is unique constraints 

--insert into Employee values(3,'Kishor','kishor@gmail.com','kolkata',67253462,10) --must need Age is greater than 18 bcoz of check constraints

select * from Employee

sp_rename 'Employee.Email','Emp_Ename'; --sp_rename 'TableName.ColName','NewColName';

sp_help Employee

alter table employee add salary bigint
alter table employee add sal bigint
alter table employee alter column salary varchar(100)
alter table employee drop column sal

---------------------------------------------Day 2---------------------------------------------------------
create database ThinkQuotient;

create table Batch(
Bid int primary key,
Bname varchar(100)
)

select * from Batch
select * from Student

alter table Student add constraint fk foreign key(Bid) references batch(bid)

create table student(
sid int primary key,
sname varchar(100),
bid int,
constraint fk foreign key(bid) references batch(bid)
on delete set null on update cascade);
-- when we want to delete or update parent record then automatically delete or update child record

insert into student values(101,'ravi',1),(102,'vinya',2)

select * from student;

delete from batch where bid=1;

update batch set bid=22 where bid=2;

create table StudentAttendece(
sid int,
Attend_date date,
Presenty char(1),
primary key(sid,Attend_date),
constraint fks foreign key(sid) references Student(sid))

insert into StudentAttendece values(101,'2022-05-16','p')

select * from StudentAttendece

---------------------------------------------------Day 3---------------------------------------------------
--and
select * from employees where salary>=5000 and salary<=10000

--or
select * from employees where department_id=1 or department_id=2

--in clause
select * from employees where department_id in (1,3,5)

--not in clause
select * from employees where department_id not in (1,3,5)

--between
select * from employees where salary between 5000 and 15000

--is null
select * from employees where phone_number is null

--is not null
select * from employees where phone_number is not null

--like
select * from employees where first_name like '%a%'
select * from employees where first_name like 'v____'

--distinct
select distinct department_id from employees

--order by
select * from employees order by first_name desc
select * from employees where department_id=3 order by salary desc,first_name 

--top
select top 3 * from employees 

--Aggregate Function = max,min,sum,avg,count
--max
select max(salary) as 'Maximum Salary' from employees where department_id=3

--min
select min(salary) 'Minimum sal' from employees

--avg
select avg(salary) from employees

--sum
select sum(salary) from employees

--count
select count(salary) from employees --count not null record in particular col
select count(*) from employees

--group by
select department_id,min(salary) from employees group by department_id
select department_id,count(*) from employees group by department_id

--group by having clause
select department_id,min(salary) from employees group by department_id having min(salary)<5000
select department_id,count(*),max(salary) from employees group by department_id having min(salary)>10000


------------------------------------------Day 4------------------------------------------------------------
--Joins 
--Subquery

update booking_details set charges=charges-(charges*10) where app_id=(select app_name from booking_app where app_name='Trivago')

delete from booking_details where hotel_id in (select hotel_id from hotel where hotel_name='Taj' and city='mumbai');

------------------------------------------Day 5------------------------------------------------------------
--Join
--cross join, inner join, self join
select * from employees
select * from departments
select * from jobs

--inner join
select first_name,department_name from employees e inner join departments d on e.department_id=d.department_id
select first_name,job_title from employees inner join jobs on Employees.job_id=jobs.job_id

-------------------------------------------Day 6------------------------------------------------------------

select * from employees order by salary offset 5 rows fetch next 5 rows only;

--self join
select e.first_name,m.first_name from employees e inner join employees m on e.employee_id=m.department_id

create table emp(
eid int primary key identity(1,1),
ename varchar(100),
mgid int,
constraint fke foreign key(mgid) references emp(eid))

insert into emp(ename,mgid) values('vijay',3)

select * from emp

select e.ename,m.ename from emp e inner join emp m on e.eid=m.mgid

select e.ename,m.ename from emp e inner join emp m on e.eid=m.mgid where m.ename='deepa'


--Upper
select upper(first_name) from employees

--Lower
select lower(last_name) from employees

--Length
select len(last_name) from employees

--trim
select trim(last_name) from employees

--Concat
select concat('Mr.',first_name,'-',last_name) from employees

--Substring
select substring(last_name,1,3) from employees

--today date
select getdate();

--month in number
select month(hire_date) from employees

--month in word
select datename(month,hire_date) from employees

------------------------------------------Day 7-------------------------------------
--view
create view vkstud
as select sid,attend_date,presenty from studentattendece

select * from vkstud

insert into vkstud values(102,'2020-04-02','p')

delete from vkstud where sid=102

create view vstat
as select sname,presenty from student s join StudentAttendece sa on s.sid=sa.sid

select * from vstat