--对于School数据库，删除SC表上的外键约束。
use sc;

--1. 向SC表插入或修改一个记录时，通过触发器检查记录的SNO值在Student表中是否存在，若不存在，则取消插入或修改操作。
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'SCSno') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
	DROP TRIGGER SCSno;

go
CREATE TRIGGER SCSno ON SC FOR INSERT,UPDATE AS
	BEGIN
		IF((SELECT sno FROM inserted) NOT IN(SELECT sno FROM Student))
			begin
			print 'Coco: 插入学号不在学生表中，插入失败';
			ROLLBACK TRANSACTION;
			print 'Coco: 回滚完毕';
			end
		else
			print 'Coco: 插入成功';
	END

--插入或修改数据，查看效果。
delete from sc where sno='s19'
insert into sc values('s19','c04',92)

delete from sc where sno='s01'
insert into sc values('s01','c04',93)


--2. 修改Student表“SNO”字段值时，该字段在SC表中的对应值也做相应修改。
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'SCSno') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
	DROP TRIGGER SCSno;
-- 注意：需要先删除1.中建立的触发器，否则会报错。
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'StudentUpdate') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
	DROP TRIGGER StudentUpdate;
go
CREATE TRIGGER StudentUpdate ON Student FOR UPDATE AS
BEGIN
	UPDATE SC SET sno=(SELECT sno FROM inserted) WHERE sno=(SELECT sno FROM deleted)
	--修改(UPDATE)记录
	--inserted表存放更新后的记录，deleted表存放更新前的记录
END

update Student set sno='s19' where sno='s02';

--3. 删除Student表中记录的同时删除该记录“SNO”字段值在SC表中对应的记录。
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'StudentDelete') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
	DROP TRIGGER StudentDelete;
go
CREATE TRIGGER StudentDelete ON Student FOR DELETE AS BEGIN
		DELETE FROM SC WHERE SNO=(SELECT SNO FROM deleted) 
	END

delete from Student where sno='s02'

--4. 创建INSTEAD OF触发器，当向SC表中插入记录时，先检查CNO列上的值在Course中是否存在，如果存在则执行插入操作，如果不存在则提示“课程编号不存在”。  
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'Course_EXISTS') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
	DROP TRIGGER Course_EXISTS;
go
CREATE TRIGGER  Course_EXISTS ON SC INSTEAD OF INSERT AS BEGIN
		DECLARE @CourseID char(6)
		SET @CourseID=(SELECT CNO FROM inserted)
		IF(@CourseID IN(SELECT CNO FROM Course)) 
			INSERT INTO SC SELECT * FROM inserted
		ELSE
			PRINT '课程编号不存在'
	END


--5. 创建DDL（数据定义语言）触发器，当删除School数据库的一个表时，提示“不能删除表”，并回滚删除表的操作。
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'table_delete') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
	DROP TRIGGER table_delete;
go
CREATE TRIGGER table_delete ON DATABASE AFTER DROP_TABLE AS BEGIN
		PRINT '不能删除该表'
		ROLLBACK TRANSACTION
	END

if exists (select * from sysobjects where id = object_id(N'SC') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table SC;

--6. 若没有删除SC表的外键约束，如果在SC表中插入的“学号”和“课程号”，分别在Student表和Course表中存在，则允许SC表中插入一条数据，如果插入的学号或课程号，不存在，则显示：课程号、学号不在范畴之列，添加不成功！
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'tr4_insert_sc') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
	DROP TRIGGER tr4_insert_sc;
go
create trigger tr4_insert_sc on SC instead of insert as begin
if exists(select * from inserted where sno in(select sno from Student) and cno in (select cno from Course))
	print '数据添加成功！'
else
	begin 
	print '课程号、学号不在范畴之列，添加不成功！'
	Rollback transaction
	end
end

insert into SC values('s19','c04',96)