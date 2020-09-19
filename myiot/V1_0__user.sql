CREATE TABLE `ll_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户唯一id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `phone` varchar(16) DEFAULT NULL COMMENT '手机号码',
  `password` varchar(255) DEFAULT NULL COMMENT '登陆密码',
  `salt` varchar(255) DEFAULT NULL COMMENT '密码盐值',
  `user_name` varchar(64) DEFAULT NULL COMMENT '用户姓名',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户有效状态：【0：有效，1：失效】',
  PRIMARY KEY (`id`),
  UNIQUE KEY `amp_user_user_id_uindex` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';