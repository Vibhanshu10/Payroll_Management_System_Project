create database Payroll_Management_System;
use Payroll_Management_System;

CREATE TABLE Department(
 Department_Id int,
 Department_Name VARCHAR(30),
 PRIMARY KEY (Department_Id)
 );

Insert into Department values(1,"General Administration");
Insert into Department values(2,"Human Resource Management");
Insert into Department values(3,"Research and Development");
Insert into Department values(4,"Finance");
Insert into Department values(5,"Marketing and Advertising");

select*from Department;

CREATE TABLE Employee(
 Employee_Id int,
 Department_Id int,
 E_Name VARCHAR(25),
 Hire_Date int,
 Hire_Month varchar(50),
 Hire_Year int,
 City VARCHAR(25),
 State VARCHAR(25),
PRIMARY KEY (Employee_Id),
FOREIGN KEY (Department_Id) REFERENCES Department(Department_Id));

Insert into Employee values(101,1,"Mohit Panthri",7,"April",2002,"Dehradun","Uttarakhand");
Insert into Employee values(102,3,"Vibhanshu Tyagi",11,"February",2002,"Rorkee","Uttarakhand");
Insert into Employee values(103,4,"Akshat Aggarwal",11,"February",2000,"Rorkee","Uttarakhand");
Insert into Employee values(104,2,"Abhimat Kala",7,"April",2001,"Haridwar","Uttarakhand");
Insert into Employee values(105,5,"Kartikay Rawat",8,"October",1999,"Shrinagar","Uttarakhand");
Insert into Employee values(106,3,"Shashank Kharayat",16,"March",2005,"Haridwar","Uttarakhand");
Insert into Employee values(107,3,"Sachin Negi",8,"October",2010,"Dehradun","Uttarakhand");
Insert into Employee values(108,2,"Madhur Arya",3,"December",2015,"Bareilly","Uttar Pradesh");

select*from Employee;

 CREATE TABLE AccountDetails(
 Account_Id int,
 Bank_Name VARCHAR(50),
 Account_Number bigint,
 Employee_Id int,
 PRIMARY KEY (Account_Id),
 FOREIGN KEY (Employee_Id) REFERENCES Employee(Employee_Id)
 );
Insert into AccountDetails values(11,"SBI",1372504828,101);
Insert into AccountDetails values(12,"HDFC",1224281232,102);
Insert into AccountDetails values(13,"AXIS Bank",1311246097,103);
Insert into AccountDetails values(14,"SBI",1480282698,104);
Insert into AccountDetails values(15,"HDFC",2369642181,105);
Insert into AccountDetails values(16,"SBI",4355776711,106);
Insert into AccountDetails values(17,"ICICI",2002025931,107);
Insert into AccountDetails values(18,"PNB",2110095441,108);

select*from AccountDetails;

 CREATE TABLE Salary(
 Salary_Id int,
 Salary int,
 Hourly_Pay int,
 Account_Id int,
 PRIMARY KEY (Salary_Id),
 FOREIGN KEY (Account_Id) REFERENCES ACCOUNTDETAILS(Account_Id) );
Insert into Salary values(1,704000,4000,11);
Insert into Salary values(2,264000,1500,12);
Insert into Salary values(3,396000,2250,13);
Insert into Salary values(4,528000,3000,14);
Insert into Salary values(5,668800,3800,15);
Insert into Salary values(6,264000,1500,16);
Insert into Salary values(7,387200,2200,17);
Insert into Salary values(8,545600,3100,18);

select*from Salary;

 CREATE TABLE Attendance(
 Attendance_Id int,
 Employee_Id int,
 Leave_days int,
 Hours_Worked int,
 CONSTRAINT Attendance_PK PRIMARY KEY (Attendance_Id),
 FOREIGN KEY (Employee_Id) REFERENCES Employee( Employee_Id)
 );

Insert into Attendance values(1,101,1,168);
Insert into Attendance values(2,102,5,136);
Insert into Attendance values(3,103,4,144);
Insert into Attendance values(4,104,8,112);
Insert into Attendance values(5,105,3,152);
Insert into Attendance values(6,106,2,160);
Insert into Attendance values(7,107,10,96);
Insert into Attendance values(8,108,9,104);

select*from Attendance;

 create table Project(
 Project_Id int,
 Department_Id int,
 Project_Name varchar(50),
 Primary key(Project_Id),
FOREIGN KEY (Department_Id) REFERENCES Department(Department_Id)
 );

Insert into Project values(1,3,"Testing Products");
Insert into Project values(2,3,"Creating new Products");
Insert into Project values(3,1,"Innovate New Ideas");
Insert into Project values(4,5,"Advertising Products");
Insert into Project values(5,4,"Generating Funds");
Insert into Project values(6,2,"Increasing Productivity");

select*from Project;

-- Displaying all Tables 
show tables;

-- Employee working in Research and Development Department
SELECT E_Name, City, State from Employee
WHERE Department_Id=3;

-- Employee working in Department where Department_Id is 1 or 2 or 3
SELECT E_Name, Department_Id, City, State from Employee
WHERE Department_Id=3 OR Department_Id=1 OR Department_Id=2;

-- List of all the Employee 
SELECT DISTINCT E_Name
FROM Employee ;

-- Name of Employee in hired before 2005
SELECT E_Name, Hire_date, Hire_Month, Hire_Year from Employee
WHERE Hire_Year<2005;

-- Average, Maximum, Minimum, Sum, Number of Salary
select sum(Salary),max(Salary),min(Salary),avg(Salary),count(Salary)
from Salary;

-- Difference Between Min and Max Salary
SELECT MAX(Salary) - MIN(Salary) Salary_Differnece
FROM Salary; 

-- Projects which are handled by Research and Development Department
Select Project_Name
from Project
where Department_Id=3;

-- List of all the Projects 
Select Project_Name
from Project
Group by Project_Id;

-- Account Id having Hourly Pay>2500
Select Account_Id, Hourly_Pay
from Salary
having Hourly_Pay>2500;

-- Employee Account and Salary Details
SELECT Employee.E_Name,AccountDetails.Bank_Name, 
AccountDetails.Account_Number, Salary.Salary, Salary.Hourly_Pay
from Employee
Join AccountDetails 
On Employee.Employee_Id = AccountDetails.Employee_Id
Join Salary 
On  AccountDetails.Account_Id = Salary.Account_Id;

-- Employee name and Department in which they work
Select Employee.E_Name, Department.Department_Name
from Employee
Join Department
On  Employee.Department_Id= Department.Department_Id;

-- Department Name ,the number of employees in the department and their average salary
Select  Department.Department_Name, Count(*), Avg(Salary)
from Employee
Join Department 
On  Employee.Department_Id= Department.Department_Id
Join AccountDetails 
On Employee.Employee_Id = AccountDetails.Employee_Id
Join Salary 
On AccountDetails.Account_Id = Salary.Account_Id 
group by Department_Name;

-- Employee Name whose salary > 500000
Select Employee.E_Name, Salary.Salary
from Employee
Join AccountDetails 
On  Employee.Employee_Id = AccountDetails.Employee_Id
Join Salary 
On AccountDetails.Account_Id = Salary.Account_Id
where Salary>500000;

-- Number of days Employee took leave and number of hours worked by the Employee
select Employee.E_Name, Attendance.Leave_days, Attendance.Hours_Worked 
from Employee
Join Attendance 
On Employee.Employee_Id = Attendance.Employee_Id;

-- Department name and Projects on which they are working
select Department.Department_Name, Project.Project_Name 
from Department
Join Project 
On Department.Department_Id = Project.Department_Id;
-- Employee which have 'i' in their Name
select E_Name from Employee
where E_Name Like "%i%";

-- Employee  whose City is Not Dehradun
Select E_Name, City, State from Employee
where not City = "Dehradun";

-- Employee Details where city is Dehradun And State is Uttrakahand
Select E_Name, City, State from Employee
where  City = "Dehradun" And State = "Uttarakhand";

-- Employee Salary in Descending Order
SELECT Employee.E_Name, Salary.Salary, Salary.Hourly_Pay
from Employee
Join AccountDetails 
On Employee.Employee_Id = AccountDetails.Employee_Id
Join Salary 
On  AccountDetails.Account_Id = Salary.Account_Id
order by Salary desc;

-- Employee Salary in Ascending Order
SELECT Employee.E_Name, Salary.Salary, Salary.Hourly_Pay
from Employee
Join AccountDetails 
On Employee.Employee_Id = AccountDetails.Employee_Id
Join Salary 
On  AccountDetails.Account_Id = Salary.Account_Id
order by Salary asc;

-- update Account Number Of Employee Where Account_Id is 1  & 2
Update AccountDetails
set Account_Number = 8328254532
where  Account_Id = 1;
Update AccountDetails
set Account_Number =4715578454
where  Account_Id = 2;

select *  from AccountDetails
limit 2;

-- List of employee name start from letter M or V
select E_name from Employee where E_name like 'M%' or E_name like 'V%';

-- list of Employee Name having leave days between 1 and 5
select Employee.E_Name, Attendance.Leave_days
from Employee
Join Attendance 
On Employee.Employee_Id = Attendance.Employee_Id
where leave_days Between 1  and 5;

-- Changing Table Name
Alter Table Employee
Rename To EmployeeDetails;
show tables;

-- Again changing Table name back to Employee
Alter Table EmployeeDetails
Rename To Employee;
show tables;

-- Modifying the column Size
Alter Table Department
Modify Department_Name varchar(50);
desc Department;

-- Alter Column name
ALTER TABLE AccountDetails Rename Column Bank_Name TO Bank;
desc AccountDetails;

-- Changing back the column name
ALTER TABLE AccountDetails Rename Column Bank To Bank_Name;
desc AccountDetails;