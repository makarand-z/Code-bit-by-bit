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
 
Find the top 3 highest-paid employees in each department.

*/

with RankedEmployees as (
select e.EmployeeID, e.FirstName, e.LastName, e.DepartmentID, e.Salary, e.DateHired, d.DepartmentName,
ROW_NUMBER() OVER(partition by e.DepartmentID order by e.Salary desc) as 'rank'
from dbo.Employees e
join dbo.Departments d
on e.DepartmentID = d.DepartmentID
)

select EmployeeID, FirstName, LastName, DepartmentID, Salary, DateHired, DepartmentName 
from RankedEmployees where rank <=3;