select * from cn_user;
select * from cn_notebook_type;
select * from cn_notebook where cn_user_id='0a577912-f0b4-41c2-868b-56e6e77f2d09';
select * from cn_note where cn_notebook_id='68c26607-de01-4775-8962-5d819aa8c546' and cn_user_id='0a577912-f0b4-41c2-868b-56e6e77f2d09';
select * from cn_share;
select * from cn_activity;
select * from cn_note_activity;

delete from cn_notebook where cn_user_id='2dbe4e2a-075b-4318-a784-a5e0fabf8d0a';


select note.* from cn_note note,cn_notebook book where
note.cn_notebook_id=book.cn_notebook_id and
 book.cn_notebook_type_id='2' and note.cn_user_id='a740b632-ceae-44a0-a4c5-7655d2972573'

update cn_note set cn_notebook_id=
(select cn_notebook_id from cn_notebook where cn_notebook_type_id='2' 
and cn_user_id='a740b632-ceae-44a0-a4c5-7655d2972573')

update cn_user set cn_user_password='111111' where cn_user_id='12b2a569-f3fa-4a12-903e-ceda9d08de7e'
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `cn_user`
-- ----------------------------
DROP TABLE IF EXISTS `cn_user`;
CREATE TABLE `cn_user` (
  `cn_user_id` varchar(100) binary NOT NULL COMMENT '用户ID',
  `cn_user_name` varchar(100) binary DEFAULT NULL COMMENT '用户名',
  `cn_user_password` varchar(100) binary DEFAULT NULL COMMENT '密码',
  `cn_user_token` varchar(100) binary DEFAULT NULL COMMENT '令牌',
  `cn_user_desc` text binary COMMENT '说明',
  PRIMARY KEY (`cn_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_user
-- ----------------------------
INSERT INTO `cn_user` VALUES ('03590914-a934-4da9-ba4d-b41799f917d1', 'zhouj', '55587a910882016321201e6ebbc9f595', null, null);
INSERT INTO `cn_user` VALUES ('2273f742-61ec-4440-b88a-42cf48db19ff', 'zhoujia123', '4297f44b13955235245b2497399d7a93', null, null);
INSERT INTO `cn_user` VALUES ('333c6d0b-e4a2-4596-9902-a5d98c2f665a', 'test1', '96e79218965eb72c92a549dd5a330112', null, null);
INSERT INTO `cn_user` VALUES ('39295a3d-cc9b-42b4-b206-a2e7fab7e77c', 'zhoujia', '4297f44b13955235245b2497399d7a93', null, null);
INSERT INTO `cn_user` VALUES ('48595f52-b22c-4485-9244-f4004255b972', 'demo', 'c8837b23ff8aaa8a2dde915473ce0991', null, null);
INSERT INTO `cn_user` VALUES ('524f7440-7283-4b2d-8af5-4a67570e892e', 'pc', 'e10adc3949ba59abbe56e057f20f883e', null, null);
INSERT INTO `cn_user` VALUES ('52f9b276-38ee-447f-a3aa-0d54e7a736e4', 'wsf', '6e7d70ed3edfb80421235af5c4ad24aa', null, null);
INSERT INTO `cn_user` VALUES ('6f339f0a-2068-4db1-8fef-8e68f444c72c', 'saipi', '4297f44b13955235245b2497399d7a93', null, null);
INSERT INTO `cn_user` VALUES ('974375a8-8557-4308-bd36-9455c7863239', 'zhoujia1231', '6a204bd89f3c8348afd5c77c717a097a', null, null);
INSERT INTO `cn_user` VALUES ('bf9d2885-f34e-4c78-9ae5-2723f62aa2b5', 'saipi', '4297f44b13955235245b2497399d7a93', null, null);
INSERT INTO `cn_user` VALUES ('ea09d9b1-ede7-4bd8-b43d-a546680df00b', 'yht', '96e79218965eb72c92a549dd5a330112', null, null);
commit;

-- ----------------------------
-- Table structure for `cn_notebook_type`
--笔记本类型表存的是笔记本的种类，一共有5种类型的笔记本，分别是：默认，普通，回收站，收藏，活动
--这些种类是固定的，不会发生变化，因此这个表的数据我们不会再代码中使用，仅仅是给我们作为参考，将其当作系统常量即可
-- ----------------------------
DROP TABLE IF EXISTS `cn_notebook_type`;
CREATE TABLE `cn_notebook_type` (
  `cn_notebook_type_id` varchar(100) binary NOT NULL COMMENT '笔记本类型ID',
  `cn_notebook_type_code` varchar(100) binary DEFAULT NULL COMMENT '笔记本类型Code',
  `cn_notebook_type_name` varchar(500) binary DEFAULT NULL COMMENT '笔记本类型名称',
  `cn_notebook_type_desc` text binary COMMENT '笔记本类型说明',
  PRIMARY KEY (`cn_notebook_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_notebook_type
-- ----------------------------
INSERT INTO `cn_notebook_type` VALUES ('1', 'favorites', 'favorites', '收藏');
INSERT INTO `cn_notebook_type` VALUES ('2', 'recycle', 'recycle', '回收站');
INSERT INTO `cn_notebook_type` VALUES ('3', 'action', 'action', '活动');
INSERT INTO `cn_notebook_type` VALUES ('4', 'push', 'push', '推送');
INSERT INTO `cn_notebook_type` VALUES ('5', 'normal', 'normal', '正常');
commit;

-- ----------------------------
-- Table structure for `cn_notebook`
-- ----------------------------
DROP TABLE IF EXISTS `cn_notebook`;
CREATE TABLE `cn_notebook` (
  `cn_notebook_id` varchar(100) binary NOT NULL COMMENT '笔记本ID',
  `cn_user_id` varchar(100) binary DEFAULT NULL COMMENT '用户ID',
  `cn_notebook_type_id` varchar(100) binary DEFAULT NULL COMMENT '笔记本类型ID',
  `cn_notebook_name` varchar(500) binary DEFAULT NULL COMMENT '笔记本名',
  `cn_notebook_desc` text binary COMMENT '笔记本说明',
  `cn_notebook_createtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cn_notebook_id`),
  KEY `FK_Note_User_Reference` (`cn_user_id`),
  KEY `FK_Reference_6` (`cn_notebook_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_notebook
-- ----------------------------
INSERT INTO `cn_notebook` VALUES ('c1', '2dbe4e2a-075b-4318-a784-a5e0fabf8d0a', '5', 'javaEE', 'java语法基础', '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('c2', '2dbe4e2a-075b-4318-a784-a5e0fabf8d0a', '5', 'javaSE', '面向对象', '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('c3', '2dbe4e2a-075b-4318-a784-a5e0fabf8d0a', '5', 'Spring', 'JavaEE', '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('0b11444a-a6d6-45ff-8d46-282afaa6a655', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', '5', '笔记本1', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('0cd94778-4d52-486d-a35d-263b3cfe6de9', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', '5', 'zhoujia_test', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('12119052-874c-4341-b85d-6529e171ed83', '48595f52-b22c-4485-9244-f4004255b972', '5', '测试——5', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('1755013b-05fc-4218-83cf-956287a81b49', 'ea09d9b1-ede7-4bd8-b43d-a546680df00b', '4', 'push', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('1b05c9c7-f1cd-4842-beae-15ed95a1febb', '03590914-a934-4da9-ba4d-b41799f917d1', '3', 'action', null, '2014-07-09 17:16:45');
INSERT INTO `cn_notebook` VALUES ('8844559e-9d93-459b-a9db-2afcb8a592c8', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', '5', 'klsfj', null, '2014-07-18 17:39:32');
INSERT INTO `cn_notebook` VALUES ('885bbeab-ab12-4048-adb2-c6fd9c3e9be8', '03590914-a934-4da9-ba4d-b41799f917d1', '2', 'recycle', null, '2014-07-09 17:16:45');
INSERT INTO `cn_notebook` VALUES ('8888888888888888888888888888888888', '524f7440-7283-4b2d-8af5-4a67570e892e', '1', 'favorites', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('8be77c36-3cd5-4727-a8a9-071316a2eb11', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', '5', 'zhoujia-111', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('94730716-2002-4952-ba23-aeb1e92ea00a', '52f9b276-38ee-447f-a3aa-0d54e7a736e4', '1', 'favorites', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('97a87189-c661-4a14-8081-faf011904499', '03590914-a934-4da9-ba4d-b41799f917d1', '4', 'push', null, '2014-07-09 17:16:45');
INSERT INTO `cn_notebook` VALUES ('9999999999999999999999999999999999', '524f7440-7283-4b2d-8af5-4a67570e892e', '2', 'recycle', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('9c68ca1a-830f-4a81-a8ec-d148d2df4f7f', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', '5', 'dddd ', null, '2014-06-27 15:18:32');
INSERT INTO `cn_notebook` VALUES ('a1358ece-bd30-48a2-a53c-0fe195609fd2', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', '5', 'wsf', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('a1669286-b171-4a06-b2fc-2dfe5afdb0ec', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', '5', 'Hello', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('a20ac761-c1eb-462a-8ed9-c0a9fb412e70', '03590914-a934-4da9-ba4d-b41799f917d1', '1', 'favorites', null, '2014-07-09 17:16:45');
INSERT INTO `cn_notebook` VALUES ('a248decc-0fb6-402c-83e9-ea33a276968a', '333c6d0b-e4a2-4596-9902-a5d98c2f665a', '1', 'favorites', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('ab2a2058-8d8f-41a1-b7c4-b4a7b6f95fc3', '333c6d0b-e4a2-4596-9902-a5d98c2f665a', '2', 'recycle', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('af8be968-66bb-4b75-ac5d-d7deb772640f', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', '5', '而成的', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('f45f368b-6558-426e-a58e-a7b819d29ca9', '52f9b276-38ee-447f-a3aa-0d54e7a736e4', '2', 'recycle', null, '2014-06-27 15:18:59');
INSERT INTO `cn_notebook` VALUES ('fa8d3d9d-2de5-4cfe-845f-951041bcc461', '524f7440-7283-4b2d-8af5-4a67570e892e', '5', '测试笔记本——3', null, '2014-06-27 15:18:59');
commit;

-- ----------------------------
-- Table structure for `cn_note`
-- ----------------------------
DROP TABLE IF EXISTS `cn_note`;
CREATE TABLE `cn_note` (
  `cn_note_id` varchar(100) binary NOT NULL COMMENT '笔记ID',
  `cn_notebook_id` varchar(100) binary DEFAULT NULL COMMENT '笔记本ID',
  `cn_user_id` varchar(100) binary DEFAULT NULL COMMENT '用户ID',
  `cn_note_status_id` varchar(100) binary DEFAULT NULL COMMENT '笔记状态ID:备用',
  `cn_note_type_id` varchar(100) binary DEFAULT NULL COMMENT '笔记本类型ID：备用',
  `cn_note_title` varchar(500) binary DEFAULT NULL COMMENT '笔记标题',
  `cn_note_body` text binary COMMENT '笔记内容',
  `cn_note_create_time` bigint(20) DEFAULT NULL COMMENT '笔记创建时间',
  `cn_note_last_modify_time` bigint(20) DEFAULT NULL COMMENT '笔记最近修改时间',
  PRIMARY KEY (`cn_note_id`),
  KEY `FK_Reference_2` (`cn_notebook_id`),
  KEY `FK_Reference_3` (`cn_user_id`),
  KEY `FK_Reference_7` (`cn_note_status_id`),
  KEY `FK_Reference_8` (`cn_note_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_note
-- ----------------------------
INSERT INTO `cn_note` VALUES ('52f05a14-b88d-4a70-8166-991d9b663854', 'b8080f1b-bb1e-4929-853c-b1cd1e2ff7a5', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, '20', '', '1402637119802', '1402637119802');
INSERT INTO `cn_note` VALUES ('53d1b3ed-59a1-4715-a7b2-9027b0d551e0', '0cd94778-4d52-486d-a35d-263b3cfe6de9', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, '周佳note', '<p>阿斯顿撒旦法撒旦撒旦撒地方</p><p>阿斯蒂芬阿斯蒂芬as阿斯蒂芬</p><p>sadf爱上</p><p>士大夫</p><p>sadf asd飞as的fsd飞as东方</p><p>阿斯蒂芬</p><p>阿斯蒂芬<br/></p>', '0', '1402902425283');
INSERT INTO `cn_note` VALUES ('5526071b-8e3d-4dbf-ad43-b70e23fedafb', 'd0b0727f-a233-4a1f-8600-f49fc1f25bc9', '48595f52-b22c-4485-9244-f4004255b972', null, null, '笔记2——1', '<p>笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1</p><p>笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1</p>', '1402968789899', '1402968789899');
INSERT INTO `cn_note` VALUES ('5565bda4-ddee-4f87-844e-2ba83aa4925f', 'd92e6b86-e48a-485d-8f11-04a93818bb42', '48595f52-b22c-4485-9244-f4004255b972', null, null, '1——5', '<p>1——5</p><p>1——5</p><p>1——5</p><p>1——5</p><p>1——5</p><p>1——5</p><p><br/></p>', '0', '1402888400626');
INSERT INTO `cn_note` VALUES ('5627a403-7ae8-4863-8c9e-66618e9489a0', '6d763ac9-dca3-42d7-a2a7-a08053095c08', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, '13', '', '1402917084511', '1402917084511');
INSERT INTO `cn_note` VALUES ('578f3584-92e6-4632-97e4-ad95426e6902', 'b8080f1b-bb1e-4929-853c-b1cd1e2ff7a5', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, '士大夫撒', '<p>阿斯顿发送到<br/></p>', '0', '1402650660588');
INSERT INTO `cn_note` VALUES ('579b3691-5dbe-4f00-ac14-211dff88edfc', '20b4cbec-bd55-4c21-9c41-3a11ada2b803', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, '测试参加活动——乱七八糟', '', '1402998352993', '1402998352993');
INSERT INTO `cn_note` VALUES ('584043b2-5156-44b0-bf7c-5943abd83f5d', '009380f9-f663-4cdf-817e-5ef0257dc220', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, '笔记1_1111', '<p>asdfasdfasdf<br/></p>', '0', '1402538676138');
INSERT INTO `cn_note` VALUES ('595ea429-9487-4601-9ce2-e0c0383773ed', 'd0b0727f-a233-4a1f-8600-f49fc1f25bc9', '48595f52-b22c-4485-9244-f4004255b972', null, null, '13', '', '1402890408368', '1402890408368');
INSERT INTO `cn_note` VALUES ('5a20819a-6b55-4479-81e7-f3913c26671a', 'c8d81ee5-f8cd-49e8-b2e6-ab174a926d95', '48595f52-b22c-4485-9244-f4004255b972', null, null, '2222222222222222', '', '1403486900967', '1403486900967');
INSERT INTO `cn_note` VALUES ('5c59bc2d-6e7d-4ad9-b0e1-1a871ee8694d', 'b8080f1b-bb1e-4929-853c-b1cd1e2ff7a5', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, '31', '', '1402637149407', '1402637149407');
INSERT INTO `cn_note` VALUES ('5d1a0678-57f7-4bbd-ac4a-323505da94b2', 'af8be968-66bb-4b75-ac5d-d7deb772640f', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, 'abc', '', '1403079755071', '1403079755071');
INSERT INTO `cn_note` VALUES ('5d9587d3-b15a-486a-970d-9964c5b2410e', '0b11444a-a6d6-45ff-8d46-282afaa6a655', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, 'aaaa', '<p>个梵蒂冈凤飞飞大方地<br/></p>', '0', '1402904597637');
INSERT INTO `cn_note` VALUES ('5efc0d6a-1fe3-45d5-863f-618d403a6d7f', 'b8080f1b-bb1e-4929-853c-b1cd1e2ff7a5', '39295a3d-cc9b-42b4-b206-a2e7fab7e77c', null, null, '7', '', '1402637084679', '1402637084679');
commit;

-- ----------------------------
-- Table structure for `cn_share`
-- ----------------------------
DROP TABLE IF EXISTS `cn_share`;
CREATE TABLE `cn_share` (
  `cn_share_id` varchar(100) binary NOT NULL COMMENT '共享ID',
  `cn_share_title` varchar(500) binary DEFAULT NULL COMMENT '共享标题',
  `cn_share_body` text binary COMMENT '共享内容',
  `cn_note_id` varchar(100) binary DEFAULT NULL COMMENT '笔记id',
  PRIMARY KEY (`cn_share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_share
-- ----------------------------
INSERT INTO `cn_share` VALUES ('009d6943-223e-450d-aa26-3aa25edfc8a4', '1——1', '<p>1——11——11——11——11——11——11——11——11——11——11——11——11——1</p>', 'e633e99d-c8dd-44f3-8d8e-5b0966e0927c');
INSERT INTO `cn_share` VALUES ('0a02ba3e-a74c-41b8-8494-01b2e3632f99', '1——1', '<p>1——11——11——11——11——11——11——11——11——11——11——11——11——1</p>', 'e633e99d-c8dd-44f3-8d8e-5b0966e0927c');
INSERT INTO `cn_share` VALUES ('0c031c50-0e95-42ea-8d20-f2f37ca056ef', 'dddd', '<p>阿斯顿发送到阿斯顿发撒旦法撒地方撒地方撒旦发斯蒂芬阿斯顿发撒旦法阿斯蒂芬飞东方撒地方撒地方阿斯顿发撒旦法撒地方阿斯顿发送到</p><p>sadfsadfasdfasd</p><p>的发生撒旦sa东方as东方as东方</p><p>撒地方</p><p>s撒地方</p><p>士大夫</p><p>阿斯蒂芬asd飞asdf</p><p>撒旦f爱上d撒</p><p>撒地方</p><p>撒地方</p><p>阿斯蒂芬</p><p>阿斯蒂芬</p><p>撒地方</p><p>爱上d撒地方</p><p>阿斯蒂芬</p><p>阿萨德f阿萨德f爱上阿斯蒂芬</p><p>撒旦</p><p>爱上</p><p>阿萨德f阿萨德</p><p>阿斯蒂芬</p><p><br/></p>', 'b4f82f9f-bc0f-480a-b8f2-335164d69945');
INSERT INTO `cn_share` VALUES ('0d9b9856-23c5-44a7-ab1f-d444abae17a2', '29', '', 'a9c3f332-9e0b-44f2-9390-e4897806be04');
INSERT INTO `cn_share` VALUES ('0e3e2ae0-eb50-4044-b422-e713f5a5272b', '32', '', '1db4a1d8-76cc-46bb-9e30-9e67f0932530');
INSERT INTO `cn_share` VALUES ('1290dce6-d7f8-4418-b417-99f1a1f42b7b', '25', '', '1153295f-d1a5-4a39-b794-980633bdc3d8');
INSERT INTO `cn_share` VALUES ('186a5ab3-5be7-4fb1-8378-3432cf774edb', 'dddd', '<p>阿斯顿发送到阿斯顿发撒旦法撒地方撒地方撒旦发斯蒂芬阿斯顿发撒旦法阿斯蒂芬飞东方撒地方撒地方阿斯顿发撒旦法撒地方阿斯顿发送到</p><p>sadfsadfasdfasd</p><p>的发生撒旦sa东方as东方as东方</p><p>撒地方</p><p>s撒地方</p><p>士大夫</p><p>阿斯蒂芬asd飞asdf</p><p>撒旦f爱上d撒</p><p>撒地方</p><p>撒地方</p><p>阿斯蒂芬</p><p>阿斯蒂芬</p><p>撒地方</p><p>爱上d撒地方</p><p>阿斯蒂芬</p><p>阿萨德f阿萨德f爱上阿斯蒂芬</p><p>撒旦</p><p>爱上</p><p>阿萨德f阿萨德</p><p>阿斯蒂芬</p><p><br/></p>', 'b4f82f9f-bc0f-480a-b8f2-335164d69945');
INSERT INTO `cn_share` VALUES ('1d27fddd-415a-4745-9dcf-01fdda3b67cf', '笔记2——1', '<p>笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1</p><p>笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1笔记2——1</p>', '80e0f021-c826-4529-b2f2-a550f6d56ed7');
INSERT INTO `cn_share` VALUES ('1ed41d3e-23f6-4e77-905a-f577e5809c6e', '30', '', '7c547246-4fdb-4d29-93b6-8507ce04c81b');
INSERT INTO `cn_share` VALUES ('1f566f6f-6a63-48ea-a46b-c4a859bf5de8', '安装笔记', '<p>首先配置环境~<br/></p>', 'd3ded3ca-4e79-48fd-a501-ea4df79936c1');
INSERT INTO `cn_share` VALUES ('2233a28f-074f-46fe-ab22-a4cbd7879418', '3', '', 'e410fc11-0fe3-44b4-9972-347279a46cc2');
INSERT INTO `cn_share` VALUES ('271e6e19-26db-44e1-b76b-88bf43d8b8bb', '啊啊啊啊', '<p>灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌</p><p>灌灌灌灌灌灌灌过嘎嘎嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎嘎嘎嘎嘎个灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌</p><p>阿萨德飞洒地方撒的发生大撒地方盛大撒旦阿斯蒂芬撒的发生大阿斯蒂芬阿萨德阿斯蒂芬阿萨德阿斯蒂芬阿斯蒂芬撒地方阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬<br/></p>', 'c347f832-e2b2-4cb7-af6f-6710241bcdf6');
INSERT INTO `cn_share` VALUES ('2a144ad2-cda8-4994-a2f2-bf7f1924d5db', '24', '', 'f2e28f90-7862-467b-a17e-31fcd9f7147b');
INSERT INTO `cn_share` VALUES ('2c1733e4-d230-4d5d-917c-c02bc1aa1492', '9', '', '3238f91d-3be7-41d6-acd3-62d0b905203f');
INSERT INTO `cn_share` VALUES ('3042bbc5-ca6d-4f7b-b3a8-975adce7fca1', '22', '', '8d18aaf6-9238-46dc-9c03-988d733790cf');
INSERT INTO `cn_share` VALUES ('30b0d1bb-55a4-4f1b-aa14-55866a27b8fd', '34', '', '864fe9cb-7d46-4481-a8a0-93e6ec5a0ca7');
INSERT INTO `cn_share` VALUES ('31d77a69-d52b-462f-9f0e-eea8798e9df0', '8', '', 'a1211435-9bdc-41a1-89a8-d69e5e60873d');
INSERT INTO `cn_share` VALUES ('384e2f5e-62f8-4ccd-b8dc-800f36d77f0e', '13', '', '446fb256-611e-4c1e-884a-32f62896139a');
INSERT INTO `cn_share` VALUES ('483a9119-462c-453c-9241-8de1a3bc1287', '26', '', '43da4a7b-0f3f-4f3b-97c4-cc522b585375');
INSERT INTO `cn_share` VALUES ('53c5d6d9-fc93-4aee-acb8-86e41e22cfc7', 'wsf1', '<p>wsf<br/></p>', '051538a6-0f8e-472c-8765-251a795bc88f');
INSERT INTO `cn_share` VALUES ('577eea44-2125-4e39-b4bc-60c88eafb0bf', '20', '', '52f05a14-b88d-4a70-8166-991d9b663854');
INSERT INTO `cn_share` VALUES ('58206ff7-9054-4adb-962e-48d98ad82cb5', '测试参加活动——11111111111', '', '7cc685b4-1b0b-4900-8511-f948aa2c2e28');
INSERT INTO `cn_share` VALUES ('58a1d7bd-0c16-4e50-9534-06b3b299e2fb', '1——4', '<p>测试</p><p>1——4</p><p>1——4</p><p>1——4</p><p>1——4</p><p>1——4</p><p>1——4<br/></p>', '07305c91-d9fa-420d-af09-c3ff209608ff');
INSERT INTO `cn_share` VALUES ('5b23fcfd-55b4-4c7d-ba0b-11463838b737', '1——5', '<p>1——5</p><p>1——5</p><p>1——5</p><p>1——5</p><p>1——5</p><p>1——5</p><p><br/></p>', '5565bda4-ddee-4f87-844e-2ba83aa4925f');
INSERT INTO `cn_share` VALUES ('5bb4d1b1-623e-442b-8491-3ed6b9a8e89c', '14', '', '7f46f26d-c999-487f-ba57-09300ea9c961');
INSERT INTO `cn_share` VALUES ('5ced12ea-3e84-4ec6-b60a-56caa11f6658', '19', '', '0a233251-8991-493c-87c8-d36e9433eae3');
INSERT INTO `cn_share` VALUES ('607cacae-1b5c-41ca-9a60-5c0f5d170385', '16', '', 'a0eda0b9-7cab-4fd3-b707-33faf074001f');
INSERT INTO `cn_share` VALUES ('671a1a8a-052e-49dd-a400-18e9cf5d8271', '安装笔记', '<p>首先配置环境~<br/></p>', 'd3ded3ca-4e79-48fd-a501-ea4df79936c1');
INSERT INTO `cn_share` VALUES ('6b33394c-17f9-4205-9424-d016ec663454', '1——3', '<p>1——3</p><p>1——3</p><p>1——3</p><p>1——3</p><p>1——3</p><p>1——3</p><p>1——3</p><p>1——3</p><p>1——3</p><p>1——3</p><p>1——3</p><p>1——3</p><p><br/></p>', '19fbb55b-0541-433b-a7cd-dba52220a447');
INSERT INTO `cn_share` VALUES ('6eb03bff-fb99-4c29-b9bd-18cafef0266f', '18', '', '69ccf926-2b95-487c-8aa4-9c65bd094a75');
INSERT INTO `cn_share` VALUES ('6ef19a79-188c-44a6-93fb-2fbde3a7c7b7', '17', '', '7e4affa2-8cd5-4ba0-abda-751605999507');
INSERT INTO `cn_share` VALUES ('7bd78bc9-bae0-4665-aa03-f1d24f9337da', '4', '', '6d6f5a2a-a09c-4410-be41-10906c5a59e6');
INSERT INTO `cn_share` VALUES ('7c1d010c-9644-4baa-ad77-f53a9e816c24', '21', '', '3651f802-aac2-4337-b700-68857c2cb04c');
INSERT INTO `cn_share` VALUES ('7f8ef845-e668-4aa4-bd11-7082765a9ea9', '31', '', '5c59bc2d-6e7d-4ad9-b0e1-1a871ee8694d');
INSERT INTO `cn_share` VALUES ('83ad2c1a-aff5-4702-b35d-58705dddabb3', '23', '', 'd45c0f17-5a6e-4d6c-ba31-701017ca0753');
INSERT INTO `cn_share` VALUES ('899e18bc-4ba9-485f-9d29-963ee6ebc770', '周佳note', '<p>阿斯顿撒旦法撒旦撒旦撒地方</p><p>阿斯蒂芬阿斯蒂芬as阿斯蒂芬</p><p>sadf爱上</p><p>士大夫</p><p>sadf asd飞as的fsd飞as东方</p><p>阿斯蒂芬</p><p>阿斯蒂芬<br/></p>', '53d1b3ed-59a1-4715-a7b2-9027b0d551e0');
INSERT INTO `cn_share` VALUES ('8c6e4ba3-2a41-47b4-9d2a-64da4a146476', '1——1', '<p>1——11——11——11——11——11——11——11——11——11——11——11——11——1</p>', 'e633e99d-c8dd-44f3-8d8e-5b0966e0927c');
INSERT INTO `cn_share` VALUES ('8ee69ab9-9af9-47ce-8ce2-9561f78e0949', '7', '', '5efc0d6a-1fe3-45d5-863f-618d403a6d7f');
INSERT INTO `cn_share` VALUES ('95f31c0f-91ad-44d6-bd67-066ca452e014', '27', '', 'c141800f-a8f5-4350-a7d3-f67bb93dc67a');
INSERT INTO `cn_share` VALUES ('96527b27-d113-4aa7-91ec-625a7a86839d', '15', '', '9860f9f4-3922-47db-a350-f8948fb852e8');
INSERT INTO `cn_share` VALUES ('99fa2a02-e965-407b-9b46-6f44eec52337', '测试收藏活动笔记——1', '<p>测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1</p>', '326f17e8-ff04-4a79-b33b-ae4bb3bb5f1b');
INSERT INTO `cn_share` VALUES ('9a4bafd3-b6ec-434f-bd03-454d48d25102', '3', '', 'e410fc11-0fe3-44b4-9972-347279a46cc2');
INSERT INTO `cn_share` VALUES ('9d7a7a99-d2fd-4f72-ae93-09a3609dcd4f', '33', '', 'db29d725-34b4-480d-8d26-8438b81d4c0d');
INSERT INTO `cn_share` VALUES ('ab16e4d0-a7ee-4a04-83c9-95314d0b13c5', '1', '<p>11111<br/></p>', '42a84ff7-198e-4c73-abdc-95f0fdc718f8');
INSERT INTO `cn_share` VALUES ('afef156c-82c3-4f9b-a0c7-27dc5fa37435', '1——1', '<p>1——11——11——11——11——11——11——11——11——11——11——11——11——1</p>', 'e633e99d-c8dd-44f3-8d8e-5b0966e0927c');
INSERT INTO `cn_share` VALUES ('b75083e9-e7c3-4f7c-a52c-24c6b72fe5f0', '11', '', 'f74d03aa-d01d-4989-95e8-4757d6ca8a2a');
INSERT INTO `cn_share` VALUES ('bf0a0f7a-1b8f-40d8-a260-151a928ed330', '周佳1111', '<p>啊水井坊绿卡圣诞节法拉盛简单了咖啡机卡拉斯的了发生发了束带结发阿斯蒂芬</p><p>SD卡反击asflsakd拉斯加发斯蒂芬</p><p>asfsda飞阿斯蒂芬</p><p>阿斯蒂芬</p><p>阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬as的阿斯蒂芬<br/></p>', 'b6f39eed-7d6f-42a5-af4f-53b3a1d12451');
INSERT INTO `cn_share` VALUES ('c773453b-b335-45a3-a0ec-ed0eb290b5e5', '2', '', 'e42e03b3-287d-4a44-95fa-498eca565a35');
INSERT INTO `cn_share` VALUES ('c9e56985-70b4-4f3c-be21-5c258950d020', '12', '', 'a8796896-7b1d-484f-9c3a-2b2616c4dfc3');
INSERT INTO `cn_share` VALUES ('d7ee4ee4-dc06-4b40-961e-4b7ff1985611', '10', '', 'd9fccea0-4abd-47de-a3e7-9b9a047bb7ca');
INSERT INTO `cn_share` VALUES ('e0200450-0b11-43d2-a599-fca43b6803e5', '28', '', '71543875-249a-48a3-8e85-e23f543fcf60');
INSERT INTO `cn_share` VALUES ('e26120e4-85f1-4ef8-bfda-e87b0a0b4386', '阿萨德', '<p>切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切去切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切去切切切切切切切切切切去去去去去去起起切切切切切切切切切切切切切切切切切切切切切起起切切切切切切切切切切切切切切切切切切切切切切切切切切切切切去前切切切切切切切切切切切切切切切切切切切切切切切切切去起起切切切切切切切切切切切切切切切切切切切切切去去&nbsp;&nbsp;&nbsp;&nbsp; 切切切切切切切切切切切切切切切切切切切哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇哇<br/></p>', '2f85e280-60c6-41a8-a1c3-e27df98dc7fd');
INSERT INTO `cn_share` VALUES ('e900f87b-106c-409f-bfb0-efa69f59a3a8', '6', '', 'e361d00f-e9e2-457a-bd1a-8b7d60e96c74');
INSERT INTO `cn_share` VALUES ('fa79c413-8c5d-478a-9c49-465be836c253', '1——1', '<p>1——11——11——11——11——11——11——11——11——11——11——11——11——1</p>', 'e633e99d-c8dd-44f3-8d8e-5b0966e0927c');
INSERT INTO `cn_share` VALUES ('fd015d5d-e13e-429b-8a7c-d099a074e7da', '5', '', '4e26ba27-7d01-4dd0-8ca5-cd679beaffb5');
commit;

-- ----------------------------
-- Table structure for `cn_activity`
-- ----------------------------
DROP TABLE IF EXISTS `cn_activity`;
CREATE TABLE `cn_activity` (
  `cn_activity_id` varchar(100) binary NOT NULL COMMENT '活动ID',
  `cn_activity_title` varchar(500) binary DEFAULT NULL COMMENT '活动标题',
  `cn_activity_body` text binary COMMENT '活动介绍(html片段)',
  `cn_activity_end_time` bigint(20) DEFAULT NULL COMMENT '活动结束时间',
  PRIMARY KEY (`cn_activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_activity
-- ----------------------------
INSERT INTO `cn_activity` VALUES ('1', 'Java', 'Java技术征文', null);
INSERT INTO `cn_activity` VALUES ('2', '.net', '.net技术征文', null);
INSERT INTO `cn_activity` VALUES ('3', 'C++', 'C++技术征文', null);
INSERT INTO `cn_activity` VALUES ('4', 'IOS', 'IOS技术征文', null);
INSERT INTO `cn_activity` VALUES ('5', 'Andriod', 'Android技术征文', null);
INSERT INTO `cn_activity` VALUES ('6', '网络营销', '网络营销技术征文', null);
INSERT INTO `cn_activity` VALUES ('7', '嵌入式', '嵌入式技术征文', null);
INSERT INTO `cn_activity` VALUES ('8', 'PHP', 'PHP技术征文', null);
INSERT INTO `cn_activity` VALUES ('9', 'UID', 'UID技术征文', null);
INSERT INTO `cn_activity` VALUES ('10', '测试', '测试技术征文', null);
INSERT INTO `cn_activity` VALUES ('11', '大数据', '大数据技术征文', null);
commit;

-- ----------------------------
-- Table structure for `cn_activity_status`
-- ----------------------------
DROP TABLE IF EXISTS `cn_activity_status`;
CREATE TABLE `cn_activity_status` (
  `cn_activity_status_id` varchar(100) binary NOT NULL COMMENT '活动状态ID',
  `cn_activity_id` varchar(100) binary DEFAULT NULL COMMENT '活动ID',
  `cn_activity_status_code` varchar(500) binary DEFAULT NULL COMMENT '活动状态Code',
  `cn_activity_status_name` varchar(500) binary DEFAULT NULL COMMENT '活动状态名称',
  PRIMARY KEY (`cn_activity_status_id`),
  KEY `FK_Reference_9` (`cn_activity_id`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`cn_activity_id`) REFERENCES `cn_activity` (`cn_activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_activity_status
-- ----------------------------
INSERT INTO `cn_activity_status` VALUES ('1', '1', 'normal', 'normal');
commit;

-- ----------------------------
-- Table structure for `cn_note_activity`
-- ----------------------------
DROP TABLE IF EXISTS `cn_note_activity`;
CREATE TABLE `cn_note_activity` (
  `cn_note_activity_id` varchar(100) binary NOT NULL COMMENT '投稿ID',
  `cn_activity_id` varchar(100) binary DEFAULT NULL COMMENT '活动ID',
  `cn_note_id` varchar(100) binary DEFAULT NULL COMMENT '笔记ID',
  `cn_note_activity_up` int(11) DEFAULT NULL COMMENT '投稿赞:增加数',
  `cn_note_activity_down` int(11) DEFAULT NULL COMMENT '投稿踩:增加数',
  `cn_note_activity_title` varchar(500) binary DEFAULT NULL,
  `cn_note_activity_body` text binary,
  PRIMARY KEY (`cn_note_activity_id`),
  KEY `FK_Reference_4` (`cn_activity_id`),
  KEY `FK_Reference_5` (`cn_note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_note_activity
-- ----------------------------
INSERT INTO `cn_note_activity` VALUES ('0533bce4-0341-4d07-a953-3e6bbb402c75', '8', '737a9a27-b02f-4cc2-b447-eba0f047cd0d', '0', '0', 'aaaa', '<p>顶顶顶顶顶顶顶顶顶顶顶顶顶顶<br/></p>');
INSERT INTO `cn_note_activity` VALUES ('07468f36-fe97-4033-aa77-88c867a4fc3b', '3', '046b0110-67f9-48c3-bef3-b0b23bda9d4e', '0', '0', '啊啊啊啊', '<p>灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌</p><p>灌灌灌灌灌灌灌过嘎嘎嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎嘎嘎嘎嘎个灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌</p><p>阿萨德飞洒地方撒的发生大撒地方盛大撒旦阿斯蒂芬撒的发生大阿斯蒂芬阿萨德阿斯蒂芬阿萨德阿斯蒂芬阿斯蒂芬撒地方阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬<br/></p>');
INSERT INTO `cn_note_activity` VALUES ('0c6b43f6-ada8-4eba-a859-c7f3ad68ea10', '1', '326f17e8-ff04-4a79-b33b-ae4bb3bb5f1b', '0', '0', '测试收藏活动笔记——1', '<p>测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1</p>');
INSERT INTO `cn_note_activity` VALUES ('1111223213', '111222', '1231312312313', '0', '0', 'junit test', '阿斯顿福建收到了空间发啊死啦款到即发阿斯利康京东方');
INSERT INTO `cn_note_activity` VALUES ('1111223213123123', '11122231231', '1231312312313', '0', '0', 'junit test', '阿斯顿福建收到了空间发啊死啦款到即发阿斯利康京东方');
INSERT INTO `cn_note_activity` VALUES ('1111223213123123adf', '11122231231', '1231312312313', '0', '0', 'junit test', '阿斯顿福建收到了空间发啊死啦款到即发阿斯利康京东方');
INSERT INTO `cn_note_activity` VALUES ('1a2348f1-d083-480d-b899-41df960927bf', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', '3febebb3-a1b7-45ac-83ba-50cdb41e5fc1', '0', '0', '测试笔记——1', '');
INSERT INTO `cn_note_activity` VALUES ('1ef6eeaa-e995-409f-a810-7c1eeb736e99', '6dc39e41-8c9e-4791-9c13-52a8e537fe64', 'ce997ee1-0adf-4d71-9be9-fe32807c34fb', '0', '0', 'ddddddddddddddddddd', '<p>彭川测试彭川测试彭川测试彭川测试彭川测试彭川测试彭川测试彭川测试dddddd</p>');
INSERT INTO `cn_note_activity` VALUES ('20010a60-bab4-41ea-9aff-18d6c16cd110', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', '754f9d52-3c25-40e1-ae5a-6110d799e608', '0', '0', 'note2', '<p>阿斯顿发送到撒旦法撒旦法斯蒂芬</p><p>阿萨德fas东方as东方</p><p>asdf s撒地方as东方</p><p>asdfas的</p><p>asdf asdf asd飞</p><p>撒地方sad飞as东方asdf撒旦</p><p>sa东方</p><p>阿斯蒂芬asd飞洒地方<br/></p>');
INSERT INTO `cn_note_activity` VALUES ('2630c3fb-ac81-4501-9d54-c6fa8cd26dd5', '1', 'd3ded3ca-4e79-48fd-a501-ea4df79936c1', '0', '0', '安装笔记', '<p>首先配置环境~<br/></p>');
INSERT INTO `cn_note_activity` VALUES ('30d697bf-c1eb-466b-9f9d-83019c6d3a56', '1', '60480071-f989-4945-9b1c-0d2aba07ae96', '0', '0', '测试参加活动——乱七八糟', '');
INSERT INTO `cn_note_activity` VALUES ('5595e8c9-df35-4e91-8e8c-a3af3a0c3de3', '1', '7cc685b4-1b0b-4900-8511-f948aa2c2e28', '0', '0', '测试参加活动——11111111111', '');
INSERT INTO `cn_note_activity` VALUES ('60aadac1-6e35-4b2e-a5c4-3cd430a7803a', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', 'b4f82f9f-bc0f-480a-b8f2-335164d69945', '0', '0', 'dddd', '');
INSERT INTO `cn_note_activity` VALUES ('61c4fbd2-b311-49f0-93cf-556b198c850f', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', 'ebd65da6-3f90-45f9-b045-782928a5e2c0', '0', '0', '测试笔记——4', '');
INSERT INTO `cn_note_activity` VALUES ('6aa515cc-43b2-4ecc-8bb6-f298ad2cabd7', '1', '5565bda4-ddee-4f87-844e-2ba83aa4925f', '0', '0', '1——5', '<p>1——5</p><p>1——5</p><p>1——5</p><p>1——5</p><p>1——5</p><p>1——5</p><p><br/></p>');
INSERT INTO `cn_note_activity` VALUES ('74a9eb36-043b-4715-8c4f-0b7927eea7de', 'undefined', '3febebb3-a1b7-45ac-83ba-50cdb41e5fc1', '0', '0', '测试笔记——1', '');
INSERT INTO `cn_note_activity` VALUES ('788f6e74-aa66-46eb-bc24-f041935080ff', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', 'b4f82f9f-bc0f-480a-b8f2-335164d69945', '0', '0', 'dddd', '');
INSERT INTO `cn_note_activity` VALUES ('918dc992-3b64-40a4-9750-7868b15121c7', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', 'ebd65da6-3f90-45f9-b045-782928a5e2c0', '0', '0', '测试笔记——4', '');
INSERT INTO `cn_note_activity` VALUES ('9971724f-e890-429b-8ffc-a52eb73e59a4', '1', '326f17e8-ff04-4a79-b33b-ae4bb3bb5f1b', '0', '0', '测试收藏活动笔记——1', '<p>测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1</p>');
INSERT INTO `cn_note_activity` VALUES ('9a0512d2-e8e3-431b-9a2b-c010e01b8cf0', 'c7f7fcdb-37c0-4d04-8dea-99123c672d4a', '60480071-f989-4945-9b1c-0d2aba07ae96', '0', '0', '测试参加活动——乱七八糟', '');
INSERT INTO `cn_note_activity` VALUES ('9f3fe6bc-3353-4f91-8883-452e37edcd5c', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', '60480071-f989-4945-9b1c-0d2aba07ae96', '0', '0', '测试参加活动——乱七八糟', '');
INSERT INTO `cn_note_activity` VALUES ('a892e798-55aa-4ee1-ac7a-feec25f52f3a', '8', 'b5fc7da0-b5e8-4792-8f1f-9fd4b347a64f', '0', '0', '笔记1——132', '<p>阿斯顿辅导费的阿萨德东方</p><p>爱的色放飞速达阿萨德</p><p>阿萨德撒地方 撒旦法撒旦按时发达发放倒萨士大夫</p><p>阿萨德法撒旦阿斯蒂芬123123<br/></p>');
INSERT INTO `cn_note_activity` VALUES ('ae2aa279-6f29-4723-97a0-71269e649921', '1', '326f17e8-ff04-4a79-b33b-ae4bb3bb5f1b', '0', '0', '测试收藏活动笔记——1', '<p>测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1测试收藏活动笔记——1</p>');
INSERT INTO `cn_note_activity` VALUES ('b492c950-8690-4c50-a0dd-2ee45a6ce199', '1', 'b6f39eed-7d6f-42a5-af4f-53b3a1d12451', '0', '0', '周佳1111', '<p>啊水井坊绿卡圣诞节法拉盛简单了咖啡机卡拉斯的了发生发了束带结发阿斯蒂芬</p><p>SD卡反击asflsakd拉斯加发斯蒂芬</p><p>asfsda飞阿斯蒂芬</p><p>阿斯蒂芬</p><p>阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬as的阿斯蒂芬<br/></p>');
INSERT INTO `cn_note_activity` VALUES ('ba60ed45-1474-4ae2-af7c-73b10dcffbc0', '1', '8530622b-f739-4048-a23f-d226228756b3', '0', '0', '2——1', '');
INSERT INTO `cn_note_activity` VALUES ('bea04303-1590-4da8-8905-3f5a3b0202e8', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', 'ebd65da6-3f90-45f9-b045-782928a5e2c0', '0', '0', '测试笔记——4', '');
INSERT INTO `cn_note_activity` VALUES ('c08620aa-dbf6-401a-9c86-59030417c70b', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', '3febebb3-a1b7-45ac-83ba-50cdb41e5fc1', '0', '0', '测试笔记——1', '');
INSERT INTO `cn_note_activity` VALUES ('c365d8e6-7a51-4607-af9a-08261c2a6f7b', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', 'e633e99d-c8dd-44f3-8d8e-5b0966e0927c', '0', '0', '1——1', '<p>1——11——11——11——11——11——11——11——11——11——11——11——11——1</p>');
INSERT INTO `cn_note_activity` VALUES ('c44c84eb-983c-49a5-8922-34f82a6750b9', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', '668354a9-c7b4-46a0-9a6d-b138cdefc941', '0', '0', 'aaaa', '<p>啊啊啊啊啊啊啊啊啊啊啊啊</p><p>啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊</p><p><br/></p><p><br/></p><p>啊&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊</p><p>啊&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊</p><p>啊&nbsp; 啊啊安装啊擦杀手锏几十封水电费哈数据库电话费阿迪少喝咖啡哈苏丹红将SD卡后方可发生东方航空阿飞啊剑神发哈卡斯加和东方加水电费哈斯卡东方红卡萨京东方看见司法局分开奖号覅王全覆盖撒地方将和的发射到发神经货到付款级啊双飞刀暗红色的罚款京哈卡加少废话卡加水电费卡拉斯电话费卡加水电费就啊哈撒地方库哈斯电话费卡萨丁后发生剪短发了卡萨京东方缴费【if圣诞节罚款加阿斯顿发货阿斯顿减肥撒旦了咖啡机收到啊剑神咖啡哈桑就款到发货爱上积分卡水井坊路口减肥拉斯克奖分拉斯克奖法拉克水煎服啊拉斯克奖地方阿拉山口缴费乐俊凯减肥拉斯克奖发了卡萨京东方看京东方<br/></p>');
INSERT INTO `cn_note_activity` VALUES ('d1311a01-20f0-4645-b764-b4066613134f', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', '53d1b3ed-59a1-4715-a7b2-9027b0d551e0', '0', '0', '周佳note', '');
INSERT INTO `cn_note_activity` VALUES ('d322e34c-e8f3-4a29-9bb1-55fa4395879f', '3', '046b0110-67f9-48c3-bef3-b0b23bda9d4e', '0', '0', '啊啊啊啊', '<p>灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌</p><p>灌灌灌灌灌灌灌过嘎嘎嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎嘎嘎嘎嘎个灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌嘎嘎灌灌灌灌灌灌灌灌灌灌</p><p>阿萨德飞洒地方撒的发生大撒地方盛大撒旦阿斯蒂芬撒的发生大阿斯蒂芬阿萨德阿斯蒂芬阿萨德阿斯蒂芬阿斯蒂芬撒地方阿斯蒂芬阿斯蒂芬阿斯蒂芬阿斯蒂芬<br/></p>');
INSERT INTO `cn_note_activity` VALUES ('ddddddddddddddddddddddddddd', '1', 'ce997ee1-0adf-4d71-9be9-fe32807c34fb', '0', '0', 'ddddddddddddddddd', '								</pre>');
INSERT INTO `cn_note_activity` VALUES ('e49eff6a-0ff1-4c57-b529-c7e6257388d4', '1', '3febebb3-a1b7-45ac-83ba-50cdb41e5fc1', '0', '0', '测试笔记——1', '');
INSERT INTO `cn_note_activity` VALUES ('eeeeeeeeeeeeeeeeeeeee', '1', 'ce997ee1-0adf-4d71-9be9-fe32807c34fb', '0', '0', 'eeeeeeee', '<pre class=\"prettyprint linenums\">\r\n&lt;script type=\"text/javascript\"&gt;\r\n	function get_dom(e){\r\n		return document.getElementById(e);\r\n	}\r\n	function set_height(){\r\n		var pc_height=window.innerHeight;\r\n		pc_height=pc_height-131;\r\n		get_dom(\'first_side_right\').style.height=(pc_height-31)+\'px\';\r\n		get_dom(\'second_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'four_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'input_note_text\').value=pc_height+\'px\';\r\n		get_dom(\'third_side_right\').style.height=(pc_height-15)+\'px\';\r\n		get_dom(\'fifth_side_right\').style.height=(pc_height-15)+\'px\';\r\n	}\r\n	set_height();\r\n	window.onresize=function(){\r\n		set_height();//pengchuan\r\n	}\r\n	function get_dom(e){\r\n		return document.getElementById(e);\r\n	}\r\n	function set_height(){\r\n		var pc_height=window.innerHeight;\r\n		pc_height=pc_height-131;\r\n		get_dom(\'first_side_right\').style.height=(pc_height-31)+\'px\';\r\n		get_dom(\'second_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'four_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'input_note_text\').value=pc_height+\'px\';\r\n		get_dom(\'third_side_right\').style.height=(pc_height-15)+\'px\';\r\n		get_dom(\'fifth_side_right\').style.height=(pc_height-15)+\'px\';\r\n	}\r\n	set_height();\r\n	window.onresize=function(){\r\n		set_height();//pengchuan\r\n	}\r\n	function get_dom(e){\r\n		return document.getElementById(e);\r\n	}\r\n	function set_height(){\r\n		var pc_height=window.innerHeight;\r\n		pc_height=pc_height-131;\r\n		get_dom(\'first_side_right\').style.height=(pc_height-31)+\'px\';\r\n		get_dom(\'second_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'four_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'input_note_text\').value=pc_height+\'px\';\r\n		get_dom(\'third_side_right\').style.height=(pc_height-15)+\'px\';\r\n		get_dom(\'fifth_side_right\').style.height=(pc_height-15)+\'px\';\r\n	}\r\n	set_height();\r\n	window.onresize=function(){\r\n		set_height();//pengchuan\r\n	}\r\n	function get_dom(e){\r\n		return document.getElementById(e);\r\n	}\r\n	function set_height(){\r\n		var pc_height=window.innerHeight;\r\n		pc_height=pc_height-131;\r\n		get_dom(\'first_side_right\').style.height=(pc_height-31)+\'px\';\r\n		get_dom(\'second_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'four_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'input_note_text\').value=pc_height+\'px\';\r\n		get_dom(\'third_side_right\').style.height=(pc_height-15)+\'px\';\r\n		get_dom(\'fifth_side_right\').style.height=(pc_height-15)+\'px\';\r\n	}\r\n	set_height();\r\n	window.onresize=function(){\r\n		set_height();//pengchuan\r\n	}\r\n	function get_dom(e){\r\n		return document.getElementById(e);\r\n	}\r\n	function set_height(){\r\n		var pc_height=window.innerHeight;\r\n		pc_height=pc_height-131;\r\n		get_dom(\'first_side_right\').style.height=(pc_height-31)+\'px\';\r\n		get_dom(\'second_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'four_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'input_note_text\').value=pc_height+\'px\';\r\n		get_dom(\'third_side_right\').style.height=(pc_height-15)+\'px\';\r\n		get_dom(\'fifth_side_right\').style.height=(pc_height-15)+\'px\';\r\n	}\r\n	set_height();\r\n	window.onresize=function(){\r\n		set_height();//pengchuan\r\n	}\r\n	function get_dom(e){\r\n		return document.getElementById(e);\r\n	}\r\n	function set_height(){\r\n		var pc_height=window.innerHeight;\r\n		pc_height=pc_height-131;\r\n		get_dom(\'first_side_right\').style.height=(pc_height-31)+\'px\';\r\n		get_dom(\'second_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'four_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'input_note_text\').value=pc_height+\'px\';\r\n		get_dom(\'third_side_right\').style.height=(pc_height-15)+\'px\';\r\n		get_dom(\'fifth_side_right\').style.height=(pc_height-15)+\'px\';\r\n	}\r\n	set_height();\r\n	window.onresize=function(){\r\n		set_height();//pengchuan\r\n	}\r\n	function get_dom(e){\r\n		return document.getElementById(e);\r\n	}\r\n	function set_height(){\r\n		var pc_height=window.innerHeight;\r\n		pc_height=pc_height-131;\r\n		get_dom(\'first_side_right\').style.height=(pc_height-31)+\'px\';\r\n		get_dom(\'second_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'four_side_right\').style.height=pc_height+\'px\';\r\n		get_dom(\'input_note_text\').value=pc_height+\'px\';\r\n		get_dom(\'third_side_right\').style.height=(pc_height-15)+\'px\';\r\n		get_dom(\'fifth_side_right\').style.height=(pc_height-15)+\'px\';\r\n	}\r\n	set_height();\r\n	window.onresize=function(){\r\n		set_height();//pengchuan\r\n	}\r\n&lt;/script&gt;\r\n								</pre>');
INSERT INTO `cn_note_activity` VALUES ('ffdf744f-0845-49bf-b7b3-81b3cd622cf9', 'fa8d3d9d-2de5-4cfe-845f-951041bcc461', '9187ffd3-4c1e-4768-9f2f-c600e835b823', '0', '0', '测试笔记——2', '');
INSERT INTO `cn_note_activity` VALUES ('sssssssssssssssssssssssssssssss', '1', 'ce997ee1-0adf-4d71-9be9-fe32807c34fb', '0', '0', 'ssssssssssssssssssssssssssss', 'ssssssssssssssssssssss');
INSERT INTO `cn_note_activity` VALUES ('wwwwwwwwwwwwwwwwwww', '1', 'ce997ee1-0adf-4d71-9be9-fe32807c34fb', '0', '0', '我勒个去', '我勒个去~~~~~');
commit;

-- ----------------------------
-- Table structure for `cn_note_status`
-- ----------------------------
DROP TABLE IF EXISTS `cn_note_status`;
CREATE TABLE `cn_note_status` (
  `cn_note_status_id` varchar(100) binary NOT NULL COMMENT '笔记状态ID',
  `cn_note_status_code` varchar(100) binary DEFAULT NULL COMMENT '笔记状态Code',
  `cn_note_status_name` varchar(500) binary DEFAULT NULL COMMENT '笔记状态名字',
  PRIMARY KEY (`cn_note_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_note_status
-- ----------------------------
INSERT INTO `cn_note_status` VALUES ('1', 'normal', 'normal');
commit;

-- ----------------------------
-- Table structure for `cn_note_type`
-- ----------------------------
DROP TABLE IF EXISTS `cn_note_type`;
CREATE TABLE `cn_note_type` (
  `cn_note_type_id` varchar(100) binary NOT NULL COMMENT '笔记本类型ID',
  `cn_note_type_code` varchar(100) binary DEFAULT NULL COMMENT '笔记本类型Code',
  `cn_note_type_name` varchar(500) binary DEFAULT NULL COMMENT '笔记本类型名称',
  `cn_note_type_desc` text binary COMMENT '笔记本类型说明',
  PRIMARY KEY (`cn_note_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cn_note_type
-- ----------------------------
INSERT INTO `cn_note_type` VALUES ('1', 'normal', 'normal', null);
commit;