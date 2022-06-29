/*
 Navicat Premium Data Transfer
 Source Server         : 羽毛球订场小程序
 Source Server Type    : MySQL
 Source Server Version : 8.0
 Source Host           : localhost:3306
 Source Schema         : gpmall
 Target Server Type    : MySQL
 Target Server Version : 8.0
 File Encoding         :
 Date: 23/06/2022 13:13:50
*/

-- ------------------
-- Add Test database
-- ------------------
DROP DATABASE if exists mall_ball;
CREATE DATABASE if not exists mall_ball default charset utf8mb4;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
USE mall_ball;
-- --------------------
-- Table add pl_role
-- --------------------
DROP TABLE IF EXISTS pl_role;
CREATE TABLE pl_role(
    id int  NOT NULL PRIMARY KEY AUTO_INCREMENT comment '主角ID,主键,自增',
    role_name varchar(30)  NOT NULL comment '角色名称',
    role_level int DEFAULT 1 NOT NULL comment '角色等级'
) comment '羽毛球场角色表单';

-- --------------------------
-- Table pl_role for tb_base
-- --------------------------
INSERT INTO pl_role VALUES (1,'普通会员',1);
INSERT INTO pl_role VALUES (2,'VIP会员',2);
INSERT INTO pl_role VALUES (3,'SVIP会员',3);



-- ------------------
-- Table add pl_user
-- ------------------
DROP TABLE IF EXISTS pl_user;
CREATE TABLE pl_user(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT comment '用户ID,主键，自增',
    uuid varchar(100) NOT NULL  comment '用户id',
    role_id int NOT NULL comment '角色ID，pl_role.id的外键',
    constraint pl_user_role foreign key (role_id) references pl_role(id)
) comment '羽毛球场用户';


-- --------------------
-- Table add pl_court
-- --------------------
DROP TABLE IF EXISTS pl_court;
CREATE TABLE pl_court(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT comment '羽毛球管ID,主键，自增',
    court_name varchar(30)  NOT NULL comment '羽毛球馆的名字',
    court_address varchar(50)  NOT NULL comment '羽毛球馆的地址',
    court_status enum('0','100') NOT NULL  comment '羽毛球馆开放状态',
    court_opentime timestamp  NOT NULL  comment '羽毛球馆开放时间',
    court_closetime timestamp  NOT NULL  comment '羽毛球馆关闭时间',
    court_owner_id  int  NOT NULL  comment '羽毛球馆归属人ID',
    court_action_json text  NULL comment '羽毛球馆的JSON数据'
) comment '羽毛球馆';


-- --------------------------
-- Table add pl_deal_history
-- --------------------------
DROP TABLE IF EXISTS pl_deal_history;
CREATE TABLE pl_deal_history(
    id int  NOT NULL PRIMARY KEY AUTO_INCREMENT  comment '交易ID,主键,自增',
    deal_user_id int  NOT NULL  comment '用户ID,pl_user.id的外键',
    deal_court_id int  NULL comment '羽毛球馆ID,pl_court.id的外键',
    deal_playgroud_no text  NULL comment '场序列号',
    deal_type enum('0','100')  NOT NULL comment '订单类型',
    deal_wx_pay_id text NOT NULL comment '微信单号',
    deal_history_time timestamp NOT NULL comment '订单时间',
    constraint pl_user_deal foreign key (deal_user_id) references pl_user(id),
    constraint pl_court_deal foreign key (deal_court_id) references pl_court(id)
)comment '历史订单';



