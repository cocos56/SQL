if exists(select top 1 * from sys.databases where name = 'spj')
	begin
	use master;
	drop database spj;
	end

CREATE DATABASE spj

-- 设置工作数据库
use spj

-- 删除表
if exists (select * from sysobjects where id = object_id(N'S') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table S;

-- 创建表
CREATE TABLE S(
	SNo CHAR(9) PRIMARY Key,
	SName CHAR(20),
	SStatus INT,
	SCity CHAR(20)
	);

--插入数据
INSERT S(SNo, SName, SStatus, SCity) 
VALUES('S1', '精益', 20, '天津');
INSERT S VALUES('S2', '盛锡', 10, '北京');
INSERT S VALUES('S3', '东方红', 30, '北京');
INSERT S VALUES('S4', '丰泰盛', 20, '天津');
INSERT S VALUES('S5', '为民', 30, '上海');

SELECT * FROM S;

-- 删除表
if exists (select * from sysobjects where id = object_id(N'P') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table P;

-- 创建表
CREATE TABLE P(
	PNo CHAR(9) PRIMARY Key,
	PName CHAR(20),
	PColor CHAR(6),
	PWeight int
	);

--插入数据
INSERT P(PNo, PName, PColor, PWeight) 
VALUES('P1', '螺母', '红', 12);
INSERT P VALUES('P2', '螺栓', '绿', 17);
INSERT P VALUES('P3', '螺丝刀', '蓝', 14);
INSERT P VALUES('P4', '螺丝刀', '红', 14);
INSERT P VALUES('P5', '凸轮', '蓝', 40);
INSERT P VALUES('P6', '齿轮', '红', 30);


SELECT * FROM P;

-- 删除表
if exists (select * from sysobjects where id = object_id(N'J') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table J;

-- 创建表
CREATE TABLE J(
	JNO CHAR(9) PRIMARY Key,
	JNAME CHAR(20),
	JCITY CHAR(20),
	);

--插入数据
INSERT J(JNO, JNAME, JCITY) 
VALUES('J1', '三建', '北京');
INSERT J VALUES('J2', '一汽', '长春');
INSERT J VALUES('J3', '弹簧厂', '天津');
INSERT J VALUES('J4', '造船厂', '天津');
INSERT J VALUES('J5', '机车厂', '唐山');
INSERT J VALUES('J6', '无线电厂', '常州');
INSERT J VALUES('J7', '半导体厂', '南京');

SELECT * FROM J;


-- 删除表
if exists (select * from sysobjects where id = object_id(N'SPJ') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table SPJ;

-- 创建表
CREATE TABLE SPJ(
	SNo CHAR(9),
	PNo CHAR(9),
	JNo CHAR(9),
	QTY int,
	PRIMARY KEY(SNo, PNo, JNo),
	FOREIGN KEY(SNo)REFERENCES S(SNo),
	FOREIGN KEY(PNo)REFERENCES P(PNo),
	FOREIGN KEY(JNo)REFERENCES J(JNo),
	);

--插入数据
INSERT SPJ(SNo, PNo, JNo, QTY) 
VALUES('S1', 'P1', 'J1', 200);
INSERT SPJ VALUES('S1', 'P1', 'J3', 100);
INSERT SPJ VALUES('S1', 'P1', 'J4', 700);
INSERT SPJ VALUES('S1', 'P2', 'J2', 100);
INSERT SPJ VALUES('S2', 'P3', 'J2', 200);
INSERT SPJ VALUES('S2', 'P3', 'J4', 500);
INSERT SPJ VALUES('S2', 'P3', 'J5', 400);
INSERT SPJ VALUES('S2', 'P5', 'J1', 400);
INSERT SPJ VALUES('S2', 'P5', 'J2', 100);
INSERT SPJ VALUES('S3', 'P1', 'J1', 200);
INSERT SPJ VALUES('S3', 'P3', 'J1', 200);
INSERT SPJ VALUES('S4', 'P5', 'J1', 100);
INSERT SPJ VALUES('S4', 'P6', 'J3', 300);
INSERT SPJ VALUES('S4', 'P6', 'J4', 200);
INSERT SPJ VALUES('S5', 'P2', 'J4', 100);
INSERT SPJ VALUES('S5', 'P3', 'J1', 200);
INSERT SPJ VALUES('S5', 'P6', 'J2', 200);
INSERT SPJ VALUES('S5', 'P6', 'J4', 500);

SELECT * FROM SPJ;