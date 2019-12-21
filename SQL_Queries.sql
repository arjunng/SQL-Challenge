-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/GAZ6wz

CREATE TABLE "departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_employee" (
    "emp_no" integer   NOT NULL,
    "dept_no" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" integer   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "gender" varchar(1)   NOT NULL,
    "hiredate" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" integer   NOT NULL,
    "salary" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" integer   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "dept_employee" ADD CONSTRAINT "fk_dept_employee_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_employee" ADD CONSTRAINT "fk_dept_employee_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- Queries to see all the records of the table after importing data from CSV files:

select max(emp_no) from employees;
select * from dept_employee;
select * from dept_manager;
select * from departments;
select * from salaries;
select * from titles;

--------------------------------------------------------------------------------------------------------------------------------------------------------

Data Analysis:

1. List the following details of each employee: employee number, last name, first name, gender, and salary.

select e.emp_no "Employee Number", e.last_name "Last Name", e.first_name "First Name",e.gender "Gender",
s.salary "Salary"
from employees e
inner join salaries s
on e.emp_no=s.emp_no order by e.emp_no;

2. List employees who were hired in 1986:

select emp_no "Employee Number",
birth_date "Birth Date",
first_name "First Name",
last_name "Last Name",
gender "Gender",
hiredate "Hire Date" 
from employees where hiredate between '1986-01-01' and '1986-12-31' order by hiredate;

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates:

select d.dept_no "Department Number",
d.dept_name "Department Name",
dm.emp_no "Employee Number",
e.last_name "Last Name",
e.first_name "First Name",
dm.from_date "Employment Start Date",
dm.to_date "Employment End Date"
from departments d
inner join dept_manager dm
on
d.dept_no=dm.dept_no
inner join
employees e
on dm.emp_no = e.emp_no order by e.emp_no;

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select e.emp_no "Employee Number",
e.last_name "Last Name",
e.first_name "First Name",
d.dept_name from
employees e
inner join dept_employee de
on e.emp_no=de.emp_no
inner join
departments d
on de.dept_no=d.dept_no order by e.emp_no;


5. List all employees whose first name is "Hercules" and last names begin with "B."

select emp_no "Employee Number",
birth_date "Birth Date",
first_name "First Name",
last_name "Last Name",
gender "Gender",
hiredate "Hire Date" 
from employees where first_name = 'Hercules' and last_name like 'B%';

6. List all employees in the Sales department, including their employee number, 
last name, first name, and department name:

select e.emp_no "Employee Number",
e.last_name "Last Name",
e.first_name "First Name",
d.dept_name from
employees e
inner join dept_employee de
on e.emp_no=de.emp_no
inner join
departments d
on de.dept_no=d.dept_no 
where d.dept_name='Sales' order by e.emp_no;

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select e.emp_no "Employee Number",
e.last_name "Last Name",
e.first_name "First Name",
d.dept_name from
employees e
inner join dept_employee de
on e.emp_no=de.emp_no
inner join
departments d
on de.dept_no=d.dept_no 
where d.dept_name in ('Sales','Development') order by e.emp_no;

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

select last_name "Last Name",
count(last_name) "Frequency of Emp. with same Last Names" 
from employees 
group by last_name 
order by count(last_name) desc;




