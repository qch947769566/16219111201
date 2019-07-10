/*
Navicat MySQL Data Transfer

Source Server         : Spider
Source Server Version : 50018
Source Host           : localhost:3306
Source Database       : db_mystudent

Target Server Type    : MYSQL
Target Server Version : 50018
File Encoding         : 65001

Date: 2019-07-10 15:04:12
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `c3p0testtable`
-- ----------------------------
DROP TABLE IF EXISTS `c3p0testtable`;
CREATE TABLE `c3p0testtable` (
  `a` char(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c3p0testtable
-- ----------------------------

-- ----------------------------
-- Table structure for `clas`
-- ----------------------------
DROP TABLE IF EXISTS `clas`;
CREATE TABLE `clas` (
  `id` int(11) NOT NULL auto_increment,
  `gradeId` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `remark` varchar(500) default NULL,
  PRIMARY KEY  (`id`),
  KEY `gradeId` (`gradeId`),
  CONSTRAINT `clas_ibfk_1` FOREIGN KEY (`gradeId`) REFERENCES `grade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of clas
-- ----------------------------
INSERT INTO `clas` VALUES ('1', '1', '计算机科学与技术', '1111');
INSERT INTO `clas` VALUES ('2', '2', '网络工程', '2222');
INSERT INTO `clas` VALUES ('4', '4', '软件工程', '444444');

-- ----------------------------
-- Table structure for `grade`
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `remark` varchar(500) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES ('1', '大一', '。。。');
INSERT INTO `grade` VALUES ('2', '大二', '2333333');
INSERT INTO `grade` VALUES ('3', '大三', '333333');
INSERT INTO `grade` VALUES ('4', '大四', '双截快打咖啡机阿里开发接口v');

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL auto_increment,
  `clasId` int(11) NOT NULL,
  `sn` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `sex` varchar(8) NOT NULL,
  `photo` varchar(128) NOT NULL,
  `remark` varchar(512) default NULL,
  PRIMARY KEY  (`id`),
  KEY `clasId` (`clasId`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`clasId`) REFERENCES `clas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '2', 'S1562661272256', '张三', '123456', '男', '/MyStudent/photo/student.jpg', '张家人');
INSERT INTO `student` VALUES ('2', '2', 'S1562661316679', '王五', '123', '男', '/MyStudent/photo/student.jpg', '6666');
INSERT INTO `student` VALUES ('3', '4', 'S1562661375549', '李四', '123', '女', '/MyStudent/upload/1562661348500.png', '11111111');
INSERT INTO `student` VALUES ('4', '2', 'S1562663511556', '王五五', '123', '男', '/MyStudent/upload/1562663494078.png', '王家人');
INSERT INTO `student` VALUES ('5', '2', 'S1562663546174', '王五', '123', '男', '/MyStudent/upload/1562663494078.png', '王家人');
INSERT INTO `student` VALUES ('6', '1', 'S1562663597776', '王老五', '123', '男', '/MyStudent/upload/1562665110833.gif', '王家人');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'admin');
INSERT INTO `user` VALUES ('2', 'qch', '123456');
INSERT INTO `user` VALUES ('4', 'qqqq', '111');
