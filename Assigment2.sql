create database Assignment

create table Customer(
Cust_Id int primary key,
Cname varchar(100),
address_line1 varchar(100),
address_line2 varchar(100),
city varchar(30),
pin_code bigint,
totalRequests int)

create table Service_Status(
Status_Id int primary key,
desc_values int)

create table Employee(
Emp_Id int primary key,
ename varchar(100),
age int,
requestsCompleted varchar(10),
emp_rating int)

create table Service_Request(
Service_Id int primary key,
cust_id int,
service_desc varchar(30),
request_open_date date,
status_id int,
Emp_id int,
request_closed_date date,
charges bigint,
constraint fkc foreign key(cust_id) references Customer(cust_id)
on delete set null on update cascade,
constraint fks foreign key(status_id) references Service_Status(status_id)
on delete set null on update cascade,
constraint fke foreign key(Emp_id) references Employee(Emp_id)
on delete set null on update cascade)

select * from Customer
insert into customer values(1,'ravi','gurukrupa','at post 2','pune',8926378,2),
(2,'dinesh','mandal','rupnar','mumbai',345672,5),
(3,'kumar','vikrantnagar','bhosari','delhi',78253,1)

select * from Service_Status
insert into Service_Status values(11,1),
(22,2),(33,3),(44,4)

select * from Employee
insert into Employee values(204,'john',31,'yes',3),
(201,'Mr.Vinyak',34,'yes',3),
(202,'Mr.Shubham',27,'no',4),
(203,'Mr.Harshad',32,'yes',1),

select * from Service_Request
insert into Service_Request values(1005,3,'open','2022-03-19',22,204,'2022-03-22',9400),
(1004,2,'open','2022-04-20',33,203,'2022-04-22',3400),
(1001,1,'open','2022-04-12',11,201,'2022-04-13',2400),
(1002,2,'close','2022-03-11',22,202,'2022-03-15',5400),
(1003,3,'open','2022-04-22',33,203,'2022-04-25',7400)

select * from Customer
select * from Service_Status
select * from Employee
select * from Service_Request

create table ReqCopy(
Request_Id int primary key,
cust_id int,
service_desc varchar(30),
request_open_date date,
status_id int,
Emp_id int,
request_closed_date date,
charges bigint,
constraint fkc1 foreign key(cust_id) references Customer(cust_id)
on delete set null on update cascade,
constraint fks1 foreign key(status_id) references Service_Status(status_id)
on delete set null on update cascade,
constraint fke1 foreign key(Emp_id) references Employee(Emp_id)
on delete set null on update cascade)

--Q.3 Write single query to create ReqCopy table which will have same structure and data of service_request table.
insert into ReqCopy select * from Service_Request

--Q.4 Show customer name, service description, charges	of requests served by employees older than age 30. (make use of sub query)
select cname,service_desc,charges from customer c join ReqCopy r on c.Cust_Id=r.cust_id
where Emp_id in (select Emp_Id from Employee where age>30)

--Q.5 Write a query to select customer names for whom employee ‘John’ has not served any request.(make use of sub query)
select cname from Customer c join ReqCopy r on c.Cust_Id=r.cust_id 
where Emp_id in (select Emp_id from Employee where ename != 'john')

--Q.6 Show employee name, total charges of all the requests served by that employee. Consider only ‘closed’ requests.
select ename,sum(charges) from Employee e inner join Service_Request s on e.Emp_Id=s.Emp_id
where status_id = (select status_id from Service_Status where desc_values=3) group by ename

--Q.7 Show service description, customer name of request having third highest charges.
select service_desc,cname from Service_Request s join Customer c on s.cust_id=c.Cust_Id where charges =(
select top 1 charges from(select top 3 charges from Service_Request order by charges desc) service_request order by charges asc)

--Q.8 Delete all requests served by ‘Sam’ as he has left the company.
delete from Service_Request where Emp_id=(select Emp_id from Employee where ename='sam')
