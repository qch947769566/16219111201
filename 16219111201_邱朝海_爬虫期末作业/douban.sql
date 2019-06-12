/*
Navicat MySQL Data Transfer

Source Server         : Spider
Source Server Version : 50018
Source Host           : localhost:3306
Source Database       : douban

Target Server Type    : MYSQL
Target Server Version : 50018
File Encoding         : 65001

Date: 2019-04-26 15:38:22
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `jdphone`
-- ----------------------------
DROP TABLE IF EXISTS `jdphone`;
CREATE TABLE `jdphone` (
  `ID` int(11) unsigned zerofill NOT NULL auto_increment,
  `图片` varchar(300) character set utf8 default NULL,
  `品牌` varchar(50) character set utf8 default NULL,
  `价格` float default NULL,
  `简介` varchar(300) character set utf8 default NULL,
  `评价条数` varchar(50) character set utf8 default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of jdphone
-- ----------------------------

-- ----------------------------
-- Table structure for `movies`
-- ----------------------------
DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies` (
  `ID` int(11) unsigned zerofill NOT NULL auto_increment,
  `链接` varchar(300) character set utf8 default NULL,
  `标题` varchar(50) character set utf8 NOT NULL default '',
  `简介` varchar(300) character set utf8 default NULL,
  PRIMARY KEY  (`ID`,`标题`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of movies
-- ----------------------------
