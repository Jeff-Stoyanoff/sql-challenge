CREATE TABLE "departments" (
    "dept_no" VARCHAR(10) NOT NULL,
    "dept_name" VARCHAR(50) NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY ("dept_no")
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(10) NOT NULL,
    "title" VARCHAR(40) NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY ("title_id")
);

CREATE TABLE "employees" (
    "emp_no" INTEGER NOT NULL,
    "emp_title_id" VARCHAR(10) NOT NULL,
    "birth_date" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "first_name" VARCHAR(30) NOT NULL,
    "last_name" VARCHAR(40) NOT NULL,
    "sex" VARCHAR(1) NOT NULL,
    "hire_date" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY ("emp_no"),
    CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY ("emp_title_id") REFERENCES "titles" ("title_id")
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER NOT NULL,
    "dept_no" VARCHAR(10) NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY ("emp_no", "dept_no"),
    CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no"),
    CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no")
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10) NOT NULL,
    "emp_no" INTEGER NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY ("dept_no", "emp_no"),
    CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no"),
    CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no")
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER NOT NULL,
    "salary" INTEGER NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY ("emp_no"),
    CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no")
);

select * from employees;
select * from salaries;

select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees e
left join salaries s on e.emp_no = s.emp_no;

select e.first_name, e.last_name, e.hire_date
from employees e
where to_char(e.hire_date, 'YYYY') like '1986%';

select * from dept_manager;
select * from dept_emp;
select * from departments;

select dm.emp_no, dm.dept_no, d.dept_name, e.first_name, e.last_name
from dept_manager dm
left join departments d on dm.dept_no = d.dept_no
left join employees e on dm.emp_no = e.emp_no;

select e.emp_no, de.dept_no, e.first_name, e.last_name, d.dept_name
from employees e
left join dept_emp de on e.emp_no = de.emp_no
left join departments d on de.dept_no = d.dept_no;

select e.first_name, e.last_name, e.sex
from employees e
where e.first_name = 'Hercules' AND e.last_name LIKE 'B%';

select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no
where d.dept_name = 'Sales';

select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development';

select e.last_name, count(e.last_name) as name_count
from employees e
group by e.last_name
order by name_count DESC;
