

CREATE TABLE `pre_common_session_app` (
  `sid` char(32) NOT NULL DEFAULT '',
  `ip` char(15) NOT NULL DEFAULT '',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` char(15) NOT NULL DEFAULT '',
  `lastlogin` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `sid` (`sid`),
  KEY `uid` (`uid`)
) TYPE=MyISAM;

CREATE TABLE  `pre_advice_app` (
 `vid` INT( 10 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY ,
 `message` MEDIUMTEXT NOT NULL ,
 `uid` MEDIUMINT( 8 ) UNSIGNED NOT NULL DEFAULT '0',
 `username` VARCHAR( 15 ) NOT NULL ,
 `uip` VARCHAR( 15 ) NOT NULL,
 `time` int(10) unsigned NOT NULL DEFAULT '0',
 KEY `uid` (`uid`)
) TYPE=MyISAM;

CREATE TABLE `pre_shop_class_app` (
`cid` INT( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`pid` INT( 11 ) UNSIGNED NOT NULL ,
`path` VARCHAR( 100 ) NOT NULL ,
`name` VARCHAR( 60 ) NOT NULL ,
`sort` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT '255'
) TYPE=MyISAM;

CREATE TABLE `pre_common_shoplist` (
  `shop_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(100) NOT NULL,
  `shop_pic` varchar(100) NOT NULL,
  `shop_info` text NOT NULL,
  `shop_phone` varchar(50) NOT NULL,
  `shop_address` varchar(300) NOT NULL,
  `shop_website` varchar(100) NOT NULL,
  `shop_lat` float unsigned NOT NULL,
  `shop_lng` float unsigned NOT NULL,
  `class` INT( 11 ) NOT NULL DEFAULT '0',
  `fuwu` INT( 11 ) NOT NULL DEFAULT '0',
  `huanjing` INT( 11 ) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shop_id`)
) ENGINE=MyISAM;

CREATE TABLE `pre_comment_shop_app` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `author` varchar(15) NOT NULL DEFAULT '',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',  
  `message` mediumtext NOT NULL,
  `mark` TINYINT( 1 ) unsigned NOT NULL DEFAULT '0',  
  `useip` varchar(15) NOT NULL DEFAULT '',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`)
) TYPE=MyISAM;

CREATE TABLE `pre_comment_shop_pic_app` (
  `com_pic_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `author` varchar(15) NOT NULL DEFAULT '',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `shop_com_pic` varchar(100) NOT NULL,
  `mark` TINYINT( 1 ) unsigned NOT NULL DEFAULT '0',
  `message` mediumtext NOT NULL,  
  `useip` varchar(15) NOT NULL DEFAULT '',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`com_pic_id`)
) TYPE=MyISAM;

CREATE TABLE `pre_count_install_app` (
 `aid` INT( 10 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `hardtype` TINYINT( 1 ) unsigned NOT NULL DEFAULT '0',
 `uip` VARCHAR( 15 ) NOT NULL,
 `time` int(10) unsigned NOT NULL DEFAULT '0'
) TYPE=MyISAM;


CREATE TABLE `pre_common_picshow` (
`picshow_id` INT( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT ,
`picshow_title` VARCHAR( 255 ) NOT NULL ,
`picshow_content` text NOT NULL,
`picshow_coverpic` VARCHAR( 255 ) NOT NULL ,
`picshow_addtime` INT( 11 ) UNSIGNED NOT NULL ,
`username` VARCHAR( 20 ) NOT NULL ,
`uid` INT( 11 ) UNSIGNED NOT NULL ,
`tid` INT( 11 ) UNSIGNED NOT NULL ,
PRIMARY KEY ( `picshow_id` )
) ENGINE = MYISAM;

CREATE TABLE `pre_common_pic` (
`pic_id` INT( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT ,
`picshow_id` INT( 11 ) UNSIGNED NOT NULL ,
`pic_message` TEXT NOT NULL ,
`pic_photo` VARCHAR( 255 ) NOT NULL ,
`pic_addtime` INT( 11 ) UNSIGNED NOT NULL ,
PRIMARY KEY ( `pic_id` )
) ENGINE = MYISAM;

CREATE TABLE `pre_common_pushinfo` (
`pushinfo_id` INT( 10 ) UNSIGNED NOT NULL AUTO_INCREMENT ,
`tid` INT( 10 ) UNSIGNED NOT NULL ,
`pushtitle` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`pushtime` INT( 10 ) UNSIGNED NOT NULL ,
PRIMARY KEY ( `pushinfo_id` )
) ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `pre_common_devicetoken` (
`token` VARCHAR( 100 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci;