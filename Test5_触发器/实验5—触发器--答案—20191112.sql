-- 1.
CREATE TRIGGER SCSno ON SC
   FOR INSERT,UPDATE 
   AS
   BEGIN
   IF((SELECT sno FROM inserted) NOT IN(SELECT sno FROM Student))
   print '插入学号不在学生表中，插入失败'
   ROLLBACK TRANSACTION
   END
  
 insert into sc values('s19','c04',92)
 delete from sc where sno='s19'

-- 2.
CREATE TRIGGER StudentUpdate
ON Student
FOR UPDATE
AS
BEGIN
UPDATE SC SET sno=(SELECT sno FROM inserted) WHERE sno=(SELECT sno FROM deleted) 
END 
update Student set sno='s19' where sno='s02'
-- 注意：需要先删除1.中建立的触发器，否则会报错。

-- 3.
CREATE TRIGGER StudentDelete
ON Student
FOR DELETE
AS
BEGIN
DELETE FROM SC  WHERE SNO=(SELECT SNO FROM deleted) 
END
delete from Student where sno='s02'


-- 4.
CREATE TRIGGER  Course_EXISTS
ON SC
INSTEAD OF INSERT
AS
BEGIN
DECLARE @CourseID char(6)
SET @CourseID=(SELECT CNO FROM inserted)
IF(@CourseID IN(SELECT CNO FROM Course)) 
   INSERT INTO SC SELECT * FROM inserted
ELSE
PRINT '课程编号不存在'
END

-- 5.
CREATE TRIGGER table_delete
ON DATABASE 
AFTER DROP_TABLE
AS 
PRINT '不能删除该表'
ROLLBACK TRANSACTION

-- 6.
create trigger tr3_insert_sc
on SC
after insert
as
--select * from inserted
if exists(select * from inserted where sno in(select sno from Student) and cno in
   (select cno from Course))
 print '数据添加成功！'
else 
begin 
print '课程号、学号不在范畴之列，添加不成功！'
Rollback transaction
end

create trigger tr4_insert_sc
on SC
instead of insert
as
--select * from inserted
if exists(select * from inserted where sno in(select sno from Student) and cno in
   (select cno from Course))
 print '数据添加成功！'
else 
begin 
print '课程号、学号不在范畴之列，添加不成功！'
Rollback transaction
end

insert into SC values('s19','c04',96)


-- 任务三代码
-- 1、
alter table course add SelectNum smallint;
select * from course;
create trigger Add_Select_Course on sc after insert as
begin
    update course_x
    set SelectNum=isnull(SelectNum,0)+1
    from 
        course course_x
    join 
        inserted inserted_x on course_x.Cno=inserted_x.Cno 
end
insert into sc values('200215124','5',null);
insert into course values('8','计算机网络','3',4);
insert into sc values('200215124','6',88);
select * from course;
select * from sc;

-- 2.
-- 创建学生数据库
create database 学生数据库;
use 学生数据库; 
-- 创建学生表并完成3行数据的插入
create table stu2(
sno char(20) not null primary key,
age char(10)
)
insert into stu2 values('201501','16');
insert into stu2 values('201502','17');
insert into stu2 values('201503','18');

-- 创建备份表
create table backupTable(
sno char(20) primary key not null,
age char(10)
)

-- 创建插入触发器
-- 插入
create trigger insert_info2
on stu2
for insert
as
-- 声明变量
declare @age char(10)
/*给变量赋值*/
select @age=age from inserted
/*使用变量*/
if @age<15 or @age>60
begin	
	print '年龄不合法'
	rollback
end
else
	print '年龄合法插入成功
//创建修改触发器
/*更新*/
create trigger update_stu
on stu2
for update
as
declare @afterage char(10)
/*获取修改之后的数据*/
select @afterage=age from inserted
if @afterage<15 or @afterage>60
begin
	print '年龄修改不合法'
	rollback 
end
else
	print '年龄修改成功'
//创建删除触发器
/*删除*/
create trigger delete_stu3
on stu2
for delete
as
/*已经删除数据，执行后续操作*/
insert into backupTable(sno,age)
select sno,age from deleted
if exists(select * from deleted)
   begin
	print '备份数据成功，备份表中的数据为:'
    SELECT * FROM backupTable
    print '备份数据成功，学生表中的数据为:'
    SELECT * FROM stu2 
	
   end
else
   begin
	print '数据备份失败'
	rollback transaction	
   end