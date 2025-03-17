/*SQL Schema
Table: Departments

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| DepartmentID  | int     |
| DepartmentName| varchar |
+---------------+---------+
In SQL, DepartmentID is the primary key column for this table.
Each row of this table indicates the id of a department and its name.

Table: Employees

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| EmployeeID    | int     |
| FirstName     | varchar |
| LastName      | varchar |
| DepartmentID  | int     |
| Salary        | decimal |
| DateHired     | date    |
+---------------+---------+
In SQL, EmployeeID is the primary key column for this table.
Each row of this table indicates an employee and the department they work for with other details. 
DepartmentID is the foreign key which references DepartmentID from Department table
 
Find the employees whose salary is less than the average salary of employees hired in the last 5 years.

*/

select EmployeeID, FirstName, LastName, DepartmentID, Salary, DateHired
from dbo.Employees
where salary < (select round(avg(salary),2)
from dbo.employees
WHERE datehired >= DATEADD(YEAR, -5, GETDATE()))