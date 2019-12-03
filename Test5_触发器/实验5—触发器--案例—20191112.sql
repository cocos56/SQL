-- 实验5  操作案例

-- 案例1：在SC表上创建一个触发器，当用户向SC表插入一条新记录时，判断该记录的学号在学生基本信息表中是否存在，如果存在则插入成功，否则，插入失败。
CREATE TRIGGER tr_insert_student1
   ON  sc
   AFTER  INSERT
AS
BEGIN
	if (select count(*) from inserted join student on inserted.sno=student.sno)=0
     begin 
       rollback tran
       select '插入记录无效！'
     end
   END
GO

-- 验证：
select * from student
select * from sc
insert  into sc values('s01','c08',78)



-- 案例2：在学生表上创建一个触发器，当用户删除学生表中的一条记录时，判断该该记录的学号在学生选课信息表中是否存在，如果不存在，允许删除，否则，不允许。
CREATE TRIGGER tr_delt_stu1
   ON  student
   AFTER  delete
AS 
BEGIN
	if (exists(select * from deleted  join sc on deleted.sno=sc.sno))
          begin 
       rollback tran
                   select '插入记录无效！'
        end
   END
GO