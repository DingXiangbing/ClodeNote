select * from t_dept;
select * from t_emp;

--部门表
create table t_dept(
  deptno int auto_increment primary key ,
  dname varchar(20),
  loc varchar(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--预置的部门表数据
insert into t_dept values (null,'销售部','北京');
insert into t_dept values (null,'采购部','上海');
insert into t_dept values (null,'研发部','广州');
commit;

--员工表
create table t_emp(
	empno int auto_increment primary key,
	ename varchar(20),
	job varchar(10),
	mgr int,
	hiredate date,
	sal double,
	comm double,
	deptno int
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--预置的员工表数据
insert into t_emp values (null,'SMITH','CLERK',3,'1980-5-12',800,null,2);
insert into t_emp values (null,'ALLEN','SALESMAN',3,'1981-6-3',1600,300,3);
insert into t_emp values (null,'WARD','SALESMAN',4,'1990-3-15',1250,500,3);
insert into t_emp values (null,'JONES','MANAGER',5,'1985-4-8',2975,null,2);
insert into t_emp values (null,'MARTIN','SALESMAN',7,'1986-3-8',1250,1400,3);
insert into t_emp values (null,'BLAKE','MANAGER',9,'1989-6-1',2850,null,3);
insert into t_emp values (null,'CLARK','MANAGER',9,'1995-10-1',2450,null,1);
insert into t_emp values (null,'SCOTT','ANALYST',9,'1993-5-1',3000,null,2);
insert into t_emp values (null,'KING','PRESIDENT',null,'1988-8-8',5000,null,1);
insert into t_emp values (null,'TURNER','SALESMAN',5,'1983-2-1',1500,0,3);
insert into t_emp values (null,'ADAMS','CLERK',5,'1992-7-3',1100,null,2);
insert into t_emp values (null,'JAMES','CLERK',1,'1996-9-10',950,null,3);
insert into t_emp values (null,'FORD','ANALYST',1,'1993-1-1',3000,null,2);
insert into t_emp values (null,'MILLER','CLERK',3,'1983-10-9',1300,null,1);
commit;