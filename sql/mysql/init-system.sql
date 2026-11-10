-- 系统管理分支初始化脚本：仅用于新建空数据库，现有环境不需要重新导入。

SET NAMES utf8mb4;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS `infra_api_access_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT 0 COMMENT '用户类型',
  `application_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求方法名',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '请求地址',
  `request_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '请求参数',
  `response_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '响应结果',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
  `operate_module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作模块',
  `operate_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作名',
  `operate_type` tinyint NULL DEFAULT 0 COMMENT '操作分类',
  `begin_time` datetime NOT NULL COMMENT '开始请求时间',
  `end_time` datetime NOT NULL COMMENT '结束请求时间',
  `duration` int NOT NULL COMMENT '执行时长',
  `result_code` int NOT NULL DEFAULT 0 COMMENT '结果码',
  `result_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '结果提示',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41097 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'API 访问日志表';

CREATE TABLE IF NOT EXISTS `infra_api_error_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT 0 COMMENT '用户类型',
  `application_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求方法名',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求地址',
  `request_params` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求参数',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
  `exception_time` datetime NOT NULL COMMENT '异常发生时间',
  `exception_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '异常名',
  `exception_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的消息',
  `exception_root_cause_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常导致的根消息',
  `exception_stack_trace` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常的栈轨迹',
  `exception_class_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类全名',
  `exception_file_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的类文件',
  `exception_method_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异常发生的方法名',
  `exception_line_number` int NOT NULL COMMENT '异常发生的方法所在行',
  `process_status` tinyint NOT NULL COMMENT '处理状态',
  `process_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `process_user_id` int NULL DEFAULT 0 COMMENT '处理用户编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26879 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统异常日志';

CREATE TABLE IF NOT EXISTS `infra_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数分组',
  `type` tinyint NOT NULL COMMENT '参数类型',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键名',
  `value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数键值',
  `visible` bit(1) NOT NULL COMMENT '是否可见',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_config_key`(`config_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '参数配置表';

CREATE TABLE IF NOT EXISTS `infra_file`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件编号',
  `config_id` bigint NULL DEFAULT NULL COMMENT '配置编号',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名',
  `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  `url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件 URL',
  `type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` int NOT NULL COMMENT '文件大小',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2331 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件表';

CREATE TABLE IF NOT EXISTS `infra_file_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名',
  `storage` tinyint NOT NULL COMMENT '存储器',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `master` bit(1) NOT NULL COMMENT '是否为主配置',
  `config` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '存储配置',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件配置表';

CREATE TABLE IF NOT EXISTS `infra_file_content`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `config_id` bigint NOT NULL COMMENT '配置编号',
  `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件路径',
  `content` mediumblob NOT NULL COMMENT '文件内容',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_config_id_path`(`config_id` ASC, `path` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 304 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文件表';

CREATE TABLE IF NOT EXISTS `system_dept`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '部门名称',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父部门id',
  `sort` int NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `leader_user_id` bigint NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL COMMENT '部门状态（0正常 1停用）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 130 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '部门表';

CREATE TABLE IF NOT EXISTS `system_dict_data`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `sort` int NOT NULL DEFAULT 0 COMMENT '字典排序',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典标签',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态（0正常 1停用）',
  `color_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '颜色类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'css 样式',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3014 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典数据表';

CREATE TABLE IF NOT EXISTS `system_dict_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典名称',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '字典类型',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `deleted_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 628 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典类型表';

CREATE TABLE IF NOT EXISTS `system_login_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `log_type` bigint NOT NULL COMMENT '日志类型',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT 0 COMMENT '用户类型',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户账号',
  `result` tinyint NOT NULL COMMENT '登陆结果',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '浏览器 UA',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8722 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统访问记录';

CREATE TABLE IF NOT EXISTS `system_mail_account`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SMTP 服务器域名',
  `port` int NOT NULL COMMENT 'SMTP 服务器端口',
  `ssl_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 SSL',
  `starttls_enable` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开启 STARTTLS',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '邮箱账号表';

CREATE TABLE IF NOT EXISTS `system_mail_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户编号',
  `user_type` tinyint NULL DEFAULT NULL COMMENT '用户类型',
  `to_mails` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接收邮箱地址',
  `cc_mails` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '抄送邮箱地址',
  `bcc_mails` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密送邮箱地址',
  `account_id` bigint NOT NULL COMMENT '邮箱账号编号',
  `from_mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送邮箱地址',
  `template_id` bigint NOT NULL COMMENT '模板编号',
  `template_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模版发送人名称',
  `template_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件标题',
  `template_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件内容',
  `template_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮件参数',
  `send_status` tinyint NOT NULL DEFAULT 0 COMMENT '发送状态',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `send_message_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发送返回的消息 ID',
  `send_exception` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发送异常',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 368 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '邮件日志表';

CREATE TABLE IF NOT EXISTS `system_mail_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `account_id` bigint NOT NULL COMMENT '发送的邮箱账号编号',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发送人名称',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板标题',
  `content` varchar(10240) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板内容',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数数组',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '邮件模版表';

CREATE TABLE IF NOT EXISTS `system_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '权限标识',
  `type` tinyint NOT NULL COMMENT '菜单类型',
  `sort` int NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父菜单ID',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '路由地址',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件路径',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件名',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '菜单状态',
  `visible` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否可见',
  `keep_alive` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否缓存',
  `always_show` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否总是显示',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25344 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单权限表';

CREATE TABLE IF NOT EXISTS `system_notice`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告内容',
  `type` tinyint NOT NULL COMMENT '公告类型（1通知 2公告）',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '公告状态（0正常 1关闭）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '通知公告表';

CREATE TABLE IF NOT EXISTS `system_notify_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `template_id` bigint NOT NULL COMMENT '模版编号',
  `template_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_nickname` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版发送人名称',
  `template_content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
  `template_type` int NOT NULL COMMENT '模版类型',
  `template_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版参数',
  `read_status` bit(1) NOT NULL COMMENT '是否已读',
  `read_time` datetime NULL DEFAULT NULL COMMENT '阅读时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id_user_type_read_status`(`user_id` ASC, `user_type` ASC, `read_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '站内信消息表';

CREATE TABLE IF NOT EXISTS `system_notify_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版编码',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送人名称',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模版内容',
  `type` tinyint NOT NULL COMMENT '类型',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '参数数组',
  `status` tinyint NOT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1062150 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '站内信模板表';

CREATE TABLE IF NOT EXISTS `system_oauth2_access_token`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `user_info` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户信息',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '访问令牌',
  `refresh_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_access_token`(`access_token` ASC) USING BTREE,
  INDEX `idx_refresh_token`(`refresh_token` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 132260 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 访问令牌';

CREATE TABLE IF NOT EXISTS `system_oauth2_approve`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '授权范围',
  `approved` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否接受',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id_user_type_client_id`(`user_id` ASC, `user_type` ASC, `client_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 批准表';

CREATE TABLE IF NOT EXISTS `system_oauth2_client`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端密钥',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '应用描述',
  `status` tinyint NOT NULL COMMENT '状态',
  `access_token_validity_seconds` int NOT NULL COMMENT '访问令牌的有效期',
  `refresh_token_validity_seconds` int NOT NULL COMMENT '刷新令牌的有效期',
  `redirect_uris` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '可重定向的 URI 地址',
  `authorized_grant_types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权类型',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '授权范围',
  `auto_approve_scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自动通过的授权范围',
  `authorities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限',
  `resource_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '资源',
  `additional_information` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '附加信息',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_client_id`(`client_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 客户端表';

CREATE TABLE IF NOT EXISTS `system_oauth2_code`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授权码',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '可重定向的 URI 地址',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 授权码表';

CREATE TABLE IF NOT EXISTS `system_oauth2_refresh_token`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `refresh_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '刷新令牌',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '授权范围',
  `expires_time` datetime NOT NULL COMMENT '过期时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_refresh_token`(`refresh_token` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6582 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'OAuth2 刷新令牌';

CREATE TABLE IF NOT EXISTS `system_operate_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `trace_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '链路追踪编号',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL DEFAULT 0 COMMENT '用户类型',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作模块类型',
  `sub_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作名',
  `biz_id` bigint NOT NULL COMMENT '操作数据模块编号',
  `action` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作内容',
  `success` bit(1) NOT NULL DEFAULT b'1' COMMENT '操作结果',
  `extra` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '拓展字段',
  `request_method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '请求方法名',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '请求地址',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户 IP',
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '浏览器 UA',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10119 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作日志记录 V2 版本';

CREATE TABLE IF NOT EXISTS `system_post`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
  `sort` int NOT NULL COMMENT '显示顺序',
  `status` tinyint NOT NULL COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '岗位信息表';

CREATE TABLE IF NOT EXISTS `system_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
  `sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` tinyint NOT NULL DEFAULT 1 COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `data_scope_dept_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据范围(指定部门数组)',
  `status` tinyint NOT NULL COMMENT '角色状态（0正常 1停用）',
  `type` tinyint NOT NULL COMMENT '角色类型',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 214 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色信息表';

CREATE TABLE IF NOT EXISTS `system_role_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12203 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色和菜单关联表';

CREATE TABLE IF NOT EXISTS `system_sms_channel`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `signature` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信签名',
  `code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '渠道编码',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `api_key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的账号',
  `api_secret` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '短信 API 的秘钥',
  `callback_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '短信发送回调 URL',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '短信渠道';

CREATE TABLE IF NOT EXISTS `system_sms_code`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '验证码',
  `create_ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建 IP',
  `scene` tinyint NOT NULL COMMENT '发送场景',
  `today_index` tinyint NOT NULL COMMENT '今日发送的第几条',
  `used` tinyint NOT NULL COMMENT '是否使用',
  `used_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  `used_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '使用 IP',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_mobile`(`mobile` ASC) USING BTREE COMMENT '手机号'
) ENGINE = InnoDB AUTO_INCREMENT = 698 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '手机验证码';

CREATE TABLE IF NOT EXISTS `system_sms_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `channel_id` bigint NOT NULL COMMENT '短信渠道编号',
  `channel_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信渠道编码',
  `template_id` bigint NOT NULL COMMENT '模板编号',
  `template_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `template_type` tinyint NOT NULL COMMENT '短信类型',
  `template_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信内容',
  `template_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信参数',
  `api_template_id` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的模板编号',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户编号',
  `user_type` tinyint NULL DEFAULT NULL COMMENT '用户类型',
  `send_status` tinyint NOT NULL DEFAULT 0 COMMENT '发送状态',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `api_send_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '短信 API 发送结果的编码',
  `api_send_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '短信 API 发送失败的提示',
  `api_request_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '短信 API 发送返回的唯一请求 ID',
  `api_serial_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '短信 API 发送返回的序号',
  `receive_status` tinyint NOT NULL DEFAULT 0 COMMENT '接收状态',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '接收时间',
  `api_receive_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'API 接收结果的编码',
  `api_receive_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'API 接收结果的说明',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1642 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '短信日志';

CREATE TABLE IF NOT EXISTS `system_sms_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` tinyint NOT NULL COMMENT '模板类型',
  `status` tinyint NOT NULL COMMENT '开启状态',
  `code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板编码',
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模板内容',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数数组',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `api_template_id` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信 API 的模板编号',
  `channel_id` bigint NOT NULL COMMENT '短信渠道编号',
  `channel_code` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '短信渠道编码',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '短信模板';

CREATE TABLE IF NOT EXISTS `system_social_client`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名',
  `social_type` tinyint NOT NULL COMMENT '社交平台的类型',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端编号',
  `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端密钥',
  `agent_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '代理编号',
  `public_key` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'publicKey 公钥',
  `status` tinyint NOT NULL COMMENT '状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社交客户端表';

CREATE TABLE IF NOT EXISTS `system_social_user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
  `type` tinyint NOT NULL COMMENT '社交平台的类型',
  `openid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '社交 openid',
  `token` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '社交 token',
  `raw_token_info` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始 Token 数据，一般是 JSON 格式',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像',
  `raw_user_info` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '原始用户数据，一般是 JSON 格式',
  `code` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '最后一次的认证 code',
  `state` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后一次的认证 state',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_type_openid`(`type` ASC, `openid` ASC) USING BTREE,
  INDEX `idx_type_code_state`(`type` ASC, `code` ASC, `state` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社交用户表';

CREATE TABLE IF NOT EXISTS `system_social_user_bind`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键(自增策略)',
  `user_id` bigint NOT NULL COMMENT '用户编号',
  `user_type` tinyint NOT NULL COMMENT '用户类型',
  `social_type` tinyint NOT NULL COMMENT '社交平台的类型',
  `social_user_id` bigint NOT NULL COMMENT '社交用户的编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_type_social_user_id`(`user_type` ASC, `social_user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 165 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '社交绑定表';

CREATE TABLE IF NOT EXISTS `system_tenant`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '租户编号',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '租户名',
  `contact_user_id` bigint NULL DEFAULT NULL COMMENT '联系人的用户编号',
  `contact_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人',
  `contact_mobile` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系手机',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '租户状态',
  `websites` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '绑定域名数组',
  `package_id` bigint NOT NULL COMMENT '租户套餐编号',
  `expire_time` datetime NOT NULL COMMENT '过期时间',
  `account_count` int NOT NULL COMMENT '账号数量',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 166 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '租户表';

CREATE TABLE IF NOT EXISTS `system_tenant_package`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '套餐名',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '租户状态（0正常 1停用）',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '备注',
  `menu_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联的菜单编号',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '租户套餐表';

CREATE TABLE IF NOT EXISTS `system_user_post`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户ID',
  `post_id` bigint NOT NULL DEFAULT 0 COMMENT '岗位ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 130 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户岗位表';

CREATE TABLE IF NOT EXISTS `system_user_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 125 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户和角色关联表';

CREATE TABLE IF NOT EXISTS `system_users`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `nickname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `post_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '岗位编号数组',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` tinyint NULL DEFAULT 0 COMMENT '用户性别',
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '头像地址',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '帐号状态（0正常 1停用）',
  `login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE,
  INDEX `idx_mobile`(`mobile` ASC) USING BTREE,
  INDEX `idx_email`(`email` ASC) USING BTREE,
  INDEX `idx_dept_id`(`dept_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 283 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表';

START TRANSACTION;

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 'biz', 1, '用户管理-账号初始密码', 'system.user.init-password', '123456', b'0', '初始化密码 123456', 'admin', '2021-01-05 17:03:48', '1', '2024-07-20 17:22:47', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (7, 'url', 2, 'MySQL 监控的地址', 'url.druid', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:33:38', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (8, 'url', 2, 'SkyWalking 监控的地址', 'url.skywalking', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:57:03', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (9, 'url', 2, 'Spring Boot Admin 监控的地址', 'url.spring-boot-admin', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:52:07', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (10, 'url', 2, 'Swagger 接口文档的地址', 'url.swagger', '', b'1', '', '1', '2023-04-07 13:41:16', '1', '2023-04-07 14:59:00', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (12, 'test2', 2, 'test3', 'test4', 'test5', b'1', 'test6', '1', '2023-12-03 09:55:16', '1', '2025-04-06 21:00:09', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (13, '用户管理-账号初始密码', 2, '用户管理-注册开关', 'system.user.register-enabled', 'true', b'0', '', '1', '2025-04-26 17:23:41', '1', '2025-04-26 17:23:41', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (14, 'eam', 2, 'EAM 采购申请业务编号', 'eam.businessCode.purchaseApply', '${string_fix,APA}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_purchase_apply 业务编号规则', '0', '2026-09-23 12:53:11', '0', '2026-09-23 12:53:11', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (15, 'eam', 2, 'EAM 采购验收业务编号', 'eam.businessCode.purchaseCheck', '${string_fix,AC}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_purchase_check 业务编号规则', '0', '2026-09-23 12:53:11', '0', '2026-09-23 12:53:11', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (16, 'eam', 2, 'EAM 采购清单业务编号', 'eam.businessCode.purchaseOrder', '${string_fix,POD}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_purchase_order 业务编号规则', '0', '2026-09-23 12:53:11', '0', '2026-09-23 12:53:11', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (17, 'eam', 2, 'EAM 库存物品入库业务编号', 'eam.businessCode.stockGoodsIn', '${string_fix,SGI}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_stock_goods_in 业务编号规则', '0', '2026-09-23 12:53:11', '0', '2026-09-23 12:53:11', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (18, 'eam', 2, 'EAM 折旧使用期限来源', 'eam.assetServiceLifeValueSource', 'finance', b'0', 'asset 使用资产期限；finance 使用资产财务分类期限', '0', '2026-09-23 12:53:11', '0', '2026-09-23 12:53:11', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (20, 'eam', 2, 'EAM 保养项目编号', 'eam.businessCode.maintainProject', '${string_fix,MPJ}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_maintain_project 业务编号规则', '0', '2026-09-23 23:11:22', '0', '2026-09-23 23:11:22', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (21, 'eam', 2, 'EAM 保养计划编号', 'eam.businessCode.maintainPlan', '${string_fix,MP}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_maintain_plan 业务编号规则', '0', '2026-09-23 23:50:51', '0', '2026-09-23 23:50:51', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (22, 'eam', 2, 'EAM 库存物品出库业务编号', 'eam.businessCode.stockGoodsOut', '${string_fix,SGO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_stock_goods_out 业务编号规则', '0', '2026-09-24 01:30:50', '0', '2026-09-24 01:30:50', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (23, 'eam', 2, 'EAM 备件出库业务编号', 'eam.businessCode.partGoodsOut', '${string_fix,PO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_part_goods_out 业务编号规则', '0', '2026-09-24 01:30:50', '0', '2026-09-24 01:30:50', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (24, 'eam', 2, 'EAM 耗材出库业务编号', 'eam.businessCode.consumablesGoodsOut', '${string_fix,HCO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_consumables_deliver 业务编号规则', '0', '2026-09-24 01:30:50', '0', '2026-09-24 01:30:50', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (25, 'eam', 2, 'EAM å¤‡ä»¶å…¥åº“ä¸šåŠ¡ç¼–å·', 'eam.businessCode.partGoodsIn', '${string_fix,PI}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', 'æº eam_asset_part_goods_in ä¸šåŠ¡ç¼–å·è§„åˆ™', '0', '2026-09-24 16:31:46', '0', '2026-09-24 16:31:46', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (26, 'eam', 2, 'EAM è€—æå…¥åº“ä¸šåŠ¡ç¼–å·', 'eam.businessCode.consumablesGoodsIn', '${string_fix,HCI}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', 'æº eam_asset_consumables_stock_in ä¸šåŠ¡ç¼–å·è§„åˆ™', '0', '2026-09-24 16:31:46', '0', '2026-09-24 16:31:46', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (27, 'eam', 2, 'EAM 资产盘点业务编号', 'eam.businessCode.assetInventory', '${string_fix,ASI}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_inventory 业务编号规则', '0', '2026-09-24 22:58:25', '0', '2026-09-24 22:58:25', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (28, 'eam', 2, 'EAM 资产借用归还业务编号', 'eam.businessCode.assetBorrowReturn', '${string_fix,BR}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_borrow_return 业务编号规则', '0', '2026-09-25 00:52:42', '0', '2026-09-25 00:52:42', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (29, 'eam', 2, 'EAM 资产借用业务编号', 'eam.businessCode.assetBorrow', '${string_fix,BO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_borrow 业务编号规则', '0', '2026-09-25 01:33:11', '0', '2026-09-25 01:33:11', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (30, 'eam', 2, 'EAM 软件资产登记业务编号', 'eam.businessCode.assetSoftware', '${string_fix,SW}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_software_insert 业务编号规则', '0', '2026-09-25 02:51:00', '0', '2026-09-25 02:51:00', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (31, 'eam', 2, 'EAM 软件分发业务编号', 'eam.businessCode.assetSoftwareDistribute', '${string_fix,ASD}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_software_distribute 业务编号规则', '0', '2026-09-25 03:24:09', '0', '2026-09-25 03:24:09', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (32, 'eam', 2, 'EAM 软件变更业务编号', 'eam.businessCode.assetSoftwareChange', '${string_fix,ASC}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_software_change 业务编号规则', '0', '2026-09-25 03:42:43', '0', '2026-09-25 03:42:43', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (33, 'eam', 2, 'EAM 软件维保业务编号', 'eam.businessCode.assetSoftwareMaintenance', '${string_fix,ASWB}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_software_maintenance 业务编号规则', '0', '2026-09-25 04:04:17', '0', '2026-09-25 04:04:17', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (34, 'eam', 2, 'EAM 保养任务编号', 'eam.businessCode.maintainTask', '${string_fix,MT}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_maintain_task 业务编号规则', '0', '2026-09-25 05:27:56', '0', '2026-09-25 05:27:56', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (35, 'eam', 2, 'EAM èµ„äº§è½¬ç§»ä¸šåŠ¡ç¼–å·', 'eam.businessCode.assetTransfer', '${string_fix,BO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', 'æºèµ„äº§è½¬ç§»åˆ›å»ºå®žé™…å¤ç”¨èµ„äº§å€Ÿç”¨ BO ç¼–å·è§„åˆ™', '0', '2026-09-26 17:59:37', '0', '2026-09-26 17:59:37', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (36, 'eam', 2, 'EAM 默认资产标签', 'eam.labelMethod', 'spec_normal_1', b'0', '源 sys_config 默认标签；专用标签配置见 eam-label-data.sql', '0', '2026-09-27 20:27:57', '0', '2026-09-27 20:27:57', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (37, 'eam', 2, 'EAM 默认资产卡片', 'eam.cardMethod', 'asset_card_1', b'0', '源 sys_config 默认资产卡片，单项资产打印', '0', '2026-09-27 20:48:33', '0', '2026-09-27 20:48:33', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (38, 'eam', 2, 'EAM 资产领用业务编号', 'eam.businessCode.assetCollection', '${string_fix,CO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}${number_seq,5,asset}', b'0', '源 eam_asset_collection 业务编号规则', '0', '2026-09-28 01:47:26', '0', '2026-09-28 01:47:26', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (39, 'eam', 2, 'EAM 资产自动编码', 'eam.assetCodeAutoCreate', '1', b'0', '源资产编码开关：1 开启，其他值关闭', '0', '2026-09-28 08:04:36', '0', '2026-09-28 08:04:36', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (40, 'eam', 2, 'EAM 资产编码规则', 'eam.businessCode.assetCode', '${string_fix,AS}${number_seq_relation,6,asset}', b'0', '源 eam_asset_code 规则；已存在的 asset 序列保留原位数', '0', '2026-09-28 08:04:36', '0', '2026-09-28 08:04:36', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (41, 'eam', 2, 'EAM 库存物品调整业务编号', 'eam.businessCode.stockGoodsAdjust', '${string_fix,SGA}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_stock_goods_adjust 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (42, 'eam', 2, 'EAM 备件调整业务编号', 'eam.businessCode.partGoodsAdjust', '${string_fix,PAD}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_part_goods_adjust 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (43, 'eam', 2, 'EAM 耗材调整业务编号', 'eam.businessCode.consumablesGoodsAdjust', '${string_fix,HCD}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_consumables_allocate 业务编号规则；目标 ownerType=consumables 调整沿用 HCD', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (44, 'eam', 2, 'EAM 库存物品调拨业务编号', 'eam.businessCode.stockGoodsTransfer', '${string_fix,SGT}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_stock_goods_tranfer 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (45, 'eam', 2, 'EAM 备件调拨业务编号', 'eam.businessCode.partGoodsTransfer', '${string_fix,PTR}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_part_goods_tranfer 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (46, 'eam', 2, 'EAM 耗材调拨业务编号', 'eam.businessCode.consumablesGoodsTransfer', '${string_fix,HCTR}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_consumables_tranfer 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (47, 'eam', 2, 'EAM 员工资产报失业务编号', 'eam.businessCode.assetEmployeeLoss', '${string_fix,EO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_employee_loss 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (48, 'eam', 2, 'EAM 员工资产领用申请业务编号', 'eam.businessCode.assetEmployeeApply', '${string_fix,EO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_employee_apply 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (49, 'eam', 2, 'EAM 员工资产报修业务编号', 'eam.businessCode.assetEmployeeRepair', '${string_fix,EO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_employee_repair 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (50, 'eam', 2, 'EAM 员工资产交接业务编号', 'eam.businessCode.assetEmployeeHandover', '${string_fix,EO}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_employee_handover 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (51, 'eam', 2, 'EAM 资产报修业务编号', 'eam.businessCode.assetRepair', '${string_fix,RE}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_repair 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (52, 'eam', 2, 'EAM 故障登记业务编号', 'eam.businessCode.assetFailureRegistration', '${string_fix,EF}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_equipment_failure_registration 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (53, 'eam', 2, 'EAM_财务变更业务编号', 'eam.businessCode.assetChangeFinancial', '${string_fix,CHF}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_change_financial 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (54, 'eam', 2, 'EAM_基本变更业务编号', 'eam.businessCode.assetChangeBaseInfo', '${string_fix,CHB}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_change_base_info 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (55, 'eam', 2, 'EAM_维保变更业务编号', 'eam.businessCode.assetChangeMaintenance', '${string_fix,CHM}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_change_maintenance 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (56, 'eam', 2, 'EAM 物品档案编码', 'eam.businessCode.goodsProfileCode', '${string_fix,GS}${number_seq,5}', b'0', '物品档案编码与条码共用编号', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (57, 'EAM', 2, '物品档案编码自动填充', 'eam.goodsCodeAutoFill', '0', b'1', '0手工填写，1自动填充编码和条码', '', '2026-10-06 12:21:19', '', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (58, 'eam', 2, 'EAM 资产报废业务编号', 'eam.businessCode.assetScrap', '${string_fix,SC}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '资产报废 SC 编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (59, 'eam', 2, 'EAM 资产调拨业务编号', 'eam.businessCode.assetAllocation', '${string_fix,AL}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '资产调拨业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (60, 'eam', 2, 'EAM 资产退库业务编号', 'eam.businessCode.assetCollectionReturn', '${string_fix,RE}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '资产退库业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (61, 'eam', 2, 'EAM 通用业务编号', 'eam.businessCode.commonCode', '${string_fix,C}${number_rand,6}', b'0', '通用业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (62, 'eam', 2, 'EAM 维修申请编号', 'eam.businessCode.repairOrder', '${string_fix,ROD}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '维修申请业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (63, 'eam', 2, 'EAM 维修工单执行编号', 'eam.businessCode.repairOrderAct', '${string_fix,MOD}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '源 eam_asset_repair_order_act 业务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (64, 'eam', 2, 'EAM 巡检计划编号', 'eam.businessCode.inspectionPlan', '${string_fix,INSP}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '巡检计划编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (65, 'eam', 2, 'EAM 巡检任务编号', 'eam.businessCode.inspectionTask', '${string_fix,INSPT}${time,yyyy}${time,mm}${time,dd}${time,hh}${time,mm}${number_rand,3}', b'0', '巡检任务编号规则', '0', '2026-10-06 12:21:19', '0', '2026-10-06 12:21:19', b'0');

INSERT IGNORE INTO `infra_config` (`id`, `category`, `type`, `name`, `config_key`, `value`, `visible`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (66, 'ai2', 1, 'AI2 工作流节点连接模式', 'ai2.workflow.connection-mode', 'whitelist', b'1', 'whitelist 白名单：仅允许“允许连接”规则中的节点对；blacklist 黑名单：仅禁止“禁止连接”规则中的节点对', '', '2026-10-07 03:22:50', '', '2026-10-07 03:22:50', b'0');

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (100, '安天源码', 0, 0, 1, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2026-01-04 18:01:12', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (101, '深圳总公司', 100, 1, 104, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2025-03-29 15:49:55', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (102, '长沙分公司', 100, 2, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '', '2021-12-15 05:01:40', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (103, '研发部门', 101, 1, 104, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2026-01-04 18:01:24', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (104, '市场部门', 101, 2, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '', '2021-12-15 05:01:38', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (105, '测试部门', 101, 3, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2022-05-16 20:25:15', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (106, '财务部门', 101, 4, 103, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '103', '2022-01-15 21:32:22', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (107, '运维部门', 101, 5, 1, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2023-12-02 09:28:22', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (108, '市场部门', 102, 1, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '1', '2022-02-16 08:35:45', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (109, '财务部门', 102, 2, NULL, '15888888888', 'ry@qq.com', 0, 'admin', '2021-01-05 17:03:47', '', '2021-12-15 05:01:29', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (110, '新部门', 0, 1, NULL, NULL, NULL, 0, '110', '2022-02-23 20:46:30', '110', '2022-02-23 20:46:30', b'0', 121);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (111, '顶级部门', 0, 1, NULL, NULL, NULL, 0, '113', '2022-03-07 21:44:50', '113', '2022-03-07 21:44:50', b'0', 122);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (112, '产品部门', 101, 100, 1, NULL, NULL, 1, '1', '2023-12-02 09:45:13', '1', '2023-12-02 09:45:31', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (113, '支持部门', 102, 3, 104, NULL, NULL, 1, '1', '2023-12-02 09:47:38', '1', '2025-03-29 15:00:56', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (116, '某个子部门', 0, 1, NULL, NULL, NULL, 0, '1', '2025-12-08 14:51:12', '1', '2025-12-08 14:51:12', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (117, '某个子部门 2', 0, 2, NULL, NULL, NULL, 0, '1', '2025-12-08 14:51:25', '1', '2025-12-08 14:51:25', b'0', 1);

INSERT IGNORE INTO `system_dept` (`id`, `name`, `parent_id`, `sort`, `leader_user_id`, `phone`, `email`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (125, '领用验证部门', 0, 0, NULL, NULL, NULL, 0, '', '2026-10-08 02:21:33', '', '2026-10-08 02:21:33', b'0', 165);

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, 1, '男', '1', 'system_user_sex', 0, 'primary', 'A', '性别男', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 2, '女', '2', 'system_user_sex', 0, 'success', '', '性别女', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3, 1, '正常', '1', 'infra_job_status', 0, 'success', '', '正常状态', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (4, 2, '暂停', '2', 'infra_job_status', 0, 'danger', '', '停用状态', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (5, 1, '系统内置', '1', 'infra_config_type', 0, 'danger', '', '参数类型 - 系统内置', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (6, 2, '自定义', '2', 'infra_config_type', 0, 'primary', '', '参数类型 - 自定义', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (7, 1, '通知', '1', 'system_notice_type', 0, 'success', '', '通知', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (8, 2, '公告', '2', 'system_notice_type', 0, 'info', '', '公告', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (9, 0, '其它', '0', 'infra_operate_type', 0, 'default', '', '其它操作', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (10, 1, '查询', '1', 'infra_operate_type', 0, 'info', '', '查询操作', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (11, 2, '新增', '2', 'infra_operate_type', 0, 'primary', '', '新增操作', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (12, 3, '修改', '3', 'infra_operate_type', 0, 'warning', '', '修改操作', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (13, 4, '删除', '4', 'infra_operate_type', 0, 'danger', '', '删除操作', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (14, 5, '导出', '5', 'infra_operate_type', 0, 'default', '', '导出操作', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (15, 6, '导入', '6', 'infra_operate_type', 0, 'default', '', '导入操作', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (16, 1, '开启', '0', 'common_status', 0, 'primary', '', '开启状态', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (17, 2, '关闭', '1', 'common_status', 0, 'info', '', '关闭状态', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (18, 1, '目录', '1', 'system_menu_type', 0, '', '', '目录', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (19, 2, '菜单', '2', 'system_menu_type', 0, '', '', '菜单', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (20, 3, '按钮', '3', 'system_menu_type', 0, '', '', '按钮', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (21, 1, '内置', '1', 'system_role_type', 0, 'danger', '', '内置角色', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (22, 2, '自定义', '2', 'system_role_type', 0, 'primary', '', '自定义角色', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (23, 1, '全部数据权限', '1', 'system_data_scope', 0, '', '', '全部数据权限', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (24, 2, '指定部门数据权限', '2', 'system_data_scope', 0, '', '', '指定部门数据权限', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (25, 3, '本部门数据权限', '3', 'system_data_scope', 0, '', '', '本部门数据权限', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (26, 4, '本部门及以下数据权限', '4', 'system_data_scope', 0, '', '', '本部门及以下数据权限', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (27, 5, '仅本人数据权限', '5', 'system_data_scope', 0, '', '', '仅本人数据权限', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (28, 0, '成功', '0', 'system_login_result', 0, 'success', '', '登陆结果 - 成功', '', '2021-01-18 06:17:36', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (29, 10, '账号或密码不正确', '10', 'system_login_result', 0, 'primary', '', '登陆结果 - 账号或密码不正确', '', '2021-01-18 06:17:54', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (30, 20, '用户被禁用', '20', 'system_login_result', 0, 'warning', '', '登陆结果 - 用户被禁用', '', '2021-01-18 06:17:54', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (31, 30, '验证码不存在', '30', 'system_login_result', 0, 'info', '', '登陆结果 - 验证码不存在', '', '2021-01-18 06:17:54', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (32, 31, '验证码不正确', '31', 'system_login_result', 0, 'info', '', '登陆结果 - 验证码不正确', '', '2021-01-18 06:17:54', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (33, 100, '未知异常', '100', 'system_login_result', 0, 'danger', '', '登陆结果 - 未知异常', '', '2021-01-18 06:17:54', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (34, 1, '是', 'true', 'infra_boolean_string', 0, 'danger', '', 'Boolean 是否类型 - 是', '', '2021-01-19 03:20:55', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (35, 1, '否', 'false', 'infra_boolean_string', 0, 'info', '', 'Boolean 是否类型 - 否', '', '2021-01-19 03:20:55', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (36, 1, '单表（增删改查）', '1', 'infra_codegen_template_type', 0, '', '', NULL, '', '2021-02-05 07:09:06', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (37, 2, '树表（增删改查）', '2', 'infra_codegen_template_type', 0, '', '', NULL, '', '2021-02-05 07:14:46', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (38, 0, '初始化中', '0', 'infra_job_status', 0, 'primary', '', NULL, '', '2021-02-07 07:46:49', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (39, 0, '运行中', '0', 'infra_job_log_status', 0, 'primary', '', 'RUNNING', '', '2021-02-08 10:04:24', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (40, 1, '成功', '1', 'infra_job_log_status', 0, 'success', '', NULL, '', '2021-02-08 10:06:57', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (41, 2, '失败', '2', 'infra_job_log_status', 0, 'warning', '', '失败', '', '2021-02-08 10:07:38', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (42, 1, '会员', '1', 'user_type', 0, 'primary', '', NULL, '', '2021-02-26 00:16:27', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (43, 2, '管理员', '2', 'user_type', 0, 'success', '', NULL, '', '2021-02-26 00:16:34', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (44, 0, '未处理', '0', 'infra_api_error_log_process_status', 0, 'primary', '', NULL, '', '2021-02-26 07:07:19', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (45, 1, '已处理', '1', 'infra_api_error_log_process_status', 0, 'success', '', NULL, '', '2021-02-26 07:07:26', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (46, 2, '已忽略', '2', 'infra_api_error_log_process_status', 0, 'danger', '', NULL, '', '2021-02-26 07:07:34', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (47, 1, '阿里云', 'ALIYUN', 'system_sms_channel_code', 0, 'primary', '', NULL, '1', '2021-04-05 01:05:26', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (48, 1, '验证码', '1', 'system_sms_template_type', 0, 'warning', '', NULL, '1', '2021-04-05 21:50:57', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (49, 2, '通知', '2', 'system_sms_template_type', 0, 'primary', '', NULL, '1', '2021-04-05 21:51:08', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (50, 0, '营销', '3', 'system_sms_template_type', 0, 'danger', '', NULL, '1', '2021-04-05 21:51:15', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (51, 0, '初始化', '0', 'system_sms_send_status', 0, 'primary', '', NULL, '1', '2021-04-11 20:18:33', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (52, 1, '发送成功', '10', 'system_sms_send_status', 0, 'success', '', NULL, '1', '2021-04-11 20:18:43', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (53, 2, '发送失败', '20', 'system_sms_send_status', 0, 'danger', '', NULL, '1', '2021-04-11 20:18:49', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (54, 3, '不发送', '30', 'system_sms_send_status', 0, 'info', '', NULL, '1', '2021-04-11 20:19:44', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (55, 0, '等待结果', '0', 'system_sms_receive_status', 0, 'primary', '', NULL, '1', '2021-04-11 20:27:43', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (56, 1, '接收成功', '10', 'system_sms_receive_status', 0, 'success', '', NULL, '1', '2021-04-11 20:29:25', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (57, 2, '接收失败', '20', 'system_sms_receive_status', 0, 'danger', '', NULL, '1', '2021-04-11 20:29:31', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (58, 0, '调试(钉钉)', 'DEBUG_DING_TALK', 'system_sms_channel_code', 0, 'info', '', NULL, '1', '2021-04-13 00:20:37', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (59, 100, '账号登录', '100', 'system_login_type', 0, 'primary', '', '账号登录', '1', '2021-10-06 00:52:02', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (60, 101, '社交登录', '101', 'system_login_type', 0, 'info', '', '社交登录', '1', '2021-10-06 00:52:17', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (61, 200, '主动登出', '200', 'system_login_type', 0, 'primary', '', '主动登出', '1', '2021-10-06 00:52:58', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (62, 202, '强制登出', '202', 'system_login_type', 0, 'danger', '', '强制退出', '1', '2021-10-06 00:53:41', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (80, 5, '首页', '1', 'promotion_banner_position', 0, 'warning', '', '', '1', '2023-10-11 07:45:24', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (81, 4, '秒杀活动页', '2', 'promotion_banner_position', 0, 'warning', '', '', '1', '2023-10-11 07:45:24', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (82, 3, '砍价活动页', '3', 'promotion_banner_position', 0, 'warning', '', '', '1', '2023-10-11 07:45:24', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (83, 2, '限时折扣页', '4', 'promotion_banner_position', 0, 'warning', '', '', '1', '2023-10-11 07:45:24', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (84, 1, '满减送页', '5', 'promotion_banner_position', 0, 'warning', '', '', '1', '2023-10-11 07:45:24', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (103, 1, '管理后台', '1', 'infra_codegen_scene', 0, '', '', '代码生成的场景枚举 - 管理后台', '1', '2022-02-02 13:15:06', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (104, 2, '用户 APP', '2', 'infra_codegen_scene', 0, '', '', '代码生成的场景枚举 - 用户 APP', '1', '2022-02-02 13:15:19', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (105, 1, '数据库', '1', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:25:28', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (106, 10, '本地磁盘', '10', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:25:41', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (107, 11, 'FTP 服务器', '11', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:26:06', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (108, 12, 'SFTP 服务器', '12', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:26:22', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (109, 20, 'S3 对象存储', '20', 'infra_file_storage', 0, 'default', '', NULL, '1', '2022-03-15 00:26:31', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (110, 103, '短信登录', '103', 'system_login_type', 0, 'default', '', NULL, '1', '2022-05-09 23:57:58', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (111, 1, 'password', 'password', 'system_oauth2_grant_type', 0, 'default', '', '密码模式', '1', '2022-05-12 00:22:05', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (112, 2, 'authorization_code', 'authorization_code', 'system_oauth2_grant_type', 0, 'primary', '', '授权码模式', '1', '2022-05-12 00:22:59', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (113, 3, 'implicit', 'implicit', 'system_oauth2_grant_type', 0, 'success', '', '简化模式', '1', '2022-05-12 00:23:40', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (114, 4, 'client_credentials', 'client_credentials', 'system_oauth2_grant_type', 0, 'default', '', '客户端模式', '1', '2022-05-12 00:23:51', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (115, 5, 'refresh_token', 'refresh_token', 'system_oauth2_grant_type', 0, 'info', '', '刷新模式', '1', '2022-05-12 00:24:02', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (116, 1, '销售中', '1', 'product_spu_status', 0, 'success', '', '商品 SPU 状态 - 销售中', '1', '2022-10-24 21:19:47', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (117, 0, '仓库中', '0', 'product_spu_status', 0, 'info', '', '商品 SPU 状态 - 仓库中', '1', '2022-10-24 21:20:54', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (118, 0, '回收站', '-1', 'product_spu_status', 0, 'default', '', '商品 SPU 状态 - 回收站', '1', '2022-10-24 21:21:11', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (119, 1, '满减', '1', 'promotion_discount_type', 0, 'success', '', '优惠类型 - 满减', '1', '2022-11-01 12:46:41', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (120, 2, '折扣', '2', 'promotion_discount_type', 0, 'primary', '', '优惠类型 - 折扣', '1', '2022-11-01 12:46:51', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (121, 1, '固定日期', '1', 'promotion_coupon_template_validity_type', 0, 'default', '', '优惠劵模板的有限期类型 - 固定日期', '1', '2022-11-02 00:07:34', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (122, 2, '领取之后', '2', 'promotion_coupon_template_validity_type', 0, 'default', '', '优惠劵模板的有限期类型 - 领取之后', '1', '2022-11-02 00:07:54', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (123, 1, '通用劵', '1', 'promotion_product_scope', 0, 'default', '', '营销的商品范围 - 全部商品参与', '1', '2022-11-02 00:28:22', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (124, 2, '商品劵', '2', 'promotion_product_scope', 0, 'default', '', '营销的商品范围 - 指定商品参与', '1', '2022-11-02 00:28:34', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (125, 1, '未使用', '1', 'promotion_coupon_status', 0, 'primary', '', '优惠劵的状态 - 已领取', '1', '2022-11-04 00:15:08', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (126, 2, '已使用', '2', 'promotion_coupon_status', 0, 'success', '', '优惠劵的状态 - 已使用', '1', '2022-11-04 00:15:21', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (127, 3, '已过期', '3', 'promotion_coupon_status', 0, 'info', '', '优惠劵的状态 - 已过期', '1', '2022-11-04 00:15:43', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (128, 1, '直接领取', '1', 'promotion_coupon_take_type', 0, 'primary', '', '优惠劵的领取方式 - 直接领取', '1', '2022-11-04 19:13:00', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (129, 2, '指定发放', '2', 'promotion_coupon_take_type', 0, 'success', '', '优惠劵的领取方式 - 指定发放', '1', '2022-11-04 19:13:13', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (130, 10, '未开始', '10', 'promotion_activity_status', 0, 'primary', '', '促销活动的状态枚举 - 未开始', '1', '2022-11-04 22:54:49', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (131, 20, '进行中', '20', 'promotion_activity_status', 0, 'success', '', '促销活动的状态枚举 - 进行中', '1', '2022-11-04 22:55:06', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (132, 30, '已结束', '30', 'promotion_activity_status', 0, 'info', '', '促销活动的状态枚举 - 已结束', '1', '2022-11-04 22:55:41', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (133, 40, '已关闭', '40', 'promotion_activity_status', 0, 'warning', '', '促销活动的状态枚举 - 已关闭', '1', '2022-11-04 22:56:10', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (134, 10, '满 N 元', '10', 'promotion_condition_type', 0, 'primary', '', '营销的条件类型 - 满 N 元', '1', '2022-11-04 22:59:45', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (135, 20, '满 N 件', '20', 'promotion_condition_type', 0, 'success', '', '营销的条件类型 - 满 N 件', '1', '2022-11-04 23:00:02', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (136, 10, '申请售后', '10', 'trade_after_sale_status', 0, 'primary', '', '交易售后状态 - 申请售后', '1', '2022-11-19 20:53:33', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (137, 20, '商品待退货', '20', 'trade_after_sale_status', 0, 'primary', '', '交易售后状态 - 商品待退货', '1', '2022-11-19 20:54:36', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (138, 30, '商家待收货', '30', 'trade_after_sale_status', 0, 'primary', '', '交易售后状态 - 商家待收货', '1', '2022-11-19 20:56:56', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (139, 40, '等待退款', '40', 'trade_after_sale_status', 0, 'primary', '', '交易售后状态 - 等待退款', '1', '2022-11-19 20:59:54', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (140, 50, '退款成功', '50', 'trade_after_sale_status', 0, 'default', '', '交易售后状态 - 退款成功', '1', '2022-11-19 21:00:33', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (141, 61, '买家取消', '61', 'trade_after_sale_status', 0, 'info', '', '交易售后状态 - 买家取消', '1', '2022-11-19 21:01:29', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (142, 62, '商家拒绝', '62', 'trade_after_sale_status', 0, 'info', '', '交易售后状态 - 商家拒绝', '1', '2022-11-19 21:02:17', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (143, 63, '商家拒收货', '63', 'trade_after_sale_status', 0, 'info', '', '交易售后状态 - 商家拒收货', '1', '2022-11-19 21:02:37', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (144, 10, '售中退款', '10', 'trade_after_sale_type', 0, 'success', '', '交易售后的类型 - 售中退款', '1', '2022-11-19 21:05:05', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (145, 20, '售后退款', '20', 'trade_after_sale_type', 0, 'primary', '', '交易售后的类型 - 售后退款', '1', '2022-11-19 21:05:32', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (146, 10, '仅退款', '10', 'trade_after_sale_way', 0, 'primary', '', '交易售后的方式 - 仅退款', '1', '2022-11-19 21:39:19', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (147, 20, '退货退款', '20', 'trade_after_sale_way', 0, 'success', '', '交易售后的方式 - 退货退款', '1', '2022-11-19 21:39:38', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (148, 10, '微信小程序', '10', 'terminal', 0, 'default', '', '终端 - 微信小程序', '1', '2022-12-10 10:51:11', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (149, 20, 'H5 网页', '20', 'terminal', 0, 'default', '', '终端 - H5 网页', '1', '2022-12-10 10:51:30', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (150, 11, '微信公众号', '11', 'terminal', 0, 'default', '', '终端 - 微信公众号', '1', '2022-12-10 10:54:16', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (151, 31, '苹果 App', '31', 'terminal', 0, 'default', '', '终端 - 苹果 App', '1', '2022-12-10 10:54:42', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (152, 32, '安卓 App', '32', 'terminal', 0, 'default', '', '终端 - 安卓 App', '1', '2022-12-10 10:55:02', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (153, 0, '普通订单', '0', 'trade_order_type', 0, 'default', '', '交易订单的类型 - 普通订单', '1', '2022-12-10 16:34:14', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (154, 1, '秒杀订单', '1', 'trade_order_type', 0, 'default', '', '交易订单的类型 - 秒杀订单', '1', '2022-12-10 16:34:26', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (155, 2, '砍价订单', '2', 'trade_order_type', 0, 'default', '', '交易订单的类型 - 拼团订单', '1', '2022-12-10 16:34:36', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (156, 3, '拼团订单', '3', 'trade_order_type', 0, 'default', '', '交易订单的类型 - 砍价订单', '1', '2022-12-10 16:34:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (157, 0, '待支付', '0', 'trade_order_status', 0, 'default', '', '交易订单状态 - 待支付', '1', '2022-12-10 16:49:29', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (158, 10, '待发货', '10', 'trade_order_status', 0, 'primary', '', '交易订单状态 - 待发货', '1', '2022-12-10 16:49:53', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (159, 20, '已发货', '20', 'trade_order_status', 0, 'primary', '', '交易订单状态 - 已发货', '1', '2022-12-10 16:50:13', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (160, 30, '已完成', '30', 'trade_order_status', 0, 'success', '', '交易订单状态 - 已完成', '1', '2022-12-10 16:50:30', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (161, 40, '已取消', '40', 'trade_order_status', 0, 'danger', '', '交易订单状态 - 已取消', '1', '2022-12-10 16:50:50', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (162, 0, '未售后', '0', 'trade_order_item_after_sale_status', 0, 'info', '', '交易订单项的售后状态 - 未售后', '1', '2022-12-10 20:58:42', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (163, 10, '售后中', '10', 'trade_order_item_after_sale_status', 0, 'primary', '', '交易订单项的售后状态 - 售后中', '1', '2022-12-10 20:59:21', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (164, 20, '已退款', '20', 'trade_order_item_after_sale_status', 0, 'success', '', '交易订单项的售后状态 - 已退款', '1', '2022-12-10 20:59:46', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (177, 0, '初始化', '0', 'system_mail_send_status', 0, 'primary', '', '邮件发送状态 - 初始化\n', '1', '2023-01-26 09:53:49', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (178, 10, '发送成功', '10', 'system_mail_send_status', 0, 'success', '', '邮件发送状态 - 发送成功', '1', '2023-01-26 09:54:28', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (179, 20, '发送失败', '20', 'system_mail_send_status', 0, 'danger', '', '邮件发送状态 - 发送失败', '1', '2023-01-26 09:54:50', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (180, 30, '不发送', '30', 'system_mail_send_status', 0, 'info', '', '邮件发送状态 -  不发送', '1', '2023-01-26 09:55:06', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (181, 1, '通知公告', '1', 'system_notify_template_type', 0, 'primary', '', '站内信模版的类型 - 通知公告', '1', '2023-01-28 10:35:59', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (182, 2, '系统消息', '2', 'system_notify_template_type', 0, 'success', '', '站内信模版的类型 - 系统消息', '1', '2023-01-28 10:36:20', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (184, 10, 'Vue2 Element UI 标准模版', '10', 'infra_codegen_front_type', 0, '', '', '', '1', '2023-04-13 00:03:55', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (185, 20, 'Vue3 Element Plus 标准模版', '20', 'infra_codegen_front_type', 0, '', '', '', '1', '2023-04-13 00:04:08', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (186, 30, 'Vben2.0 Ant Design Schema 模版', '30', 'infra_codegen_front_type', 1, '', '', '', '1', '2023-04-13 00:04:26', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (187, 0, '按件', '1', 'trade_delivery_express_charge_mode', 0, '', '', '', '1', '2023-05-21 22:46:40', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (188, 1, '按重量', '2', 'trade_delivery_express_charge_mode', 0, '', '', '', '1', '2023-05-21 22:46:58', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (189, 2, '按体积', '3', 'trade_delivery_express_charge_mode', 0, '', '', '', '1', '2023-05-21 22:47:18', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (207, 1, '快递发货', '1', 'trade_delivery_type', 0, '', '', '', '1', '2023-08-23 00:04:55', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (208, 2, '用户自提', '2', 'trade_delivery_type', 0, '', '', '', '1', '2023-08-23 00:05:05', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (209, 3, '品类劵', '3', 'promotion_product_scope', 0, 'default', '', '', '1', '2023-09-01 23:43:07', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (210, 1, '人人分销', '1', 'brokerage_enabled_condition', 0, '', '', '所有用户都可以分销', '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (211, 2, '指定分销', '2', 'brokerage_enabled_condition', 0, '', '', '仅可后台手动设置推广员', '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (212, 1, '首次绑定', '1', 'brokerage_bind_mode', 0, '', '', '只要用户没有推广人，随时都可以绑定推广关系', '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (213, 2, '注册绑定', '2', 'brokerage_bind_mode', 0, '', '', '仅新用户注册时才能绑定推广关系', '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (214, 3, '覆盖绑定', '3', 'brokerage_bind_mode', 0, '', '', '如果用户已经有推广人，推广人会被变更', '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (215, 1, '钱包', '1', 'brokerage_withdraw_type', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (216, 2, '银行卡', '2', 'brokerage_withdraw_type', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (217, 3, '微信收款码', '3', 'brokerage_withdraw_type', 0, '', '', '手动打款', '', '2023-09-28 02:46:05', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (218, 4, '支付宝收款码', '4', 'brokerage_withdraw_type', 0, '', '', '手动打款', '', '2023-09-28 02:46:05', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (219, 1, '订单返佣', '1', 'brokerage_record_biz_type', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (220, 2, '申请提现', '2', 'brokerage_record_biz_type', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (221, 3, '申请提现驳回', '3', 'brokerage_record_biz_type', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (222, 0, '待结算', '0', 'brokerage_record_status', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (223, 1, '已结算', '1', 'brokerage_record_status', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (224, 2, '已取消', '2', 'brokerage_record_status', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (225, 0, '审核中', '0', 'brokerage_withdraw_status', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (226, 10, '审核通过', '10', 'brokerage_withdraw_status', 0, 'success', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (227, 11, '提现成功', '11', 'brokerage_withdraw_status', 0, 'success', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (228, 20, '审核不通过', '20', 'brokerage_withdraw_status', 0, 'danger', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (229, 21, '提现失败', '21', 'brokerage_withdraw_status', 0, 'danger', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (230, 0, '工商银行', '0', 'brokerage_bank_name', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (231, 1, '建设银行', '1', 'brokerage_bank_name', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (232, 2, '农业银行', '2', 'brokerage_bank_name', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (233, 3, '中国银行', '3', 'brokerage_bank_name', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (234, 4, '交通银行', '4', 'brokerage_bank_name', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (235, 5, '招商银行', '5', 'brokerage_bank_name', 0, '', '', NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (237, 1, '砍价中', '1', 'promotion_bargain_record_status', 0, 'default', '', '', '1', '2023-10-05 10:41:26', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (238, 2, '砍价成功', '2', 'promotion_bargain_record_status', 0, 'success', '', '', '1', '2023-10-05 10:41:39', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (239, 3, '砍价失败', '3', 'promotion_bargain_record_status', 0, 'warning', '', '', '1', '2023-10-05 10:41:57', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (240, 0, '拼团中', '0', 'promotion_combination_record_status', 0, '', '', '', '1', '2023-10-08 07:24:44', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (241, 1, '拼团成功', '1', 'promotion_combination_record_status', 0, 'success', '', '', '1', '2023-10-08 07:24:56', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (242, 2, '拼团失败', '2', 'promotion_combination_record_status', 0, 'warning', '', '', '1', '2023-10-08 07:25:11', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (274, 10, 'Gitee', '10', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:04:42', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (275, 20, '钉钉', '20', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:04:54', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (276, 30, '企业微信', '30', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:05:09', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (277, 31, '微信公众平台', '31', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:05:18', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (278, 32, '微信开放平台', '32', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:05:30', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (279, 34, '微信小程序', '34', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:05:38', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (282, 15, '子表', '15', 'infra_codegen_template_type', 0, 'default', '', '', '1', '2023-11-13 23:06:16', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (283, 10, '主表（标准模式）', '10', 'infra_codegen_template_type', 0, 'default', '', '', '1', '2023-11-14 12:32:49', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (284, 11, '主表（ERP 模式）', '11', 'infra_codegen_template_type', 0, 'default', '', '', '1', '2023-11-14 12:33:05', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (285, 12, '主表（内嵌模式）', '12', 'infra_codegen_template_type', 0, '', '', '', '1', '2023-11-14 12:33:31', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (353, 1, '天', '1', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:50:26', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (354, 2, '周', '2', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:50:36', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (355, 3, '月', '3', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:50:46', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (356, 4, '季度', '4', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:51:01', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (357, 5, '年', '5', 'date_interval', 0, '', '', '', '1', '2024-03-29 22:51:07', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (407, 2, '腾讯云', 'TENCENT', 'system_sms_channel_code', 0, '', '', '', '1', '2024-07-22 22:23:16', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (408, 3, '华为云', 'HUAWEI', 'system_sms_channel_code', 0, '', '', '', '1', '2024-07-22 22:23:46', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (412, 4, '七牛云', 'QINIU', 'system_sms_channel_code', 0, '', '', '', '1', '2024-08-31 08:45:03', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (413, 3, '新人券', '3', 'promotion_coupon_take_type', 0, 'info', '', '新人注册后，自动发放', '1', '2024-09-03 11:57:16', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (414, 5, '微信零钱', '5', 'brokerage_withdraw_type', 0, '', '', 'API 打款', '1', '2024-10-13 11:06:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (596, 40, 'Vben5.0 Ant Design Schema 模版', '40', 'infra_codegen_front_type', 0, '', '', NULL, '1', '2025-04-23 21:47:47', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (597, 6, '支付宝余额', '6', 'brokerage_withdraw_type', 0, '', '', 'API 打款', '1', '2025-05-10 08:24:49', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (622, 41, 'Vben5.0 Ant Design 标准模版', '41', 'infra_codegen_front_type', 0, '', '', '', '1', '2025-09-04 23:26:07', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (623, 50, 'Vben5.0 Element Plus Schema 模版', '50', 'infra_codegen_front_type', 0, '', '', '', '1', '2025-09-04 23:26:38', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (624, 51, 'Vben5.0 Element Plus 标准模版', '51', 'infra_codegen_front_type', 0, '', '', '', '1', '2025-09-04 23:26:49', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (626, 40, '支付宝小程序', '40', 'system_social_type', 0, '', '', '', '1', '2023-11-04 13:05:38', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (627, 60, 'Admin Uniapp 移动端', '60', 'infra_codegen_front_type', 0, '', '', NULL, '1', '2025-12-16 19:25:51', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (628, 42, 'Vben5.0 Antdv Next Schema 模版', '42', 'infra_codegen_front_type', 0, '', '', '', '1', '2026-05-23 13:52:25', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (629, 43, 'Vben5.0 Antdv Next 标准模版', '43', 'infra_codegen_front_type', 0, '', '', '', '1', '2026-05-23 13:52:25', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (980, 1, '客户', '1', 'merchant_type', 0, 'primary', '', '客户', '1', '2026-05-10 15:26:09', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (981, 2, '供应商', '2', 'merchant_type', 0, 'success', '', '供应商', '1', '2026-05-10 15:26:09', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (982, 3, '客户/供应商', '3', 'merchant_type', 0, 'warning', '', '客户/供应商', '1', '2026-05-10 15:26:09', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1292, 0, '草稿', '0', 'cms_article_status', 0, 'info', '', '', '1', '2026-08-15 09:43:09', '1', '2026-08-15 10:07:34', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1293, 1, '待审核', '1', 'cms_article_status', 0, 'warning', '', '', '1', '2026-08-15 09:43:09', '1', '2026-08-15 10:07:34', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1294, 2, '已下线', '2', 'cms_article_status', 0, 'info', '', '', '1', '2026-08-15 09:43:09', '1', '2026-08-15 10:07:34', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1295, 3, '已退回', '3', 'cms_article_status', 0, 'danger', '', '', '1', '2026-08-15 09:43:09', '1', '2026-08-15 10:07:34', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1296, 10, '待发布', '10', 'cms_article_status', 0, 'warning', '', '', '1', '2026-08-15 09:43:09', '1', '2026-08-15 10:07:34', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1297, 11, '已发布', '11', 'cms_article_status', 0, 'success', '', '', '1', '2026-08-15 09:43:09', '1', '2026-08-15 10:07:34', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1298, 20, '已删除', '20', 'cms_article_status', 0, 'danger', '', '', '1', '2026-08-15 09:43:09', '1', '2026-08-15 10:07:34', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1299, 21, '已归档', '21', 'cms_article_status', 0, 'info', '', '', '1', '2026-08-15 09:43:09', '1', '2026-08-15 10:07:34', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1307, 1, '富文本', '1', 'cms_editor_type', 0, '', '', '', '1', '2026-08-15 21:33:04', '1', '2026-08-15 21:33:04', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1308, 2, 'Markdown', '2', 'cms_editor_type', 0, '', '', '', '1', '2026-08-15 21:33:04', '1', '2026-08-15 21:33:04', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1337, 1, '是', 'true', 'cms_boolean', 0, 'success', '', '', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1338, 2, '否', 'false', 'cms_boolean', 0, 'info', '', '', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1339, 1, '独立访客', '1', 'cms_interaction_mode', 0, '', '', '', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1340, 2, '独立 IP', '2', 'cms_interaction_mode', 0, '', '', '', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1341, 3, '独立用户', '3', 'cms_interaction_mode', 0, '', '', '', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1342, 0, '正常', '0', 'cms_vote_status', 0, 'success', '', '', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1343, 1, '未启用', '1', 'cms_vote_status', 0, 'info', '', '', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1344, 2, '未开始', '2', 'cms_vote_status', 0, 'warning', '', '', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1345, 3, '已结束', '3', 'cms_vote_status', 0, 'danger', '', '', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1416, 0, '未运行', '0', 'cms_collection_status', 0, 'info', '', NULL, '1', '2026-09-05 21:01:49', '1', '2026-09-05 21:01:49', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1417, 1, '等待执行', '5', 'cms_collection_status', 0, 'warning', '', NULL, '1', '2026-09-05 21:01:49', '1', '2026-09-05 21:01:49', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1418, 2, '运行中', '1', 'cms_collection_status', 0, 'success', '', NULL, '1', '2026-09-05 21:01:49', '1', '2026-09-05 21:01:49', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1419, 3, '暂停', '2', 'cms_collection_status', 0, 'warning', '', NULL, '1', '2026-09-05 21:01:49', '1', '2026-09-05 21:01:49', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1420, 4, '完成', '3', 'cms_collection_status', 0, 'success', '', NULL, '1', '2026-09-05 21:01:49', '1', '2026-09-05 21:01:49', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1421, 5, '出错', '4', 'cms_collection_status', 0, 'danger', '', NULL, '1', '2026-09-05 21:01:49', '1', '2026-09-05 21:01:49', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1635, 1, '低价值', 'low_value', 'eam_goods_cost_type', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1636, 2, '高价值', 'high_value', 'eam_goods_cost_type', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1637, 3, '易耗品', 'consumables', 'eam_goods_cost_type', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1638, 4, '标准物品', 'normal', 'eam_goods_cost_type', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1642, 1, '常规出库', 'normal', 'eam_stock_out_type', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1643, 100, '常规入库', 'normal', 'eam_stock_in_type', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1644, 0, '采购', 'purchase', 'eam_source', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1645, 10, '赠送', 'give', 'eam_source', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1646, 100, '借用', 'borrow', 'eam_source', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1647, 9999, '自建', 'selfbuild', 'eam_source', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1648, 9999, '捐赠', 'donation', 'eam_source', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1649, 9999, '其他', 'other', 'eam_source', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1651, 1, '不入库', 'none', 'eam_purchase_import_method', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1652, 2, '自动入库', 'auto', 'eam_purchase_import_method', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1653, 3, '草稿入库单', 'draft', 'eam_purchase_import_method', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1654, 1, '一级', 'one', 'eam_supplier_grade', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1655, 2, '二级', 'two', 'eam_supplier_grade', 0, '', '', NULL, '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1657, 1, '默认类型', 'default', 'eam_maintain_type', 0, '', '', NULL, '', '2026-09-23 23:11:22', '', '2026-09-23 23:11:22', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1658, 1, '按年', 'year', 'eam_maintain_type', 0, '', '', NULL, '', '2026-09-23 23:11:22', '', '2026-09-23 23:11:22', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1659, 1, '按季', 'season', 'eam_maintain_type', 0, '', '', NULL, '', '2026-09-23 23:11:22', '', '2026-09-23 23:11:22', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1660, 3, '按月', 'month', 'eam_maintain_type', 0, '', '', NULL, '', '2026-09-23 23:11:22', '', '2026-09-23 23:11:22', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1661, 5, '按周', 'week', 'eam_maintain_type', 0, '', '', NULL, '', '2026-09-23 23:11:22', '', '2026-09-23 23:11:22', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1662, 5, '半年', 'half_year', 'eam_maintain_type', 0, '', '', NULL, '', '2026-09-23 23:11:22', '', '2026-09-23 23:11:22', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1663, 10, '临时保养', 'temp', 'eam_maintain_type', 0, '', '', NULL, '', '2026-09-23 23:11:22', '', '2026-09-23 23:11:22', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1664, 1, 'å·²ç»´ä¿®', 'repaired', 'eam_repair_result_type', 0, '', '', NULL, '', '2026-09-24 05:28:27', '', '2026-09-24 05:28:27', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1665, 2, 'æ— æ³•ç»´ä¿®', 'unable_to_repair', 'eam_repair_result_type', 0, '', '', NULL, '', '2026-09-24 05:28:27', '', '2026-09-24 05:28:27', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1667, 1, '不限制', '0', 'cms_password_strength', 0, 'info', '', 'CMS 密码强度', '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1668, 2, '字母和数字', '1', 'cms_password_strength', 0, 'info', '', 'CMS 密码强度', '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1669, 3, '大小写字母和数字', '2', 'cms_password_strength', 0, 'primary', '', 'CMS 密码强度', '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1670, 4, '字母、数字和特殊字符', '3', 'cms_password_strength', 0, 'warning', '', 'CMS 密码强度', '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1671, 5, '大小写字母、数字和特殊字符', '4', 'cms_password_strength', 0, 'danger', '', 'CMS 密码强度', '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1672, 1, '本地存储', '10', 'cms_storage_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1673, 2, 'FTP', '11', 'cms_storage_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1674, 3, 'SFTP', '12', 'cms_storage_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1675, 4, 'S3 对象存储', '20', 'cms_storage_type', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1676, 1, '前台游客', '0', 'cms_form_mode', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1677, 2, '前台会员', '1', 'cms_form_mode', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1678, 3, '后台录入', '2', 'cms_form_mode', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1679, 1, '文章', '0', 'cms_model_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1680, 2, '栏目', '1', 'cms_model_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1681, 3, '表单', '2', 'cms_model_type', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1682, 4, '站点设置', '4', 'cms_model_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1683, 5, '全局设置', '5', 'cms_model_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1684, 1, '本站私有', '0', 'cms_share_scope', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1685, 2, '子站点共享', '1', 'cms_share_scope', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1686, 3, '全局共享', '2', 'cms_share_scope', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1687, 1, '常规栏目', '1', 'cms_channel_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1688, 2, '单页栏目', '2', 'cms_channel_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1689, 3, '转向链接', '3', 'cms_channel_type', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1690, 4, '链接到第一个子栏目', '4', 'cms_channel_type', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1691, 1, '保留空行', 'remain', 'cms_editor_empty_line', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1692, 2, '合并为一行', 'one', 'cms_editor_empty_line', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1693, 3, '删除空行', 'remove', 'cms_editor_empty_line', 0, 'danger', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1694, 1, '常规', '0', 'cms_article_input_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1695, 2, '投稿', '1', 'cms_article_input_type', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1696, 3, '采集', '2', 'cms_article_input_type', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1697, 4, '接口', '3', 'cms_article_input_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1698, 5, '站内推送', '4', 'cms_article_input_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1699, 6, '站群推送', '5', 'cms_article_input_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1700, 1, '常规', '0', 'cms_article_source_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1701, 2, '复制', '1', 'cms_article_source_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1702, 3, '映射', '2', 'cms_article_source_type', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1703, 4, '引用', '3', 'cms_article_source_type', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1704, 1, '文字链接', '1', 'cms_link_group_display_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-10-20 16:58:47', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1705, 2, '图片链接', '2', 'cms_link_group_display_type', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-10-20 16:58:47', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1706, 1, '文章', '1', 'cms_attachment_business_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1707, 2, '留言板', '2', 'cms_attachment_business_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1708, 3, '链接', '3', 'cms_attachment_business_type', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-10-20 16:58:47', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1709, 4, '评论', '4', 'cms_attachment_business_type', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1710, 1, '全站', '1', 'cms_static_task_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1711, 2, '首页', '2', 'cms_static_task_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1712, 3, '栏目', '3', 'cms_static_task_type', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1713, 4, '文章', '4', 'cms_static_task_type', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1714, 1, '手动生成', '1', 'cms_static_task_trigger_type', 0, 'primary', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1715, 2, '数据变更', '2', 'cms_static_task_trigger_type', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1716, 3, '定时生成', '3', 'cms_static_task_trigger_type', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1717, 4, '重新执行', '4', 'cms_static_task_trigger_type', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1718, 1, '等待', '0', 'cms_static_task_status', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1719, 2, '运行中', '1', 'cms_static_task_status', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1720, 3, '出错', '2', 'cms_static_task_status', 0, 'danger', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1721, 4, '停止', '3', 'cms_static_task_status', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1722, 5, '完成', '4', 'cms_static_task_status', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1723, 1, '草稿', '0', 'cms_form_submission_status', 0, 'info', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:21:09', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1724, 2, '待审核', '1', 'cms_form_submission_status', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:21:09', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1725, 4, '已审核', '11', 'cms_form_submission_status', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:21:09', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1726, 3, '已退回', '3', 'cms_form_submission_status', 0, 'danger', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:19:16', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1727, 5, '已删除', '20', 'cms_form_submission_status', 0, 'danger', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-10-22 09:47:38', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1728, 1, '已审核', '0', 'cms_message_board_status', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:21:09', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1729, 2, '未审核', '1', 'cms_message_board_status', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:21:09', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1730, 3, '已屏蔽', '2', 'cms_message_board_status', 0, 'danger', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:19:04', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1731, 1, '已审核', '0', 'cms_comment_status', 0, 'success', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:21:09', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1732, 2, '未审核', '1', 'cms_comment_status', 0, 'warning', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:21:09', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1733, 3, '已屏蔽', '2', 'cms_comment_status', 0, 'danger', '', NULL, '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:19:04', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1734, 1, 'æ­£å¸¸', 'nomal', 'eam_inventory_plan_type', 0, '', '', NULL, '', '2026-09-24 21:44:56', '', '2026-09-24 21:44:56', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1735, 2, 'è®¡åˆ’', 'plan', 'eam_inventory_plan_type', 0, '', '', NULL, '', '2026-09-24 21:44:56', '', '2026-09-24 21:44:56', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1752, 1, '供应商', 'supplier', 'asset_software_copyright_type', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1753, 2, '共有', 'common', 'asset_software_copyright_type', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1754, 3, '自有', 'own', 'asset_software_copyright_type', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1755, 1, '按Core授权', 'core', 'asset_software_license_mode', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1756, 2, '按Cpu授权', 'cpu', 'asset_software_license_mode', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1757, 3, '按套数授权', 'sets', 'asset_software_license_mode', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1758, 4, '按用户授权', 'user', 'asset_software_license_mode', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1759, 5, '开源免费', 'openSourceFree', 'asset_software_license_mode', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1760, 6, '预装', 'preloaded', 'asset_software_license_mode', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1761, 7, '自主开发', 'independentDevelopment', 'asset_software_license_mode', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1762, 8, '合作开发', 'cooperativeDevelopment', 'asset_software_license_mode', 0, '', '', NULL, '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1776, 0, '国产软件', '1', 'cms_download_type', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1777, 1, '国外软件', '2', 'cms_download_type', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1778, 0, '免费软件', '1', 'cms_download_license', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1779, 1, '收费软件', '2', 'cms_download_license', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1780, 0, '简体中文', '1', 'cms_download_language', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1781, 1, '繁体中文', '2', 'cms_download_language', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1782, 2, '英文', '3', 'cms_download_language', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1783, 0, '★★★★★', '5', 'cms_download_star', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1784, 1, '★★★★☆', '4', 'cms_download_star', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1785, 2, '★★★☆☆', '3', 'cms_download_star', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1786, 3, '★★☆☆☆', '2', 'cms_download_star', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1787, 4, '★☆☆☆☆', '1', 'cms_download_star', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1788, 0, 'win7', '1', 'cms_download_system', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1789, 1, 'win10', '2', 'cms_download_system', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1790, 2, 'linux', '3', 'cms_download_system', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1791, 3, 'unix', '4', 'cms_download_system', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1792, 4, 'mac', '5', 'cms_download_system', 0, '', '', NULL, '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1793, 0, '华语', '1', 'cms_video_area', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1794, 1, '美国', '2', 'cms_video_area', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1795, 2, '欧洲', '3', 'cms_video_area', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1796, 3, '韩国', '4', 'cms_video_area', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1797, 4, '日本', '5', 'cms_video_area', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1798, 5, '其它', '6', 'cms_video_area', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1799, 0, '喜剧', '1', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1800, 1, '悲剧', '2', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1801, 2, '爱情', '3', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1802, 3, '动作', '4', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1803, 4, '枪战', '5', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1804, 5, '犯罪', '6', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1805, 6, '惊悚', '7', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1806, 7, '恐怖', '8', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1807, 8, '悬疑', '9', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1808, 9, '动画', '10', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1809, 10, '家庭', '11', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1810, 11, '奇幻', '12', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1811, 12, '魔幻', '13', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1812, 13, '科幻', '14', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1813, 14, '战争', '15', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1814, 15, '武侠', '16', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1815, 16, '青春', '17', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1816, 17, '功夫', '18', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1817, 18, '灾难', '19', 'cms_video_type', 0, '', '', NULL, '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1818, 1, '64GB', '1', 'cms_product_phone_storage', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1819, 2, '128GB', '2', 'cms_product_phone_storage', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1820, 3, '256GB', '3', 'cms_product_phone_storage', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1821, 4, '512GB', '4', 'cms_product_phone_storage', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1822, 5, '1TB', '5', 'cms_product_phone_storage', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1823, 1, '5.0-5.49英寸', '1', 'cms_product_phone_screen', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1824, 2, '5.5-5.99英寸', '2', 'cms_product_phone_screen', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1825, 3, '6.0-6.49英寸', '3', 'cms_product_phone_screen', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1826, 4, '6.5英寸以上', '4', 'cms_product_phone_screen', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1827, 1, '公路车', '1', 'cms_product_bike_type', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1828, 2, '山地车', '2', 'cms_product_bike_type', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1829, 3, '旅行车', '3', 'cms_product_bike_type', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1830, 1, '定焦', '1', 'cms_product_camera_type', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1831, 2, '变焦', '2', 'cms_product_camera_type', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1832, 1, 'EF', '1', 'cms_product_camera_mount', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1833, 2, 'RF', '2', 'cms_product_camera_mount', 0, '', '', NULL, '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1834, 5, '块项', '5', 'cms_attachment_business_type', 0, 'info', '', NULL, '1', '2026-09-27 22:26:10', '1', '2026-09-27 22:26:10', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1835, 6, '站点', '6', 'cms_attachment_business_type', 0, 'info', '', NULL, '1', '2026-09-27 22:26:10', '1', '2026-09-27 22:26:10', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1836, 7, '栏目', '7', 'cms_attachment_business_type', 0, 'info', '', NULL, '1', '2026-09-27 22:26:10', '1', '2026-09-27 22:26:10', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1837, 1, 'EAM_资产调拨', 'eam_asset_allocate', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1838, 2, 'EAM_资产借用', 'eam_asset_borrow', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1839, 3, 'EAM_资产借用归还', 'eam_asset_borrow_return', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1840, 4, 'EAM_资产卡片', 'eam_asset_card', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1841, 5, 'EAM_资产基本变更', 'eam_asset_change_base_info', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1842, 6, 'EAM_资产财务变更', 'eam_asset_change_financial', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1843, 7, 'EAM_资产维保变更', 'eam_asset_change_maintenance', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1844, 8, 'EAM_资产编码', 'eam_asset_code', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1845, 9, 'EAM_资产领用', 'eam_asset_collection', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1846, 10, 'EAM_资产退库', 'eam_asset_collection_return', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1847, 11, 'EAM_资产耗材单据调拨', 'eam_asset_consumables_allocate', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1848, 12, 'EAM_资产耗材编码', 'eam_asset_consumables_code', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1849, 13, 'EAM_资产耗材单据领用', 'eam_asset_consumables_collection', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1850, 14, 'EAM_资产耗材单据出库', 'eam_asset_consumables_deliver', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1851, 15, 'EAM_资产耗材单据入库', 'eam_asset_consumables_stock_in', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1852, 16, 'EAM_资产耗材单据转移', 'eam_asset_consumables_tranfer', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1853, 17, 'EAM_资产折旧', 'eam_asset_depreciation_oper', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1854, 18, 'EAM_员工领用申请', 'eam_asset_employee_apply', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1855, 19, 'EAM_员工资产交接', 'eam_asset_employee_handover', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1856, 20, 'EAM_员工资产报失', 'eam_asset_employee_loss', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1857, 21, 'EAM_员工资产报修', 'eam_asset_employee_repair', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1858, 22, 'EAM_资产处置', 'eam_asset_handle', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1859, 23, 'EAM_巡检方案', 'eam_asset_inspection_plan', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1860, 24, 'EAM_巡检任务', 'eam_asset_inspection_task', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1861, 25, 'EAM_资产数据盘点', 'eam_asset_inventory', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1862, 26, 'EAM_资产保养方案', 'eam_asset_maintain_plan', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1863, 27, 'EAM_资产保养项目', 'eam_asset_maintain_project', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1864, 28, 'EAM_资产保养任务', 'eam_asset_maintain_task', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1865, 29, 'EAM_资产备件调整', 'eam_asset_part_goods_adjust', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1866, 30, 'EAM_资产备件入库', 'eam_asset_part_goods_in', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1867, 31, 'EAM_资产备件出库', 'eam_asset_part_goods_out', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1868, 32, 'EAM_资产备件转移', 'eam_asset_part_goods_tranfer', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1869, 33, 'EAM_资产采购申请', 'eam_asset_purchase_apply', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1870, 34, 'EAM_资产采购验收', 'eam_asset_purchase_check', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1871, 35, 'EAM_资产采购订单', 'eam_asset_purchase_order', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1872, 36, 'EAM_资产登记', 'eam_asset_register', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1873, 37, 'EAM_资产报修', 'eam_asset_repair', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1874, 38, 'EAM_设备故障申请', 'eam_asset_repair_order', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1875, 39, 'EAM_维修验收', 'eam_asset_repair_order_acceptance', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1876, 40, 'EAM_维修工单', 'eam_asset_repair_order_act', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1877, 41, 'EAM_资产报废', 'eam_asset_scrap', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1878, 42, 'EAM_软件资产变更', 'eam_asset_software_change', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1879, 43, 'EAM_软件资产编码', 'eam_asset_software_code', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1880, 44, 'EAM_资产软件分发', 'eam_asset_software_distribute', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1881, 45, 'EAM_软件资产登记', 'eam_asset_software_insert', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1882, 46, 'EAM_软件资产维保', 'eam_asset_software_maintenance', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1883, 47, 'EAM_资产库存编码', 'eam_asset_stock_code', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1884, 48, 'EAM_资产库存出库', 'eam_asset_stock_deliver', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1885, 49, 'EAM_资产库存分配', 'eam_asset_stock_distribute', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1886, 50, 'EAM_库存物品调整', 'eam_asset_stock_goods_adjust', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1887, 51, 'EAM_库存物品入库', 'eam_asset_stock_goods_in', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1888, 52, 'EAM_库存物品盘点', 'eam_asset_stock_goods_inventory', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1889, 53, 'EAM_库存物品出库', 'eam_asset_stock_goods_out', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1890, 54, 'EAM_库存物品转移', 'eam_asset_stock_goods_tranfer', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1891, 55, 'EAM_资产库存入库', 'eam_asset_stock_in', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1892, 56, 'EAM_资产库存-盘点', 'eam_asset_stock_inventory', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1893, 57, 'EAM_资产入库', 'eam_asset_storage', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1894, 58, 'EAM_资产转移', 'eam_asset_tranfer', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1895, 59, 'EAM_资产数据下载', 'eam_download_asset', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1896, 60, 'EAM_资产调拨下载', 'eam_download_asset_allocate_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1897, 61, 'EAM_资产借用下载', 'eam_download_asset_borrow_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1898, 62, 'EAM_资产卡片下载', 'eam_download_asset_card', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1899, 63, 'EAM_资产领用下载', 'eam_download_asset_collection_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1900, 64, 'EAM_资产退库下载', 'eam_download_asset_collection_return_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1901, 65, 'EAM_资产物品库存调整单下载', 'eam_download_asset_consumables_goods_adjust_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1902, 66, 'EAM_耗材库存入库单下载', 'eam_download_asset_consumables_goods_in_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1903, 67, 'EAM_耗材库存出库单下载', 'eam_download_asset_consumables_goods_out_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1904, 68, 'EAM_资产物品库存转移单下载', 'eam_download_asset_consumables_goods_tranfer_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1905, 69, 'EAM_资产标签下载', 'eam_download_asset_label', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1906, 70, 'EAM_资产备件库存调整单下载', 'eam_download_asset_part_goods_adjust_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1907, 71, 'EAM_资产备件库存入库单下载', 'eam_download_asset_part_goods_in_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1908, 72, 'EAM_资产备件库存出库单下载', 'eam_download_asset_part_goods_out_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1909, 73, 'EAM_资产备件库存转移单下载', 'eam_download_asset_part_goods_tranfer_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1910, 74, 'EAM_资产登记单据', 'eam_download_asset_register_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1911, 75, 'EAM_资产报修下载', 'eam_download_asset_repair_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1912, 76, 'EAM_资产报废下载', 'eam_download_asset_scrap_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1913, 77, 'EAM_资产物品库存调整单下载', 'eam_download_asset_stock_goods_adjust_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1914, 78, 'EAM_资产物品入库下载', 'eam_download_asset_stock_goods_in_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1915, 79, 'EAM_资产物品出库下载', 'eam_download_asset_stock_goods_out_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1916, 80, 'EAM_资产物品库存转移单下载', 'eam_download_asset_stock_goods_tranfer_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1917, 81, 'EAM_资产转移下载', 'eam_download_asset_tranfer_bill', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1918, 82, 'EAM_故障登记', 'eam_equipment_failure_registration', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1919, 83, 'EAM_标准物品编码', 'eam_goods_stock_code', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1920, 84, 'EAM_标准物品条形码', 'eam_goods_stock_txm', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1921, 85, 'VEHICLE_车辆申请', 'vehicle_apply', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1922, 86, 'VEHICLE_车辆维修', 'vehicle_maintenance', 'eam_document_template_code', 0, '', '', NULL, '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1968, 1, '对话', '0', 'ai1_model_type', 0, 'primary', '', '', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1969, 2, '嵌入', '1', 'ai1_model_type', 0, 'success', '', '', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1970, 1, '远程（Streamable HTTP）', 'http', 'ai1_mcp_transport', 0, 'primary', '', '', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1971, 2, '本地进程（stdio）', 'stdio', 'ai1_mcp_transport', 0, 'warning', '', '', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1972, 1, '未处理', '0', 'ai1_knowledge_document_status', 0, 'info', '', '', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1973, 2, '已向量化', '1', 'ai1_knowledge_document_status', 0, 'success', '', '', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1974, 3, '失败', '2', 'ai1_knowledge_document_status', 0, 'danger', '', '', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1975, 1, '用户', 'user', 'ai1_session_message_role', 0, 'primary', '', '', '1', '2026-09-30 16:49:11', '1', '2026-09-30 22:25:03', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1976, 2, '助手', 'assistant', 'ai1_session_message_role', 0, 'success', '', '', '1', '2026-09-30 16:49:11', '1', '2026-09-30 22:25:03', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1977, 1, '生成中', '0', 'ai1_session_message_status', 0, 'warning', '', '', '1', '2026-09-30 16:49:11', '1', '2026-09-30 22:25:03', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1978, 2, '完成', '1', 'ai1_session_message_status', 0, 'success', '', '', '1', '2026-09-30 16:49:11', '1', '2026-09-30 22:25:03', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1979, 3, '失败', '2', 'ai1_session_message_status', 0, 'danger', '', '', '1', '2026-09-30 16:49:11', '1', '2026-09-30 22:25:03', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1980, 1, '目录', '0', 'ai1_skill_file_type', 0, 'warning', '', '', '1', '2026-09-30 17:19:05', '1', '2026-09-30 17:19:05', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1981, 2, '文件', '1', 'ai1_skill_file_type', 0, 'primary', '', '', '1', '2026-09-30 17:19:05', '1', '2026-09-30 17:19:05', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2743, 1, '新华网', '新华网', 'cms_article_source', 0, '', '', NULL, '1', '2026-10-06 23:10:49', '1', '2026-10-06 23:10:49', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2744, 2, '人民网', '人民网', 'cms_article_source', 0, '', '', NULL, '1', '2026-10-06 23:10:49', '1', '2026-10-06 23:10:49', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2745, 1, '知识问答', 'knowledge_qa', 'ai2_workflow_category', 0, 'primary', '', '知识问答类型的工作流', '', '2026-10-07 03:22:50', '', '2026-10-07 03:22:50', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2746, 2, '智能客服', 'customer_service', 'ai2_workflow_category', 0, 'success', '', '智能客服类型的工作流', '', '2026-10-07 03:22:50', '', '2026-10-07 03:22:50', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2747, 3, '营销', 'marketing', 'ai2_workflow_category', 0, 'warning', '', '营销类型的工作流', '', '2026-10-07 03:22:50', '', '2026-10-07 03:22:50', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2748, 1, 'å¯ç”¨', 'enable', 'eam_status_enable', 0, '', '', NULL, '', '2026-10-08 08:01:27', '', '2026-10-08 08:01:27', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2749, 2, 'ç¦ç”¨', 'disable', 'eam_status_enable', 0, '', '', NULL, '', '2026-10-08 08:01:27', '', '2026-10-08 08:01:27', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2751, 8, '全局设置', '8', 'cms_attachment_business_type', 0, 'info', '', NULL, '1', '2026-10-08 08:50:20', '1', '2026-10-08 08:50:20', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2752, 1, '已完成', 'complete', 'eam_asset_handle_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2753, 2, '草稿', 'incomplete', 'eam_asset_handle_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2754, 3, '拒绝', 'deny', 'eam_asset_handle_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2755, 4, '审批中', 'approval', 'eam_asset_handle_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2756, 5, '取消', 'cancel', 'eam_asset_handle_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2759, 1, '启用', 'enable', 'eam_warehouse_position_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2760, 2, '锁定', 'locked', 'eam_warehouse_position_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2761, 3, '禁用', 'disable', 'eam_warehouse_position_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2762, 1, '未借用', 'not_borrowed', 'eam_asset_borrow_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2763, 2, '已借用', 'borrowed', 'eam_asset_borrow_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2764, 3, '已归还', 'returned', 'eam_asset_borrow_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2765, 1, '等待维修', 'wait_repair', 'eam_asset_repair_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2766, 2, '维修中', 'repairing', 'eam_asset_repair_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2767, 3, '维修结束', 'finish', 'eam_asset_repair_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2768, 1, '未派单', 'not_dispatch', 'eam_repair_order_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2769, 2, '已派单', 'dispatched', 'eam_repair_order_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2770, 3, '待维修', 'wait_repair', 'eam_repair_order_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2771, 4, '维修中', 'repairing', 'eam_repair_order_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2772, 5, '待验收', 'wait_acceptance', 'eam_repair_order_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2773, 6, '验收未通过', 'acceptance_failed', 'eam_repair_order_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2774, 7, '维修结束', 'finish', 'eam_repair_order_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2775, 8, '取消', 'cancel', 'eam_repair_order_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2783, 1, '自修', 'self_repair', 'eam_repair_order_type', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2784, 2, '外部维修', 'external_repair', 'eam_repair_order_type', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2786, 1, '验收通过', 'finish', 'eam_repair_order_act_accept_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2787, 2, '验收未通过', 'acceptance_failed', 'eam_repair_order_act_accept_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2789, 1, '待保养', 'wait', 'eam_maintain_task_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2790, 2, '保养中', 'acting', 'eam_maintain_task_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2791, 3, '取消', 'cancel', 'eam_maintain_task_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2792, 4, '已完成', 'finish', 'eam_maintain_task_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2796, 1, '未保养', 'unexecuted', 'eam_maintain_task_project_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2797, 2, '已保养', 'executed', 'eam_maintain_task_project_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2798, 3, '不保养', 'none', 'eam_maintain_task_project_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2799, 1, '停用', 'stop', 'eam_plan_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2800, 2, '运行中', 'acting', 'eam_plan_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2801, 3, '结束', 'finish', 'eam_plan_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2802, 4, '已过期', 'expired', 'eam_plan_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2806, 1, '单次', 'once', 'eam_maintain_cycle_method', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2807, 2, '周期性', 'cycle', 'eam_maintain_cycle_method', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2809, 1, '未开始', 'not_start', 'eam_inventory_action_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2810, 2, '进行中', 'acting', 'eam_inventory_action_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2811, 3, '取消', 'cancel', 'eam_inventory_action_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2812, 4, '已完成', 'finish', 'eam_inventory_action_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2816, 1, '未同步', 'not_sync', 'eam_inventory_data_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2817, 2, '已同步', 'sync', 'eam_inventory_data_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2819, 1, '盘盈', 'surplus', 'eam_inventory_detail_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2820, 2, '盘亏', 'loss', 'eam_inventory_detail_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2821, 3, '已盘点', 'counted', 'eam_inventory_detail_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2822, 4, '待盘点', 'not_counted', 'eam_inventory_detail_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2823, 5, '异常', 'exception', 'eam_inventory_detail_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2826, 1, '待检', 'wait', 'eam_inspection_task_point_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2827, 2, '正常', 'normal', 'eam_inspection_task_point_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2828, 3, '异常', 'abnormal', 'eam_inspection_task_point_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2829, 4, '不巡检', 'none', 'eam_inspection_task_point_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2833, 1, '未处理', 'not_process', 'eam_inspection_task_abnormal_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2834, 2, '已处理', 'processed', 'eam_inspection_task_abnormal_status', 0, '', '', NULL, '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2836, 1, '文本框', 'input', 'eam_check_item_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2837, 2, '单选按钮', 'radiobox', 'eam_check_item_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2838, 3, '数字范围', 'number_range', 'eam_check_item_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2839, 1, '待导入', 'wait', 'eam_asset_import_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2840, 2, '取消', 'cancel', 'eam_asset_import_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2841, 3, '完成', 'finish', 'eam_asset_import_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2842, 1, '验收通过', 'checked', 'eam_asset_apply_check_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2843, 2, '未验收', 'not_check', 'eam_asset_apply_check_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2844, 3, '验收未通过', 'not_pass', 'eam_asset_apply_check_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2845, 1, '待检', 'wait', 'eam_inspection_task_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2846, 2, '检中', 'acting', 'eam_inspection_task_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2847, 3, '完成', 'finish', 'eam_inspection_task_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2848, 4, '取消', 'cancel', 'eam_inspection_task_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2852, 1, '按月计算', 'monthly', 'eam_depreciation_code', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2853, 2, '测试', 'test', 'eam_depreciation_code', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2855, 1, '按月平均法', 'average_age', 'eam_depreciation_method', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2856, 1, '跟随资产', 'follow_asset', 'eam_depreciation_residual_value_select', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2857, 2, '当前方案', 'current_scheme', 'eam_depreciation_residual_value_select', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2859, 1, '入账当月', 'register_cur_month', 'eam_depreciation_first_method', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2860, 2, '入账次月', 'register_next_month', 'eam_depreciation_first_method', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2862, 1, '前置条件', 'preconditions', 'eam_depreciation_rule_action', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2863, 2, '已折旧完', 'depreciation_finish', 'eam_depreciation_rule_action', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2864, 3, '正常折旧', 'depreciation_normal', 'eam_depreciation_rule_action', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2865, 4, '首次折旧', 'depreciation_first', 'eam_depreciation_rule_action', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2866, 5, '最后折旧', 'depreciation_last', 'eam_depreciation_rule_action', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2867, 6, '不在折旧', 'depreciation_idle', 'eam_depreciation_rule_action', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2869, 1, '空', 'idle', 'eam_depreciation_calculation_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2870, 2, '不为NULL', 'not_null', 'eam_depreciation_calculation_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2871, 3, 'jexl表达式', 'jexl_expression', 'eam_depreciation_calculation_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2872, 4, '脚本', 'script', 'eam_depreciation_calculation_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2873, 5, 'sql', 'sql', 'eam_depreciation_calculation_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2876, 1, '字符串', 'string', 'eam_depreciation_return_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2877, 2, '浮点', 'double', 'eam_depreciation_return_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2878, 3, 'Boolean', 'boolean', 'eam_depreciation_return_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2879, 4, '无', 'idle', 'eam_depreciation_return_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2883, 1, '未开始', 'not_start', 'eam_depreciation_oper_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2884, 2, '进行中', 'acting', 'eam_depreciation_oper_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2885, 3, '成功', 'sucess', 'eam_depreciation_oper_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2886, 4, '失败', 'failed', 'eam_depreciation_oper_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2887, 5, '完成', 'complete', 'eam_depreciation_oper_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2890, 1, '正常折旧', 'depreciation_normal', 'eam_depreciation_detail_result', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2891, 2, '不在折旧', 'depreciation_idle', 'eam_depreciation_detail_result', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2892, 3, '已折旧完', 'depreciation_finish', 'eam_depreciation_detail_result', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2893, 4, '首次折旧', 'depreciation_first', 'eam_depreciation_detail_result', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2894, 5, '最后折旧', 'depreciation_last', 'eam_depreciation_detail_result', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2897, 1, '待计算', 'not_calculated', 'eam_depreciation_detail_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2898, 2, '计算成功', 'success', 'eam_depreciation_detail_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2899, 3, '计算失败', 'failed', 'eam_depreciation_detail_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2900, 1, '库存', 'stock', 'eam_stock_goods_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2901, 2, '备件', 'part', 'eam_stock_goods_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2902, 3, '耗材', 'consumables', 'eam_stock_goods_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2903, 1, '不做更新', 'none', 'eam_maintenance_record_batch_update_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2904, 2, '单据全部资产', 'all', 'eam_maintenance_record_batch_update_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2905, 3, '列表选择', 'selected', 'eam_maintenance_record_batch_update_type', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2906, 1, '在保', 'under', 'eam_maintenance_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2907, 2, '脱保', 'out', 'eam_maintenance_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2908, 3, '不需要', 'not_need', 'eam_maintenance_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2909, 4, '未知', 'unknow', 'eam_maintenance_status', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2913, 1, '前台', 'front', 'eam_financial_options', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2914, 2, '后台', 'back', 'eam_financial_options', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2916, 1, '固定资产-管理费用', 'manage', 'eam_expense_items', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2917, 2, '固定资产-销售费用', 'sale', 'eam_expense_items', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2918, 3, '固定资产-研发费用', 'development', 'eam_expense_items', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2919, 4, '固定资产-主营业务成本', 'main_business', 'eam_expense_items', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2923, 1, '丢失', 'loss', 'eam_scrap_method', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2924, 2, '过期', 'expire', 'eam_scrap_method', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2925, 3, '损坏', 'damage', 'eam_scrap_method', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2926, 1, '是', '1', 'eam_status_yn', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2927, 2, '否', '0', 'eam_status_yn', 0, '', '', NULL, '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2929, 9, '表单投稿', '9', 'cms_attachment_business_type', 0, 'default', '', 'CMS 表单投稿附件引用业务类型', 'admin', '2026-10-13 20:56:50', 'admin', '2026-10-13 20:56:50', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2930, 5, '搜索索引', '5', 'cms_static_task_type', 0, '', '', 'CMS 生成管理搜索索引任务类型', '1', '2026-10-16 00:35:57', '1', '2026-10-16 00:35:57', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2931, 6, '专题', '6', 'cms_model_type', 0, 'primary', '', NULL, '1', '2026-10-21 10:49:41', '1', '2026-10-21 10:49:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2932, 10, '专题', '10', 'cms_attachment_business_type', 0, 'primary', '', NULL, '1', '2026-10-21 10:49:41', '1', '2026-10-21 10:49:41', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2933, 1, '红色', 'red', 'cms_jack_form_20261021_153612', 0, '', '', 'jack-form-todo-20261021-153612', '1', '2026-10-21 17:19:14', '1', '2026-10-21 17:19:14', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2934, 2, '蓝色', 'blue', 'cms_jack_form_20261021_153612', 0, '', '', 'jack-form-todo-20261021-153612', '1', '2026-10-21 17:19:14', '1', '2026-10-21 17:19:14', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2935, 3, '停用绿色', 'green', 'cms_jack_form_20261021_153612', 1, '', '', 'jack-form-todo-20261021-153612', '1', '2026-10-21 17:19:14', '1', '2026-10-21 17:19:14', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2936, 7, '区块项', '7', 'cms_model_type', 0, '', '', 'CMS 区块项模型类型', '1', '2026-10-21 19:12:39', '1', '2026-10-21 19:12:39', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2937, 105, '扫码登录', '105', 'system_login_type', 0, 'primary', '', NULL, '1', '2026-10-24 21:38:51', '1', '2026-10-24 21:38:51', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2938, 11, '领导信箱', '11', 'cms_attachment_business_type', 0, '', '', '领导信箱答复附件', '1', '2026-10-26 17:25:24', '1', '2026-10-26 17:25:24', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2939, 12, '依申请公开', '12', 'cms_attachment_business_type', 0, '', '', NULL, '1', '2026-10-26 18:34:42', '1', '2026-10-26 18:34:42', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2940, 13, '在线访谈', '13', 'cms_attachment_business_type', 0, '', '', NULL, '1', '2026-10-26 21:20:12', '1', '2026-10-26 21:20:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2941, 1, '待受理', '0', 'cms_mailbox_status', 0, 'warning', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2942, 2, '已受理', '1', 'cms_mailbox_status', 0, 'primary', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2943, 3, '已退回', '2', 'cms_mailbox_status', 0, 'info', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2944, 4, '已答复', '3', 'cms_mailbox_status', 0, 'success', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2945, 1, '待受理', '0', 'cms_disclosure_status', 0, 'warning', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2946, 2, '已受理', '1', 'cms_disclosure_status', 0, 'primary', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2947, 3, '已补正告知', '2', 'cms_disclosure_status', 0, 'info', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2948, 4, '已答复', '3', 'cms_disclosure_status', 0, 'success', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2949, 1, '预告', '0', 'cms_interview_status', 0, 'info', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2950, 2, '直播中', '1', 'cms_interview_status', 0, 'danger', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2951, 3, '已结束', '2', 'cms_interview_status', 0, 'success', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2952, 1, '待审核', '0', 'cms_interview_question_status', 0, 'warning', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2953, 2, '已采用', '1', 'cms_interview_question_status', 0, 'success', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2954, 3, '已拒绝', '2', 'cms_interview_question_status', 0, 'info', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2955, 1, '待运行', '0', 'cms_census_status', 0, 'info', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2956, 2, '运行中', '1', 'cms_census_status', 0, 'primary', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2957, 3, '出错', '2', 'cms_census_status', 0, 'danger', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2958, 4, '已停止', '3', 'cms_census_status', 0, 'warning', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2959, 5, '已完成', '4', 'cms_census_status', 0, 'success', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2960, 1, '合格', '1', 'cms_census_conclusion', 0, 'success', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2961, 2, '不合格', '2', 'cms_census_conclusion', 0, 'danger', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2962, 1, '待处理', '0', 'cms_census_issue_status', 0, 'warning', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2963, 2, '已处理', '1', 'cms_census_issue_status', 0, 'success', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2964, 3, '已忽略', '2', 'cms_census_issue_status', 0, 'info', '', 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2965, 1, '咨询', '1', 'cms_mailbox_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2966, 2, '建议', '2', 'cms_mailbox_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2967, 3, '投诉', '3', 'cms_mailbox_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2968, 4, '求助', '4', 'cms_mailbox_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2969, 5, '表扬', '5', 'cms_mailbox_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2970, 1, '满意', '1', 'cms_mailbox_rate', 0, 'success', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2971, 2, '基本满意', '2', 'cms_mailbox_rate', 0, 'primary', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2972, 3, '不满意', '3', 'cms_mailbox_rate', 0, 'danger', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2973, 1, '公民', '1', 'cms_disclosure_applicant_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2974, 2, '法人或其他组织', '2', 'cms_disclosure_applicant_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2975, 1, '纸质', '1', 'cms_disclosure_provide_method', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2976, 2, '电子邮件', '2', 'cms_disclosure_provide_method', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2977, 3, '光盘', '3', 'cms_disclosure_provide_method', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2978, 4, '其他', '4', 'cms_disclosure_provide_method', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2979, 1, '邮寄', '1', 'cms_disclosure_obtain_method', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2980, 2, '电子邮件', '2', 'cms_disclosure_obtain_method', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2981, 3, '自行领取', '3', 'cms_disclosure_obtain_method', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2982, 4, '传真', '4', 'cms_disclosure_obtain_method', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2983, 1, '已主动公开', '1', 'cms_disclosure_reply_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2984, 2, '予以公开', '2', 'cms_disclosure_reply_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2985, 3, '部分公开', '3', 'cms_disclosure_reply_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2986, 4, '不予公开', '4', 'cms_disclosure_reply_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2987, 5, '信息不存在', '5', 'cms_disclosure_reply_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2988, 6, '非本机关掌握', '6', 'cms_disclosure_reply_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2989, 7, '重复申请', '7', 'cms_disclosure_reply_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2990, 8, '按其他规定办理', '8', 'cms_disclosure_reply_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2991, 1, '单项否决指标', '1', 'cms_census_indicator_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2992, 2, '扣分指标', '2', 'cms_census_indicator_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2993, 3, '加分指标', '3', 'cms_census_indicator_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2994, 1, '单项否决', '0', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2995, 2, '发布解读', '1', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2996, 3, '办事服务', '2', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2997, 4, '互动交流', '3', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2998, 5, '功能设计', '4', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2999, 6, '信息发布', '5', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3000, 7, '办事服务', '6', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3001, 8, '互动交流', '7', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3002, 9, '功能设计', '8', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3003, 10, '创新发展', '9', 'cms_census_indicator_category', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3004, 1, '空白栏目', '1', 'cms_census_issue_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3005, 2, '要闻栏目未更新', '2', 'cms_census_issue_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3006, 3, '政策栏目未更新', '3', 'cms_census_issue_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3007, 4, '栏目长期未更新', '4', 'cms_census_issue_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3008, 5, '首页未更新', '5', 'cms_census_issue_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3009, 6, '错别字', '6', 'cms_census_issue_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3010, 7, '敏感词', '7', 'cms_census_issue_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3011, 8, '死链', '8', 'cms_census_issue_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3012, 9, '站点无法访问', '9', 'cms_census_issue_type', 0, '', '', NULL, '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0');

INSERT IGNORE INTO `system_dict_data` (`id`, `sort`, `label`, `value`, `dict_type`, `status`, `color_type`, `css_class`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3013, 6, '批量新增译文', '6', 'cms_static_task_type', 0, 'primary', '', '非 AI 译文建稿任务', '1', '2026-10-30 21:44:40', '1', '2026-10-30 21:44:40', b'0');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (1, '用户性别', 'system_user_sex', 0, NULL, 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (2, '参数类型', 'infra_config_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (3, '通知类型', 'system_notice_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (4, '操作类型', 'infra_operate_type', 0, NULL, 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (5, '系统状态', 'common_status', 0, NULL, 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (6, 'Boolean 是否类型', 'infra_boolean_string', 0, 'boolean 转是否', '', '2021-01-19 03:20:08', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (7, '登陆结果', 'system_login_result', 0, '登陆结果', '', '2021-01-18 06:17:11', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (8, '代码生成模板类型', 'infra_codegen_template_type', 0, NULL, '', '2021-02-05 07:08:06', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (9, '定时任务状态', 'infra_job_status', 0, NULL, '', '2021-02-07 07:44:16', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (10, '定时任务日志状态', 'infra_job_log_status', 0, NULL, '', '2021-02-08 10:03:51', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (11, '用户类型', 'user_type', 0, NULL, '', '2021-02-26 00:15:51', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (12, 'API 异常数据的处理状态', 'infra_api_error_log_process_status', 0, NULL, '', '2021-02-26 07:07:01', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (13, '短信渠道编码', 'system_sms_channel_code', 0, NULL, '1', '2021-04-05 01:04:50', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (14, '短信模板的类型', 'system_sms_template_type', 0, NULL, '1', '2021-04-05 21:50:43', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (15, '短信发送状态', 'system_sms_send_status', 0, NULL, '1', '2021-04-11 20:18:03', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (16, '短信接收状态', 'system_sms_receive_status', 0, NULL, '1', '2021-04-11 20:27:14', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (17, '登陆日志的类型', 'system_login_type', 0, '登陆日志的类型', '1', '2021-10-06 00:50:46', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (27, '代码生成的场景枚举', 'infra_codegen_scene', 0, '代码生成的场景枚举', '1', '2022-02-02 13:14:45', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (28, '角色类型', 'system_role_type', 0, '角色类型', '1', '2022-02-16 13:01:46', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (29, '文件存储器', 'infra_file_storage', 0, '文件存储器', '1', '2022-03-15 00:24:38', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (30, 'OAuth 2.0 授权类型', 'system_oauth2_grant_type', 0, 'OAuth 2.0 授权类型（模式）', '1', '2022-05-12 00:20:52', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (31, '商品 SPU 状态', 'product_spu_status', 0, '商品 SPU 状态', '1', '2022-10-24 21:19:04', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (32, '优惠类型', 'promotion_discount_type', 0, '优惠类型', '1', '2022-11-01 12:46:06', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (33, '优惠劵模板的有限期类型', 'promotion_coupon_template_validity_type', 0, '优惠劵模板的有限期类型', '1', '2022-11-02 00:06:20', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (34, '营销的商品范围', 'promotion_product_scope', 0, '营销的商品范围', '1', '2022-11-02 00:28:01', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (35, '优惠劵的状态', 'promotion_coupon_status', 0, '优惠劵的状态', '1', '2022-11-04 00:14:49', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (36, '优惠劵的领取方式', 'promotion_coupon_take_type', 0, '优惠劵的领取方式', '1', '2022-11-04 19:12:27', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (37, '促销活动的状态', 'promotion_activity_status', 0, '促销活动的状态', '1', '2022-11-04 22:54:23', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (38, '营销的条件类型', 'promotion_condition_type', 0, '营销的条件类型', '1', '2022-11-04 22:59:23', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (39, '交易售后状态', 'trade_after_sale_status', 0, '交易售后状态', '1', '2022-11-19 20:52:56', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (40, '交易售后的类型', 'trade_after_sale_type', 0, '交易售后的类型', '1', '2022-11-19 21:04:09', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (41, '交易售后的方式', 'trade_after_sale_way', 0, '交易售后的方式', '1', '2022-11-19 21:39:04', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (42, '终端', 'terminal', 0, '终端', '1', '2022-12-10 10:50:50', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (43, '交易订单的类型', 'trade_order_type', 0, '交易订单的类型', '1', '2022-12-10 16:33:54', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (44, '交易订单的状态', 'trade_order_status', 0, '交易订单的状态', '1', '2022-12-10 16:48:44', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (45, '交易订单项的售后状态', 'trade_order_item_after_sale_status', 0, '交易订单项的售后状态', '1', '2022-12-10 20:58:08', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (48, '邮件发送状态', 'system_mail_send_status', 0, '邮件发送状态', '1', '2023-01-26 09:53:13', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (49, '站内信模版的类型', 'system_notify_template_type', 0, '站内信模版的类型', '1', '2023-01-28 10:35:10', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (50, '代码生成的前端类型', 'infra_codegen_front_type', 0, '', '1', '2023-04-12 23:57:52', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (51, '快递计费方式', 'trade_delivery_express_charge_mode', 0, '用于商城交易模块配送管理', '1', '2023-05-21 22:45:03', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (55, '交易配送类型', 'trade_delivery_type', 0, '', '1', '2023-08-23 00:03:14', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (56, '分佣模式', 'brokerage_enabled_condition', 0, NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (57, '分销关系绑定模式', 'brokerage_bind_mode', 0, NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (58, '佣金提现类型', 'brokerage_withdraw_type', 0, NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (59, '佣金记录业务类型', 'brokerage_record_biz_type', 0, NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (60, '佣金记录状态', 'brokerage_record_status', 0, NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (61, '佣金提现状态', 'brokerage_withdraw_status', 0, NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (62, '佣金提现银行', 'brokerage_bank_name', 0, NULL, '', '2023-09-28 02:46:05', '', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (63, '砍价记录的状态', 'promotion_bargain_record_status', 0, '', '1', '2023-10-05 10:41:08', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (64, '拼团记录的状态', 'promotion_combination_record_status', 0, '', '1', '2023-10-08 07:24:25', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (69, 'Banner 位置', 'promotion_banner_position', 0, '', '1', '2023-10-08 07:24:25', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (70, '社交类型', 'system_social_type', 0, '', '1', '2023-11-04 13:03:54', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (81, '时间间隔', 'date_interval', 0, '', '1', '2024-03-29 22:50:09', '1', '2026-08-14 01:49:42', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (201, '往来企业类型', 'merchant_type', 0, 'WMS 往来企业类型', '1', '2026-05-10 15:26:09', '1', '2026-08-14 01:49:42', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (274, 'CMS 文章状态', 'cms_article_status', 0, 'CMS 文章状态（对齐后端 CmsArticleStatusEnum）', '1', '2026-08-15 09:43:09', '1', '2026-08-15 10:07:34', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (275, 'CMS 编辑器类型', 'cms_editor_type', 0, 'CMS 编辑器类型（对齐后端 CmsEditorTypeEnum）', '1', '2026-08-15 21:33:04', '1', '2026-08-15 21:33:04', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (280, 'CMS 布尔值', 'cms_boolean', 0, 'CMS 布尔值（true=是，false=否）', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (281, 'CMS 互动参与模式', 'cms_interaction_mode', 0, 'CMS 互动参与模式（1=独立访客，2=独立 IP，3=独立用户）', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (282, 'CMS 投票状态', 'cms_vote_status', 0, 'CMS 投票状态（对齐后端 CmsVoteStatusEnum）', '1', '2026-09-01 21:26:46', '1', '2026-09-01 21:26:46', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (300, 'CMS 采集状态', 'cms_collection_status', 0, '采集任务运行状态', '1', '2026-09-05 21:01:49', '1', '2026-09-05 21:01:49', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (353, '物品价值类型', 'eam_goods_cost_type', 0, 'EAM 物品档案价值类型', '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (354, '库存出库类型', 'eam_stock_out_type', 0, 'EAM 库存出库单类型', '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (355, '库存入库类型', 'eam_stock_in_type', 0, 'EAM 库存入库单类型', '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (356, '资产来源', 'eam_source', 0, 'EAM 资产与入库来源', '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (357, '采购验收入库方式', 'eam_purchase_import_method', 0, 'EAM 采购验收生成入库单策略', '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (358, '供应商评级', 'eam_supplier_grade', 0, 'EAM 供应商评级', '', '2026-09-23 22:53:31', '', '2026-09-23 22:53:31', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (359, '保养类型', 'eam_maintain_type', 0, 'EAM 保养项目类型', '', '2026-09-23 23:11:22', '', '2026-09-23 23:11:22', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (360, 'ç»´ä¿®éªŒæ”¶ç»“æžœç±»åž‹', 'eam_repair_result_type', 0, 'EAM ç»´ä¿®éªŒæ”¶ç»“æžœç±»åž‹', '', '2026-09-24 05:28:27', '', '2026-09-24 05:28:27', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (361, 'CMS 密码强度', 'cms_password_strength', 0, 'CMS 密码强度', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (362, 'CMS 存储类型', 'cms_storage_type', 0, 'CMS 文件存储类型', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (363, 'CMS 表单模式', 'cms_form_mode', 0, 'CMS 表单录入模式', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (364, 'CMS 模型类型', 'cms_model_type', 0, 'CMS 模型类型', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (365, 'CMS 共享范围', 'cms_share_scope', 0, 'CMS 模型和内容块共享范围', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (366, 'CMS 栏目类型', 'cms_channel_type', 0, 'CMS 栏目类型', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (367, 'CMS 编辑器空行处理', 'cms_editor_empty_line', 0, 'CMS 编辑器空行处理方式', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (368, 'CMS 文章录入类型', 'cms_article_input_type', 0, 'CMS 文章录入类型', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (369, 'CMS 文章来源类型', 'cms_article_source_type', 0, 'CMS 文章来源类型', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (370, 'CMS 链接组展示类型', 'cms_link_group_display_type', 0, 'CMS 链接组展示类型', '1', '2026-09-24 10:05:52', '1', '2026-10-20 16:58:47', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (371, 'CMS 附件业务类型', 'cms_attachment_business_type', 0, 'CMS 附件业务类型', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (372, 'CMS 静态化任务类型', 'cms_static_task_type', 0, 'CMS 静态化任务类型', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (373, 'CMS 静态化任务触发方式', 'cms_static_task_trigger_type', 0, 'CMS 静态化任务触发方式', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (374, 'CMS 静态化任务状态', 'cms_static_task_status', 0, 'CMS 静态化任务状态', '1', '2026-09-24 10:05:52', '1', '2026-09-24 10:05:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (375, 'CMS 表单提交状态', 'cms_form_submission_status', 0, 'CMS 表单提交状态', '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (376, 'CMS 留言状态', 'cms_message_board_status', 0, 'CMS 留言状态', '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (377, 'CMS 评论状态', 'cms_comment_status', 0, 'CMS 评论状态', '1', '2026-09-24 10:05:53', '1', '2026-09-24 10:05:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (378, 'ç›˜ç‚¹è®¡åˆ’ç±»åž‹', 'eam_inventory_plan_type', 0, 'EAM ç›˜ç‚¹è®¡åˆ’ç±»åž‹', '', '2026-09-24 21:44:56', '', '2026-09-24 21:44:56', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (380, '软件版权类型', 'asset_software_copyright_type', 0, 'EAM 软件资产源字典', '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (381, '软件许可模式', 'asset_software_license_mode', 0, 'EAM 软件资产源字典', '', '2026-09-25 02:12:41', '', '2026-09-25 02:12:41', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (386, 'CMS 下载 - 软件类型', 'cms_download_type', 0, '下载文章的软件类型', '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (387, 'CMS 下载 - 授权方式', 'cms_download_license', 0, '下载文章的授权方式', '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (388, 'CMS 下载 - 界面语言', 'cms_download_language', 0, '下载文章的界面语言', '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (389, 'CMS 下载 - 推荐星级', 'cms_download_star', 0, '下载文章的推荐星级', '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (390, 'CMS 下载 - 运行环境', 'cms_download_system', 0, '下载文章的运行环境', '1', '2026-09-26 02:42:44', '1', '2026-09-26 02:42:44', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (391, 'CMS 视频 - 地区', 'cms_video_area', 0, '视频文章的地区', '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (392, 'CMS 视频 - 类型', 'cms_video_type', 0, '视频文章的类型', '1', '2026-09-26 03:11:41', '1', '2026-09-26 03:11:41', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (393, 'CMS 产品 - 手机机身存储', 'cms_product_phone_storage', 0, '对齐产品模型筛选', '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (394, 'CMS 产品 - 手机屏幕尺寸', 'cms_product_phone_screen', 0, '对齐产品模型筛选', '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (395, 'CMS 产品 - 自行车类型', 'cms_product_bike_type', 0, '对齐产品模型筛选', '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (396, 'CMS 产品 - 相机类型', 'cms_product_camera_type', 0, '对齐产品模型筛选', '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (397, 'CMS 产品 - 相机卡口', 'cms_product_camera_mount', 0, '对齐产品模型筛选', '1', '2026-09-26 06:02:19', '1', '2026-09-26 06:02:19', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (398, 'EAM 文档模板业务编码', 'eam_document_template_code', 0, '源 sys_code_register 的 EAM 业务编码', '', '2026-09-27 23:31:57', '', '2026-09-27 23:31:57', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (400, 'AI1 模型类型', 'ai1_model_type', 0, '对应 Ai1ModelTypeEnum', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (401, 'AI1 MCP 传输方式', 'ai1_mcp_transport', 0, '对应 Ai1McpTransportEnum', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (402, 'AI1 知识文档状态', 'ai1_knowledge_document_status', 0, '对应 Ai1KnowledgeDocumentStatusEnum', '1', '2026-09-30 11:31:36', '1', '2026-09-30 11:31:36', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (403, 'AI1 会话消息角色', 'ai1_session_message_role', 0, '对应 Ai1SessionMessageRoleEnum', '1', '2026-09-30 16:49:11', '1', '2026-09-30 22:25:03', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (404, 'AI1 会话消息状态', 'ai1_session_message_status', 0, '对应 Ai1SessionMessageStatusEnum', '1', '2026-09-30 16:49:11', '1', '2026-09-30 22:25:03', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (405, 'AI1 SKILL 文件类型', 'ai1_skill_file_type', 0, '对应 Ai1SkillFileTypeEnum', '1', '2026-09-30 17:19:05', '1', '2026-09-30 17:19:05', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (570, 'CMS 文章来源', 'cms_article_source', 0, '文章表单来源联想，允许录入自定义来源', '1', '2026-10-06 23:10:49', '1', '2026-10-06 23:10:49', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (571, 'AI2 工作流分类', 'ai2_workflow_category', 0, '工作流与工作流模板的分类', '', '2026-10-07 03:22:50', '', '2026-10-07 03:22:50', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (572, 'å¯ç”¨çŠ¶æ€', 'eam_status_enable', 0, 'EAM å…¬å…±å¯ç”¨çŠ¶æ€ï¼ˆæº StatusEnableEnumï¼‰', '', '2026-10-08 08:01:27', '', '2026-10-08 08:01:27', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (573, '资产报修类型', 'eam_repair_type', 0, 'EAM 资产报修类型，字典项按源 sys_dict_item 维护', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (574, '单据办理状态', 'eam_asset_handle_status', 0, 'EAM 单据办理状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (575, '库位状态', 'eam_warehouse_position_status', 0, 'EAM 库位状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (576, '资产借用状态', 'eam_asset_borrow_status', 0, 'EAM 资产借用状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (577, '资产报修维修状态', 'eam_asset_repair_status', 0, 'EAM 资产报修维修状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (578, '维修工单状态', 'eam_repair_order_status', 0, 'EAM 维修工单状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (579, '维修方式', 'eam_repair_order_type', 0, 'EAM 维修方式', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (580, '维修验收结论', 'eam_repair_order_act_accept_status', 0, 'EAM 维修验收结论', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (581, '保养任务状态', 'eam_maintain_task_status', 0, 'EAM 保养任务状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (582, '保养项目结果', 'eam_maintain_task_project_status', 0, 'EAM 保养项目结果', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (583, '计划状态', 'eam_plan_status', 0, 'EAM 计划状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (584, '保养周期方式', 'eam_maintain_cycle_method', 0, 'EAM 保养周期方式', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (585, '盘点执行状态', 'eam_inventory_action_status', 0, 'EAM 盘点执行状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (586, '盘点数据同步状态', 'eam_inventory_data_status', 0, 'EAM 盘点数据同步状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (587, '盘点明细状态', 'eam_inventory_detail_status', 0, 'EAM 盘点明细状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (588, '巡检点结果', 'eam_inspection_task_point_status', 0, 'EAM 巡检点结果', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (589, '巡检异常处理状态', 'eam_inspection_task_abnormal_status', 0, 'EAM 巡检异常处理状态', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (590, '检查项类型', 'eam_check_item_type', 0, 'EAM 检查项类型', '', '2026-10-08 10:45:52', '', '2026-10-08 10:45:52', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (591, '资产导入状态', 'eam_asset_import_status', 0, 'EAM 资产导入状态', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (592, '采购验收状态', 'eam_asset_apply_check_status', 0, 'EAM 采购验收状态', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (593, '巡检任务状态', 'eam_inspection_task_status', 0, 'EAM 巡检任务状态', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (594, '折旧方案编码', 'eam_depreciation_code', 0, 'EAM 折旧方案编码', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (595, '折旧方法', 'eam_depreciation_method', 0, 'EAM 折旧方法', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (596, '残值率选择', 'eam_depreciation_residual_value_select', 0, 'EAM 残值率选择', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (597, '首次折旧方式', 'eam_depreciation_first_method', 0, 'EAM 首次折旧方式', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (598, '折旧规则动作', 'eam_depreciation_rule_action', 0, 'EAM 折旧规则动作', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (599, '折旧计算方式', 'eam_depreciation_calculation_type', 0, 'EAM 折旧计算方式', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (600, '折旧计算返回类型', 'eam_depreciation_return_type', 0, 'EAM 折旧计算返回类型', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (601, '折旧执行状态', 'eam_depreciation_oper_status', 0, 'EAM 折旧执行状态', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (602, '折旧明细结果', 'eam_depreciation_detail_result', 0, 'EAM 折旧明细结果', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (603, '折旧明细计算状态', 'eam_depreciation_detail_status', 0, 'EAM 折旧明细计算状态', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (604, '物品类型', 'eam_stock_goods_type', 0, 'EAM 物品类型', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (605, '维保批量更新方式', 'eam_maintenance_record_batch_update_type', 0, 'EAM 维保批量更新方式', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (606, '维保状态', 'eam_maintenance_status', 0, 'EAM 资产字段选项', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (607, '财务选项', 'eam_financial_options', 0, 'EAM 资产字段选项', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (608, '财务费用项目', 'eam_expense_items', 0, 'EAM 资产字段选项', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (609, '资产报废方式', 'eam_scrap_method', 0, 'EAM 资产报废方式', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (610, '是否', 'eam_status_yn', 0, 'EAM 公共是否状态（源 StatusYNEnum）', '', '2026-10-08 10:45:53', '', '2026-10-08 10:45:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (611, '验收153612表单选项', 'cms_jack_form_20261021_153612', 0, 'jack-form-todo-20261021-153612', '1', '2026-10-21 17:19:14', '1', '2026-10-21 17:19:14', b'0', '1970-01-01 00:00:00');

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (612, 'CMS 领导信箱状态', 'cms_mailbox_status', 0, 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (613, 'CMS 依申请公开状态', 'cms_disclosure_status', 0, 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (614, 'CMS 在线访谈状态', 'cms_interview_status', 0, 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (615, 'CMS 在线访谈提问审核状态', 'cms_interview_question_status', 0, 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (616, 'CMS 网站普查状态', 'cms_census_status', 0, 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (617, 'CMS 网站普查评定结论', 'cms_census_conclusion', 0, 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (618, 'CMS 网站普查问题处理状态', 'cms_census_issue_status', 0, 'Jack 政务内置状态', '1', '2026-10-27 23:22:53', '1', '2026-10-27 23:22:53', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (619, 'CMS 领导信件类型', 'cms_mailbox_category', 0, 'Jack 政务内置枚举（对齐后端 CmsMailboxCategoryEnum）', '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (620, 'CMS 领导信箱满意度', 'cms_mailbox_rate', 0, 'Jack 政务内置枚举（对齐后端 CmsMailboxRateEnum）', '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (621, 'CMS 依申请公开申请人类型', 'cms_disclosure_applicant_type', 0, 'Jack 政务内置枚举（对齐后端 CmsDisclosureApplicantTypeEnum）', '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (622, 'CMS 依申请公开信息提供方式', 'cms_disclosure_provide_method', 0, 'Jack 政务内置枚举（对齐后端 CmsDisclosureProvideMethodEnum）', '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (623, 'CMS 依申请公开信息获取方式', 'cms_disclosure_obtain_method', 0, 'Jack 政务内置枚举（对齐后端 CmsDisclosureObtainMethodEnum）', '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (624, 'CMS 依申请公开答复类型', 'cms_disclosure_reply_type', 0, 'Jack 政务内置枚举（对齐后端 CmsDisclosureReplyTypeEnum）', '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (625, 'CMS 网站普查指标类型', 'cms_census_indicator_type', 0, 'Jack 政务内置枚举（对齐后端 CmsCensusIndicatorTypeEnum）', '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (626, 'CMS 网站普查指标分类', 'cms_census_indicator_category', 0, 'Jack 政务内置枚举（对齐后端 CmsCensusIndicatorCategoryEnum；扣分、加分下存在同名分类，按值区分）', '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0', NULL);

INSERT IGNORE INTO `system_dict_type` (`id`, `name`, `type`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `deleted_time`) VALUES (627, 'CMS 网站普查问题类型', 'cms_census_issue_type', 0, 'Jack 政务内置枚举（对齐后端 CmsCensusIssueTypeEnum）', '1', '2026-10-28 14:36:12', '1', '2026-10-28 14:36:12', b'0', NULL);

INSERT IGNORE INTO `system_mail_account` (`id`, `mail`, `username`, `password`, `host`, `port`, `ssl_enable`, `starttls_enable`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, '7684413@qq.com', '7684413@qq.com', '1234576', '127.0.0.1', 8080, b'0', b'0', '1', '2023-01-25 17:39:52', '1', '2025-04-04 16:34:40', b'0');

INSERT IGNORE INTO `system_mail_account` (`id`, `mail`, `username`, `password`, `host`, `port`, `ssl_enable`, `starttls_enable`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 'ydym_test@163.com', 'ydym_test@163.com', 'WBZTEINMIFVRYSOE', 'smtp.163.com', 465, b'1', b'0', '1', '2023-01-26 01:26:03', '1', '2025-12-20 18:09:32', b'0');

INSERT IGNORE INTO `system_mail_account` (`id`, `mail`, `username`, `password`, `host`, `port`, `ssl_enable`, `starttls_enable`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3, '76854114@qq.com', '3335', '11234', 'yunai1.cn', 466, b'0', b'0', '1', '2023-01-27 15:06:38', '1', '2023-01-27 07:08:36', b'1');

INSERT IGNORE INTO `system_mail_account` (`id`, `mail`, `username`, `password`, `host`, `port`, `ssl_enable`, `starttls_enable`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (4, '7685413x@qq.com', '2', '3', '4', 5, b'1', b'0', '1', '2023-04-12 23:05:06', '1', '2023-04-12 15:05:11', b'1');

INSERT IGNORE INTO `system_mail_template` (`id`, `name`, `code`, `account_id`, `nickname`, `title`, `content`, `params`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (13, '后台用户短信登录', 'admin-sms-login', 1, '奥特曼', '你猜我猜', '<p>您的验证码是{code}，名字是{name}</p>', '[\"code\",\"name\"]', 0, '3', '1', '2021-10-11 08:10:00', '1', '2023-12-02 19:51:14', b'0');

INSERT IGNORE INTO `system_mail_template` (`id`, `name`, `code`, `account_id`, `nickname`, `title`, `content`, `params`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (14, '测试模版', 'test_01', 2, '芋艿', '一个标题', '<p>你是 {key01} 吗？</p><p><br></p><p>是的话，赶紧 {key02} 一下！</p>', '[\"key01\",\"key02\"]', 0, NULL, '1', '2023-01-26 01:27:40', '1', '2025-07-26 21:48:45', b'0');

INSERT IGNORE INTO `system_mail_template` (`id`, `name`, `code`, `account_id`, `nickname`, `title`, `content`, `params`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (15, '3', '2', 2, '7', '4', '<p>45</p>', '[]', 1, '80', '1', '2023-01-27 15:50:35', '1', '2025-07-26 21:47:49', b'1');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, '系统管理', '', 1, 10, 0, '/system', 'ep:tools', NULL, NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-09-02 18:42:01', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (4, '用户管理', 'system:user:list', 2, 1, 1, 'user', 'ep:avatar', 'system/user/index', 'SystemUser', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (5, '角色管理', '', 2, 2, 1, 'role', 'ep:user', 'system/role/index', 'SystemRole', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (6, '菜单管理', '', 2, 3, 1, 'menu', 'ep:menu', 'system/menu/index', 'SystemMenu', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (7, '部门管理', '', 2, 4, 1, 'dept', 'fa:address-card', 'system/dept/index', 'SystemDept', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (8, '岗位管理', '', 2, 5, 1, 'post', 'fa:address-book-o', 'system/post/index', 'SystemPost', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (9, '字典管理', '', 2, 6, 1, 'dict', 'ep:collection', 'system/dict/index', 'SystemDictType', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (11, '通知公告', '', 2, 4, 772, 'notice', 'ep:takeaway-box', 'system/notice/index', 'SystemNotice', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (12, '审计日志', '', 1, 9, 1, 'log', 'ep:document-copy', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (13, '令牌管理', '', 2, 2, 201, 'token', 'fa:key', 'system/oauth2/token/index', 'SystemTokenClient', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (21, '操作日志', '', 2, 1, 12, 'operate-log', 'ep:position', 'system/operatelog/index', 'SystemOperateLog', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (22, '登录日志', '', 2, 2, 12, 'login-log', 'ep:promotion', 'system/loginlog/index', 'SystemLoginLog', 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (23, '用户查询', 'system:user:query', 3, 1, 4, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (24, '用户新增', 'system:user:create', 3, 2, 4, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (25, '用户修改', 'system:user:update', 3, 3, 4, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (26, '用户删除', 'system:user:delete', 3, 4, 4, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (27, '用户导出', 'system:user:export', 3, 5, 4, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (28, '用户导入', 'system:user:import', 3, 6, 4, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (29, '重置密码', 'system:user:update-password', 3, 7, 4, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (30, '角色查询', 'system:role:query', 3, 1, 5, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (31, '角色新增', 'system:role:create', 3, 2, 5, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (32, '角色修改', 'system:role:update', 3, 3, 5, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (33, '角色删除', 'system:role:delete', 3, 4, 5, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (34, '角色导出', 'system:role:export', 3, 5, 5, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (35, '菜单查询', 'system:menu:query', 3, 1, 6, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (36, '菜单新增', 'system:menu:create', 3, 2, 6, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (37, '菜单修改', 'system:menu:update', 3, 3, 6, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (38, '菜单删除', 'system:menu:delete', 3, 4, 6, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (39, '部门查询', 'system:dept:query', 3, 1, 7, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (40, '部门新增', 'system:dept:create', 3, 2, 7, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (41, '部门修改', 'system:dept:update', 3, 3, 7, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (42, '部门删除', 'system:dept:delete', 3, 4, 7, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (43, '岗位查询', 'system:post:query', 3, 1, 8, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (44, '岗位新增', 'system:post:create', 3, 2, 8, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (45, '岗位修改', 'system:post:update', 3, 3, 8, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (46, '岗位删除', 'system:post:delete', 3, 4, 8, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (47, '岗位导出', 'system:post:export', 3, 5, 8, '', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (48, '字典查询', 'system:dict:query', 3, 1, 9, '#', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (49, '字典新增', 'system:dict:create', 3, 2, 9, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (50, '字典修改', 'system:dict:update', 3, 3, 9, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (51, '字典删除', 'system:dict:delete', 3, 4, 9, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (52, '字典导出', 'system:dict:export', 3, 5, 9, '#', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (58, '公告查询', 'system:notice:query', 3, 1, 11, '#', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (59, '公告新增', 'system:notice:create', 3, 2, 11, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (60, '公告修改', 'system:notice:update', 3, 3, 11, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (61, '公告删除', 'system:notice:delete', 3, 4, 11, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (62, '操作查询', 'system:operate-log:query', 3, 1, 21, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (63, '日志导出', 'system:operate-log:export', 3, 2, 21, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (64, '登录查询', 'system:login-log:query', 3, 1, 22, '#', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (65, '日志导出', 'system:login-log:export', 3, 3, 22, '#', '#', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (66, '令牌列表', 'system:oauth2-token:page', 3, 1, 13, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (67, '令牌删除', 'system:oauth2-token:delete', 3, 2, 13, '', '', '', NULL, 0, b'1', b'1', b'1', 'admin', '2021-01-05 17:03:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (78, '设置角色菜单权限', 'system:permission:assign-role-menu', 3, 6, 5, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-01-06 17:53:44', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (79, '设置角色数据权限', 'system:permission:assign-role-data-scope', 3, 7, 5, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-01-06 17:56:31', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (80, '设置用户角色', 'system:permission:assign-user-role', 3, 8, 5, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-01-07 10:23:28', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (98, '短信管理', '', 1, 1, 772, 'sms', 'ep:message', NULL, NULL, 0, b'1', b'1', b'1', '1', '2021-04-05 01:10:16', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (99, '短信渠道', '', 2, 0, 98, 'sms-channel', 'fa:stack-exchange', 'system/sms/channel/index', 'SystemSmsChannel', 0, b'1', b'1', b'1', '', '2021-04-01 11:07:15', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (100, '短信渠道查询', 'system:sms-channel:query', 3, 1, 99, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-01 11:07:15', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (101, '短信渠道创建', 'system:sms-channel:create', 3, 2, 99, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-01 11:07:15', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (102, '短信渠道更新', 'system:sms-channel:update', 3, 3, 99, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-01 11:07:15', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (103, '短信渠道删除', 'system:sms-channel:delete', 3, 4, 99, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-01 11:07:15', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (104, '短信模板', '', 2, 1, 98, 'sms-template', 'ep:connection', 'system/sms/template/index', 'SystemSmsTemplate', 0, b'1', b'1', b'1', '', '2021-04-01 17:35:17', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (105, '短信模板查询', 'system:sms-template:query', 3, 1, 104, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-01 17:35:17', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (106, '短信模板创建', 'system:sms-template:create', 3, 2, 104, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-01 17:35:17', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (107, '短信模板更新', 'system:sms-template:update', 3, 3, 104, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-01 17:35:17', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (108, '短信模板删除', 'system:sms-template:delete', 3, 4, 104, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-01 17:35:17', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (109, '短信模板导出', 'system:sms-template:export', 3, 5, 104, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-01 17:35:17', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (110, '发送测试短信', 'system:sms-template:send-sms', 3, 6, 104, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2021-04-11 00:26:40', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (111, '短信日志', '', 2, 2, 98, 'sms-log', 'fa:edit', 'system/sms/log/index', 'SystemSmsLog', 0, b'1', b'1', b'1', '', '2021-04-11 08:37:05', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (112, '短信日志查询', 'system:sms-log:query', 3, 1, 111, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-11 08:37:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (113, '短信日志导出', 'system:sms-log:export', 3, 5, 111, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-04-11 08:37:05', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (129, '租户列表', '', 2, 0, 181, 'list', 'ep:house', 'system/tenant/index', 'SystemTenant', 0, b'1', b'1', b'1', '', '2021-12-14 12:31:43', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (130, '租户查询', 'system:tenant:query', 3, 1, 129, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-12-14 12:31:44', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (131, '租户创建', 'system:tenant:create', 3, 2, 129, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-12-14 12:31:44', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (132, '租户更新', 'system:tenant:update', 3, 3, 129, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-12-14 12:31:44', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (133, '租户删除', 'system:tenant:delete', 3, 4, 129, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-12-14 12:31:44', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (134, '租户导出', 'system:tenant:export', 3, 5, 129, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2021-12-14 12:31:44', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (181, '租户管理', '', 2, 0, 1, 'tenant', 'fa-solid:house-user', NULL, NULL, 0, b'1', b'1', b'1', '1', '2022-02-20 01:41:13', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (182, '租户套餐', '', 2, 0, 181, 'package', 'fa:bars', 'system/tenantPackage/index', 'SystemTenantPackage', 0, b'1', b'1', b'1', '', '2022-02-19 17:44:06', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (183, '租户套餐查询', 'system:tenant-package:query', 3, 1, 182, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2022-02-19 17:44:06', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (184, '租户套餐创建', 'system:tenant-package:create', 3, 2, 182, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2022-02-19 17:44:06', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (185, '租户套餐更新', 'system:tenant-package:update', 3, 3, 182, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2022-02-19 17:44:06', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (186, '租户套餐删除', 'system:tenant-package:delete', 3, 4, 182, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2022-02-19 17:44:06', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (201, 'OAuth 2.0', '', 2, 10, 1, 'oauth2', 'fa:dashcube', NULL, NULL, 0, b'1', b'1', b'1', '1', '2022-05-09 23:38:17', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (202, '应用管理', '', 2, 0, 201, 'oauth2/application', 'fa:hdd-o', 'system/oauth2/client/index', 'SystemOAuth2Client', 0, b'1', b'1', b'1', '', '2022-05-10 16:26:33', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (203, '客户端查询', 'system:oauth2-client:query', 3, 1, 202, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2022-05-10 16:26:33', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (204, '客户端创建', 'system:oauth2-client:create', 3, 2, 202, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2022-05-10 16:26:33', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (205, '客户端更新', 'system:oauth2-client:update', 3, 3, 202, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2022-05-10 16:26:33', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (206, '客户端删除', 'system:oauth2-client:delete', 3, 4, 202, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2022-05-10 16:26:33', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (271, '地区管理', '', 2, 14, 1, 'area', 'fa:map-marker', 'system/area/index', 'SystemArea', 0, b'1', b'1', b'1', '1', '2022-12-23 17:35:05', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (318, '邮箱管理', '', 2, 2, 772, 'mail', 'fa-solid:mail-bulk', NULL, NULL, 0, b'1', b'1', b'1', '1', '2023-01-25 17:27:44', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (319, '邮箱账号', '', 2, 0, 318, 'mail-account', 'fa:universal-access', 'system/mail/account/index', 'SystemMailAccount', 0, b'1', b'1', b'1', '', '2023-01-25 09:33:48', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (320, '账号查询', 'system:mail-account:query', 3, 1, 319, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-25 09:33:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (321, '账号创建', 'system:mail-account:create', 3, 2, 319, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-25 09:33:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (322, '账号更新', 'system:mail-account:update', 3, 3, 319, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-25 09:33:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (323, '账号删除', 'system:mail-account:delete', 3, 4, 319, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-25 09:33:48', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (324, '邮件模版', '', 2, 0, 318, 'mail-template', 'fa:tag', 'system/mail/template/index', 'SystemMailTemplate', 0, b'1', b'1', b'1', '', '2023-01-25 12:05:31', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (325, '模版查询', 'system:mail-template:query', 3, 1, 324, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-25 12:05:31', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (326, '模版创建', 'system:mail-template:create', 3, 2, 324, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-25 12:05:31', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (327, '模版更新', 'system:mail-template:update', 3, 3, 324, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-25 12:05:31', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (328, '模版删除', 'system:mail-template:delete', 3, 4, 324, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-25 12:05:31', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (329, '邮件记录', '', 2, 0, 318, 'mail-log', 'fa:edit', 'system/mail/log/index', 'SystemMailLog', 0, b'1', b'1', b'1', '', '2023-01-26 02:16:50', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (330, '日志查询', 'system:mail-log:query', 3, 1, 329, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-26 02:16:50', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (331, '发送测试邮件', 'system:mail-template:send-mail', 3, 5, 324, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-26 23:29:15', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (332, '站内信管理', '', 1, 3, 772, 'notify', 'ep:message-box', NULL, NULL, 0, b'1', b'1', b'1', '1', '2023-01-28 10:25:18', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (333, '模板管理', '', 2, 0, 332, 'notify-template', 'fa:archive', 'system/notify/template/index', 'SystemNotifyTemplate', 0, b'1', b'1', b'1', '', '2023-01-28 02:26:42', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (334, '站内信模板查询', 'system:notify-template:query', 3, 1, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-28 02:26:42', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (335, '站内信模板创建', 'system:notify-template:create', 3, 2, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-28 02:26:42', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (336, '站内信模板更新', 'system:notify-template:update', 3, 3, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-28 02:26:42', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (337, '站内信模板删除', 'system:notify-template:delete', 3, 4, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-28 02:26:42', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (338, '发送测试站内信', 'system:notify-template:send-notify', 3, 5, 333, '', '', '', NULL, 0, b'1', b'1', b'1', '1', '2023-01-28 10:54:43', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (339, '消息记录', '', 2, 0, 332, 'notify-message', 'fa:edit', 'system/notify/message/index', 'SystemNotifyMessage', 0, b'1', b'1', b'1', '', '2023-01-28 04:28:22', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (340, '站内信消息查询', 'system:notify-message:query', 3, 1, 339, '', '', '', NULL, 0, b'1', b'1', b'1', '', '2023-01-28 04:28:22', '', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (529, '三方登录', '', 1, 10, 1, 'social', 'fa:rocket', '', '', 0, b'1', b'1', b'1', '1', '2023-11-04 12:12:01', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (530, '三方应用', '', 2, 1, 529, 'client', 'ep:set-up', 'system/social/client/index.vue', 'SocialClient', 0, b'1', b'1', b'1', '1', '2023-11-04 12:17:19', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (531, '三方应用查询', 'system:social-client:query', 3, 1, 530, '', '', '', '', 0, b'1', b'1', b'1', '1', '2023-11-04 12:43:12', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (532, '三方应用创建', 'system:social-client:create', 3, 2, 530, '', '', '', '', 0, b'1', b'1', b'1', '1', '2023-11-04 12:43:58', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (533, '三方应用更新', 'system:social-client:update', 3, 3, 530, '', '', '', '', 0, b'1', b'1', b'1', '1', '2023-11-04 12:44:27', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (534, '三方应用删除', 'system:social-client:delete', 3, 4, 530, '', '', '', '', 0, b'1', b'1', b'1', '1', '2023-11-04 12:44:43', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (535, '三方用户', 'system:social-user:query', 2, 2, 529, 'user', 'ep:avatar', 'system/social/user/index.vue', 'SocialUser', 0, b'1', b'1', b'1', '1', '2023-11-04 14:01:05', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (772, '消息中心', '', 1, 7, 1, 'messages', 'ep:chat-dot-round', '', '', 0, b'1', b'1', b'1', '1', '2024-04-22 23:54:30', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_menu` (`id`, `name`, `permission`, `type`, `sort`, `parent_id`, `path`, `icon`, `component`, `component_name`, `status`, `visible`, `keep_alive`, `always_show`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (920, '租户切换', 'system:tenant:visit', 3, 999, 129, '', '', '', '', 0, b'1', b'1', b'1', '1', '2025-05-05 15:25:32', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_notice` (`id`, `title`, `content`, `type`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '安天的公众', '<p>新版本内容133222</p>', 1, 0, 'admin', '2021-01-05 17:03:48', '\"1\"', '2025-08-31 09:38:22', b'0', 1);

INSERT IGNORE INTO `system_notice` (`id`, `title`, `content`, `type`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, '维护通知：2018-07-01 系统凌晨维护', '<p><img src=\"http://test.yudao.iocoder.cn/b7cb3cf49b4b3258bf7309a09dd2f4e5.jpg\" alt=\"\" data-href=\"\">11112222<img src=\"http://test.yudao.iocoder.cn/fe44fc7bdb82ca421184b2eebbaee9e2148d4a1827479a4eb4521e11d2a062ba.png\" alt=\"image\" data-href=\"http://test.yudao.iocoder.cn/fe44fc7bdb82ca421184b2eebbaee9e2148d4a1827479a4eb4521e11d2a062ba.png\">3333</p>\n<p><img src=\"http://test.yudao.iocoder.cn/20260503/备份.jpg\" alt=\"\" width=\"258\" height=\"258\"><img src=\"http://test.yudao.iocoder.cn/20260503/萌萌的皮卡丘.png\"></p>', 2, 1, 'admin', '2021-01-05 17:03:48', '1', '2026-05-03 23:07:48', b'0', 1);

INSERT IGNORE INTO `system_notice` (`id`, `title`, `content`, `type`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (4, '我是测试标题', '<p>哈哈哈哈123</p>', 1, 0, '110', '2022-02-22 01:01:25', '110', '2022-02-22 01:01:46', b'0', 121);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, 1, 2, 1, 'test', '123', '我是 1，我开始 2 了', 1, '{\"name\":\"1\",\"what\":\"2\"}', b'1', '2025-12-15 21:24:36', '1', '2023-01-28 11:44:08', '1', '2025-12-15 21:24:36', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3, 1, 2, 1, 'test', '123', '我是 1，我开始 2 了', 1, '{\"name\":\"1\",\"what\":\"2\"}', b'1', '2025-12-15 21:24:36', '1', '2023-01-28 11:45:04', '1', '2025-12-15 21:24:36', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (4, 103, 2, 2, 'register', '系统消息', '你好，欢迎 哈哈 加入大家庭！', 2, '{\"name\":\"哈哈\"}', b'0', NULL, '1', '2023-01-28 21:02:20', '1', '2023-01-28 21:02:20', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5, 1, 2, 1, 'test', '123', '我是 芋艿，我开始 写代码 了', 1, '{\"name\":\"芋艿\",\"what\":\"写代码\"}', b'1', '2025-12-08 17:25:28', '1', '2023-01-28 22:21:42', '1', '2025-12-08 17:25:28', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6, 1, 2, 1, 'test', '123', '我是 芋艿，我开始 写代码 了', 1, '{\"name\":\"芋艿\",\"what\":\"写代码\"}', b'1', '2025-12-08 17:25:30', '1', '2023-01-28 22:22:07', '1', '2025-12-08 17:25:30', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (7, 1, 2, 1, 'test', '123', '我是 2，我开始 3 了', 1, '{\"name\":\"2\",\"what\":\"3\"}', b'1', '2025-12-08 17:25:22', '1', '2023-01-28 23:45:21', '1', '2025-12-08 17:25:22', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (8, 1, 2, 2, 'register', '系统消息', '你好，欢迎 123 加入大家庭！', 2, '{\"name\":\"123\"}', b'1', '2025-12-08 16:46:01', '1', '2023-01-28 23:50:21', '1', '2025-12-08 16:46:01', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (9, 247, 1, 4, 'brokerage_withdraw_audit_approve', 'system', '您在2023-09-28 08:35:46提现￥0.09元的申请已通过审核', 2, '{\"reason\":null,\"createTime\":\"2023-09-28 08:35:46\",\"price\":\"0.09\"}', b'0', NULL, '1', '2023-09-28 16:36:22', '1', '2023-09-28 16:36:22', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (10, 247, 1, 4, 'brokerage_withdraw_audit_approve', 'system', '您在2023-09-30 20:59:40提现￥1.00元的申请已通过审核', 2, '{\"reason\":null,\"createTime\":\"2023-09-30 20:59:40\",\"price\":\"1.00\"}', b'0', NULL, '1', '2023-10-03 12:11:34', '1', '2023-10-03 12:11:34', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (11, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340024314】有一项【员工填写】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工填写\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340024314\",\"assessmentId\":82}', b'0', NULL, '1', '2026-07-29 23:47:05', '1', '2026-07-29 23:47:05', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (12, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340024314】有一项【目标确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"目标确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340024314\",\"assessmentId\":82}', b'0', NULL, '1', '2026-07-29 23:47:05', '1', '2026-07-29 23:47:05', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (13, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340024314】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340024314\",\"assessmentId\":82}', b'0', NULL, '1', '2026-07-29 23:47:05', '1', '2026-07-29 23:47:05', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (14, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340074418】有一项【员工填写】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工填写\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340074418\",\"assessmentId\":83}', b'0', NULL, '1', '2026-07-29 23:47:55', '1', '2026-07-29 23:47:55', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (15, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340074418】有一项【目标确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"目标确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340074418\",\"assessmentId\":83}', b'0', NULL, '1', '2026-07-29 23:47:55', '1', '2026-07-29 23:47:55', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (16, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340074418】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340074418\",\"assessmentId\":83}', b'0', NULL, '1', '2026-07-29 23:47:55', '1', '2026-07-29 23:47:55', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (17, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340074418】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340074418\",\"assessmentId\":83}', b'0', NULL, '1', '2026-07-29 23:47:55', '1', '2026-07-29 23:47:55', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (18, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【DEBUG-1785340117237】有一项【自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"DEBUG-1785340117237\",\"assessmentId\":84}', b'0', NULL, '1', '2026-07-29 23:48:37', '1', '2026-07-29 23:48:37', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (19, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【DEBUG-1785340117237】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"DEBUG-1785340117237\",\"assessmentId\":84}', b'0', NULL, '1', '2026-07-29 23:48:38', '1', '2026-07-29 23:48:38', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (20, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340320525】有一项【员工填写】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工填写\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340320525\",\"assessmentId\":85}', b'0', NULL, '1', '2026-07-29 23:52:01', '1', '2026-07-29 23:52:01', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (21, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340320525】有一项【目标确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"目标确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340320525\",\"assessmentId\":85}', b'0', NULL, '1', '2026-07-29 23:52:01', '1', '2026-07-29 23:52:01', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (22, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340320525】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340320525\",\"assessmentId\":85}', b'0', NULL, '1', '2026-07-29 23:52:01', '1', '2026-07-29 23:52:01', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (23, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340320525】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340320525\",\"assessmentId\":85}', b'0', NULL, '1', '2026-07-29 23:52:02', '1', '2026-07-29 23:52:02', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (24, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340385940】有一项【员工填写】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工填写\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86}', b'0', NULL, '1', '2026-07-29 23:53:06', '1', '2026-07-29 23:53:06', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (25, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340385940】有一项【目标确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"目标确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86}', b'0', NULL, '1', '2026-07-29 23:53:06', '1', '2026-07-29 23:53:06', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (26, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340385940】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86}', b'0', NULL, '1', '2026-07-29 23:53:07', '1', '2026-07-29 23:53:07', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (27, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340385940】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86}', b'0', NULL, '1', '2026-07-29 23:53:07', '1', '2026-07-29 23:53:07', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (28, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340385940】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86}', b'0', NULL, '100', '2026-07-29 23:53:07', '100', '2026-07-29 23:53:07', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (29, 1, 2, 1062142, 'hrm_performance_process_result', 'HRM', '绩效计划【API自测-申诉-1785340385940】的【考核评分】处理结果：已被驳回，请重新评分。', 2, '{\"result\":\"已被驳回，请重新评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86,\"actionName\":\"考核评分\"}', b'0', NULL, '100', '2026-07-29 23:53:07', '100', '2026-07-29 23:53:07', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (30, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340385940】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86}', b'0', NULL, '1', '2026-07-29 23:53:07', '1', '2026-07-29 23:53:07', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (31, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340385940】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86}', b'0', NULL, '100', '2026-07-29 23:53:07', '100', '2026-07-29 23:53:07', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (32, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340385940】有一项【结果确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86}', b'0', NULL, '1', '2026-07-29 23:53:07', '1', '2026-07-29 23:53:07', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (33, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-申诉-1785340385940】有一项【申诉确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"申诉确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86}', b'0', NULL, '1', '2026-07-29 23:53:08', '1', '2026-07-29 23:53:08', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (34, 1, 2, 1062142, 'hrm_performance_process_result', 'HRM', '绩效计划【API自测-申诉-1785340385940】的【绩效申诉】处理结果：已驳回，考核流程已结束。', 2, '{\"result\":\"已驳回，考核流程已结束\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-申诉-1785340385940\",\"assessmentId\":86,\"actionName\":\"绩效申诉\"}', b'0', NULL, '100', '2026-07-29 23:53:08', '100', '2026-07-29 23:53:08', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (35, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-收尾-1785340445057-正常确认】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-收尾-1785340445057-正常确认\",\"assessmentId\":87}', b'0', NULL, '1', '2026-07-29 23:54:05', '1', '2026-07-29 23:54:05', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (36, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-收尾-1785340445057-正常确认】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-收尾-1785340445057-正常确认\",\"assessmentId\":87}', b'0', NULL, '1', '2026-07-29 23:54:05', '1', '2026-07-29 23:54:05', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (37, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-收尾-1785340445057-正常确认】有一项【结果确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-收尾-1785340445057-正常确认\",\"assessmentId\":87}', b'0', NULL, '1', '2026-07-29 23:54:06', '1', '2026-07-29 23:54:06', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (38, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-收尾-1785340445057-员工归档删除】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-收尾-1785340445057-员工归档删除\",\"assessmentId\":88}', b'0', NULL, '1', '2026-07-29 23:54:06', '1', '2026-07-29 23:54:06', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (39, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【API自测-收尾-1785340445057-员工归档删除】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"API自测-收尾-1785340445057-员工归档删除\",\"assessmentId\":88}', b'0', NULL, '1', '2026-07-29 23:54:06', '1', '2026-07-29 23:54:06', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (40, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】有一项【员工填写】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工填写\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92}', b'0', NULL, '1', '2026-07-30 00:27:26', '1', '2026-07-30 00:27:26', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (41, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】有一项【目标确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"目标确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92}', b'0', NULL, '1', '2026-07-30 00:27:26', '1', '2026-07-30 00:27:26', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (42, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92}', b'0', NULL, '1', '2026-07-30 00:27:26', '1', '2026-07-30 00:27:26', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (43, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92}', b'0', NULL, '1', '2026-07-30 00:27:27', '1', '2026-07-30 00:27:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (44, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92}', b'0', NULL, '100', '2026-07-30 00:27:27', '100', '2026-07-30 00:27:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (45, 1, 2, 1062142, 'hrm_performance_process_result', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】的【考核评分】处理结果：已被驳回，请重新评分。', 2, '{\"result\":\"已被驳回，请重新评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92,\"actionName\":\"考核评分\"}', b'0', NULL, '100', '2026-07-30 00:27:27', '100', '2026-07-30 00:27:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (46, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92}', b'0', NULL, '1', '2026-07-30 00:27:27', '1', '2026-07-30 00:27:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (47, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92}', b'0', NULL, '100', '2026-07-30 00:27:27', '100', '2026-07-30 00:27:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (48, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】有一项【结果确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92}', b'0', NULL, '1', '2026-07-30 00:27:27', '1', '2026-07-30 00:27:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (49, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】有一项【申诉确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"申诉确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92}', b'0', NULL, '1', '2026-07-30 00:27:27', '1', '2026-07-30 00:27:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (50, 1, 2, 1062142, 'hrm_performance_process_result', 'HRM', '绩效计划【VERIFIER-1785342445099-申诉全流程】的【绩效申诉】处理结果：已驳回，考核流程已结束。', 2, '{\"result\":\"已驳回，考核流程已结束\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-申诉全流程\",\"assessmentId\":92,\"actionName\":\"绩效申诉\"}', b'0', NULL, '100', '2026-07-30 00:27:27', '100', '2026-07-30 00:27:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (51, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-正常确认】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-正常确认\",\"assessmentId\":94}', b'0', NULL, '1', '2026-07-30 00:27:28', '1', '2026-07-30 00:27:28', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (52, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-正常确认】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-正常确认\",\"assessmentId\":94}', b'0', NULL, '100', '2026-07-30 00:27:28', '100', '2026-07-30 00:27:28', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (53, 100, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【VERIFIER-1785342445099-正常确认】有一项【结果确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"VERIFIER-1785342445099-正常确认\",\"assessmentId\":94}', b'0', NULL, '1', '2026-07-30 00:27:28', '1', '2026-07-30 00:27:28', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (54, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【浏览器KPI计划-1785391365814】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"浏览器KPI计划-1785391365814\",\"assessmentId\":96}', b'0', NULL, '1', '2026-07-30 14:16:27', '1', '2026-07-30 14:16:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (55, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效结果待确认】有一项【申诉确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"申诉确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2}', b'0', NULL, '1', '2026-07-30 14:20:05', '1', '2026-07-30 14:20:05', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (56, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效结果待确认】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2}', b'0', NULL, '1', '2026-07-30 14:21:01', '1', '2026-07-30 14:21:01', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (57, 1, 2, 1062142, 'hrm_performance_process_result', 'HRM', '绩效计划【2026年7月绩效结果待确认】的【绩效申诉】处理结果：已通过，相关评分将重新处理。', 2, '{\"result\":\"已通过，相关评分将重新处理\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2,\"actionName\":\"绩效申诉\"}', b'0', NULL, '1', '2026-07-30 14:21:01', '1', '2026-07-30 14:21:01', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (58, 1, 2, 1062140, 'hrm_salary_slip_sent', 'HRM', '您的 2026 年 8 月工资条已发放，实发工资为 -523.20 元，请前往“我的工资条”查看。', 2, '{\"employeeName\":\"安天源码\",\"realSalary\":\"-523.20\",\"month\":8,\"year\":2026}', b'0', NULL, '1', '2026-07-30 15:20:06', '1', '2026-07-30 15:20:06', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (59, 1, 2, 1062140, 'hrm_salary_slip_sent', 'HRM', '您的 2026 年 8 月工资条已发放，实发工资为 -523.20 元，请前往“我的工资条”查看。', 2, '{\"employeeName\":\"安天源码\",\"realSalary\":\"-523.20\",\"month\":8,\"year\":2026}', b'0', NULL, '1', '2026-07-30 15:22:05', '1', '2026-07-30 15:22:05', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (60, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【浏览器全量回归 KPI 20260730（已修改）】有一项【员工自评】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工自评\",\"route\":\"/hrm/portal/performance\",\"planName\":\"浏览器全量回归 KPI 20260730（已修改）\",\"assessmentId\":101}', b'0', NULL, '1', '2026-07-30 19:50:28', '1', '2026-07-30 19:50:28', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (61, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效评分待处理】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效评分待处理\",\"assessmentId\":7}', b'0', NULL, '1', '2026-07-30 19:56:56', '1', '2026-07-30 19:56:56', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (62, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效评分待处理】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效评分待处理\",\"assessmentId\":7}', b'0', NULL, '1', '2026-07-30 19:58:28', '1', '2026-07-30 19:58:28', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (63, 1, 2, 1062142, 'hrm_performance_process_result', 'HRM', '绩效计划【2026年7月绩效评分待处理】的【结果审核】处理结果：已驳回，请重新评分。', 2, '{\"result\":\"已驳回，请重新评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效评分待处理\",\"assessmentId\":7,\"actionName\":\"结果审核\"}', b'0', NULL, '1', '2026-07-30 19:58:28', '1', '2026-07-30 19:58:28', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (64, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效评分待处理】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效评分待处理\",\"assessmentId\":7}', b'0', NULL, '1', '2026-07-30 19:59:13', '1', '2026-07-30 19:59:13', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (65, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效结果待确认】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2}', b'0', NULL, '1', '2026-07-30 20:00:33', '1', '2026-07-30 20:00:33', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (66, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效结果待确认】有一项【结果确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2}', b'0', NULL, '1', '2026-07-30 20:01:03', '1', '2026-07-30 20:01:03', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (67, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效结果待确认】有一项【申诉确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"申诉确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2}', b'0', NULL, '1', '2026-07-30 20:03:17', '1', '2026-07-30 20:03:17', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (68, 1, 2, 1062142, 'hrm_performance_process_result', 'HRM', '绩效计划【2026年7月绩效申诉待处理】的【绩效申诉】处理结果：已驳回，考核流程已结束。', 2, '{\"result\":\"已驳回，考核流程已结束\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效申诉待处理\",\"assessmentId\":4,\"actionName\":\"绩效申诉\"}', b'0', NULL, '1', '2026-07-30 20:04:31', '1', '2026-07-30 20:04:31', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (69, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效结果待确认】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2}', b'0', NULL, '1', '2026-07-30 20:04:52', '1', '2026-07-30 20:04:52', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (70, 1, 2, 1062142, 'hrm_performance_process_result', 'HRM', '绩效计划【2026年7月绩效结果待确认】的【绩效申诉】处理结果：已通过，相关评分将重新处理。', 2, '{\"result\":\"已通过，相关评分将重新处理\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2,\"actionName\":\"绩效申诉\"}', b'0', NULL, '1', '2026-07-30 20:04:52', '1', '2026-07-30 20:04:52', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (71, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效结果待确认】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2}', b'0', NULL, '1', '2026-07-30 20:05:29', '1', '2026-07-30 20:05:29', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (72, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年7月绩效结果待确认】有一项【结果确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"2026年7月绩效结果待确认\",\"assessmentId\":2}', b'0', NULL, '1', '2026-07-30 20:05:54', '1', '2026-07-30 20:05:54', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (73, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【浏览器目标确认回归 20260730】有一项【员工填写】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工填写\",\"route\":\"/hrm/portal/performance\",\"planName\":\"浏览器目标确认回归 20260730\",\"assessmentId\":102}', b'0', NULL, '1', '2026-07-30 20:42:15', '1', '2026-07-30 20:42:15', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (74, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【浏览器目标确认回归 20260730】有一项【目标确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"目标确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"浏览器目标确认回归 20260730\",\"assessmentId\":102}', b'0', NULL, '1', '2026-07-30 20:43:24', '1', '2026-07-30 20:43:24', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (75, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【浏览器目标确认回归 20260730】有一项【员工填写】任务待处理，请及时处理。', 2, '{\"stageName\":\"员工填写\",\"route\":\"/hrm/portal/performance\",\"planName\":\"浏览器目标确认回归 20260730\",\"assessmentId\":102}', b'0', NULL, '1', '2026-07-30 20:45:55', '1', '2026-07-30 20:45:55', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (76, 1, 2, 1062142, 'hrm_performance_process_result', 'HRM', '绩效计划【浏览器目标确认回归 20260730】的【目标确认】处理结果：已驳回，请重新填写指标。', 2, '{\"result\":\"已驳回，请重新填写指标\",\"route\":\"/hrm/portal/performance\",\"planName\":\"浏览器目标确认回归 20260730\",\"assessmentId\":102,\"actionName\":\"目标确认\"}', b'0', NULL, '1', '2026-07-30 20:45:55', '1', '2026-07-30 20:45:55', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (77, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【浏览器目标确认回归 20260730】有一项【目标确认】任务待处理，请及时处理。', 2, '{\"stageName\":\"目标确认\",\"route\":\"/hrm/portal/performance\",\"planName\":\"浏览器目标确认回归 20260730\",\"assessmentId\":102}', b'0', NULL, '1', '2026-07-30 20:47:14', '1', '2026-07-30 20:47:14', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (78, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年8月绩效指标待填写】有一项【指定员工评分】任务待处理，请及时处理。', 2, '{\"stageName\":\"指定员工评分\",\"route\":\"/hrm/portal/performance/assessment\",\"planName\":\"2026年8月绩效指标待填写\",\"assessmentId\":108}', b'0', NULL, '1', '2026-08-04 22:08:13', '1', '2026-08-04 22:08:13', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (79, 1, 2, 1062141, 'hrm_performance_task_pending', 'HRM', '绩效计划【2026年8月绩效指标待填写】有一项【结果审核】任务待处理，请及时处理。', 2, '{\"stageName\":\"结果审核\",\"route\":\"/hrm/portal/performance/assessment\",\"planName\":\"2026年8月绩效指标待填写\",\"assessmentId\":108}', b'0', NULL, '1', '2026-08-04 22:09:34', '1', '2026-08-04 22:09:34', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (80, 104, 2, 1062144, 'pms_knowledge_document_shared', 'PMS 知识中心', '知识文档“产品需求文档模板”已分享给您，查看地址：/pms/knowledge/detail/2?documentId=2', 2, '{\"route\":\"/pms/knowledge/detail/2?documentId=2\",\"documentTitle\":\"产品需求文档模板\"}', b'0', NULL, '1', '2026-08-19 17:47:02', '1', '2026-08-19 17:47:02', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (81, 1, 2, 1062145, 'oa_schedule_reminder', 'OA 办公系统', '日程“OA 迁移验收会议（已验证）”将于 2026-08-24 12:00 开始，查看地址：/oa/schedule', 2, '{\"scheduleTitle\":\"OA 迁移验收会议（已验证）\",\"startTime\":\"2026-08-24 12:00\",\"route\":\"/oa/schedule\"}', b'0', NULL, '1', '2026-08-24 01:48:27', '1', '2026-08-24 01:48:27', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (82, 142, 2, 1062144, 'pms_knowledge_document_shared', 'PMS 知识中心', '知识文档“品牌视觉使用规范”已分享给您，查看地址：/pms/kb/detail/5?documentId=22', 2, '{\"documentTitle\":\"品牌视觉使用规范\",\"route\":\"/pms/kb/detail/5?documentId=22\"}', b'0', NULL, '1', '2026-08-25 16:15:49', '1', '2026-08-25 16:15:49', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (83, 141, 2, 1062144, 'pms_knowledge_document_shared', 'PMS 知识中心', '知识文档“品牌视觉使用规范”已分享给您，查看地址：/pms/kb/detail/5?documentId=22', 2, '{\"documentTitle\":\"品牌视觉使用规范\",\"route\":\"/pms/kb/detail/5?documentId=22\"}', b'0', NULL, '1', '2026-08-25 16:31:38', '1', '2026-08-25 16:31:38', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (84, 100, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (85, 103, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (86, 104, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (87, 112, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (88, 115, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (89, 117, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (90, 118, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (91, 139, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (92, 143, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (93, 144, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (94, 240, 2, 1062146, 'oa_announcement_published', 'OA 办公系统', '您收到公告【OA 迁移验收公告】，请及时查看。查看地址：/oa/announcement/list', 2, '{\"announcementTitle\":\"OA 迁移验收公告\",\"route\":\"/oa/announcement/list\"}', b'0', NULL, '1', '2026-09-05 01:08:00', '1', '2026-09-05 01:08:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (95, 1, 2, 1062145, 'oa_schedule_reminder', 'OA 办公系统', '日程“OA验收-0916-定时提醒”将于 2026-09-17 00:12 开始，查看地址：/oa/schedule/calendar', 2, '{\"scheduleTitle\":\"OA验收-0916-定时提醒\",\"startTime\":\"2026-09-17 00:12\",\"route\":\"/oa/schedule/calendar\"}', b'0', NULL, NULL, '2026-09-16 23:13:00', NULL, '2026-09-16 23:13:00', b'0', 1);

INSERT IGNORE INTO `system_notify_message` (`id`, `user_id`, `user_type`, `template_id`, `template_code`, `template_nickname`, `template_content`, `template_type`, `template_params`, `read_status`, `read_time`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (96, 104, 2, 1062145, 'oa_schedule_reminder', 'OA 办公系统', '日程“OA验收-0916-定时提醒”将于 2026-09-17 00:12 开始，查看地址：/oa/schedule/calendar', 2, '{\"scheduleTitle\":\"OA验收-0916-定时提醒\",\"startTime\":\"2026-09-17 00:12\",\"route\":\"/oa/schedule/calendar\"}', b'0', NULL, NULL, '2026-09-16 23:13:00', NULL, '2026-09-16 23:13:00', b'0', 1);

INSERT IGNORE INTO `system_oauth2_client` (`id`, `client_id`, `secret`, `name`, `logo`, `description`, `status`, `access_token_validity_seconds`, `refresh_token_validity_seconds`, `redirect_uris`, `authorized_grant_types`, `scopes`, `auto_approve_scopes`, `authorities`, `resource_ids`, `additional_information`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, 'default', 'admin123', '安天源码', 'http://test.yudao.iocoder.cn/20250502/sort2_1746189740718.png', '我是描述', 0, 1800, 2592000, '[\"https://www.antianwl.com\",\"https://doc.iocoder.cn\"]', '[\"password\",\"authorization_code\",\"implicit\",\"refresh_token\",\"client_credentials\"]', '[\"user.read\",\"user.write\"]', '[]', '[\"user.read\",\"user.write\"]', '[]', '{}', '1', '2022-05-11 21:47:12', '1', '2025-12-07 20:07:09', b'0');

INSERT IGNORE INTO `system_oauth2_client` (`id`, `client_id`, `secret`, `name`, `logo`, `description`, `status`, `access_token_validity_seconds`, `refresh_token_validity_seconds`, `redirect_uris`, `authorized_grant_types`, `scopes`, `auto_approve_scopes`, `authorities`, `resource_ids`, `additional_information`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (40, 'test', 'test2', 'biubiu', 'http://test.yudao.iocoder.cn/20251227/javayuanma_1766829882970.jpg', '啦啦啦啦', 0, 1800, 43200, '[\"https://www.antianwl.com\"]', '[\"password\",\"authorization_code\",\"implicit\"]', '[\"user_info\",\"projects\"]', '[\"user_info\"]', '[]', '[]', '{}', '1', '2022-05-12 00:28:20', '1', '2025-12-27 18:04:44', b'0');

INSERT IGNORE INTO `system_oauth2_client` (`id`, `client_id`, `secret`, `name`, `logo`, `description`, `status`, `access_token_validity_seconds`, `refresh_token_validity_seconds`, `redirect_uris`, `authorized_grant_types`, `scopes`, `auto_approve_scopes`, `authorities`, `resource_ids`, `additional_information`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (41, 'antian-sso-demo-by-code', 'test', '基于授权码模式，如何实现 SSO 单点登录？', 'http://test.yudao.iocoder.cn/it/20250502/sign_1746181948685.png', NULL, 0, 1800, 43200, '[\"http://127.0.0.1:18080/callback.html\"]', '[\"authorization_code\",\"refresh_token\"]', '[\"user.read\",\"user.write\"]', '[]', '[]', '[]', NULL, '1', '2022-09-29 13:28:31', '1', '2026-10-27 20:57:04', b'0');

INSERT IGNORE INTO `system_oauth2_client` (`id`, `client_id`, `secret`, `name`, `logo`, `description`, `status`, `access_token_validity_seconds`, `refresh_token_validity_seconds`, `redirect_uris`, `authorized_grant_types`, `scopes`, `auto_approve_scopes`, `authorities`, `resource_ids`, `additional_information`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (42, 'antian-sso-demo-by-password', 'test', '基于密码模式，如何实现 SSO 单点登录？', 'http://test.yudao.iocoder.cn/oauth2/20260615/iShot_2026-05-31_23.18.10.png', NULL, 0, 1800, 43200, '[\"http://127.0.0.1:18080\"]', '[\"password\",\"refresh_token\"]', '[\"user.read\",\"user.write\"]', '[]', '[]', '[]', NULL, '1', '2022-10-04 17:40:16', '1', '2026-06-15 18:58:30', b'0');

INSERT IGNORE INTO `system_post` (`id`, `code`, `name`, `sort`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, 'se', '项目经理', 2, 0, '', 'admin', '2021-01-05 17:03:48', '1', '2025-12-15 22:38:43', b'0', 1);

INSERT IGNORE INTO `system_post` (`id`, `code`, `name`, `sort`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (4, 'user', '普通员工', 4, 0, '111222', 'admin', '2021-01-05 17:03:48', '1', '2025-03-24 21:32:40', b'0', 1);

INSERT IGNORE INTO `system_post` (`id`, `code`, `name`, `sort`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5, 'HR', '人力资源', 5, 0, '`', '1', '2024-03-24 20:45:40', '1', '2025-03-29 19:08:10', b'0', 1);

INSERT IGNORE INTO `system_post` (`id`, `code`, `name`, `sort`, `status`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (7, 'test', '测试', 10, 0, NULL, '1', '2025-09-02 08:45:57', '1', '2025-09-02 08:45:57', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '超级管理员', 'super_admin', 1, 1, '', 0, 1, '超级管理员', 'admin', '2021-01-05 17:03:48', '', '2022-02-22 05:08:21', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, '普通角色', 'common', 2, 2, '', 0, 1, '普通角色', 'admin', '2021-01-05 17:03:48', '', '2022-02-22 05:08:20', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3, 'CRM 管理员', 'crm_admin', 2, 1, '', 0, 1, 'CRM 专属角色', '1', '2024-02-24 10:51:13', '1', '2024-02-24 02:51:32', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (109, '租户管理员', 'tenant_admin', 0, 1, '', 0, 1, '系统自动生成', '1', '2022-02-22 00:56:14', '1', '2022-02-22 00:56:14', b'0', 121);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (111, '租户管理员', 'tenant_admin', 0, 1, '', 0, 1, '系统自动生成', '1', '2022-03-07 21:37:58', '1', '2022-03-07 21:37:58', b'0', 122);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (155, '测试数据权限12', 'test-dp', 4, 2, '[112,100,102,103,104,105,107,108]', 0, 2, '1111', '1', '2025-03-31 14:58:06', '1', '2026-06-26 10:42:44', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (162, 'HRM团队负责人', 'hrm_team_leader', 50, 2, '', 0, 2, '本地团队工作台演示角色', 'admin', '2026-08-01 03:52:53', 'admin', '2026-08-01 03:52:53', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (172, '领用验证角色', 'eam_http_24243d7e8c4e41fb812d5ccc501c5b73', 1, 1, '', 0, 2, NULL, '', '2026-10-08 02:21:33', '', '2026-10-08 02:21:33', b'0', 165);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (176, 'channel101791808948462-ro', 'channel101791808948462ro', 1, 1, '', 0, 2, NULL, '1', '2026-10-12 20:44:01', '1', '2026-10-12 20:44:01', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (190, '固定资产【管理】', 'eam_admin_role', 10, 1, '', 0, 2, '对标 app_init.sys_role.eam_admin_role（eamadmin 账号）', '', '2026-10-17 13:04:40', '', '2026-10-17 13:04:40', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (191, '固定资产【普通】', 'eam_employee_role', 11, 1, '', 0, 2, '对标 app_init.sys_role.eam_employee_role（固定资产普通人员）', '', '2026-10-17 13:04:40', '', '2026-10-17 13:04:40', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (196, 'Jack表单153612仅审核', 'jack_form_audit_153612', 0, 1, '', 0, 2, NULL, '1', '2026-10-21 17:25:18', '1', '2026-10-21 17:25:18', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (212, 'CMS只读验收20261030', 'cms_ui_viewer_20261030', 99, 1, '', 0, 2, 'Owned acceptance fixture; no existing roles changed', '1', '2026-10-30 07:42:45', '1', '2026-10-30 07:42:45', b'0', 1);

INSERT IGNORE INTO `system_role` (`id`, `name`, `code`, `sort`, `data_scope`, `data_scope_dept_ids`, `status`, `type`, `remark`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (213, '设计条件写入验收20261030', 'cms_remaining_writer_20261030', 99, 1, '', 0, 2, 'Owned acceptance only; no global permission', '1', '2026-10-30 15:56:28', '1', '2026-10-30 15:56:28', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (263, 109, 1, '1', '2022-02-22 00:56:14', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (434, 2, 1, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (454, 2, 98, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (455, 2, 99, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (460, 2, 104, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (467, 2, 111, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (477, 2, 4, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (478, 2, 5, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (479, 2, 6, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (481, 2, 7, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (483, 2, 8, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (485, 2, 9, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (488, 2, 11, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (490, 2, 12, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (492, 2, 13, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (498, 2, 129, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (523, 2, 181, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (524, 2, 182, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (541, 2, 21, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (543, 2, 22, '1', '2022-02-22 13:09:12', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1296, 110, 1, '110', '2022-02-23 00:23:55', '110', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1729, 109, 4, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1730, 109, 5, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1731, 109, 78, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1732, 109, 79, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1733, 109, 23, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1734, 109, 80, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1735, 109, 24, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1736, 109, 25, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1737, 109, 26, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1738, 109, 27, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1739, 109, 28, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1740, 109, 29, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1741, 109, 30, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1742, 109, 31, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1743, 109, 32, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1744, 109, 33, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1745, 109, 34, '1', '2022-09-21 22:08:51', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1763, 109, 4, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1764, 109, 5, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1765, 109, 78, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1766, 109, 79, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1767, 109, 23, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1768, 109, 80, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1769, 109, 24, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1770, 109, 25, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1771, 109, 26, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1772, 109, 27, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1773, 109, 28, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1774, 109, 29, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1775, 109, 30, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1776, 109, 31, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1777, 109, 32, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1778, 109, 33, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1779, 109, 34, '1', '2022-09-21 22:08:53', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1797, 109, 4, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1798, 109, 5, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1799, 109, 78, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1800, 109, 79, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1801, 109, 23, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1802, 109, 80, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1803, 109, 24, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1804, 109, 25, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1805, 109, 26, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1806, 109, 27, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1807, 109, 28, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1808, 109, 29, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1809, 109, 30, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1810, 109, 31, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1811, 109, 32, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1812, 109, 33, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1813, 109, 34, '1', '2022-09-21 22:08:55', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1831, 109, 7, '1', '2022-09-21 22:43:23', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1832, 109, 39, '1', '2022-09-21 22:43:23', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1833, 109, 40, '1', '2022-09-21 22:43:23', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1834, 109, 41, '1', '2022-09-21 22:43:23', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1835, 109, 42, '1', '2022-09-21 22:43:23', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1841, 109, 58, '1', '2022-09-21 22:48:13', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1842, 109, 59, '1', '2022-09-21 22:48:13', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1843, 109, 60, '1', '2022-09-21 22:48:13', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1844, 109, 61, '1', '2022-09-21 22:48:13', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1845, 109, 11, '1', '2022-09-21 22:48:13', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1991, 2, 46, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1992, 2, 47, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1993, 2, 48, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1994, 2, 49, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1995, 2, 50, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1996, 2, 51, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1997, 2, 52, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2003, 2, 58, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2004, 2, 59, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2005, 2, 60, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2006, 2, 61, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2007, 2, 62, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2008, 2, 63, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2009, 2, 64, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2010, 2, 65, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2011, 2, 66, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2012, 2, 67, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2021, 2, 271, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2024, 2, 78, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2025, 2, 79, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2026, 2, 80, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2044, 2, 100, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2045, 2, 101, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2046, 2, 102, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2047, 2, 103, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2048, 2, 105, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2049, 2, 106, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2050, 2, 107, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2051, 2, 108, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2052, 2, 109, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2053, 2, 110, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2054, 2, 112, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2055, 2, 113, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2073, 2, 130, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2075, 2, 131, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2077, 2, 132, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2078, 2, 133, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2079, 2, 134, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2099, 2, 183, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2100, 2, 184, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2101, 2, 185, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2102, 2, 186, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2123, 2, 201, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2124, 2, 202, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2125, 2, 203, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2126, 2, 204, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2127, 2, 205, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2128, 2, 206, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2129, 2, 23, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2130, 2, 24, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2131, 2, 25, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2132, 2, 26, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2133, 2, 27, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2134, 2, 28, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2135, 2, 29, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2136, 2, 30, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2137, 2, 31, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2138, 2, 32, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2139, 2, 33, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2140, 2, 34, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2141, 2, 35, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2143, 2, 37, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2145, 2, 39, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2146, 2, 40, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2147, 2, 41, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2148, 2, 42, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2149, 2, 43, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2150, 2, 44, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2151, 2, 45, '1', '2023-01-25 08:42:52', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2929, 109, 181, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2930, 109, 182, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2931, 109, 183, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2932, 109, 184, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2933, 109, 185, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2934, 109, 186, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2935, 109, 129, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2936, 109, 130, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2937, 109, 131, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2938, 109, 132, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2939, 109, 133, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2940, 109, 134, '1', '2023-12-02 23:19:40', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3221, 109, 6, '1', '2023-12-30 11:42:36', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3222, 109, 35, '1', '2023-12-30 11:42:36', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3223, 109, 36, '1', '2023-12-30 11:42:36', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3224, 109, 37, '1', '2023-12-30 11:42:36', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3225, 109, 38, '1', '2023-12-30 11:42:36', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5779, 2, 772, '1', '2024-07-07 20:39:38', '1', '2026-08-14 01:49:42', b'0', 1);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5789, 109, 772, '1', '2024-07-13 22:37:24', '1', '2026-08-14 01:49:42', b'0', 121);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6381, 111, 1, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6389, 111, 58, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6390, 111, 59, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6391, 111, 60, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6392, 111, 61, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6403, 111, 78, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6404, 111, 79, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6405, 111, 80, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6427, 111, 4, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6428, 111, 5, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6429, 111, 6, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6431, 111, 7, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6437, 111, 11, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6450, 111, 129, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6451, 111, 130, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6453, 111, 131, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6455, 111, 132, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6456, 111, 133, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6457, 111, 134, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6504, 111, 772, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6527, 111, 181, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6528, 111, 182, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6529, 111, 183, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6530, 111, 184, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6531, 111, 185, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6532, 111, 186, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6607, 111, 23, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6608, 111, 24, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6609, 111, 25, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6610, 111, 26, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6611, 111, 27, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6612, 111, 28, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6613, 111, 29, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6614, 111, 30, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6615, 111, 31, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6616, 111, 32, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6617, 111, 33, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6618, 111, 34, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6619, 111, 35, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6621, 111, 36, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6623, 111, 37, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6625, 111, 38, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6627, 111, 39, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6629, 111, 40, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6631, 111, 41, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_role_menu` (`id`, `role_id`, `menu_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6633, 111, 42, '1', '2026-06-01 23:29:35', '1', '2026-08-14 01:49:42', b'0', 122);

INSERT IGNORE INTO `system_sms_channel` (`id`, `signature`, `code`, `status`, `remark`, `api_key`, `api_secret`, `callback_url`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 'Ballcat', 'ALIYUN', 0, '你要改哦，只有我可以用！！！！', 'LTAI5tCnKso2uG3kJ5gRav88', 'fGJ5SNXL7P1NHNRmJ7DJaMJGPyE55C', NULL, '', '2021-03-31 11:53:10', '1', '2024-08-04 08:53:26', b'0');

INSERT IGNORE INTO `system_sms_channel` (`id`, `signature`, `code`, `status`, `remark`, `api_key`, `api_secret`, `callback_url`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (4, '测试渠道', 'DEBUG_DING_TALK', 0, '123', '696b5d8ead48071237e4aa5861ff08dbadb2b4ded1c688a7b7c9afc615579859', 'SEC5c4e5ff888bc8a9923ae47f59e7ccd30af1f14d93c55b4e2c9cb094e35aeed67', NULL, '1', '2021-04-13 00:23:14', '1', '2022-03-27 20:29:49', b'0');

INSERT IGNORE INTO `system_sms_channel` (`id`, `signature`, `code`, `status`, `remark`, `api_key`, `api_secret`, `callback_url`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (7, 'mock腾讯云', 'TENCENT', 0, '123', '1 2', '2 3', '', '1', '2024-09-30 08:53:45', '1', '2025-12-20 11:30:18', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (2, 1, 0, 'test_01', '测试验证码短信', '正在进行登录操作{operation}，您的验证码是{code}', '[\"operation\",\"code\"]', '测试备注', '4383920', 4, 'DEBUG_DING_TALK', '', '2021-03-31 10:49:38', '1', '2024-08-18 11:57:18', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (3, 1, 0, 'test_02', '公告通知', '您的验证码{code}，该验证码5分钟内有效，请勿泄漏于他人！', '[\"code\"]', NULL, 'SMS_207945135', 2, 'ALIYUN', '', '2021-03-31 11:56:30', '1', '2021-04-10 01:22:02', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (6, 3, 0, 'test-01', '测试模板', '哈哈哈 {name}', '[\"name\"]', 'f哈哈哈', '4383920', 4, 'DEBUG_DING_TALK', '1', '2021-04-10 01:07:21', '1', '2024-08-18 11:57:07', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (7, 3, 0, 'test-04', '测试下', '老鸡{name}，牛逼{code}', '[\"name\",\"code\"]', '哈哈哈哈', 'suibian', 7, 'DEBUG_DING_TALK', '1', '2021-04-13 00:29:53', '1', '2024-09-30 00:56:24', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (8, 1, 0, 'user-sms-login', '前台用户短信登录', '您的验证码是{code}', '[\"code\"]', NULL, '4372216', 4, 'DEBUG_DING_TALK', '1', '2021-10-11 08:10:00', '1', '2024-08-18 11:57:06', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (9, 2, 0, 'bpm_task_assigned', '【工作流】任务被分配', '您收到了一条新的待办任务：{processInstanceName}-{taskName}，申请人：{startUserNickname}，处理链接：{detailUrl}', '[\"processInstanceName\",\"taskName\",\"startUserNickname\",\"detailUrl\"]', NULL, 'suibian', 4, 'DEBUG_DING_TALK', '1', '2022-01-21 22:31:19', '1', '2022-01-22 00:03:36', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (10, 2, 0, 'bpm_process_instance_reject', '【工作流】流程被不通过', '您的流程被审批不通过：{processInstanceName}，原因：{reason}，查看链接：{detailUrl}', '[\"processInstanceName\",\"reason\",\"detailUrl\"]', NULL, 'suibian', 4, 'DEBUG_DING_TALK', '1', '2022-01-22 00:03:31', '1', '2022-05-01 12:33:14', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (11, 2, 0, 'bpm_process_instance_approve', '【工作流】流程被通过', '您的流程被审批通过：{processInstanceName}，查看链接：{detailUrl}', '[\"processInstanceName\",\"detailUrl\"]', NULL, 'suibian', 4, 'DEBUG_DING_TALK', '1', '2022-01-22 00:04:31', '1', '2022-03-27 20:32:21', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (12, 2, 0, 'demo', '演示模板', '我就是测试一下下', '[]', NULL, 'biubiubiu', 4, 'DEBUG_DING_TALK', '1', '2022-04-10 23:22:49', '1', '2024-08-18 11:57:04', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (14, 1, 0, 'user-update-mobile', '会员用户 - 修改手机', '您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', '[\"code\"]', '', 'null', 4, 'DEBUG_DING_TALK', '1', '2023-08-19 18:58:01', '1', '2023-08-19 11:34:04', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (15, 1, 0, 'user-update-password', '会员用户 - 修改密码', '您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', '[\"code\"]', '', 'null', 4, 'DEBUG_DING_TALK', '1', '2023-08-19 18:58:01', '1', '2023-08-19 11:34:18', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (16, 1, 0, 'user-reset-password', '会员用户 - 重置密码', '您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', '[\"code\"]', '', 'null', 4, 'DEBUG_DING_TALK', '1', '2023-08-19 18:58:01', '1', '2023-12-02 22:35:27', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (17, 2, 0, 'bpm_task_timeout', '【工作流】任务审批超时', '您收到了一条超时的待办任务：{processInstanceName}-{taskName}，处理链接：{detailUrl}', '[\"processInstanceName\",\"taskName\",\"detailUrl\"]', '', 'X', 4, 'DEBUG_DING_TALK', '1', '2024-08-16 21:59:15', '1', '2024-08-16 21:59:34', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (18, 1, 0, 'admin-reset-password', '后台用户 - 忘记密码', '您的验证码{code}，该验证码 5 分钟内有效，请勿泄漏于他人！', '[\"code\"]', '', 'null', 4, 'DEBUG_DING_TALK', '1', '2025-03-16 14:19:34', '1', '2025-03-16 14:19:45', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (19, 1, 0, 'admin-sms-login', '后台用户短信登录', '您的验证码是{code}', '[\"code\"]', '', '4372216', 4, 'DEBUG_DING_TALK', '1', '2025-04-08 09:36:03', '1', '2025-04-08 09:36:17', b'0');

INSERT IGNORE INTO `system_sms_template` (`id`, `type`, `status`, `code`, `name`, `content`, `params`, `remark`, `api_template_id`, `channel_id`, `channel_code`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (20, 1, 0, 'user-sms-register', '会员用户 - 手机号注册', '您的验证码是{code}', '[\"code\"]', '会员注册验证码，沿用本地登录短信调试通道', '4372216', 4, 'DEBUG_DING_TALK', '1', '2026-09-22 20:58:13', '1', '2026-09-22 20:58:13', b'0');

INSERT IGNORE INTO `system_social_client` (`id`, `name`, `social_type`, `user_type`, `client_id`, `client_secret`, `agent_id`, `public_key`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, '钉钉', 20, 2, 'dingvrnreaje3yqvzhxg', 'i8E6iZyDvZj51JIb0tYsYfVQYOks9Cq1lgryEjFRqC79P3iJcrxEwT6Qk2QvLrLI', NULL, NULL, 0, '', '2023-10-18 11:21:18', '1', '2023-12-20 21:28:26', b'1', 1);

INSERT IGNORE INTO `system_social_client` (`id`, `name`, `social_type`, `user_type`, `client_id`, `client_secret`, `agent_id`, `public_key`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, '钉钉（王土豆）', 20, 2, 'dingtsu9hpepjkbmthhw', 'FP_bnSq_HAHKCSncmJjw5hxhnzs6vaVDSZZn3egj6rdqTQ_hu5tQVJyLMpgCakdP', NULL, NULL, 0, '', '2023-10-18 11:21:18', '', '2023-12-20 21:28:26', b'1', 121);

INSERT IGNORE INTO `system_social_client` (`id`, `name`, `social_type`, `user_type`, `client_id`, `client_secret`, `agent_id`, `public_key`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (3, '微信公众号', 31, 1, 'wx5b23ba7a5589ecbb', '2a7b3b20c537e52e74afd395eb85f61f', NULL, NULL, 0, '', '2023-10-18 16:07:46', '1', '2023-12-20 21:28:23', b'1', 1);

INSERT IGNORE INTO `system_social_client` (`id`, `name`, `social_type`, `user_type`, `client_id`, `client_secret`, `agent_id`, `public_key`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (43, '微信小程序', 34, 1, 'wx63c280fe3248a3e7', '6f270509224a7ae1296bbf1c8cb97aed', NULL, NULL, 0, '', '2023-10-19 13:37:41', '1', '2023-12-20 21:28:25', b'1', 1);

INSERT IGNORE INTO `system_social_client` (`id`, `name`, `social_type`, `user_type`, `client_id`, `client_secret`, `agent_id`, `public_key`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (44, '1', 10, 1, '2', '3', NULL, NULL, 0, '1', '2025-04-06 20:36:28', '1', '2025-04-06 20:43:12', b'1', 1);

INSERT IGNORE INTO `system_social_client` (`id`, `name`, `social_type`, `user_type`, `client_id`, `client_secret`, `agent_id`, `public_key`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (45, '1', 10, 1, '2', '3', NULL, NULL, 1, '1', '2025-09-06 20:26:15', '1', '2025-09-06 20:27:55', b'1', 1);

INSERT IGNORE INTO `system_social_client` (`id`, `name`, `social_type`, `user_type`, `client_id`, `client_secret`, `agent_id`, `public_key`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (46, '1', 10, 1, '2', '3', NULL, NULL, 0, '1', '2025-11-29 16:04:23', '1', '2025-11-29 16:04:26', b'1', 1);

INSERT IGNORE INTO `system_social_client` (`id`, `name`, `social_type`, `user_type`, `client_id`, `client_secret`, `agent_id`, `public_key`, `status`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (47, '123', 10, 1, '1', '2', '3', NULL, 0, '1', '2025-12-21 10:27:02', '1', '2025-12-21 10:27:20', b'1', 1);

INSERT IGNORE INTO `system_tenant` (`id`, `name`, `contact_user_id`, `contact_name`, `contact_mobile`, `status`, `websites`, `package_id`, `expire_time`, `account_count`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (1, '安天源码', NULL, '芋艿', '17321315478', 0, 'www.antianwl.com,127.0.0.1:3000,wxc4598c446f8a9cb3', 0, '2099-02-19 17:14:16', 9999, '1', '2021-01-05 17:03:47', '1', '2025-08-19 05:18:41', b'0');

INSERT IGNORE INTO `system_tenant` (`id`, `name`, `contact_user_id`, `contact_name`, `contact_mobile`, `status`, `websites`, `package_id`, `expire_time`, `account_count`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (121, '小租户', 110, '小王2', '15601691300', 0, 'zsxq.iocoder.cn,123321', 111, '2026-07-10 00:00:00', 30, '1', '2022-02-22 00:56:14', '1', '2026-07-11 15:17:23', b'0');

INSERT IGNORE INTO `system_tenant` (`id`, `name`, `contact_user_id`, `contact_name`, `contact_mobile`, `status`, `websites`, `package_id`, `expire_time`, `account_count`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (122, '测试租户', 113, '安天', '15601691300', 0, 'test.iocoder.cn,222,333', 111, '2023-04-29 00:00:00', 50, '1', '2022-03-07 21:37:58', '1', '2026-06-01 23:29:35', b'0');

INSERT IGNORE INTO `system_tenant` (`id`, `name`, `contact_user_id`, `contact_name`, `contact_mobile`, `status`, `websites`, `package_id`, `expire_time`, `account_count`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (165, 'EAM-HTTP-24243d7e8c4e', NULL, 'EAM 测试', NULL, 0, '', 0, '2026-10-09 02:21:33', 2, '', '2026-10-08 02:21:33', '', '2026-10-08 02:21:33', b'0');

INSERT IGNORE INTO `system_tenant_package` (`id`, `name`, `status`, `remark`, `menu_ids`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (111, '普通套餐', 0, '小功能', '[1,58,59,60,61,78,79,80,4,5,6,7,11,129,130,131,132,133,134,772,181,182,183,184,185,186,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42]', '1', '2022-02-22 00:54:00', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_tenant_package` (`id`, `name`, `status`, `remark`, `menu_ids`, `creator`, `create_time`, `updater`, `update_time`, `deleted`) VALUES (113, '测试套餐（啥都没有）', 0, '', '[]', '1', '2026-06-01 23:22:39', '1', '2026-08-14 01:49:42', b'0');

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (112, 1, 1, 'admin', '2022-05-02 07:25:24', 'admin', '2022-05-02 07:25:24', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (113, 100, 1, 'admin', '2022-05-02 07:25:24', 'admin', '2022-05-02 07:25:24', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (115, 104, 1, '1', '2022-05-16 19:36:28', '1', '2022-05-16 19:36:28', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (116, 117, 2, '1', '2022-07-09 17:40:26', '1', '2022-07-09 17:40:26', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (117, 118, 1, '1', '2022-07-09 17:44:44', '1', '2022-07-09 17:44:44', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (119, 114, 5, '1', '2024-03-24 20:45:51', '1', '2024-03-24 20:45:51', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (123, 115, 1, '1', '2024-04-04 09:37:14', '1', '2024-04-04 09:37:14', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (124, 115, 2, '1', '2024-04-04 09:37:14', '1', '2024-04-04 09:37:14', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (125, 1, 2, '1', '2024-07-13 22:31:39', '1', '2024-07-13 22:31:39', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (128, 139, 2, '1', '2025-12-05 21:43:27', '1', '2025-12-05 21:43:27', b'0', 1);

INSERT IGNORE INTO `system_user_post` (`id`, `user_id`, `post_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (129, 139, 4, '1', '2025-12-05 21:43:27', '1', '2025-12-05 21:43:27', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, 1, 1, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:17', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (2, 2, 2, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:13', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (5, 100, 1, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:12', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (6, 100, 2, '', '2022-01-11 13:19:45', '', '2022-05-12 12:35:11', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (10, 103, 1, '1', '2022-01-11 13:19:45', '1', '2022-01-11 13:19:45', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (14, 110, 109, '1', '2022-02-22 00:56:14', '1', '2022-02-22 00:56:14', b'0', 121);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (15, 111, 110, '110', '2022-02-23 13:14:38', '110', '2022-02-23 13:14:38', b'0', 121);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (16, 113, 111, '1', '2022-03-07 21:37:58', '1', '2022-03-07 21:37:58', b'0', 122);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (18, 1, 2, '1', '2022-05-12 20:39:29', '1', '2022-05-12 20:39:29', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (22, 115, 2, '1', '2022-07-21 22:08:30', '1', '2022-07-21 22:08:30', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (35, 112, 1, '1', '2024-03-15 20:00:24', '1', '2024-03-15 20:00:24', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (36, 118, 1, '1', '2024-03-17 09:12:08', '1', '2024-03-17 09:12:08', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (46, 117, 1, '1', '2024-10-02 10:16:11', '1', '2024-10-02 10:16:11', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (47, 104, 2, '1', '2025-01-04 10:40:33', '1', '2025-01-04 10:40:33', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (48, 100, 155, '1', '2025-04-04 10:41:14', '1', '2025-04-04 10:41:14', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (49, 142, 1, '1', '2025-07-23 09:11:42', '1', '2025-07-23 09:11:42', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (50, 142, 2, '1', '2025-10-07 20:50:37', '1', '2025-10-07 20:50:37', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (51, 139, 1, '1', '2025-12-05 22:36:57', '1', '2025-12-05 22:36:57', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (52, 139, 2, '1', '2025-12-05 22:37:00', '1', '2025-12-05 22:37:00', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (53, 114, 2, '1', '2026-01-04 18:15:40', '1', '2026-01-04 18:15:40', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (54, 114, 3, '1', '2026-01-04 18:16:19', '1', '2026-01-04 18:16:19', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (82, 104, 162, 'admin', '2026-08-01 03:52:53', 'admin', '2026-08-01 03:52:53', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (83, 240, 162, '1', '2026-08-01 11:56:35', '1', '2026-08-01 11:56:35', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (97, 255, 172, '', '2026-10-08 02:21:33', '', '2026-10-08 02:21:33', b'0', 165);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (101, 260, 176, '1', '2026-10-12 20:44:02', '1', '2026-10-12 20:44:02', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (106, 265, 196, '1', '2026-10-21 17:27:03', '1', '2026-10-21 17:27:03', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (123, 281, 212, '1', '2026-10-30 07:42:46', '1', '2026-10-30 07:42:46', b'0', 1);

INSERT IGNORE INTO `system_user_role` (`id`, `user_id`, `role_id`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (124, 282, 213, '1', '2026-10-30 15:56:28', '1', '2026-10-30 15:56:28', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (1, 'admin', '$2a$04$.vd8nPeLwxt6hnSzmAoAyul8BOLX7Cib6QhcxRe30rfvrIPQHH1OG', '安天源码', '管理员', 103, '[1,2]', '13aoteman@126.com', '18818260272', 1, 'http://test.yudao.iocoder.cn/20260517/blob_1778998103688.png', 0, '127.0.0.1', '2026-10-29 23:17:48', 'admin', '2021-01-05 17:03:47', NULL, '2026-10-29 23:17:48', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (100, 'antian', '$2a$04$.vd8nPeLwxt6hnSzmAoAyul8BOLX7Cib6QhcxRe30rfvrIPQHH1OG', '安天', '不要吓我', 104, '[1]', 'antian@iocoder.cn', '15601691300', 1, NULL, 0, '127.0.0.1', '2026-08-19 17:47:34', '', '2021-01-07 09:07:17', NULL, '2026-08-19 17:47:34', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (103, 'yuanma', '$2a$04$k/d6mc0nySN0i2udwcI8Ee8V5aM5OHixBRbQfXmPuFTUl3Zf/DBs.', '源码', NULL, 106, NULL, 'yuanma@iocoder.cn', '15601701300', 0, NULL, 0, '0:0:0:0:0:0:0:1', '2026-04-27 13:19:27', '', '2021-01-13 23:50:35', NULL, '2026-04-27 13:19:27', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (104, 'test', '$2a$04$DQ.n8D3cWRJDhZefFG6ZCOedzpfaLxeFmDrjFXhY.qlgb3Wvbhofm', '测试号', NULL, 107, '[1,2]', '111@qq.com', '15601691200', 1, NULL, 0, '127.0.0.1', '2026-08-01 11:54:49', '', '2021-01-21 02:13:53', NULL, '2026-08-01 11:54:49', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (107, 'admin107', '$2a$10$dYOOBKMO93v/.ReCqzyFg.o67Tqk.bbc2bhrpyBGkIw9aypCtr2pm', '芋艿', NULL, NULL, NULL, '', '15601691300', 0, NULL, 0, '', NULL, '1', '2022-02-20 22:59:33', '1', '2025-04-21 14:23:08', b'0', 118);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (108, 'admin108', '$2a$10$y6mfvKoNYL1GXWak8nYwVOH.kCWqjactkzdoIDgiKl93WN3Ejg.Lu', '芋艿', NULL, NULL, NULL, '', '15601691300', 0, NULL, 0, '', NULL, '1', '2022-02-20 23:00:50', '1', '2025-04-21 14:23:08', b'0', 119);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (109, 'admin109', '$2a$10$JAqvH0tEc0I7dfDVBI7zyuB4E3j.uH6daIjV53.vUS6PknFkDJkuK', '芋艿', NULL, NULL, NULL, '', '15601691300', 0, NULL, 0, '', NULL, '1', '2022-02-20 23:11:50', '1', '2025-04-21 14:23:08', b'0', 120);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (110, 'admin110', '$2a$10$mRMIYLDtRHlf6.9ipiqH1.Z.bh/R9dO9d5iHiGYPigi6r5KOoR2Wm', '小王', NULL, NULL, NULL, '', '15601691300', 0, NULL, 0, '127.0.0.1', '2026-07-11 15:16:04', '1', '2022-02-22 00:56:14', NULL, '2026-07-11 15:16:04', b'0', 121);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (111, 'test', '$2a$10$mRMIYLDtRHlf6.9ipiqH1.Z.bh/R9dO9d5iHiGYPigi6r5KOoR2Wm', '测试用户', NULL, NULL, '[]', '', '', 0, NULL, 0, '0:0:0:0:0:0:0:1', '2023-12-30 11:42:17', '110', '2022-02-23 13:14:33', NULL, '2025-04-21 14:23:08', b'0', 121);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (112, 'newobject', '$2a$04$dB0z8Q819fJWz0hbaLe6B.VfHCjYgWx6LFfET5lyz3JwcqlyCkQ4C', '新对象', NULL, 100, '[]', '', '15601691235', 1, NULL, 0, '127.0.0.1', '2026-06-17 09:07:20', '1', '2022-02-23 19:08:03', NULL, '2026-06-17 09:07:20', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (113, 'aoteman', '$2a$10$0acJOIk2D25/oC87nyclE..0lzeu9DtQ/n3geP4fkun/zIVRhHJIO', '安天1', NULL, NULL, NULL, '', '15601691300', 0, NULL, 0, '127.0.0.1', '2022-03-19 18:38:51', '1', '2022-03-07 21:37:58', '1', '2025-05-05 15:30:53', b'0', 122);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (114, 'hrmgr', '$2a$10$TR4eybBioGRhBmDBWkqWLO6NIh3mzYa8KBKDDB5woiGYFVlRAi.fu', 'hr 小姐姐', NULL, NULL, '[5]', '', '15601691236', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2026-01-04 18:16:01', '1', '2022-03-19 21:50:58', NULL, '2026-01-04 18:16:01', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (115, 'aotemane', '$2a$04$GcyP0Vyzb2F2Yni5PuIK9ueGxM0tkZGMtDwVRwrNbtMvorzbpNsV2', '阿呆', '11222', 102, '[1,2]', '7648@qq.com', '15601691229', 2, NULL, 0, '', NULL, '1', '2022-04-30 02:55:43', '1', '2025-04-21 14:23:08', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (117, 'admin123', '$2a$04$sEtimsHu9YCkYY4/oqElHem2Ijc9ld20eYO6lN.g/21NfLUTDLB9W', '测试号02', '1111', 100, '[2]', '', '15601691234', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2024-10-02 10:16:20', '1', '2022-07-09 17:40:26', '1', '2025-05-14 09:56:04', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (118, 'goudan', '$2a$04$3suGZjnA6rM5bErf38u1felbgqbsPHGdRG3l9NkxPCEt2ah9Y6aJi', '狗蛋', NULL, 103, '[1]', '', '15601691239', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2025-11-23 15:28:25', '1', '2022-07-09 17:44:43', NULL, '2025-11-23 15:28:25', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (139, 'wwbwwb', '$2a$04$FJLIyg8lbPytP29pbZaiU.LesJvCsYfEaHqQfB0pGQhK3e9BeZmLy', '小秃头', '123', 108, '[2,4]', '', '', 1, NULL, 0, '0:0:0:0:0:0:0:1', '2024-09-10 21:03:58', NULL, '2024-09-10 21:03:58', '1', '2025-12-15 22:38:15', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (141, 'admin1', '$2a$04$oj6F6d7HrZ70kYVD3TNzEu.m3TPUzajOVuC66zdKna8KRerK1FmVa', '新用户', NULL, NULL, NULL, '', '', 0, '', 0, '127.0.0.1', '2026-06-17 09:37:18', '1', '2025-04-08 13:09:07', NULL, '2026-06-17 09:37:18', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (142, 'test01', '$2a$04$4bCYWZkjxxOC4QE0LY2M9uEEKWeJbLfs489NFtQoyidL5I0FndRaO', 'test01', '', NULL, '[]', '', '19021719925', 1, '', 0, '0:0:0:0:0:0:0:1', '2026-06-17 10:44:58', '1', '2025-07-09 21:07:10', NULL, '2026-06-17 10:44:58', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (143, 'a00001', '$2a$04$GhVHFviOw/SsTmiQtifHJesDYFlHMeGK7OWh7aGCCjGGVCmbHVAwa', 'a00001', NULL, 104, NULL, '', '', 0, '', 0, '0:0:0:0:0:0:0:1', '2025-12-01 16:10:13', NULL, '2025-12-01 16:10:13', '1', '2025-12-05 21:34:05', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (144, 'aoteman001', '$2a$04$omQOmhz8OyUFBKw77nr8KOtMp6xdvoQ1gWStjk9r8.OYT3Bv6oEYe', 'aoteman00112', NULL, 104, NULL, '', '', 0, '', 1, '0:0:0:0:0:0:0:1', '2025-12-01 17:05:27', '1', '2025-12-01 17:05:27', '1', '2026-06-15 18:58:56', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (240, 'hrmteam', '$2a$04$JedFPcbQWaOf1OM4IrVbgeNnefdSuz4F.ktffitOu5ZGIA01fdZmm', 'HRM团队负责人', '本地团队工作台演示账号', 103, '[]', '', '', 1, '', 0, '0:0:0:0:0:0:0:1', '2026-08-01 13:28:58', '1', '2026-08-01 11:56:19', NULL, '2026-08-01 13:28:58', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (255, 'eam24243d7e8c4e41fb810', 'f7055d34222be50360d094ead70eef932f0a9e73a9b5984f834b2779ddc9', '领用办理测试员', NULL, 125, NULL, '', '', 0, '', 0, '', NULL, '', '2026-10-08 02:21:33', '', '2026-10-08 02:21:33', b'0', 165);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (256, 'eam24243d7e8c4e41fb811', '54aada6f14addd3b2a86e490a28a528aad5aeebf32bc96d56094bb5b055a', '领用接收测试员', NULL, 125, NULL, '', '', 0, '', 0, '', NULL, '', '2026-10-08 02:21:33', '', '2026-10-08 02:21:33', b'0', 165);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (260, 'channel101791808948462ro', '$2a$04$uKzSWWqMNXWIvJU/AC33P.b1qYNgKVb/kcvSsCdWjoS0UhMSG7Kr2', '栏目只读验收', NULL, 103, '[]', '', '', 1, '', 0, '127.0.0.1', '2026-10-12 23:19:12', '1', '2026-10-12 20:44:02', NULL, '2026-10-12 23:19:12', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (265, 'jackforma153612', '$2a$04$xdK84VIRuoGa24rHDbfFruFOZbpVthUx2nWBLS8gU4xX64CaSl8QS', '表单仅审核验收153612', 'jack-form-todo-20261021-153612', 100, '[]', '', '', 0, '', 0, '127.0.0.1', '2026-10-21 17:27:03', '1', '2026-10-21 17:27:03', NULL, '2026-10-21 17:27:03', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (281, 'cmsui20261030viewer', '$2a$04$GaEkfYlLh3D0Yo84HTTy/uYVyKZq95BS1RsVUEQoDRZeOOPdnhC2G', '设计只读验收20261030', NULL, NULL, NULL, '', '', 0, '', 0, '127.0.0.1', '2026-10-30 16:24:34', '1', '2026-10-30 07:42:45', NULL, '2026-10-30 16:24:34', b'0', 1);

INSERT IGNORE INTO `system_users` (`id`, `username`, `password`, `nickname`, `remark`, `dept_id`, `post_ids`, `email`, `mobile`, `sex`, `avatar`, `status`, `login_ip`, `login_date`, `creator`, `create_time`, `updater`, `update_time`, `deleted`, `tenant_id`) VALUES (282, 'cmsremaining20261030', '$2a$04$ICeB.xpdPy01lk7oUwxo1ufo88ZWoywR80X6XnaC1R9qHeVZ9vDiW', '设计条件写入验收20261030', NULL, NULL, NULL, '', '', 0, '', 0, '127.0.0.1', '2026-10-30 16:39:57', '1', '2026-10-30 15:56:28', NULL, '2026-10-30 16:39:57', b'0', 1);

INSERT IGNORE INTO `infra_file_config` (`id`,`name`,`storage`,`remark`,`master`,`config`,`deleted`) VALUES (4,'系统文件存储',1,'系统服务内置数据库文件存储',b'1','{"@class":"com.group.antian.module.infra.framework.file.core.client.db.DBFileClientConfig","domain":"http://127.0.0.1:48080"}',b'0');

COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
