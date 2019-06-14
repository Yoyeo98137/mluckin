-- 瑞幸移动端
set names utf8;
drop database if exists mluck;
create database mluck charset=utf8;
use mluck;

-- 用户信息
create table luck_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  uimg VARCHAR(128)
);
INSERT INTO luck_user VALUES(null,'Arser',md5('123456'),'http://127.0.0.1:3000/img/user1.jpg');
INSERT INTO luck_user VALUES(null,'tom',md5('456789'),'');

-- 用户XXX的商品列表
create table shop_list(
  id INT PRIMARY KEY AUTO_INCREMENT,
  state VARCHAR(25),
  store VARCHAR(128),
  lname VARCHAR(64),
  price DECIMAL(10,2),
  ltime VARCHAR(48),
  uid int
);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','拿铁','9.03','2019-05-22 07:55',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','美式咖啡','13.76','2019-05-22 07:55',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','卡布奇诺','11.73','2019-05-24 07:58',1);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','NFC鲜榨橙汁','24','2019-05-23 07:55',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','卡布奇诺瑞纳冰','24','2019-05-23 07:55',1);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','拿铁','9.03','2019-05-25 07:51',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','卡布奇诺瑞纳冰','24','2019-05-25 07:53',1);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','焦糖拿铁','24','2019-05-27 07:55',1);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','香草','27','2019-05-28 07:52',1);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','拿铁','9.03','2019-05-30 07:54',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','卡布奇诺瑞纳冰','24','2019-05-22 07:55',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','拿铁','9.03','2019-06-02 07:55',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','焦糖拿铁','24','2019-06-12 08:05',1);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','拿铁','9.03','2019-06-13 07:55',1);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','焦糖拿铁','24','2019-06-22 07:55',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','香草','27','2019-06-22 07:55',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','拿铁','9.03','2019-06-22 07:55',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','NFC鲜榨橙汁','24','2019-06-22 07:47',1);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','焦糖拿铁','24','2019-06-12 08:05',2);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','拿铁','9.03','2019-06-13 07:55',2);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','焦糖拿铁','24','2019-06-22 07:55',2);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','香草','27','2019-06-22 07:55',2);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','拿铁','9.03','2019-06-22 07:55',2);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','NFC鲜榨橙汁','24','2019-06-22 07:47',2);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','焦糖拿铁','24','2019-06-12 08:05',2);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','拿铁','9.03','2019-06-13 07:55',2);
INSERT INTO shop_list VALUES(null,'已完成','优城A座店','焦糖拿铁','24','2019-06-12 08:05',2);
INSERT INTO shop_list VALUES(null,'未完成','优城A座店','拿铁','9.03','2019-06-13 07:55',2);


-- 用户XXX的购物车列表
create table shop_cart(
  id INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(25),
  ceng VARCHAR(25),
  price DECIMAL(10,2),
  count INT,
  uid   INT
);

INSERT INTO shop_cart VALUES(null,'橘金气泡美式','Mandarine Soda Americano',24,1,2);
INSERT INTO shop_cart VALUES(null,'拿铁','Latte',24,1,2);
INSERT INTO shop_cart VALUES(null,'香草','Vanilla Latte',27,1,2);
INSERT INTO shop_cart VALUES(null,'焦糖拿铁','Caramel Latte',27,1,2);
INSERT INTO shop_cart VALUES(null,'NFC鲜榨橙汁','NFC Fresh Orange Juice',24,1,2);
INSERT INTO shop_cart VALUES(null,'卡布奇诺瑞纳冰','Cappuccino Exfreezo',27,1,1);
INSERT INTO shop_cart VALUES(null,'香草','Vanilla Latte',27,1,1);
INSERT INTO shop_cart VALUES(null,'焦糖拿铁','Caramel Latte',27,1,1);
INSERT INTO shop_cart VALUES(null,'NFC鲜榨橙汁','NFC Fresh Orange Juice',24,1,1);
