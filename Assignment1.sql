create database Assignment;

--Q.1 Write a queries to create all tables with primary key ,foreign key
create table Doctor(
Did int primary key,
dname varchar(100),
daddress varchar(100),
qualification varchar(30),
noofpatient_handled int)

create table PatientMaster(
Pcode int primary key,
pname varchar(100),
paddr varchar(100),
age int ,
gender varchar(10) ,
bloodgroup varchar(20))

create table AdmittedPatient(
Pcode int foreign key references PatientMaster(Pcode) ,
Entry_date varchar(100) ,
Discharge_date varchar(100),
wardno int,
disease varchar(20),
did int foreign key references Doctor(did))

create table Bill(
Pcode int foreign key references PatientMaster(Pcode) ,
BillAmount bigint)

--Q.2 Write a query to describe above tables;
sp_help Doctor
sp_help PatientMaster
sp_help AdmittedPatient
sp_help Bill

--Q.3 write a query to drop primary key from patientMaster
alter table PatientMaster drop constraint "PK__PatientM__9F96D7D982FB4CB0"

--Q.4 Suppose Discharge _date is not present into AdmittedPatient write query to add Discharge_date column into the AdmittedPatient
alter table AdmittedPatient add Discharge_date varchar(100)

--Q.5 write a query to change the data type ward no int to varchar(10)
alter table AdmittedPatient alter column wardno varchar(10)

--Q.6 write a query to drop one foreign key from AdmittedPatient
alter table AdmittedPatient drop constraint "FK__AdmittedPat__did__145C0A3F"

--Q.7 write a query to add foreign key such that if parent is delete or update child also delete or update 


--Q.8 write a query to add primary key to patientMaster
alter table PatientMaster add pid int primary key

--Q.9 write a query to insert 5 records into the Doctor table
insert into Doctor values('1','shree','pune','MD',6),
('2','kishan','mumbai','BAMS',10),
('3','vinaya','delhi','MBBS',12),
('4','shubham','kolkata','MD',10),
('5','ravi','pune','MD',9);

--Q.10 write a query find the no. of doctors as per qualification
select count(qualification) from Doctor where qualification='MD';

--Q.11 find the doctors whose qualification is MD or MBBS
select * from Doctor where qualification='MD' or qualification='MBBS';

--Q.12 find patients  whose age is between 21to 27 with blood group A+ 
select * from PatientMaster where bloodgroup='A+' and age between 21 and 27

--Q.13 Find the doctors whose address is Mumbai and no_of_patient_handle are 10
select * from Doctor where daddress='Mumbai' and noofpatient_handled=10

--Q.14 Find the count of patient as per the blood group
select count(pname),bloodgroup from PatientMaster group by bloodgroup

--Q.15 find the maximum bill amount and find the minimum bill amount 
select top 1 * from Bill order by BillAmount desc
select top 1 * from Bill order by BillAmount asc

--Q.16 find the doctors who has no_of_patient_handle are more than 10;
select * from Doctor where noofpatient_handled>10;

--Q.17 find the number of patients who live in pune;
select paddr,count(pname) from PatientMaster where paddr='pune' group by paddr

--Q.18 find the patients whose blood group is AB+ and gender is the female
select * from PatientMaster where bloodgroup='AB+' and gender='female'

--Q.19 delete the patient whose ward no is 4 or 6 and Disease is covid 19 
delete from AdmittedPatient where wardno in(4,6) and disease='covid 19'

--Q.20 remove all records from bill table
truncate table bill

--Q.21 find the details of doctor who are treating the patient of wardno3
select dname,daddress,qualification,noofpatient_handled from Doctor d join AdmittedPatient a on d.Did=a.did where wardno=3

--Q.22 find the patient who are suffered from dengue and having age less than 30and bloodgroup is'A'
select * from AdmittedPatient a join PatientMaster p on a.Pcode=p.Pcode where disease='dengue' and age<30 and bloodgroup='A'

--Q.23 find the patient who recover from dengue and  bill amount is greater than 10000
select * from AdmittedPatient a join bill b on a.Pcode=b.Pcode where disease='dengue' and BillAmount>10000
