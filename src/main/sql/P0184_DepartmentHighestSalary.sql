-- 184. Department Highest Salary

/*
部门工资最高的员工
SQL架构
Employee 表包含所有员工信息，每个员工有其对应的 Id, salary 和 department Id。

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department 表包含公司所有部门的信息。

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
编写一个 SQL 查询，找出每个部门工资最高的员工。对于上述表，您的 SQL 查询应返回以下行（行的顺序无关紧要）。

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
解释：

Max 和 Jim 在 IT 部门的工资都是最高的，Henry 在销售部的工资最高。
*/

Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, DepartmentId int);
Create table If Not Exists Department (Id int, Name varchar(255));
Truncate table Employee;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Jim', '90000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Max', '90000', '1');
Truncate table Department;
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');

select
    d.Name as 'Department',
    e.Name as 'Employee',
    t.Salary
from Employee e
         join Department d
              on e.DepartmentId = d.Id
         join (
    select
        DepartmentId,
        max(Salary) as 'Salary'
    from Employee
    group by DepartmentId
) t on e.DepartmentId = t.DepartmentId
    and e.Salary = t.Salary;