-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(20)  NOT NULL COMMENT 'user_name',
  `password` varchar(20)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `birthday` varchar(20)  NULL COMMENT '出生日期',
  `telephone` varchar(20)  NOT NULL COMMENT '用户电话',
  `address` varchar(20)  NULL COMMENT '家庭地址',
  `userType` varchar(20)  NOT NULL COMMENT '用户类型',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_movieHall` (
  `movieHallId` int(11) NOT NULL AUTO_INCREMENT COMMENT '影厅id',
  `movieHallName` varchar(20)  NOT NULL COMMENT '影厅名称',
  `rows` int(11) NOT NULL COMMENT '座位排数',
  `cols` int(11) NOT NULL COMMENT '座位列数',
  PRIMARY KEY (`movieHallId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_movie` (
  `movieId` int(11) NOT NULL AUTO_INCREMENT COMMENT '影片id',
  `movieName` varchar(40)  NOT NULL COMMENT '影片名称',
  `movieType` varchar(20)  NOT NULL COMMENT '影片类型',
  `moviePhoto` varchar(60)  NOT NULL COMMENT '影片图片',
  `director` varchar(20)  NOT NULL COMMENT '导演',
  `mainPerformer` varchar(50)  NOT NULL COMMENT '主演',
  `duration` varchar(20)  NOT NULL COMMENT '时长',
  `area` varchar(20)  NOT NULL COMMENT '地区',
  `releaseDate` varchar(20)  NULL COMMENT '上映日期',
  `price` float NOT NULL COMMENT '票价',
  `opera` varchar(2000)  NOT NULL COMMENT '剧情',
  PRIMARY KEY (`movieId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_schedule` (
  `scheduleId` int(11) NOT NULL AUTO_INCREMENT COMMENT '档期id',
  `movieObj` int(11) NOT NULL COMMENT '电影',
  `hallObj` int(11) NOT NULL COMMENT '播放影厅',
  `scheduleDate` varchar(20)  NULL COMMENT '放映日期',
  `scheduleTime` varchar(20)  NOT NULL COMMENT '放映时间',
  PRIMARY KEY (`scheduleId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_movieOrder` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订票id',
  `scheduleObj` int(11) NOT NULL COMMENT '档期',
  `rowsIndex` int(11) NOT NULL COMMENT '座位行号',
  `cols` int(11) NOT NULL COMMENT '座位列号',
  `price` float NOT NULL COMMENT '票价',
  `userObj` varchar(20)  NOT NULL COMMENT '用户',
  `orderTime` varchar(20)  NULL COMMENT '预定时间',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_comment` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT COMMENT '影评id',
  `movieObj` int(11) NOT NULL COMMENT '电影',
  `content` varchar(90)  NOT NULL COMMENT '影评内容',
  `userObj` varchar(20)  NOT NULL COMMENT '评论用户',
  `commentTime` varchar(20)  NULL COMMENT '评论时间',
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_schedule ADD CONSTRAINT FOREIGN KEY (movieObj) REFERENCES t_movie(movieId);
ALTER TABLE t_schedule ADD CONSTRAINT FOREIGN KEY (hallObj) REFERENCES t_movieHall(movieHallId);
ALTER TABLE t_movieOrder ADD CONSTRAINT FOREIGN KEY (scheduleObj) REFERENCES t_schedule(scheduleId);
ALTER TABLE t_movieOrder ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_comment ADD CONSTRAINT FOREIGN KEY (movieObj) REFERENCES t_movie(movieId);
ALTER TABLE t_comment ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


