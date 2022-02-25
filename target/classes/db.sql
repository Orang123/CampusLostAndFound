DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL UNIQUE,
  `password` varchar(45) NOT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `role` int(11) NOT NULL,
  `start_time` bigint DEFAULT -1,
  `forbid_talk_duration` bigint DEFAULT NULL
  PRIMARY KEY (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

#mysql 表字段在已经插入值的情况下,也是可以再添加新的列的;
#alter table user add column start_time bigint DEFAULT -1;
#alter table user add column forbid_talk_duration bigint DEFAULT NULL;
#alter table user modify password varchar(40) not null;

#INSERT INTO `user` (`username`,`password`,`qq`,`email`,`role`) VALUES ('orang','123456','897444460','897444460@qq.com',0);
#INSERT INTO `user` (`username`,`password`,`qq`,`email`,`role`) VALUES ('root','mysql123','805936768','805936768@qq.com',0);
#INSERT INTO `user` (`username`,`password`,`qq`,`email`,`role`) VALUES ('admin','admin','154528225','154528225@qq.com',1);
#INSERT INTO `user` (`username`,`password`,`qq`,`email`,`role`) VALUES ('jack','jack','25654474','25654474@123.com',0);
#INSERT INTO `user` (`username`,`password`,`qq`,`email`,`role`) VALUES ('peter','peter','1548664844','1548664844@qq.com',0);
#INSERT INTO `user` (`username`,`password`,`qq`,`email`,`role`) VALUES ('bob','bob','1456884824','1456884824@qq.com',0);

DROP TABLE IF EXISTS `goods`;
CREATE TABLE IF NOT EXISTS `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info_type` varchar(15) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `publish_time` datetime DEFAULT NULL,
  `goods_name` varchar(50) DEFAULT NULL,
  `goods_type` varchar(30) DEFAULT NULL,
  `happen_place` varchar(60) DEFAULT NULL,
  `happen_time` datetime DEFAULT NULL,
  `img_url` varchar(50) DEFAULT NULL,
  `state` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `auid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_goods_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#这里auid不设外键 是因为answer_user表里goods_id是goods的外键,两个都设外键没法创建表

#INSERT INTO `goods` (`info_type`,`happen_time`,`state`,`uid`) VALUES ('寻物','2020-04-05','0','2');

DROP TABLE IF EXISTS `answer_user`;
CREATE TABLE IF NOT EXISTS `answer_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `goods_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_answer_user_goods` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `thanks_letter`;
CREATE TABLE IF NOT EXISTS `thanks_letter`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_time` datetime DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(120) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_thanks_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `help_info`;
CREATE TABLE IF NOT EXISTS `help_info`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_time` datetime DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `content` varchar(350) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_help_info_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#insert into help_info (title,content,uid) values ('如何登陆网站','新用户需要单击主页面导航栏内的注册栏目,进行玩新用户信息的注册后就可点击登录链接登录,即可重新跳转到主页,此时用户已在线。',3);
#insert into help_info (title,content,uid) values ('如何发布信息','用户登录后进入相应的寻物或招领页面点击右侧打的发布信息链接即可进入到发布信息的页面,然后填写相应的信息,之后点击发布失物按钮即可进行发布信息,发布完成后会跳转到相应的页面。',3);
#insert into help_info (title,content,uid) values ('为什么已经登录了还提示要登录','这是因为为了保护用户账号的安全和隐私,浏览器设置了httpsession的生命周期,都设置了这个只要长时间没有操作页面超过设定的时间就会自动下线,你再动的时候会提示你重新登陆,是一种安全举措,是正常现象。',3);
#insert into help_info (title,content,uid) values ('如何申领别人发布的失物招领','在确保已登录账号的前提下,在寻物或招领详情页面中右侧发布信息栏目找到提供按钮并点击即可。',3);
#alter table help_info modify title varchar(100) DEFAULT NULL;
#alter table help_info add column publish_time datetime DEFAULT NULL;
#update help_info set publish_time='2020-02-25 12:15:37' where id =1;
#update help_info set publish_time='2020-02-25 12:20:20' where id =2;
#update help_info set publish_time='2020-02-25 12:25:41' where id =3;
#update help_info set publish_time='2020-02-25 12:30:30' where id =4;

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_time` datetime DEFAULT NULL,
  `content` varchar(120) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comment_goods` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `reply`;
CREATE TABLE IF NOT EXISTS `reply`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_time` datetime DEFAULT NULL,
  `content` varchar(120) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `replied_uid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_reply_comment` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_replied_user` FOREIGN KEY (`replied_uid`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reply_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

#alter table answer_user modify username varchar(30) not null;
#alter table answer_user drop index username;(删除username的unique约束对应的是index索引)
