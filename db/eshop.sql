if exists (select * from sys.databases where name = 'eshop')
	begin
	use master
	drop database eshop
	end

CREATE DATABASE eshop

-- 设置工作数据库
use eshop

-- 删除表
if exists (select * from sysobjects where id = object_id(N'products') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table products;

-- 创建表
CREATE TABLE products(
	P_no varchar(20) NOT NULL PRIMARY Key,
	P_name varchar(50) NOT NULL,
	P_date datetime NOT NULL,
	P_quantity int NOT NULL,
	P_price SMALLMONEY NOT NULL,
	P_infomation varchar(500) NOT NULL,
);

--插入数据
INSERT products(P_no, P_name, P_date, P_quantity, P_price, P_infomation) 
VALUES('P_001', '自行车', '2005-05-31 00:00:00.000', 10, 586, '价廉物美')
INSERT products VALUES('P_002', '爱国者MP3', '2005-05-31 00:00:00.000', 100, 450, '价廉物美')
INSERT products VALUES('P_003', '商务通', '2005-05-20 00:00:00.000', 10, 850, '价廉物美')
INSERT products VALUES('P_004', '名人好记星', '2005-05-31 00:00:00.000', 100, 550, '价廉物美')
INSERT products VALUES('P_005', '奥美嘉U盘', '2005-05-31 00:00:00.000', 100, 350, '价廉物美')

--产品表添加记录
INSERT INTO products VALUES('0130810324','清华同方电脑','2005-12-11',7,8000.0,'优惠多多')
INSERT INTO products VALUES('0140810330','洗衣粉','2005-05-31',1000,8.6,'特价销售')
INSERT INTO products VALUES('0140810332','红彤彤腊肉','2005-5-20',43,15.0,'是一种卫生食品')
INSERT INTO products VALUES('0140810333','力士牌香皂','2005-05-06',22,6.0,'是一种清洁用品')
INSERT INTO products VALUES('0240810330','电动自行车','2005-05-31',10,1586.0,'价廉物美')
INSERT INTO products VALUES('0240810333','自行车','2005-05-31',10,586.0,'价廉物美')
INSERT INTO products VALUES('0910810001','爱国者MP3','2005-05-31',100,450.0,'价廉物美')
INSERT INTO products VALUES('0910810002', '商务通','2005-05-20',10,850.0,'价廉物美')
INSERT INTO products VALUES('0910810003','名人好记星','2005-05-31',100,550.0,'价廉物美')
INSERT INTO products VALUES('0910810004','奥美嘉U盘','2005-05-31',100,350.0,'价廉物美')

SELECT * FROM products;

-- 设置工作数据库
use eshop

-- 删除表
if exists (select * from sysobjects where id = object_id(N'members') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table members;

-- 创建表
CREATE TABLE members(
	M_account varchar(20) NOT NULL PRIMARY Key,
	M_name varchar(20) NOT NULL,
	M_birth datetime NULL,
	M_sex char(2) NULL,
	M_address varchar(50) NULL,
	M_salary decimal(7, 0) NOT NULL,
	M_password varchar(20) NOT NULL,
);

-- 插入数据
INSERT members(M_account, M_name, M_birth, M_sex, M_address, M_salary, M_password)
VALUES('M_001', '张三', '1985-09-02 00:00:00.000', '男', '平顶山', 2500, '123456')
INSERT members VALUES('M_002', '李四', '1986-03-01 00:00:00.000', '男', '洛阳', 2600, '111111')
INSERT members VALUES('M_003', '小红', '1987-01-02 00:00:00.000', '女', '郑州', 3000, '222222')
INSERT members VALUES('M_004', '小菊', '1988-01-01 00:00:00.000', '女', '开封', 2700, '333333')
INSERT members VALUES('M_005', '小明', '1985-02-03 00:00:00.000', '男', '漯河', 2400, '444444')

--会员表添加记录
INSERT INTO members VALUES('liuzc518','刘志成','1972-05-18','男','湖南株洲',3500.0,'liuzc518')
INSERT INTO members VALUES('liuzc','刘爱平','1974-07-18','男','江西南昌',4500.0,'liuzc')
INSERT INTO members VALUES('zhao888','赵爱云','1972-02-12','男','湖南株洲',5500.0,'zhao888')
INSERT INTO members VALUES('wangym','王咏梅','1974-08-06','女','湖南长沙',4000.0,'wangym0806')
INSERT INTO members VALUES('jinjin','津津有味','1982-04-14','女','北京市',8200.0,'jinjin')
INSERT INTO members VALUES('lfz','刘法治','1976-08-26','男','天津市',4500.0,'lfz0826')
INSERT INTO members VALUES('zhangzl','张自梁','1975-04-20','男','湖南株洲',4300.0,'zhangzl')

SELECT * FROM members


-- 设置工作数据库
use eshop

-- 删除表
if exists (select * from sysobjects where id = object_id(N'orders') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table orders;

-- 创建表
CREATE TABLE orders(
	M_account varchar(20) NOT NULL,
	P_no varchar(20) NOT NULL,
	O_quantity int NOT NULL,
	O_date datetime NOT NULL,
	O_confirm_state bit NOT NULL,
	O_pay_state bit NOT NULL,
	O_send_state bit NOT NULL,
	CONSTRAINT M_P PRIMARY KEY(M_account,P_no)
);

--插入数据
INSERT orders(M_account, P_no, O_quantity, O_date, O_confirm_state, O_pay_state, O_send_state) 
VALUES('M_001', 'P_001', 1, '2005-10-09 00:00:00.000', 0, 0, 0)
INSERT orders VALUES('M_001', 'P_002', 1, '2005-10-09 00:00:00.000', 1, 1, 0)
INSERT orders VALUES('M_002', 'P_001', 2, '2005-10-09 00:00:00.000', 1, 1, 0)
INSERT orders VALUES('M_003', 'P_003', 1, '2005-08-09 00:00:00.000', 1, 0, 0)
INSERT orders VALUES('M_004', 'P_004', 1, '2005-08-09 00:00:00.000', 1, 1, 1)

--订单表添加记录
INSERT INTO orders VALUES('liuzc','0130810324',1,'2005-10-09',0,0,0)
INSERT INTO orders VALUES('liuzc','0910810004',2,'2005-10-09',1,1,0)
INSERT INTO orders VALUES('liuzc','0910810001',1,'2005-10-09',1,1,0)
INSERT INTO orders VALUES('wangym','0910810001',1,'2005-08-09',1,0,0)
INSERT INTO orders VALUES('jinjin','0910810004',1,'2005-08-09',1,1,1)
INSERT INTO orders VALUES('lfz','0910810001',1,'2005-08-09',0,0,0)
INSERT INTO orders VALUES('lfz','0910810004',2,'2005-08-09',1,1,1)
INSERT INTO orders VALUES('zhao888','0240810333',2,'2005-06-06',1,1,0)

SELECT * FROM orders;