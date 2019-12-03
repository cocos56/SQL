if exists(select top 1 * from sys.databases where name = 'sc')
	begin
	use master;
	drop database sc;
	end

CREATE DATABASE sc

-- 设置工作数据库
use sc

-- 删除表
if exists (select * from sysobjects where id = object_id(N'Student') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table Student;

-- 创建表
CREATE TABLE Student(
	SNo CHAR(9) PRIMARY Key,
	SName CHAR(20) UNIQUE,
	SDept CHAR(20),
	SB datetime,
	SSex CHAR(2),
	);

--插入数据
--INSERT Student(SNo, SName, SSex, SAge, SDept) 
--VALUES('201215121', '李勇', '男', 20, 'CS');
--INSERT Student VALUES('201215122', '刘晨', '女', 19, 'CS');
--INSERT Student VALUES('201215123', '王敏', '女', 18, 'MA');
--INSERT Student VALUES('201215125', '张立', '男', 19, 'IS');

INSERT INTO student VALUES('s01','王玲','计算机','1986-03-01','男')
INSERT INTO student VALUES('s02','李想','计算机','1985-04-01','女')
INSERT INTO student VALUES('s03','罗军','数学','1986-03-01','男')
INSERT INTO student VALUES('s04','李爱民','英语','1987-06-01','女')
INSERT INTO student VALUES('s05','季然','英语','1986-02-01','女')
INSERT INTO student VALUES('s06','王明','数学','1987-06-01','男')

SELECT * FROM Student;

-- 设置工作数据库
use sc

-- 删除表
if exists (select * from sysobjects where id = object_id(N'Course') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table Course;

-- 创建表
CREATE TABLE Course(
	CNo CHAR(4) PRIMARY Key,
	CName CHAR(40) NOT null,
	CPno CHAR(4),
	--CCredit SMALLINT,
	--FOREIGN KEY(CPno)REFERENCES Course(CNo)
		--表级完整性约束条件，CPno是外码，被参照表是Course，被参照列是CNo
	);

--插入数据
--INSERT Course(CNo, CName, CPno, CCredit)
--VALUES('1', '数据库', 5, 4);
--INSERT Course VALUES('2', '数学', null, 2);
--INSERT Course VALUES('3', '信息系统', 1, 4);
--INSERT Course VALUES('4', '操作系统', 6, 3);
--INSERT Course VALUES('5', '数据结构', 7, 4);
--INSERT Course VALUES('6', '数据处理', null, 2);
--INSERT Course VALUES('7', 'PASCAL语言', 6, 4);

INSERT INTO course VALUES('c01','高等数学',null)
INSERT INTO course VALUES('c02','数据结构',null)
INSERT INTO course VALUES('c03','操作系统','c02')
INSERT INTO course VALUES('c04','数据库','c03')
INSERT INTO course VALUES('c05','作战指挥','c04')
INSERT INTO course VALUES('c06','离散数学','c01')
INSERT INTO course VALUES('c07','信息安全','c06')
INSERT INTO course VALUES('c08','大学英语',null)
INSERT INTO course VALUES('c09','商贸英语','c08')
INSERT INTO course VALUES('c10','大学物理',null)
INSERT INTO course VALUES('c11','网络',null)
INSERT INTO course VALUES('c12','C程序',null)

SELECT * FROM Course;

-- 设置工作数据库
use sc

-- 删除表
if exists (select * from sysobjects where id = object_id(N'SC') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table SC;

-- 创建表
CREATE TABLE SC(
	SNo CHAR(9),
	CNo CHAR(4),
	Grade SMALLINT,
	PRIMARY KEY(SNo, CNo),
	);

--插入数据
--INSERT SC(SNo, CNo, Grade) 
--VALUES('201215121', '1', 92);
--INSERT SC VALUES('201215121', '2', 85);
--INSERT SC VALUES('201215121', '3', 88);
--INSERT SC VALUES('201215122', '2', 90);
--INSERT SC VALUES('201215122', '3', 80);

INSERT INTO sc VALUES('s01','c01',80.0)
INSERT INTO sc VALUES('s01','c02',98.0)
INSERT INTO sc VALUES('s01','c03',85.0)
INSERT INTO sc VALUES('s01','c04',80.0)
INSERT INTO sc VALUES('s02','c07',89.0)
INSERT INTO sc VALUES('s02','c05',88.0)
INSERT INTO sc VALUES('s02','c06',78.0)
INSERT INTO sc VALUES('s03','c04',89.0)
INSERT INTO sc VALUES('s03','c01',88.0)
INSERT INTO sc VALUES('s03','c03',78.0)
INSERT INTO sc VALUES('s04','c07',77.0)
INSERT INTO sc VALUES('s04','c02',null)
INSERT INTO sc VALUES('s04','c09',83.0)
INSERT INTO sc VALUES('s05','c10',75.0)
INSERT INTO sc VALUES('s05','c11',90.0)
INSERT INTO sc VALUES('s05','c03',94.0)
INSERT INTO sc VALUES('s06','c09',89.0)
INSERT INTO sc VALUES('s06','c10',88.0)
INSERT INTO sc VALUES('s06','c11',null)

SELECT * FROM SC;