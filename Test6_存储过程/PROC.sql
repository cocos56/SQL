-- 1.创建存储过程s_info，根据学生的姓名和学号查询学生的年龄、所在系。
IF EXISTS(SELECT NAME FROM sysobjects WHERE NAME='s_info' AND TYPE='P')
	DROP PROCEDURE s_info

GO
CREATE PROC s_info @stname varchar(8),@stsno varchar(10)
    AS
    SELECT SName,SNo,DATEDIFF(yy,SB,GETDATE()) AS Age,SDept FROM Student
		WHERE SName=@stname and SNo=@stsno

GO
EXEC s_info  李想, s02

if exists (select name from sysobjects where name='s_info' and type='p')
	drop proc s_info

go
create proc s_info @sn varchar(20), @sno varchar(9) as
	select Sname, Sno, DATEDIFF(yy, SB, GETDATE()) as Age, Sdept from Student

-- *2.创建存储过程s_default，根据学生的姓名和学号查询学生的年龄、所在系。如果未提供学生的姓名和学号，该存储过程将显示学号为‘s01’,姓名为“王玲”的学生信息。
IF EXISTS(SELECT NAME FROM sysobjects WHERE NAME='s_default' AND TYPE='P')
	DROP PROCEDURE s_default

GO
CREATE PROC s_default @stname varchar(8)= '王玲',@stsno varchar(10)= 's01'
    AS
		SELECT SName,SNo,DATEDIFF(yy,SB,'2008-12-30') AS Age,SDept FROM Student
			WHERE SName=@stname and SNo=@stsno

GO
EXEC s_default
EXEC s_default  李想, s02

-- 3.创建存储过程s_nul，根据学生的姓名和学号查询学生选修的课程。如果未提供生的姓名和学号，则显示提示信息“请输入学号和姓名！”。
IF EXISTS(SELECT NAME FROM sysobjects WHERE NAME='s_null' AND TYPE='P')
    DROP PROCEDURE s_null

GO
CREATE PROC s_null @stname varchar(8)= null,@stsno varchar(10)= null
	AS
		IF @stname IS NULL OR @stsno IS NULL
			PRINT '请输入学号和姓名! '
		ELSE
			SELECT sc.sno,sname,sc.cno,cname  FROM SC,Course,Student
				WHERE Student.SNO=SC.SNO AND Course.CNO=SC.CNO 
					AND sname=@stname AND Student.sno=@stsno

GO
EXEC  s_null
EXEC  s_null @stname='罗军',@stsno='s03'

-- 4.创建存储过程s_count，根据课程名，检索选修某门课程的学生人数。
IF EXISTS(SELECT NAME FROM sysobjects WHERE NAME='s_count' AND TYPE='P')
	DROP PROCEDURE s_count

GO
CREATE PROC s_count @cname varchar(30)= null AS
IF @cname IS NULL
	PRINT '请输入课程名! '
ELSE
	SELECT 课程名=cname,学生选修人数=count(distinct sno)  FROM SC,Course
		WHERE Course.CNO=SC.CNO AND Course.cname=@cname
		group by cname order by cname

GO
EXEC  s_count  '高等数学'      
--或 EXEC  s_count @ctname=‘数据结构’

-- 5.创建存储过程sg,根据输入的学号和课程号，获得指定学号和课程号的课程成绩。
IF EXISTS(SELECT NAME FROM sysobjects
        WHERE NAME='sg' AND TYPE='P')
    DROP PROCEDURE sg

GO
CREATE PROC sg @sn varchar(8)= 's01', @cn  varchar(3)='c01',@gr smallint output
	AS
	SELECT sno,cno,grade FROM SC
		WHERE sc.sno=@sn and sc.cno=@cn
	SELECT @gr=grade FROM SC
		WHERE sc.sno=@sn and sc.cno=@cn

GO
--执行1：
DECLARE @g1 smallint EXEC sg @sn='s01',@gr=@g1 output
--执行2：
DECLARE @g1 smallint EXEC sg @sn=DEFAULT,@gr=@g1
--执行3：
DECLARE @g1 smallint EXEC sg @gr=@g1

-- *6.创建存储过程update_s_1,修改指定学号的数据信息。
IF EXISTS(SELECT NAME FROM sysobjects 
        WHERE NAME='update_s_1' AND TYPE='P')
    DROP PROCEDURE update_s_1

go
CREATE PROCEDURE update_s_1
(
    @t_sno varchar(20),
    @t_cno varchar(50),
    @t_grade SMALLINT
)
AS
	select '修改前', * from sc where (sno = @t_sno) AND (cno = @t_cno)
    UPDATE SC SET grade = @t_grade WHERE (sno = @t_sno) AND (cno = @t_cno)
	select '修改后', * from sc where (sno = @t_sno) AND (cno = @t_cno)
	
GO
exec update_s_1 's01', 'c01', 80