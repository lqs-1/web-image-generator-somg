/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : storage

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 18/05/2023 22:30:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for file_location
-- ----------------------------
DROP TABLE IF EXISTS `file_location`;
CREATE TABLE `file_location`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `imagePath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件的本地路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '本地文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file_location
-- ----------------------------
INSERT INTO `file_location` VALUES (35, '/home/somg/img/local/5ff0709b07c54ee2b16695de6200aa85.png');
INSERT INTO `file_location` VALUES (36, '/home/somg/img/scale/e86419a986914c8997dc139aea8072a5.png');
INSERT INTO `file_location` VALUES (37, '/home/somg/img/local/d6554390d65a4c4082088938c6077f85.png');
INSERT INTO `file_location` VALUES (38, '/home/somg/img/scale/8e82e05c2eaf491c89de06ed93387077.png');
INSERT INTO `file_location` VALUES (39, '/home/somg/img/local/b02dc56d0d25446fa53c292553f3b968.png');
INSERT INTO `file_location` VALUES (40, '/home/somg/img/scale/f359a3beea2e4d2f9bf01496d2e63c57.png');

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menuIndex` int NULL DEFAULT NULL COMMENT '菜单索引（父级菜单才有）',
  `menuPath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单路径（父级菜单和子菜单都有）',
  `menuName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名',
  `parentIndex` int NULL DEFAULT NULL COMMENT '子菜单的父级菜单索引',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES (1, 1, 'storage', '我的文件', NULL);
INSERT INTO `menus` VALUES (2, 2, 'user', '用户管理', NULL);
INSERT INTO `menus` VALUES (3, NULL, '/user/userList', '用户列表', 2);
INSERT INTO `menus` VALUES (4, NULL, '/user/roleList', '角色列表', 2);
INSERT INTO `menus` VALUES (5, NULL, '/user/permissionList', '权限列表', 2);
INSERT INTO `menus` VALUES (6, NULL, '/storage/fileList', '文件列表', 1);
INSERT INTO `menus` VALUES (7, NULL, '/user/menuList', '菜单权限', 2);
INSERT INTO `menus` VALUES (19, NULL, '/storage/imageList', '图片列表', 1);
INSERT INTO `menus` VALUES (22, NULL, '/storage/videoList', '视频列表', 1);
INSERT INTO `menus` VALUES (23, NULL, '/storage/audioList', '音频列表', 1);
INSERT INTO `menus` VALUES (26, NULL, '/user/resource', '整站资源', 2);
INSERT INTO `menus` VALUES (27, NULL, '/user/sysLogList', '系统日志', 2);
INSERT INTO `menus` VALUES (31, 3, 'chatGPT', 'ChatGPT', NULL);
INSERT INTO `menus` VALUES (32, NULL, '/chatGPT/TextRequest', '文字问答', 3);
INSERT INTO `menus` VALUES (33, 6, 'image', '图片处理', NULL);
INSERT INTO `menus` VALUES (34, NULL, '/image/scale', '图片缩放', 6);
INSERT INTO `menus` VALUES (35, 12, 'news', '热点要闻', NULL);
INSERT INTO `menus` VALUES (36, NULL, '/news/cnJingJiItNews', '中国经济网IT', 12);
INSERT INTO `menus` VALUES (37, NULL, '/news/cnPeopleNews', '人民网滚动要闻', 12);
INSERT INTO `menus` VALUES (38, NULL, '/news/cnTouTiaoNews', '头条热搜榜', 12);
INSERT INTO `menus` VALUES (39, NULL, '/news/CnWeiBoHotSearch', '微博热搜榜', 12);
INSERT INTO `menus` VALUES (43, NULL, '/user/sysDictList', '系统字典', 2);
INSERT INTO `menus` VALUES (44, 24, 'tv', '影视', NULL);
INSERT INTO `menus` VALUES (45, NULL, '/tv/tvSearch', '影视搜索', 24);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `permissionName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '接口权限名字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '接口权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'select');
INSERT INTO `permission` VALUES (3, 'delete');
INSERT INTO `permission` VALUES (4, 'add');
INSERT INTO `permission` VALUES (7, 'update');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `roleName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'common');
INSERT INTO `role` VALUES (2, 'supermanager');
INSERT INTO `role` VALUES (5, 'admin');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '字典id',
  `dictCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典编码',
  `parentId` int NULL DEFAULT NULL COMMENT '父字典id',
  `dictDesc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典描述',
  `dictValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (4, 'PATH_DICT', NULL, '所有路径字典', NULL);
INSERT INTO `sys_dict` VALUES (5, 'ha', 4, 'desc', '23');
INSERT INTO `sys_dict` VALUES (6, 'ha', 4, 'desc', '23');
INSERT INTO `sys_dict` VALUES (7, 'ha', 4, 'desc', '23');
INSERT INTO `sys_dict` VALUES (8, 'ha', 4, 'desc', '23');
INSERT INTO `sys_dict` VALUES (9, 'ha', 4, 'desc', '23');
INSERT INTO `sys_dict` VALUES (10, 'ha', 4, 'desc', '23');
INSERT INTO `sys_dict` VALUES (11, 'ha', 4, 'desc', '23');
INSERT INTO `sys_dict` VALUES (28, 'SYSTEM_STATUS_CODE', NULL, '所有环境变量', NULL);
INSERT INTO `sys_dict` VALUES (29, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (30, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (31, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (32, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (33, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (34, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (35, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (36, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (37, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (38, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (39, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (40, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (41, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (42, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (43, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (44, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (45, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (46, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (47, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (48, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (49, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (50, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (51, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (52, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (53, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (54, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (55, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (56, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (57, 'ha', 28, 'desc', '23');
INSERT INTO `sys_dict` VALUES (58, 'SYSTEM_DEFAULT_SETTING', NULL, '系统默认配置项', NULL);
INSERT INTO `sys_dict` VALUES (59, 'USER_DEFAULT_PASSWORD', 58, '默认充值密码', 'liqisong2002');
INSERT INTO `sys_dict` VALUES (60, 'USER_DEFAULT_ROLE', 58, '用户创建时候的默认角色', 'common');
INSERT INTO `sys_dict` VALUES (61, 'USER_DEFAULT_PERMISSION', 58, '用户创建时候的默认权限', 'select');
INSERT INTO `sys_dict` VALUES (62, 'USER_DEFAULT_MENU', 58, '用户创建时候的默认菜单', 'storage:chatGPT:image:news:tv');
INSERT INTO `sys_dict` VALUES (63, 'THIRD_SYS_LOG_DEFAULT_REQUEST_PATH', 58, '系统默认第三方系统日志请求路径', 'http://127.0.0.1:8888/sysLog/thirdSysLog');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userId` int NOT NULL COMMENT '用户id',
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `time` datetime NOT NULL COMMENT '操作时间',
  `serverName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务模块名字',
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行的操作',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1441 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, 23, 'lqs', '2023-04-01 06:20:22', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (2, 23, 'lqs', '2023-04-01 06:20:55', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (3, 23, 'lqs', '2023-04-01 07:04:27', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (4, 23, 'lqs', '2023-04-01 07:04:35', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (5, 23, 'lqs', '2023-04-01 07:04:37', '用户服务', '获取验证码');
INSERT INTO `sys_log` VALUES (6, 23, 'lqs', '2023-04-01 07:08:12', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (7, 23, 'lqs', '2023-04-01 07:08:13', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (8, 23, 'lqs', '2023-04-01 07:08:27', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (9, 23, 'lqs', '2023-04-01 07:08:35', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (10, 23, 'lqs', '2023-04-01 07:09:18', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (11, 23, 'lqs', '2023-04-01 07:10:05', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (12, 23, 'lqs', '2023-04-01 07:10:42', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (13, 23, 'lqs', '2023-04-01 07:10:57', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (14, 23, 'lqs', '2023-04-01 07:11:08', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (15, 23, 'lqs', '2023-04-01 07:11:33', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (16, 23, 'lqs', '2023-04-01 07:11:43', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (17, 23, 'lqs', '2023-04-01 07:11:45', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (18, 23, 'lqs', '2023-04-01 07:11:50', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (19, 23, 'lqs', '2023-04-01 07:11:52', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (20, 23, 'lqs', '2023-04-01 07:18:36', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (21, 23, 'lqs', '2023-04-01 07:19:20', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (22, 23, 'lqs', '2023-04-01 07:19:55', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (23, 23, 'lqs', '2023-04-01 07:21:06', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (24, 23, 'lqs', '2023-04-01 07:21:07', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (25, 23, 'lqs', '2023-04-01 07:21:08', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (26, 23, 'lqs', '2023-04-01 15:22:57', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (27, 23, 'lqs', '2023-04-01 15:22:57', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (28, 23, 'lqs', '2023-04-01 15:23:09', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (29, 23, 'lqs', '2023-04-01 15:23:11', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (30, 23, 'lqs', '2023-04-01 15:25:35', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (31, 23, 'lqs', '2023-04-01 15:25:37', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (32, 23, 'lqs', '2023-04-01 15:25:42', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (33, 23, 'lqs', '2023-04-01 15:25:44', '日志服务', '日志列表');
INSERT INTO `sys_log` VALUES (34, 23, 'lqs', '2023-04-08 18:11:49', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (35, 23, 'lqs', '2023-04-08 18:11:59', '上传服务', '删除文件');
INSERT INTO `sys_log` VALUES (36, 23, 'lqs', '2023-04-08 18:12:00', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (37, 23, 'lqs', '2023-04-08 18:12:05', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (38, 23, 'lqs', '2023-04-25 12:53:18', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (39, 23, 'lqs', '2023-04-25 12:53:21', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (40, 23, 'lqs', '2023-04-25 12:53:23', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (41, 23, 'lqs', '2023-04-25 12:53:26', '文件服务', '所有音频列表[用户]');
INSERT INTO `sys_log` VALUES (42, 23, 'lqs', '2023-04-25 12:53:27', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (43, 23, 'lqs', '2023-04-25 12:56:32', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (44, 23, 'lqs', '2023-04-25 12:56:34', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (45, 23, 'lqs', '2023-04-25 12:56:37', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (46, 23, 'lqs', '2023-04-25 12:56:39', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (47, 23, 'lqs', '2023-04-25 12:56:43', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (48, 23, 'lqs', '2023-04-25 12:56:44', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (49, 23, 'lqs', '2023-04-25 12:56:46', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (50, 23, 'lqs', '2023-04-25 12:56:58', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (51, 23, 'lqs', '2023-04-25 12:56:59', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (52, 23, 'lqs', '2023-04-25 12:57:02', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (53, 23, 'lqs', '2023-04-25 12:57:44', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (54, 23, 'lqs', '2023-04-25 12:57:45', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (55, 23, 'lqs', '2023-04-25 12:57:47', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (56, 23, 'lqs', '2023-04-25 12:57:48', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (57, 23, 'lqs', '2023-04-25 12:57:49', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (58, 23, 'lqs', '2023-04-25 12:57:51', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (59, 23, 'lqs', '2023-04-25 12:57:52', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (60, 23, 'lqs', '2023-04-25 12:57:57', '菜单服务', '给用户授权菜单');
INSERT INTO `sys_log` VALUES (61, 23, 'lqs', '2023-04-25 12:57:58', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (62, 23, 'lqs', '2023-04-25 12:59:02', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (63, 23, 'lqs', '2023-04-25 12:59:06', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (64, 23, 'lqs', '2023-04-25 12:59:21', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (65, 23, 'lqs', '2023-04-25 12:59:21', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (66, 23, 'lqs', '2023-04-25 12:59:28', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (67, 23, 'lqs', '2023-04-25 12:59:29', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (68, 23, 'lqs', '2023-04-25 12:59:33', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (69, 23, 'lqs', '2023-04-25 12:59:35', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (70, 23, 'lqs', '2023-04-25 12:59:42', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (71, 23, 'lqs', '2023-04-25 12:59:59', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (72, 23, 'lqs', '2023-04-25 12:59:59', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (73, 23, 'lqs', '2023-04-25 13:00:07', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (74, 23, 'lqs', '2023-04-25 13:00:11', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (75, 23, 'lqs', '2023-04-25 13:00:31', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (76, 23, 'lqs', '2023-04-25 13:01:07', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (77, 23, 'lqs', '2023-04-25 13:01:08', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (78, 23, 'lqs', '2023-04-25 13:01:13', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (79, 23, 'lqs', '2023-04-25 13:01:15', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (80, 23, 'lqs', '2023-04-25 13:01:18', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (81, 23, 'lqs', '2023-04-25 13:01:19', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (82, 23, 'lqs', '2023-04-25 13:01:20', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (83, 23, 'lqs', '2023-04-25 13:01:21', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (84, 23, 'lqs', '2023-04-25 13:01:22', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (85, 23, 'lqs', '2023-04-25 13:01:29', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (86, 23, 'lqs', '2023-04-25 13:01:30', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (87, 23, 'lqs', '2023-04-25 13:01:32', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (88, 23, 'lqs', '2023-04-25 13:01:53', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (89, 23, 'lqs', '2023-04-25 13:01:54', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (90, 23, 'lqs', '2023-04-25 13:02:10', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (91, 23, 'lqs', '2023-04-25 13:02:24', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (92, 23, 'lqs', '2023-04-25 13:02:25', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (93, 23, 'lqs', '2023-04-25 13:02:27', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (94, 23, 'lqs', '2023-04-25 13:02:43', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (95, 23, 'lqs', '2023-04-25 13:02:43', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (96, 23, 'lqs', '2023-04-25 13:02:47', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (97, 23, 'lqs', '2023-04-25 13:03:18', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (98, 23, 'lqs', '2023-04-25 13:03:18', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (99, 23, 'lqs', '2023-04-25 13:03:20', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (100, 23, 'lqs', '2023-04-25 13:04:08', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (101, 23, 'lqs', '2023-04-25 13:04:08', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (102, 23, 'lqs', '2023-04-25 13:04:10', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (103, 23, 'lqs', '2023-04-25 13:04:26', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (104, 23, 'lqs', '2023-04-25 13:04:28', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (105, 23, 'lqs', '2023-04-25 13:04:43', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (106, 23, 'lqs', '2023-04-25 13:04:44', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (107, 23, 'lqs', '2023-04-25 13:04:46', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (108, 23, 'lqs', '2023-04-25 13:05:09', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (109, 23, 'lqs', '2023-04-25 13:05:10', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (110, 23, 'lqs', '2023-04-25 13:05:19', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (111, 23, 'lqs', '2023-04-25 13:05:36', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (112, 23, 'lqs', '2023-04-25 13:05:37', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (113, 23, 'lqs', '2023-04-25 13:05:40', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (114, 23, 'lqs', '2023-04-25 13:05:44', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (115, 23, 'lqs', '2023-04-25 13:05:46', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (116, 23, 'lqs', '2023-04-25 13:05:47', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (117, 23, 'lqs', '2023-04-25 13:05:52', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (118, 23, 'lqs', '2023-04-25 13:05:52', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (119, 23, 'lqs', '2023-04-25 13:05:56', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (120, 23, 'lqs', '2023-04-25 13:05:56', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (121, 23, 'lqs', '2023-04-25 13:06:08', '菜单服务', '给用户授权菜单');
INSERT INTO `sys_log` VALUES (122, 23, 'lqs', '2023-04-25 13:06:09', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (123, 23, 'lqs', '2023-04-25 13:07:23', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (124, 23, 'lqs', '2023-04-25 13:07:25', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (125, 23, 'lqs', '2023-04-25 13:07:30', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (126, 23, 'lqs', '2023-04-25 13:08:05', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (127, 23, 'lqs', '2023-04-25 13:08:10', '用户服务', '删除用户');
INSERT INTO `sys_log` VALUES (128, 23, 'lqs', '2023-04-25 13:08:11', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (129, 23, 'lqs', '2023-04-25 13:08:13', '用户服务', '删除用户');
INSERT INTO `sys_log` VALUES (130, 23, 'lqs', '2023-04-25 13:08:13', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (131, 23, 'lqs', '2023-04-25 13:10:23', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (132, 23, 'lqs', '2023-04-25 13:10:25', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (133, 23, 'lqs', '2023-04-25 13:10:26', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (134, 23, 'lqs', '2023-04-25 13:12:35', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (135, 23, 'lqs', '2023-04-25 13:12:42', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (136, 23, 'lqs', '2023-04-25 13:12:48', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (137, 23, 'lqs', '2023-04-25 13:12:50', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (138, 23, 'lqs', '2023-04-25 13:12:58', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (139, 23, 'lqs', '2023-04-25 13:13:13', '图片服务', '上传缩放图片');
INSERT INTO `sys_log` VALUES (140, 23, 'lqs', '2023-04-25 13:17:30', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (141, 23, 'lqs', '2023-04-25 13:19:46', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (142, 23, 'lqs', '2023-04-25 13:23:25', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (143, 23, 'lqs', '2023-04-25 13:23:38', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (144, 23, 'lqs', '2023-04-25 13:23:52', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (145, 23, 'lqs', '2023-04-25 13:23:55', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (146, 23, 'lqs', '2023-04-25 13:23:57', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (147, 23, 'lqs', '2023-04-25 13:24:09', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (148, 23, 'lqs', '2023-04-25 13:24:16', '上传服务', '上传单文件');
INSERT INTO `sys_log` VALUES (149, 23, 'lqs', '2023-04-25 13:24:18', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (150, 23, 'lqs', '2023-04-25 13:24:21', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (151, 23, 'lqs', '2023-04-25 22:42:36', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (152, 23, 'lqs', '2023-04-25 22:42:38', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (153, 23, 'lqs', '2023-04-25 22:42:41', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (154, 23, 'lqs', '2023-04-25 22:42:43', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (155, 23, 'lqs', '2023-04-25 22:43:42', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (156, 23, 'lqs', '2023-04-25 22:43:44', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (157, 23, 'lqs', '2023-04-25 22:43:46', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (158, 23, 'lqs', '2023-04-25 22:43:50', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (159, 23, 'lqs', '2023-04-25 22:44:23', '图片服务', '上传缩放图片');
INSERT INTO `sys_log` VALUES (160, 23, 'lqs', '2023-04-26 18:35:03', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (161, 23, 'lqs', '2023-04-26 22:00:56', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (162, 23, 'lqs', '2023-04-27 08:09:21', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (163, 23, 'lqs', '2023-04-27 08:09:23', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (164, 23, 'lqs', '2023-04-27 08:09:26', '文件服务', '所有音频列表[用户]');
INSERT INTO `sys_log` VALUES (165, 23, 'lqs', '2023-04-27 08:09:29', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (166, 23, 'lqs', '2023-04-27 08:10:17', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (167, 23, 'lqs', '2023-04-27 08:10:19', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (168, 23, 'lqs', '2023-04-27 08:10:21', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (169, 23, 'lqs', '2023-04-27 08:10:25', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (170, 23, 'lqs', '2023-04-27 08:10:28', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (171, 23, 'lqs', '2023-04-27 08:10:30', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (172, 23, 'lqs', '2023-04-27 08:10:32', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (173, 23, 'lqs', '2023-04-29 17:23:13', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (174, 23, 'lqs', '2023-04-29 17:23:15', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (175, 23, 'lqs', '2023-04-29 17:23:17', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (176, 23, 'lqs', '2023-04-29 17:24:21', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (177, 23, 'lqs', '2023-04-29 17:24:21', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (178, 23, 'lqs', '2023-04-29 17:24:39', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (179, 23, 'lqs', '2023-04-29 17:24:43', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (180, 23, 'lqs', '2023-04-29 17:24:46', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (181, 23, 'lqs', '2023-04-29 17:24:49', '文件服务', '所有音频列表[用户]');
INSERT INTO `sys_log` VALUES (182, 23, 'lqs', '2023-04-29 17:24:54', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (183, 23, 'lqs', '2023-04-29 17:24:57', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (184, 23, 'lqs', '2023-04-29 17:25:00', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (185, 23, 'lqs', '2023-04-29 17:25:03', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (186, 23, 'lqs', '2023-04-29 17:25:06', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (187, 23, 'lqs', '2023-04-29 17:42:16', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (188, 23, 'lqs', '2023-04-29 17:42:26', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (189, 23, 'lqs', '2023-04-29 17:42:35', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (190, 23, 'lqs', '2023-04-29 17:42:38', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (191, 23, 'lqs', '2023-04-29 17:42:40', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (192, 23, 'lqs', '2023-04-29 17:42:42', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (193, 23, 'lqs', '2023-04-29 17:42:44', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (194, 23, 'lqs', '2023-04-29 17:43:14', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (195, 23, 'lqs', '2023-04-29 17:46:44', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (196, 23, 'lqs', '2023-04-29 17:46:48', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (197, 23, 'lqs', '2023-04-29 17:46:51', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (198, 23, 'lqs', '2023-04-29 17:47:04', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (199, 23, 'lqs', '2023-04-29 17:47:05', '文件服务', '所有音频列表[用户]');
INSERT INTO `sys_log` VALUES (200, 23, 'lqs', '2023-04-29 17:47:06', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (201, 23, 'lqs', '2023-04-29 17:47:08', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (202, 23, 'lqs', '2023-04-29 17:47:16', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (203, 23, 'lqs', '2023-04-29 17:47:20', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (204, 23, 'lqs', '2023-04-29 17:47:31', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (205, 23, 'lqs', '2023-04-29 17:47:33', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (206, 23, 'lqs', '2023-04-29 17:47:35', '文件服务', '所有音频列表[用户]');
INSERT INTO `sys_log` VALUES (207, 23, 'lqs', '2023-04-29 17:47:39', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (208, 23, 'lqs', '2023-04-29 17:47:47', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (209, 23, 'lqs', '2023-04-29 17:47:50', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (210, 23, 'lqs', '2023-04-29 17:48:01', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (211, 23, 'lqs', '2023-04-29 17:48:07', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (212, 23, 'lqs', '2023-04-29 17:48:09', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (213, 23, 'lqs', '2023-04-29 17:48:13', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (214, 23, 'lqs', '2023-04-29 17:48:49', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (215, 23, 'lqs', '2023-04-29 17:48:52', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (216, 23, 'lqs', '2023-04-29 17:48:55', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (217, 23, 'lqs', '2023-04-29 17:49:01', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (218, 23, 'lqs', '2023-04-29 17:49:07', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (219, 23, 'lqs', '2023-04-29 17:49:10', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (220, 23, 'lqs', '2023-04-29 17:49:11', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (221, 23, 'lqs', '2023-04-29 17:49:33', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (222, 23, 'lqs', '2023-04-29 17:49:35', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (223, 23, 'lqs', '2023-04-29 17:49:36', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (224, 23, 'lqs', '2023-04-29 17:49:40', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (225, 23, 'lqs', '2023-04-29 17:49:56', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (226, 23, 'lqs', '2023-04-29 17:50:00', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (227, 23, 'lqs', '2023-04-29 17:50:10', '图片服务', '上传缩放图片');
INSERT INTO `sys_log` VALUES (228, 23, 'lqs', '2023-04-29 17:50:29', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (229, 23, 'lqs', '2023-04-29 17:50:34', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (230, 23, 'lqs', '2023-04-29 17:50:37', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (231, 23, 'lqs', '2023-04-29 17:50:39', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (232, 23, 'lqs', '2023-04-29 17:51:29', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (233, 23, 'lqs', '2023-04-29 17:52:38', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (234, 23, 'lqs', '2023-04-29 17:52:41', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (235, 23, 'lqs', '2023-04-29 17:52:47', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (236, 23, 'lqs', '2023-04-29 17:53:05', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (237, 23, 'lqs', '2023-04-29 17:53:06', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (238, 23, 'lqs', '2023-04-29 17:53:09', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (239, 23, 'lqs', '2023-04-29 17:53:11', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (240, 23, 'lqs', '2023-04-29 17:53:15', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (241, 23, 'lqs', '2023-04-29 17:53:15', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (242, 23, 'lqs', '2023-04-29 17:53:19', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (243, 23, 'lqs', '2023-04-29 17:53:22', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (244, 23, 'lqs', '2023-04-29 17:53:25', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (245, 23, 'lqs', '2023-04-29 17:53:28', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (246, 23, 'lqs', '2023-04-29 17:54:01', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (247, 23, 'lqs', '2023-04-29 17:54:05', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (248, 23, 'lqs', '2023-04-29 17:54:07', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (249, 23, 'lqs', '2023-04-29 17:54:07', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (250, 23, 'lqs', '2023-04-29 17:55:53', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (251, 23, 'lqs', '2023-04-29 17:55:54', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (252, 23, 'lqs', '2023-04-29 17:55:55', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (253, 23, 'lqs', '2023-04-29 17:55:56', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (254, 23, 'lqs', '2023-04-29 17:55:56', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (255, 23, 'lqs', '2023-04-29 17:56:02', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (256, 23, 'lqs', '2023-04-29 17:56:03', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (257, 23, 'lqs', '2023-04-29 17:56:05', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (258, 23, 'lqs', '2023-04-29 17:56:27', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (259, 23, 'lqs', '2023-04-29 17:56:29', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (260, 23, 'lqs', '2023-04-29 17:56:30', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (261, 23, 'lqs', '2023-04-29 17:56:41', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (262, 23, 'lqs', '2023-04-29 17:56:43', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (263, 23, 'lqs', '2023-04-29 17:56:45', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (264, 23, 'lqs', '2023-04-29 17:56:46', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (265, 23, 'lqs', '2023-04-29 17:56:47', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (266, 23, 'lqs', '2023-04-29 17:57:05', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (267, 23, 'lqs', '2023-04-29 17:57:06', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (268, 23, 'lqs', '2023-04-29 17:57:08', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (269, 23, 'lqs', '2023-04-29 17:57:09', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (270, 23, 'lqs', '2023-04-29 17:57:13', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (271, 23, 'lqs', '2023-04-29 17:57:16', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (272, 23, 'lqs', '2023-04-29 17:57:17', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (273, 23, 'lqs', '2023-04-29 17:57:20', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (274, 23, 'lqs', '2023-04-29 17:57:21', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (275, 23, 'lqs', '2023-04-29 17:57:42', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (276, 23, 'lqs', '2023-04-29 17:57:49', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (277, 23, 'lqs', '2023-04-29 17:57:51', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (278, 23, 'lqs', '2023-04-29 17:57:53', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (279, 23, 'lqs', '2023-04-29 17:57:55', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (280, 23, 'lqs', '2023-04-29 17:57:56', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (281, 23, 'lqs', '2023-04-29 17:57:57', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (282, 23, 'lqs', '2023-04-29 17:58:06', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (283, 23, 'lqs', '2023-04-29 17:58:07', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (284, 23, 'lqs', '2023-04-29 17:58:08', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (285, 23, 'lqs', '2023-04-29 17:58:13', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (286, 23, 'lqs', '2023-04-29 17:58:13', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (287, 23, 'lqs', '2023-04-29 17:58:15', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (288, 23, 'lqs', '2023-04-29 17:58:19', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (289, 23, 'lqs', '2023-04-29 17:58:19', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (290, 23, 'lqs', '2023-04-29 17:58:20', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (291, 23, 'lqs', '2023-04-29 17:59:07', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (292, 23, 'lqs', '2023-04-29 17:59:10', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (293, 23, 'lqs', '2023-04-29 17:59:12', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (294, 23, 'lqs', '2023-04-29 17:59:13', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (295, 23, 'lqs', '2023-04-29 17:59:14', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (296, 23, 'lqs', '2023-04-29 17:59:16', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (297, 23, 'lqs', '2023-04-29 17:59:24', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (298, 23, 'lqs', '2023-04-29 17:59:29', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (299, 23, 'lqs', '2023-04-29 17:59:30', '文件服务', '所有音频列表[用户]');
INSERT INTO `sys_log` VALUES (300, 23, 'lqs', '2023-04-29 17:59:31', '文件服务', '所有音频列表[用户]');
INSERT INTO `sys_log` VALUES (301, 23, 'lqs', '2023-04-29 17:59:38', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (302, 23, 'lqs', '2023-04-29 17:59:39', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (303, 23, 'lqs', '2023-04-29 17:59:45', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (304, 23, 'lqs', '2023-04-29 17:59:56', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (305, 23, 'lqs', '2023-04-29 17:59:57', '文件服务', '所有音频列表[用户]');
INSERT INTO `sys_log` VALUES (306, 23, 'lqs', '2023-04-29 18:00:07', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (307, 23, 'lqs', '2023-04-29 18:00:09', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (308, 23, 'lqs', '2023-04-29 18:00:13', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (309, 23, 'lqs', '2023-04-29 18:19:09', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (310, 23, 'lqs', '2023-04-29 18:20:46', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (311, 23, 'lqs', '2023-04-29 18:20:49', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (312, 23, 'lqs', '2023-04-29 18:20:52', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (313, 23, 'lqs', '2023-04-29 18:21:00', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (314, 23, 'lqs', '2023-04-29 18:27:40', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (315, 23, 'lqs', '2023-04-29 20:30:15', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (316, 23, 'lqs', '2023-04-29 20:30:20', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (317, 23, 'lqs', '2023-04-29 20:30:22', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (318, 23, 'lqs', '2023-04-29 20:30:26', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (319, 23, 'lqs', '2023-04-29 20:30:30', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (320, 23, 'lqs', '2023-04-29 22:51:43', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (321, 23, 'lqs', '2023-04-29 23:29:12', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (322, 23, 'lqs', '2023-04-30 11:02:00', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (323, 23, 'lqs', '2023-04-30 11:02:01', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (324, 23, 'lqs', '2023-04-30 11:18:15', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (325, 23, 'lqs', '2023-04-30 11:18:19', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (326, 23, 'lqs', '2023-04-30 11:18:22', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (327, 23, 'lqs', '2023-04-30 11:18:42', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (328, 23, 'lqs', '2023-04-30 11:18:44', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (329, 23, 'lqs', '2023-04-30 11:18:45', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (330, 23, 'lqs', '2023-04-30 11:19:12', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (331, 23, 'lqs', '2023-04-30 11:19:13', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (332, 23, 'lqs', '2023-04-30 11:19:17', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (333, 23, 'lqs', '2023-04-30 11:19:18', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (334, 23, 'lqs', '2023-04-30 11:19:21', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (335, 23, 'lqs', '2023-04-30 11:19:22', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (336, 23, 'lqs', '2023-04-30 11:19:24', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (337, 23, 'lqs', '2023-04-30 11:19:28', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (338, 23, 'lqs', '2023-04-30 11:19:29', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (339, 23, 'lqs', '2023-04-30 11:19:34', '菜单服务', '给用户授权菜单');
INSERT INTO `sys_log` VALUES (340, 23, 'lqs', '2023-04-30 11:19:35', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (341, 23, 'lqs', '2023-04-30 14:33:52', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (342, 23, 'lqs', '2023-04-30 14:33:54', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (343, 23, 'lqs', '2023-04-30 14:33:56', '文件服务', '所有视频列表[用户]');
INSERT INTO `sys_log` VALUES (344, 23, 'lqs', '2023-04-30 14:33:58', '文件服务', '所有音频列表[用户]');
INSERT INTO `sys_log` VALUES (345, 23, 'lqs', '2023-04-30 14:34:02', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (346, 23, 'lqs', '2023-04-30 14:34:05', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (347, 23, 'lqs', '2023-04-30 14:34:08', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (348, 23, 'lqs', '2023-04-30 14:34:10', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (349, 23, 'lqs', '2023-04-30 14:34:12', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (350, 23, 'lqs', '2023-04-30 14:34:33', '图片服务', '上传缩放图片');
INSERT INTO `sys_log` VALUES (351, 23, 'lqs', '2023-04-30 18:22:04', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (352, 23, 'lqs', '2023-04-30 19:11:07', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (353, 23, 'lqs', '2023-04-30 19:16:26', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (354, 23, 'lqs', '2023-04-30 19:16:34', '上传服务', '上传单文件');
INSERT INTO `sys_log` VALUES (355, 23, 'lqs', '2023-04-30 19:16:36', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (356, 23, 'lqs', '2023-04-30 19:16:59', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (357, 23, 'lqs', '2023-04-30 19:20:25', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (358, 23, 'lqs', '2023-04-30 19:53:22', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (359, 23, 'lqs', '2023-04-30 19:53:32', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (360, 23, 'lqs', '2023-04-30 19:53:32', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (361, 23, 'lqs', '2023-04-30 19:53:37', '菜单服务', '给用户授权菜单');
INSERT INTO `sys_log` VALUES (362, 23, 'lqs', '2023-04-30 19:53:38', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (363, 23, 'lqs', '2023-05-01 00:44:14', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (364, 23, 'lqs', '2023-05-01 00:44:59', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (365, 23, 'lqs', '2023-05-01 00:52:30', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (366, 23, 'lqs', '2023-05-01 01:01:34', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (367, 23, 'lqs', '2023-05-01 01:01:42', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (368, 23, 'lqs', '2023-05-01 01:01:50', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (369, 23, 'lqs', '2023-05-01 01:01:56', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (370, 23, 'lqs', '2023-05-01 01:26:05', '图片服务', '上传缩放图片');
INSERT INTO `sys_log` VALUES (371, 23, 'lqs', '2023-05-01 01:37:52', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (372, 23, 'lqs', '2023-05-01 01:38:02', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (373, 23, 'lqs', '2023-05-01 01:38:28', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (374, 23, 'lqs', '2023-05-01 01:38:46', '用户服务', '添加用户');
INSERT INTO `sys_log` VALUES (375, 23, 'lqs', '2023-05-01 01:38:47', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (376, 23, 'lqs', '2023-05-01 01:38:50', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (377, 23, 'lqs', '2023-05-01 01:38:50', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (378, 23, 'lqs', '2023-05-01 01:39:05', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (379, 23, 'lqs', '2023-05-01 01:39:05', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (380, 23, 'lqs', '2023-05-01 01:40:57', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (381, 23, 'lqs', '2023-05-01 01:41:01', '用户服务', '删除用户');
INSERT INTO `sys_log` VALUES (382, 23, 'lqs', '2023-05-01 01:41:02', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (383, 23, 'lqs', '2023-05-01 01:43:58', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (384, 23, 'lqs', '2023-05-01 01:44:17', '用户服务', '添加用户');
INSERT INTO `sys_log` VALUES (385, 23, 'lqs', '2023-05-01 01:44:18', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (386, 23, 'lqs', '2023-05-01 01:44:21', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (387, 23, 'lqs', '2023-05-01 01:44:21', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (388, 23, 'lqs', '2023-05-01 01:45:05', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (389, 23, 'lqs', '2023-05-01 01:45:09', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (390, 23, 'lqs', '2023-05-01 01:45:10', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (391, 23, 'lqs', '2023-05-01 01:45:10', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (392, 23, 'lqs', '2023-05-01 01:45:10', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (393, 37, 'liubangqi', '2023-05-01 01:52:23', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (394, 37, 'liubangqi', '2023-05-01 01:52:31', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (395, 37, 'liubangqi', '2023-05-01 09:25:57', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (396, 23, 'lqs', '2023-05-01 10:42:20', '文件服务', '所有图片列表[用户]');
INSERT INTO `sys_log` VALUES (397, 23, 'lqs', '2023-05-01 21:46:45', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (398, 23, 'lqs', '2023-05-01 21:46:47', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (399, 23, 'lqs', '2023-05-01 21:46:47', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (400, 23, 'lqs', '2023-05-01 21:46:56', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (401, 23, 'lqs', '2023-05-01 21:46:57', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (402, 23, 'lqs', '2023-05-01 21:46:58', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (403, 23, 'lqs', '2023-05-01 21:47:18', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (404, 23, 'lqs', '2023-05-01 21:47:18', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (405, 23, 'lqs', '2023-05-01 21:47:20', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (406, 23, 'lqs', '2023-05-01 21:47:22', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (407, 23, 'lqs', '2023-05-01 21:47:22', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (408, 23, 'lqs', '2023-05-01 21:47:26', '菜单服务', '给用户授权菜单');
INSERT INTO `sys_log` VALUES (409, 23, 'lqs', '2023-05-01 21:47:26', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (410, 23, 'lqs', '2023-05-01 21:48:19', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (411, 23, 'lqs', '2023-05-01 21:48:22', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (412, 23, 'lqs', '2023-05-01 21:48:22', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (413, 23, 'lqs', '2023-05-01 21:48:24', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (414, 23, 'lqs', '2023-05-01 21:48:41', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (415, 23, 'lqs', '2023-05-01 21:48:41', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (416, 23, 'lqs', '2023-05-01 21:48:42', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (417, 23, 'lqs', '2023-05-01 21:48:44', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (418, 23, 'lqs', '2023-05-01 21:48:44', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (419, 23, 'lqs', '2023-05-01 21:48:48', '菜单服务', '给用户授权菜单');
INSERT INTO `sys_log` VALUES (420, 23, 'lqs', '2023-05-01 21:48:48', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (421, 23, 'lqs', '2023-05-01 21:49:00', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (422, 23, 'lqs', '2023-05-01 21:49:24', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (423, 23, 'lqs', '2023-05-01 21:49:33', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (424, 23, 'lqs', '2023-05-01 21:49:33', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (425, 23, 'lqs', '2023-05-01 21:50:02', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (426, 23, 'lqs', '2023-05-01 21:50:02', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (427, 23, 'lqs', '2023-05-01 21:54:05', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (428, 23, 'lqs', '2023-05-01 21:54:05', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (429, 23, 'lqs', '2023-05-01 21:54:45', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (430, 23, 'lqs', '2023-05-01 21:54:45', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (431, 23, 'lqs', '2023-05-01 21:56:32', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (432, 23, 'lqs', '2023-05-01 21:56:32', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (433, 23, 'lqs', '2023-05-01 21:56:56', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (434, 23, 'lqs', '2023-05-01 21:56:56', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (435, 23, 'lqs', '2023-05-01 21:58:45', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (436, 23, 'lqs', '2023-05-01 21:59:26', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (437, 23, 'lqs', '2023-05-01 21:59:26', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (438, 23, 'lqs', '2023-05-01 22:00:13', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (439, 23, 'lqs', '2023-05-01 22:00:13', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (440, 23, 'lqs', '2023-05-01 22:00:59', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (441, 23, 'lqs', '2023-05-01 22:00:59', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (442, 23, 'lqs', '2023-05-01 22:08:53', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (443, 23, 'lqs', '2023-05-01 22:08:59', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (444, 23, 'lqs', '2023-05-01 22:09:12', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (445, 23, 'lqs', '2023-05-01 22:09:50', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (446, 23, 'lqs', '2023-05-01 22:09:50', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (447, 23, 'lqs', '2023-05-01 22:09:52', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (448, 23, 'lqs', '2023-05-01 22:11:18', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (449, 23, 'lqs', '2023-05-01 22:11:18', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (450, 23, 'lqs', '2023-05-02 15:26:28', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (451, 23, 'lqs', '2023-05-02 15:26:31', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (452, 23, 'lqs', '2023-05-02 15:27:00', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (453, 23, 'lqs', '2023-05-02 15:27:00', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (454, 23, 'lqs', '2023-05-02 15:33:33', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (455, 23, 'lqs', '2023-05-02 15:33:52', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (456, 23, 'lqs', '2023-05-02 15:33:52', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (457, 23, 'lqs', '2023-05-02 15:34:22', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (458, 23, 'lqs', '2023-05-02 15:34:23', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (459, 23, 'lqs', '2023-05-02 15:35:26', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (460, 23, 'lqs', '2023-05-02 15:35:26', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (461, 23, 'lqs', '2023-05-02 15:35:54', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (462, 23, 'lqs', '2023-05-02 15:35:54', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (463, 23, 'lqs', '2023-05-02 15:35:59', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (464, 23, 'lqs', '2023-05-02 15:36:09', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (465, 23, 'lqs', '2023-05-02 15:36:09', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (466, 23, 'lqs', '2023-05-02 15:36:11', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (467, 23, 'lqs', '2023-05-02 15:36:25', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (468, 23, 'lqs', '2023-05-02 15:36:25', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (469, 23, 'lqs', '2023-05-02 15:36:35', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (470, 23, 'lqs', '2023-05-02 15:36:35', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (471, 23, 'lqs', '2023-05-02 15:36:44', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (472, 23, 'lqs', '2023-05-02 15:36:52', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (473, 23, 'lqs', '2023-05-02 15:36:52', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (474, 23, 'lqs', '2023-05-02 15:37:01', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (475, 23, 'lqs', '2023-05-02 15:37:01', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (476, 23, 'lqs', '2023-05-02 15:37:04', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (477, 23, 'lqs', '2023-05-02 15:37:04', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (478, 23, 'lqs', '2023-05-02 15:37:11', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (479, 23, 'lqs', '2023-05-02 15:37:11', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (480, 23, 'lqs', '2023-05-02 15:37:13', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (481, 23, 'lqs', '2023-05-02 15:37:13', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (482, 23, 'lqs', '2023-05-02 15:37:17', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (483, 23, 'lqs', '2023-05-02 15:37:25', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (484, 23, 'lqs', '2023-05-02 15:37:25', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (485, 23, 'lqs', '2023-05-02 15:37:27', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (486, 23, 'lqs', '2023-05-02 15:37:27', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (487, 23, 'lqs', '2023-05-10 09:32:19', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (488, 23, 'lqs', '2023-05-10 09:32:24', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (489, 23, 'lqs', '2023-05-10 09:32:26', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (490, 23, 'lqs', '2023-05-10 09:32:33', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (491, 23, 'lqs', '2023-05-10 09:32:35', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (492, 23, 'lqs', '2023-05-10 09:33:25', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (493, 23, 'lqs', '2023-05-10 09:33:29', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (494, 23, 'lqs', '2023-05-10 09:33:46', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (495, 23, 'lqs', '2023-05-10 09:34:44', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (496, 23, 'lqs', '2023-05-10 09:34:44', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (497, 23, 'lqs', '2023-05-10 09:34:55', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (498, 23, 'lqs', '2023-05-10 09:34:58', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (499, 23, 'lqs', '2023-05-10 09:35:46', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (500, 23, 'lqs', '2023-05-10 09:35:53', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (501, 23, 'lqs', '2023-05-10 09:35:55', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (502, 23, 'lqs', '2023-05-10 09:39:44', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (503, 23, 'lqs', '2023-05-10 09:42:53', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (504, 23, 'lqs', '2023-05-10 09:43:40', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (505, 23, 'lqs', '2023-05-10 09:44:28', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (506, 23, 'lqs', '2023-05-10 09:44:31', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (507, 23, 'lqs', '2023-05-10 09:44:32', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (508, 23, 'lqs', '2023-05-10 09:44:34', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (509, 23, 'lqs', '2023-05-10 09:44:35', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (510, 23, 'lqs', '2023-05-10 09:44:40', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (511, 23, 'lqs', '2023-05-10 09:44:41', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (512, 23, 'lqs', '2023-05-10 09:44:44', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (513, 23, 'lqs', '2023-05-10 09:47:33', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (514, 23, 'lqs', '2023-05-10 09:48:26', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (515, 23, 'lqs', '2023-05-10 09:48:29', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (516, 23, 'lqs', '2023-05-10 09:48:35', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (517, 23, 'lqs', '2023-05-10 09:52:35', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (518, 23, 'lqs', '2023-05-10 09:52:59', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (519, 23, 'lqs', '2023-05-10 09:54:31', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (520, 23, 'lqs', '2023-05-10 09:56:25', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (521, 23, 'lqs', '2023-05-10 09:56:28', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (522, 23, 'lqs', '2023-05-10 09:56:30', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (523, 23, 'lqs', '2023-05-10 09:56:36', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (524, 23, 'lqs', '2023-05-10 09:56:45', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (525, 23, 'lqs', '2023-05-10 10:01:08', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (526, 23, 'lqs', '2023-05-10 10:01:11', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (527, 23, 'lqs', '2023-05-10 10:01:17', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (528, 23, 'lqs', '2023-05-10 10:01:21', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (529, 23, 'lqs', '2023-05-10 10:01:24', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (530, 23, 'lqs', '2023-05-10 10:01:24', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (531, 23, 'lqs', '2023-05-10 10:01:29', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (532, 23, 'lqs', '2023-05-10 10:01:29', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (533, 23, 'lqs', '2023-05-10 10:02:24', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (534, 23, 'lqs', '2023-05-10 10:02:26', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (535, 23, 'lqs', '2023-05-10 10:02:26', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (536, 23, 'lqs', '2023-05-10 10:02:32', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (537, 23, 'lqs', '2023-05-10 10:02:32', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (538, 23, 'lqs', '2023-05-10 10:03:45', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (539, 23, 'lqs', '2023-05-10 10:03:47', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (540, 23, 'lqs', '2023-05-10 10:03:51', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (541, 23, 'lqs', '2023-05-10 10:03:54', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (542, 23, 'lqs', '2023-05-10 10:03:58', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (543, 23, 'lqs', '2023-05-10 10:04:14', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (544, 23, 'lqs', '2023-05-10 10:04:21', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (545, 23, 'lqs', '2023-05-10 10:04:23', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (546, 23, 'lqs', '2023-05-10 10:04:46', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (547, 23, 'lqs', '2023-05-10 10:08:55', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (548, 23, 'lqs', '2023-05-10 10:16:53', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (549, 23, 'lqs', '2023-05-10 10:17:04', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (550, 23, 'lqs', '2023-05-10 10:17:12', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (551, 23, 'lqs', '2023-05-10 10:19:30', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (552, 23, 'lqs', '2023-05-10 10:19:37', '系统字典服务', '修改字典');
INSERT INTO `sys_log` VALUES (553, 23, 'lqs', '2023-05-10 10:19:37', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (554, 23, 'lqs', '2023-05-10 10:19:43', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (555, 23, 'lqs', '2023-05-10 10:19:45', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (556, 23, 'lqs', '2023-05-10 10:19:54', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (557, 23, 'lqs', '2023-05-10 10:21:42', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (558, 23, 'lqs', '2023-05-10 10:22:43', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (559, 23, 'lqs', '2023-05-10 10:22:47', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (560, 23, 'lqs', '2023-05-10 10:22:47', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (561, 23, 'lqs', '2023-05-10 10:22:51', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (562, 23, 'lqs', '2023-05-10 10:22:54', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (563, 23, 'lqs', '2023-05-10 10:22:56', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (564, 23, 'lqs', '2023-05-10 10:22:56', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (565, 23, 'lqs', '2023-05-10 10:23:00', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (566, 23, 'lqs', '2023-05-10 10:23:03', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (567, 23, 'lqs', '2023-05-10 10:23:03', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (568, 23, 'lqs', '2023-05-10 10:23:07', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (569, 23, 'lqs', '2023-05-10 10:23:09', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (570, 23, 'lqs', '2023-05-10 10:23:09', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (571, 23, 'lqs', '2023-05-10 10:23:14', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (572, 23, 'lqs', '2023-05-10 10:23:30', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (573, 23, 'lqs', '2023-05-10 10:23:30', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (574, 23, 'lqs', '2023-05-10 10:23:40', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (575, 23, 'lqs', '2023-05-10 10:23:43', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (576, 23, 'lqs', '2023-05-10 10:23:43', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (577, 23, 'lqs', '2023-05-10 10:23:52', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (578, 23, 'lqs', '2023-05-10 10:23:54', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (579, 23, 'lqs', '2023-05-10 10:23:54', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (580, 23, 'lqs', '2023-05-10 10:24:37', '系统字典服务', '修改字典');
INSERT INTO `sys_log` VALUES (581, 23, 'lqs', '2023-05-10 10:24:37', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (582, 23, 'lqs', '2023-05-10 10:24:40', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (583, 23, 'lqs', '2023-05-10 10:24:43', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (584, 23, 'lqs', '2023-05-10 10:24:43', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (585, 23, 'lqs', '2023-05-10 10:24:45', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (586, 23, 'lqs', '2023-05-10 10:25:24', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (587, 23, 'lqs', '2023-05-10 10:25:30', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (588, 23, 'lqs', '2023-05-10 10:25:30', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (589, 23, 'lqs', '2023-05-10 10:25:35', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (590, 23, 'lqs', '2023-05-10 10:25:37', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (591, 23, 'lqs', '2023-05-10 10:25:38', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (592, 23, 'lqs', '2023-05-10 10:25:38', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (593, 23, 'lqs', '2023-05-10 10:25:41', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (594, 23, 'lqs', '2023-05-10 10:25:42', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (595, 23, 'lqs', '2023-05-10 10:25:42', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (596, 23, 'lqs', '2023-05-10 10:25:45', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (597, 23, 'lqs', '2023-05-10 10:26:08', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (598, 23, 'lqs', '2023-05-10 10:26:08', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (599, 23, 'lqs', '2023-05-10 10:26:10', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (600, 23, 'lqs', '2023-05-10 10:26:13', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (601, 23, 'lqs', '2023-05-10 10:26:16', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (602, 23, 'lqs', '2023-05-10 10:27:23', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (603, 23, 'lqs', '2023-05-10 10:27:25', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (604, 23, 'lqs', '2023-05-10 10:27:30', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (605, 23, 'lqs', '2023-05-10 10:27:32', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (606, 23, 'lqs', '2023-05-10 10:27:52', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (607, 23, 'lqs', '2023-05-10 10:27:53', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (608, 23, 'lqs', '2023-05-10 10:27:56', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (609, 23, 'lqs', '2023-05-10 10:29:09', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (610, 23, 'lqs', '2023-05-10 10:29:12', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (611, 23, 'lqs', '2023-05-10 10:29:34', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (612, 23, 'lqs', '2023-05-10 10:29:35', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (613, 23, 'lqs', '2023-05-10 10:29:39', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (614, 23, 'lqs', '2023-05-10 10:30:45', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (615, 23, 'lqs', '2023-05-10 10:30:48', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (616, 23, 'lqs', '2023-05-10 10:30:51', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (617, 23, 'lqs', '2023-05-10 10:30:51', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (618, 23, 'lqs', '2023-05-10 10:32:21', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (619, 23, 'lqs', '2023-05-10 10:32:23', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (620, 23, 'lqs', '2023-05-10 10:32:25', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (621, 23, 'lqs', '2023-05-10 10:32:29', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (622, 23, 'lqs', '2023-05-10 10:32:32', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (623, 23, 'lqs', '2023-05-10 10:32:32', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (624, 23, 'lqs', '2023-05-10 10:32:47', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (625, 23, 'lqs', '2023-05-10 10:32:50', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (626, 23, 'lqs', '2023-05-10 10:33:00', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (627, 23, 'lqs', '2023-05-10 10:33:02', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (628, 23, 'lqs', '2023-05-10 10:33:12', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (629, 23, 'lqs', '2023-05-10 10:33:14', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (630, 23, 'lqs', '2023-05-10 10:33:16', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (631, 23, 'lqs', '2023-05-10 10:33:19', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (632, 23, 'lqs', '2023-05-10 10:33:27', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (633, 23, 'lqs', '2023-05-10 10:33:37', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (634, 23, 'lqs', '2023-05-10 10:36:23', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (635, 23, 'lqs', '2023-05-10 10:36:23', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (636, 23, 'lqs', '2023-05-10 10:36:27', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (637, 23, 'lqs', '2023-05-10 10:36:28', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (638, 23, 'lqs', '2023-05-10 10:36:31', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (639, 23, 'lqs', '2023-05-10 10:36:37', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (640, 23, 'lqs', '2023-05-10 10:36:37', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (641, 23, 'lqs', '2023-05-10 10:36:38', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (642, 23, 'lqs', '2023-05-10 10:36:38', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (643, 23, 'lqs', '2023-05-10 10:36:39', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (644, 23, 'lqs', '2023-05-10 10:36:39', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (645, 23, 'lqs', '2023-05-10 10:36:40', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (646, 23, 'lqs', '2023-05-10 10:36:40', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (647, 23, 'lqs', '2023-05-10 10:36:45', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (648, 23, 'lqs', '2023-05-10 10:36:48', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (649, 23, 'lqs', '2023-05-10 10:36:50', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (650, 23, 'lqs', '2023-05-10 10:36:55', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (651, 23, 'lqs', '2023-05-10 10:36:57', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (652, 23, 'lqs', '2023-05-10 10:36:57', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (653, 23, 'lqs', '2023-05-10 10:37:00', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (654, 23, 'lqs', '2023-05-10 10:37:02', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (655, 23, 'lqs', '2023-05-10 10:37:07', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (656, 23, 'lqs', '2023-05-10 10:37:09', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (657, 23, 'lqs', '2023-05-10 10:37:12', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (658, 23, 'lqs', '2023-05-10 10:38:07', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (659, 23, 'lqs', '2023-05-10 10:38:09', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (660, 23, 'lqs', '2023-05-10 10:38:11', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (661, 23, 'lqs', '2023-05-10 10:38:13', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (662, 23, 'lqs', '2023-05-10 10:38:15', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (663, 23, 'lqs', '2023-05-10 10:38:20', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (664, 23, 'lqs', '2023-05-10 10:38:23', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (665, 23, 'lqs', '2023-05-10 10:38:28', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (666, 23, 'lqs', '2023-05-10 10:38:31', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (667, 23, 'lqs', '2023-05-10 10:38:36', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (668, 23, 'lqs', '2023-05-10 10:38:45', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (669, 23, 'lqs', '2023-05-10 10:38:48', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (670, 23, 'lqs', '2023-05-10 10:39:25', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (671, 23, 'lqs', '2023-05-10 10:39:27', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (672, 23, 'lqs', '2023-05-10 10:39:30', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (673, 23, 'lqs', '2023-05-10 10:39:39', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (674, 23, 'lqs', '2023-05-10 10:40:37', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (675, 23, 'lqs', '2023-05-10 10:40:43', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (676, 23, 'lqs', '2023-05-10 10:40:46', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (677, 23, 'lqs', '2023-05-10 10:40:49', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (678, 23, 'lqs', '2023-05-10 10:41:05', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (679, 23, 'lqs', '2023-05-10 10:41:08', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (680, 23, 'lqs', '2023-05-10 10:41:14', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (681, 23, 'lqs', '2023-05-10 10:41:19', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (682, 23, 'lqs', '2023-05-10 10:41:21', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (683, 23, 'lqs', '2023-05-10 10:41:24', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (684, 23, 'lqs', '2023-05-10 10:41:29', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (685, 23, 'lqs', '2023-05-10 10:41:32', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (686, 23, 'lqs', '2023-05-10 10:41:42', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (687, 23, 'lqs', '2023-05-10 10:41:43', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (688, 23, 'lqs', '2023-05-10 10:41:44', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (689, 23, 'lqs', '2023-05-10 10:41:48', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (690, 23, 'lqs', '2023-05-10 10:41:51', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (691, 23, 'lqs', '2023-05-10 10:42:20', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (692, 23, 'lqs', '2023-05-10 10:42:45', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (693, 23, 'lqs', '2023-05-10 10:42:54', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (694, 23, 'lqs', '2023-05-10 10:42:56', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (695, 23, 'lqs', '2023-05-10 10:43:09', '系统字典服务', '修改字典');
INSERT INTO `sys_log` VALUES (696, 23, 'lqs', '2023-05-10 10:43:09', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (697, 23, 'lqs', '2023-05-10 10:43:20', '系统字典服务', '修改字典');
INSERT INTO `sys_log` VALUES (698, 23, 'lqs', '2023-05-10 10:43:20', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (699, 23, 'lqs', '2023-05-10 10:43:31', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (700, 23, 'lqs', '2023-05-10 10:43:37', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (701, 23, 'lqs', '2023-05-10 10:43:38', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (702, 23, 'lqs', '2023-05-10 10:44:08', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (703, 23, 'lqs', '2023-05-10 10:44:08', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (704, 23, 'lqs', '2023-05-10 10:44:13', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (705, 23, 'lqs', '2023-05-10 10:44:17', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (706, 23, 'lqs', '2023-05-10 10:44:24', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (707, 23, 'lqs', '2023-05-10 10:44:26', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (708, 23, 'lqs', '2023-05-10 10:44:28', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (709, 23, 'lqs', '2023-05-10 10:44:33', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (710, 23, 'lqs', '2023-05-10 10:44:59', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (711, 23, 'lqs', '2023-05-10 10:45:05', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (712, 23, 'lqs', '2023-05-10 10:45:14', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (713, 23, 'lqs', '2023-05-10 10:45:17', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (714, 23, 'lqs', '2023-05-10 10:45:20', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (715, 23, 'lqs', '2023-05-10 10:45:22', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (716, 23, 'lqs', '2023-05-10 10:45:22', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (717, 23, 'lqs', '2023-05-10 10:45:24', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (718, 23, 'lqs', '2023-05-10 10:45:24', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (719, 23, 'lqs', '2023-05-10 10:45:35', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (720, 23, 'lqs', '2023-05-10 10:46:19', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (721, 23, 'lqs', '2023-05-10 10:46:27', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (722, 23, 'lqs', '2023-05-10 10:46:29', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (723, 23, 'lqs', '2023-05-10 10:46:37', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (724, 23, 'lqs', '2023-05-10 10:46:41', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (725, 23, 'lqs', '2023-05-10 10:46:50', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (726, 23, 'lqs', '2023-05-10 10:46:50', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (727, 23, 'lqs', '2023-05-10 10:46:52', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (728, 23, 'lqs', '2023-05-10 10:46:52', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (729, 23, 'lqs', '2023-05-10 10:46:52', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (730, 23, 'lqs', '2023-05-10 10:46:52', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (731, 23, 'lqs', '2023-05-10 10:46:52', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (732, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (733, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (734, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (735, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (736, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (737, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (738, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (739, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (740, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (741, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (742, 23, 'lqs', '2023-05-10 10:46:53', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (743, 23, 'lqs', '2023-05-10 10:46:54', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (744, 23, 'lqs', '2023-05-10 10:46:54', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (745, 23, 'lqs', '2023-05-10 10:46:54', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (746, 23, 'lqs', '2023-05-10 10:46:54', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (747, 23, 'lqs', '2023-05-10 10:46:54', '系统字典服务', '删除字典');
INSERT INTO `sys_log` VALUES (748, 23, 'lqs', '2023-05-10 10:46:54', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (749, 23, 'lqs', '2023-05-10 21:07:21', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (750, 23, 'lqs', '2023-05-10 21:07:25', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (751, 23, 'lqs', '2023-05-10 21:07:56', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (752, 23, 'lqs', '2023-05-10 21:08:20', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (753, 23, 'lqs', '2023-05-10 21:08:35', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (754, 23, 'lqs', '2023-05-10 21:09:33', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (755, 23, 'lqs', '2023-05-10 21:09:44', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (756, 23, 'lqs', '2023-05-10 21:10:13', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (757, 23, 'lqs', '2023-05-10 21:10:47', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (758, 23, 'lqs', '2023-05-10 21:11:06', '菜单服务', '修改菜单');
INSERT INTO `sys_log` VALUES (759, 23, 'lqs', '2023-05-10 21:11:06', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (760, 23, 'lqs', '2023-05-10 21:11:12', '菜单服务', '修改菜单');
INSERT INTO `sys_log` VALUES (761, 23, 'lqs', '2023-05-10 21:11:12', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (762, 23, 'lqs', '2023-05-10 21:11:14', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (763, 23, 'lqs', '2023-05-10 21:11:14', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (764, 23, 'lqs', '2023-05-10 21:11:17', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (765, 23, 'lqs', '2023-05-10 21:11:17', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (766, 23, 'lqs', '2023-05-10 21:11:19', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (767, 23, 'lqs', '2023-05-10 21:11:22', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (768, 23, 'lqs', '2023-05-10 21:11:26', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (769, 23, 'lqs', '2023-05-10 21:11:39', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (770, 23, 'lqs', '2023-05-10 21:11:39', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (771, 23, 'lqs', '2023-05-10 21:11:43', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (772, 23, 'lqs', '2023-05-10 21:11:49', '菜单服务', '修改菜单');
INSERT INTO `sys_log` VALUES (773, 23, 'lqs', '2023-05-10 21:11:49', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (774, 23, 'lqs', '2023-05-10 21:11:55', '菜单服务', '修改菜单');
INSERT INTO `sys_log` VALUES (775, 23, 'lqs', '2023-05-10 21:11:55', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (776, 23, 'lqs', '2023-05-10 21:11:57', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (777, 23, 'lqs', '2023-05-10 21:12:08', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (778, 23, 'lqs', '2023-05-10 21:12:08', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (779, 23, 'lqs', '2023-05-10 21:12:12', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (780, 23, 'lqs', '2023-05-10 21:12:15', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (781, 23, 'lqs', '2023-05-10 21:12:24', '菜单服务', '修改菜单');
INSERT INTO `sys_log` VALUES (782, 23, 'lqs', '2023-05-10 21:12:24', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (783, 23, 'lqs', '2023-05-10 21:12:37', '菜单服务', '修改菜单');
INSERT INTO `sys_log` VALUES (784, 23, 'lqs', '2023-05-10 21:12:37', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (785, 23, 'lqs', '2023-05-10 21:12:45', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (786, 23, 'lqs', '2023-05-10 21:12:47', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (787, 23, 'lqs', '2023-05-10 21:12:47', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (788, 23, 'lqs', '2023-05-10 21:12:52', '菜单服务', '修改菜单');
INSERT INTO `sys_log` VALUES (789, 23, 'lqs', '2023-05-10 21:12:52', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (790, 23, 'lqs', '2023-05-10 21:12:56', '菜单服务', '修改菜单');
INSERT INTO `sys_log` VALUES (791, 23, 'lqs', '2023-05-10 21:12:56', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (792, 23, 'lqs', '2023-05-10 21:12:58', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (793, 23, 'lqs', '2023-05-10 21:13:00', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (794, 23, 'lqs', '2023-05-10 21:13:03', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (795, 23, 'lqs', '2023-05-10 21:13:04', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (796, 23, 'lqs', '2023-05-10 21:13:04', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (797, 23, 'lqs', '2023-05-10 21:13:07', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (798, 23, 'lqs', '2023-05-10 21:13:11', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (799, 23, 'lqs', '2023-05-10 21:13:14', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (800, 23, 'lqs', '2023-05-10 21:13:16', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (801, 23, 'lqs', '2023-05-10 21:13:16', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (802, 23, 'lqs', '2023-05-10 21:13:19', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (803, 23, 'lqs', '2023-05-10 21:13:22', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (804, 23, 'lqs', '2023-05-10 21:13:22', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (805, 23, 'lqs', '2023-05-10 21:13:42', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (806, 23, 'lqs', '2023-05-10 21:13:47', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (807, 23, 'lqs', '2023-05-10 21:13:50', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (808, 23, 'lqs', '2023-05-10 21:14:13', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (809, 23, 'lqs', '2023-05-10 21:14:20', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (810, 23, 'lqs', '2023-05-10 21:14:20', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (811, 23, 'lqs', '2023-05-10 21:14:22', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (812, 23, 'lqs', '2023-05-10 21:14:23', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (813, 23, 'lqs', '2023-05-10 21:14:23', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (814, 23, 'lqs', '2023-05-10 21:14:35', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (815, 23, 'lqs', '2023-05-10 21:14:37', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (816, 23, 'lqs', '2023-05-10 21:14:41', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (817, 23, 'lqs', '2023-05-10 21:14:57', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (818, 23, 'lqs', '2023-05-10 21:14:57', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (819, 23, 'lqs', '2023-05-10 21:14:58', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (820, 23, 'lqs', '2023-05-10 21:15:00', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (821, 23, 'lqs', '2023-05-10 21:15:00', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (822, 23, 'lqs', '2023-05-10 21:15:09', '菜单服务', '给用户授权菜单');
INSERT INTO `sys_log` VALUES (823, 23, 'lqs', '2023-05-10 21:15:09', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (824, 23, 'lqs', '2023-05-10 21:15:11', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (825, 23, 'lqs', '2023-05-10 21:15:11', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (826, 23, 'lqs', '2023-05-10 21:15:18', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (827, 23, 'lqs', '2023-05-10 21:15:20', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (828, 23, 'lqs', '2023-05-10 21:15:27', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (829, 23, 'lqs', '2023-05-10 21:15:27', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (830, 23, 'lqs', '2023-05-10 21:15:29', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (831, 23, 'lqs', '2023-05-10 21:15:32', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (832, 23, 'lqs', '2023-05-10 21:15:34', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (833, 23, 'lqs', '2023-05-10 21:15:34', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (834, 23, 'lqs', '2023-05-10 21:15:36', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (835, 23, 'lqs', '2023-05-10 21:15:38', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (836, 23, 'lqs', '2023-05-10 21:15:38', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (837, 23, 'lqs', '2023-05-10 21:15:46', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (838, 23, 'lqs', '2023-05-10 21:15:47', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (839, 23, 'lqs', '2023-05-10 21:15:51', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (840, 23, 'lqs', '2023-05-10 21:15:51', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (841, 23, 'lqs', '2023-05-10 21:15:53', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (842, 23, 'lqs', '2023-05-10 21:15:57', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (843, 23, 'lqs', '2023-05-10 21:15:59', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (844, 23, 'lqs', '2023-05-10 21:16:03', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (845, 23, 'lqs', '2023-05-10 21:16:09', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (846, 23, 'lqs', '2023-05-10 21:16:12', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (847, 23, 'lqs', '2023-05-10 21:16:41', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (848, 23, 'lqs', '2023-05-10 21:16:55', '菜单服务', '添加菜单');
INSERT INTO `sys_log` VALUES (849, 23, 'lqs', '2023-05-10 21:16:56', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (850, 23, 'lqs', '2023-05-10 21:18:42', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (851, 23, 'lqs', '2023-05-10 21:18:44', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (852, 23, 'lqs', '2023-05-10 21:18:46', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (853, 23, 'lqs', '2023-05-10 21:18:49', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (854, 23, 'lqs', '2023-05-10 21:18:51', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (855, 23, 'lqs', '2023-05-10 21:18:53', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (856, 23, 'lqs', '2023-05-10 21:18:55', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (857, 23, 'lqs', '2023-05-10 21:18:55', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (858, 23, 'lqs', '2023-05-10 21:18:57', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (859, 23, 'lqs', '2023-05-10 21:18:58', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (860, 23, 'lqs', '2023-05-10 21:18:58', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (861, 23, 'lqs', '2023-05-10 21:19:00', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (862, 23, 'lqs', '2023-05-10 21:19:02', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (863, 23, 'lqs', '2023-05-10 21:19:02', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (864, 23, 'lqs', '2023-05-10 21:19:03', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (865, 23, 'lqs', '2023-05-10 21:19:05', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (866, 23, 'lqs', '2023-05-10 21:19:05', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (867, 23, 'lqs', '2023-05-10 21:19:06', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (868, 23, 'lqs', '2023-05-10 21:19:06', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (869, 23, 'lqs', '2023-05-10 21:19:06', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (870, 23, 'lqs', '2023-05-10 21:19:06', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (871, 23, 'lqs', '2023-05-10 21:19:06', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (872, 23, 'lqs', '2023-05-10 21:19:06', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (873, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (874, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (875, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (876, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (877, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (878, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (879, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (880, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (881, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (882, 23, 'lqs', '2023-05-10 21:19:07', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (883, 23, 'lqs', '2023-05-10 21:19:11', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (884, 23, 'lqs', '2023-05-10 21:19:11', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (885, 23, 'lqs', '2023-05-10 21:19:11', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (886, 23, 'lqs', '2023-05-10 21:19:11', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (887, 23, 'lqs', '2023-05-10 21:19:11', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (888, 23, 'lqs', '2023-05-10 21:19:11', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (889, 23, 'lqs', '2023-05-10 21:19:11', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (890, 23, 'lqs', '2023-05-10 21:19:11', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (891, 23, 'lqs', '2023-05-10 21:19:12', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (892, 23, 'lqs', '2023-05-10 21:19:12', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (893, 23, 'lqs', '2023-05-10 21:19:13', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (894, 23, 'lqs', '2023-05-10 21:19:13', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (895, 23, 'lqs', '2023-05-10 21:19:13', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (896, 23, 'lqs', '2023-05-10 21:19:13', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (897, 23, 'lqs', '2023-05-10 21:19:13', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (898, 23, 'lqs', '2023-05-10 21:19:13', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (899, 23, 'lqs', '2023-05-10 21:19:18', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (900, 23, 'lqs', '2023-05-10 21:19:20', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (901, 23, 'lqs', '2023-05-10 21:19:20', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (902, 23, 'lqs', '2023-05-10 21:19:23', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (903, 23, 'lqs', '2023-05-10 21:19:25', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (904, 23, 'lqs', '2023-05-10 21:19:27', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (905, 23, 'lqs', '2023-05-10 21:19:27', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (906, 23, 'lqs', '2023-05-10 21:19:27', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (907, 23, 'lqs', '2023-05-10 21:19:27', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (908, 23, 'lqs', '2023-05-10 21:19:27', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (909, 23, 'lqs', '2023-05-10 21:19:27', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (910, 23, 'lqs', '2023-05-10 21:19:27', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (911, 23, 'lqs', '2023-05-10 21:19:27', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (912, 23, 'lqs', '2023-05-10 21:19:30', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (913, 23, 'lqs', '2023-05-10 21:19:31', '菜单服务', '删除菜单');
INSERT INTO `sys_log` VALUES (914, 23, 'lqs', '2023-05-10 21:19:31', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (915, 23, 'lqs', '2023-05-10 21:19:38', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (916, 23, 'lqs', '2023-05-10 21:19:40', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (917, 23, 'lqs', '2023-05-10 21:19:43', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (918, 23, 'lqs', '2023-05-10 21:20:07', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (919, 23, 'lqs', '2023-05-10 21:20:16', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (920, 23, 'lqs', '2023-05-10 21:20:27', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (921, 23, 'lqs', '2023-05-10 21:20:32', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (922, 23, 'lqs', '2023-05-10 21:20:34', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (923, 23, 'lqs', '2023-05-10 21:20:37', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (924, 23, 'lqs', '2023-05-10 21:20:49', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (925, 23, 'lqs', '2023-05-10 22:18:41', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (926, 23, 'lqs', '2023-05-10 22:18:45', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (927, 23, 'lqs', '2023-05-10 22:18:45', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (928, 23, 'lqs', '2023-05-10 22:18:50', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (929, 23, 'lqs', '2023-05-10 22:18:50', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (930, 23, 'lqs', '2023-05-10 22:20:27', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (931, 23, 'lqs', '2023-05-10 22:20:27', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (932, 23, 'lqs', '2023-05-10 22:21:44', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (933, 23, 'lqs', '2023-05-10 22:21:44', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (934, 23, 'lqs', '2023-05-10 22:21:44', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (935, 23, 'lqs', '2023-05-10 22:21:44', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (936, 23, 'lqs', '2023-05-10 22:21:44', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (937, 23, 'lqs', '2023-05-10 22:21:44', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (938, 23, 'lqs', '2023-05-10 22:21:44', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (939, 23, 'lqs', '2023-05-10 22:21:46', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (940, 23, 'lqs', '2023-05-10 22:22:04', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (941, 23, 'lqs', '2023-05-10 22:22:04', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (942, 23, 'lqs', '2023-05-10 22:22:06', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (943, 23, 'lqs', '2023-05-10 22:22:33', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (944, 23, 'lqs', '2023-05-10 22:22:33', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (945, 23, 'lqs', '2023-05-10 22:22:35', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (946, 23, 'lqs', '2023-05-10 22:22:37', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (947, 23, 'lqs', '2023-05-10 22:23:05', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (948, 23, 'lqs', '2023-05-10 22:23:05', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (949, 23, 'lqs', '2023-05-10 22:24:37', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (950, 23, 'lqs', '2023-05-10 22:24:37', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (951, 23, 'lqs', '2023-05-10 22:28:23', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (952, 23, 'lqs', '2023-05-10 22:28:23', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (953, 23, 'lqs', '2023-05-10 22:29:07', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (954, 23, 'lqs', '2023-05-10 22:29:07', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (955, 23, 'lqs', '2023-05-10 22:29:41', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (956, 23, 'lqs', '2023-05-10 22:29:43', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (957, 23, 'lqs', '2023-05-10 22:30:00', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (958, 23, 'lqs', '2023-05-10 22:30:19', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (959, 23, 'lqs', '2023-05-10 22:30:19', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (960, 23, 'lqs', '2023-05-10 22:30:22', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (961, 23, 'lqs', '2023-05-10 22:30:22', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (962, 23, 'lqs', '2023-05-10 22:30:24', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (963, 23, 'lqs', '2023-05-10 22:30:24', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (964, 23, 'lqs', '2023-05-10 22:30:25', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (965, 23, 'lqs', '2023-05-10 22:30:25', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (966, 23, 'lqs', '2023-05-10 22:30:29', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (967, 23, 'lqs', '2023-05-10 22:30:29', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (968, 23, 'lqs', '2023-05-10 22:30:41', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (969, 23, 'lqs', '2023-05-10 22:30:57', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (970, 23, 'lqs', '2023-05-10 22:30:57', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (971, 23, 'lqs', '2023-05-10 22:30:58', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (972, 23, 'lqs', '2023-05-10 22:30:58', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (973, 23, 'lqs', '2023-05-10 22:31:22', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (974, 23, 'lqs', '2023-05-10 22:31:36', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (975, 23, 'lqs', '2023-05-10 22:31:42', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (976, 23, 'lqs', '2023-05-10 22:31:49', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (977, 23, 'lqs', '2023-05-10 22:31:53', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (978, 23, 'lqs', '2023-05-10 22:31:58', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (979, 23, 'lqs', '2023-05-10 22:31:58', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (980, 23, 'lqs', '2023-05-10 22:32:29', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (981, 23, 'lqs', '2023-05-10 22:32:34', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (982, 23, 'lqs', '2023-05-10 22:32:35', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (983, 23, 'lqs', '2023-05-10 22:32:36', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (984, 23, 'lqs', '2023-05-10 22:32:36', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (985, 23, 'lqs', '2023-05-10 22:32:38', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (986, 23, 'lqs', '2023-05-10 22:32:38', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (987, 23, 'lqs', '2023-05-10 22:32:39', '用户服务', '重置密码');
INSERT INTO `sys_log` VALUES (988, 23, 'lqs', '2023-05-10 22:32:39', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (989, 23, 'lqs', '2023-05-10 22:32:53', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (990, 23, 'lqs', '2023-05-10 22:33:05', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (991, 23, 'lqs', '2023-05-10 22:33:06', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (992, 23, 'lqs', '2023-05-10 22:33:07', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (993, 23, 'lqs', '2023-05-10 22:33:10', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (994, 23, 'lqs', '2023-05-10 22:33:13', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (995, 23, 'lqs', '2023-05-10 22:33:16', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (996, 23, 'lqs', '2023-05-11 08:11:58', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (997, 23, 'lqs', '2023-05-11 08:12:00', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (998, 23, 'lqs', '2023-05-11 08:12:02', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (999, 23, 'lqs', '2023-05-11 08:12:04', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1000, 23, 'lqs', '2023-05-11 08:12:04', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1001, 23, 'lqs', '2023-05-11 08:12:04', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1002, 23, 'lqs', '2023-05-11 08:12:04', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1003, 23, 'lqs', '2023-05-11 08:13:30', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1004, 23, 'lqs', '2023-05-11 08:13:33', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1005, 23, 'lqs', '2023-05-11 08:13:33', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1006, 23, 'lqs', '2023-05-11 08:13:33', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1007, 23, 'lqs', '2023-05-11 08:13:33', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1008, 23, 'lqs', '2023-05-11 08:13:43', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (1009, 23, 'lqs', '2023-05-11 08:13:43', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (1010, 23, 'lqs', '2023-05-11 08:13:47', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1011, 23, 'lqs', '2023-05-11 08:13:47', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1012, 23, 'lqs', '2023-05-11 08:13:47', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1013, 23, 'lqs', '2023-05-11 08:13:47', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1014, 23, 'lqs', '2023-05-11 08:17:00', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1015, 23, 'lqs', '2023-05-11 08:17:02', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1016, 23, 'lqs', '2023-05-11 08:17:02', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1017, 23, 'lqs', '2023-05-11 08:17:02', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1018, 23, 'lqs', '2023-05-11 08:17:02', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1019, 23, 'lqs', '2023-05-11 08:17:28', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1020, 23, 'lqs', '2023-05-11 08:17:29', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1021, 23, 'lqs', '2023-05-11 08:17:29', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1022, 23, 'lqs', '2023-05-11 08:17:29', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1023, 23, 'lqs', '2023-05-11 08:17:29', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1024, 23, 'lqs', '2023-05-11 08:17:55', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1025, 23, 'lqs', '2023-05-11 08:17:57', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1026, 23, 'lqs', '2023-05-11 08:17:57', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1027, 23, 'lqs', '2023-05-11 08:17:57', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1028, 23, 'lqs', '2023-05-11 08:17:57', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1029, 23, 'lqs', '2023-05-11 08:18:27', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1030, 23, 'lqs', '2023-05-11 08:18:29', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (1031, 23, 'lqs', '2023-05-11 08:18:29', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (1032, 23, 'lqs', '2023-05-11 08:18:33', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1033, 23, 'lqs', '2023-05-11 08:18:33', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1034, 23, 'lqs', '2023-05-11 08:18:33', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1035, 23, 'lqs', '2023-05-11 08:18:33', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1036, 23, 'lqs', '2023-05-11 08:19:58', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1037, 23, 'lqs', '2023-05-11 08:19:59', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1038, 23, 'lqs', '2023-05-11 08:19:59', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1039, 23, 'lqs', '2023-05-11 08:19:59', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1040, 23, 'lqs', '2023-05-11 08:19:59', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1041, 23, 'lqs', '2023-05-11 08:20:42', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1042, 23, 'lqs', '2023-05-11 08:20:43', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1043, 23, 'lqs', '2023-05-11 08:20:43', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1044, 23, 'lqs', '2023-05-11 08:20:43', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1045, 23, 'lqs', '2023-05-11 08:20:43', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1046, 23, 'lqs', '2023-05-11 08:24:44', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1047, 23, 'lqs', '2023-05-11 08:24:46', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1048, 23, 'lqs', '2023-05-11 08:24:46', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1049, 23, 'lqs', '2023-05-11 08:24:46', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1050, 23, 'lqs', '2023-05-11 08:24:46', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1051, 23, 'lqs', '2023-05-11 08:32:12', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1052, 23, 'lqs', '2023-05-11 08:32:14', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1053, 23, 'lqs', '2023-05-11 08:32:14', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1054, 23, 'lqs', '2023-05-11 08:33:30', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1055, 23, 'lqs', '2023-05-11 08:33:38', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1056, 23, 'lqs', '2023-05-11 08:33:41', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1057, 23, 'lqs', '2023-05-11 08:33:41', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1058, 23, 'lqs', '2023-05-11 08:33:41', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1059, 23, 'lqs', '2023-05-11 08:33:41', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1060, 23, 'lqs', '2023-05-11 08:33:52', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1061, 23, 'lqs', '2023-05-11 08:33:52', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1062, 23, 'lqs', '2023-05-11 08:33:52', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1063, 23, 'lqs', '2023-05-11 08:33:52', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1064, 23, 'lqs', '2023-05-11 08:38:49', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1065, 23, 'lqs', '2023-05-11 08:38:52', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1066, 23, 'lqs', '2023-05-11 08:38:52', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1067, 23, 'lqs', '2023-05-11 08:38:52', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1068, 23, 'lqs', '2023-05-11 08:38:52', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1069, 23, 'lqs', '2023-05-11 08:39:23', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1070, 23, 'lqs', '2023-05-11 08:39:26', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1071, 23, 'lqs', '2023-05-11 08:39:26', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1072, 23, 'lqs', '2023-05-11 08:39:26', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1073, 23, 'lqs', '2023-05-11 08:39:26', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1074, 23, 'lqs', '2023-05-11 08:41:26', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1075, 23, 'lqs', '2023-05-11 08:41:31', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1076, 23, 'lqs', '2023-05-11 08:41:31', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1077, 23, 'lqs', '2023-05-11 08:41:31', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1078, 23, 'lqs', '2023-05-11 08:41:31', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1079, 23, 'lqs', '2023-05-11 08:42:16', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1080, 23, 'lqs', '2023-05-11 08:42:17', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1081, 23, 'lqs', '2023-05-11 08:42:17', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1082, 23, 'lqs', '2023-05-11 08:42:17', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1083, 23, 'lqs', '2023-05-11 08:42:17', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1084, 23, 'lqs', '2023-05-11 08:42:51', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1085, 23, 'lqs', '2023-05-11 08:42:53', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1086, 23, 'lqs', '2023-05-11 08:42:53', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1087, 23, 'lqs', '2023-05-11 08:42:53', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1088, 23, 'lqs', '2023-05-11 08:42:53', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1089, 23, 'lqs', '2023-05-11 08:43:36', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1090, 23, 'lqs', '2023-05-11 08:43:37', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1091, 23, 'lqs', '2023-05-11 08:43:37', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1092, 23, 'lqs', '2023-05-11 08:43:37', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1093, 23, 'lqs', '2023-05-11 08:43:37', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1094, 23, 'lqs', '2023-05-11 08:44:05', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1095, 23, 'lqs', '2023-05-11 08:44:12', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1096, 23, 'lqs', '2023-05-11 08:44:12', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1097, 23, 'lqs', '2023-05-11 08:44:12', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1098, 23, 'lqs', '2023-05-11 08:44:12', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1099, 23, 'lqs', '2023-05-11 08:44:42', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1100, 23, 'lqs', '2023-05-11 08:44:42', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1101, 23, 'lqs', '2023-05-11 08:44:45', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1102, 23, 'lqs', '2023-05-11 08:44:45', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1103, 23, 'lqs', '2023-05-11 08:44:45', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1104, 23, 'lqs', '2023-05-11 08:44:45', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1105, 23, 'lqs', '2023-05-11 08:44:52', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1106, 23, 'lqs', '2023-05-11 08:44:52', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1107, 23, 'lqs', '2023-05-11 08:44:52', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1108, 23, 'lqs', '2023-05-11 08:44:52', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1109, 23, 'lqs', '2023-05-11 08:45:03', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1110, 23, 'lqs', '2023-05-11 08:45:03', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1111, 23, 'lqs', '2023-05-11 08:45:03', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1112, 23, 'lqs', '2023-05-11 08:45:03', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1113, 23, 'lqs', '2023-05-11 08:45:13', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1114, 23, 'lqs', '2023-05-11 08:45:14', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1115, 23, 'lqs', '2023-05-11 08:45:14', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1116, 23, 'lqs', '2023-05-11 08:45:14', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1117, 23, 'lqs', '2023-05-11 08:45:14', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1118, 23, 'lqs', '2023-05-11 08:46:31', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1119, 23, 'lqs', '2023-05-11 08:46:32', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1120, 23, 'lqs', '2023-05-11 08:46:32', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1121, 23, 'lqs', '2023-05-11 08:46:32', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1122, 23, 'lqs', '2023-05-11 08:46:32', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1123, 23, 'lqs', '2023-05-11 08:46:37', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1124, 23, 'lqs', '2023-05-11 08:46:37', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1125, 23, 'lqs', '2023-05-11 08:46:38', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1126, 23, 'lqs', '2023-05-11 08:46:38', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1127, 23, 'lqs', '2023-05-11 08:46:38', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1128, 23, 'lqs', '2023-05-11 08:46:38', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1129, 23, 'lqs', '2023-05-11 08:46:45', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1130, 23, 'lqs', '2023-05-11 08:46:45', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1131, 23, 'lqs', '2023-05-11 08:46:47', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1132, 23, 'lqs', '2023-05-11 08:46:47', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1133, 23, 'lqs', '2023-05-11 08:46:47', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1134, 23, 'lqs', '2023-05-11 08:46:47', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1135, 23, 'lqs', '2023-05-11 08:47:57', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1136, 23, 'lqs', '2023-05-11 08:47:59', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1137, 23, 'lqs', '2023-05-11 08:47:59', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1138, 23, 'lqs', '2023-05-11 08:47:59', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1139, 23, 'lqs', '2023-05-11 08:47:59', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1140, 23, 'lqs', '2023-05-11 08:48:10', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1141, 23, 'lqs', '2023-05-11 08:48:10', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1142, 23, 'lqs', '2023-05-11 08:49:46', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1143, 23, 'lqs', '2023-05-11 08:49:48', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1144, 23, 'lqs', '2023-05-11 08:49:48', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1145, 23, 'lqs', '2023-05-11 08:49:48', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1146, 23, 'lqs', '2023-05-11 08:49:48', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1147, 23, 'lqs', '2023-05-11 08:51:17', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1148, 23, 'lqs', '2023-05-11 08:55:10', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1149, 23, 'lqs', '2023-05-11 08:55:14', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1150, 23, 'lqs', '2023-05-11 08:55:14', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1151, 23, 'lqs', '2023-05-11 08:55:14', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1152, 23, 'lqs', '2023-05-11 08:55:14', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1153, 23, 'lqs', '2023-05-11 08:56:29', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1154, 23, 'lqs', '2023-05-11 08:56:31', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1155, 23, 'lqs', '2023-05-11 08:56:31', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1156, 23, 'lqs', '2023-05-11 08:56:31', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1157, 23, 'lqs', '2023-05-11 08:56:31', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1158, 23, 'lqs', '2023-05-11 08:57:34', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1159, 23, 'lqs', '2023-05-11 08:57:34', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1160, 23, 'lqs', '2023-05-11 08:57:34', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1161, 23, 'lqs', '2023-05-11 08:57:34', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1162, 23, 'lqs', '2023-05-11 08:58:02', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1163, 23, 'lqs', '2023-05-11 08:58:09', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1164, 23, 'lqs', '2023-05-11 08:58:12', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1165, 23, 'lqs', '2023-05-11 08:58:12', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1166, 23, 'lqs', '2023-05-11 08:58:12', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1167, 23, 'lqs', '2023-05-11 08:58:12', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1168, 23, 'lqs', '2023-05-11 08:58:53', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1169, 23, 'lqs', '2023-05-11 08:58:53', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1170, 23, 'lqs', '2023-05-11 08:58:54', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1171, 23, 'lqs', '2023-05-11 08:58:54', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1172, 23, 'lqs', '2023-05-11 08:58:54', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1173, 23, 'lqs', '2023-05-11 08:58:54', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1174, 23, 'lqs', '2023-05-11 08:59:05', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1175, 23, 'lqs', '2023-05-11 09:01:54', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1176, 23, 'lqs', '2023-05-11 09:01:54', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1177, 23, 'lqs', '2023-05-11 09:01:59', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1178, 23, 'lqs', '2023-05-11 09:01:59', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1179, 23, 'lqs', '2023-05-11 09:01:59', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1180, 23, 'lqs', '2023-05-11 09:01:59', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1181, 23, 'lqs', '2023-05-11 09:02:04', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1182, 23, 'lqs', '2023-05-11 09:02:04', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1183, 23, 'lqs', '2023-05-11 09:02:06', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1184, 23, 'lqs', '2023-05-11 09:02:06', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1185, 23, 'lqs', '2023-05-11 09:02:06', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1186, 23, 'lqs', '2023-05-11 09:02:06', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1187, 23, 'lqs', '2023-05-11 09:02:16', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1188, 23, 'lqs', '2023-05-11 09:02:16', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1189, 23, 'lqs', '2023-05-11 09:02:16', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1190, 23, 'lqs', '2023-05-11 09:02:16', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1191, 23, 'lqs', '2023-05-11 09:02:29', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (1192, 23, 'lqs', '2023-05-11 09:02:29', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (1193, 23, 'lqs', '2023-05-11 09:02:35', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1194, 23, 'lqs', '2023-05-11 09:02:35', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1195, 23, 'lqs', '2023-05-11 09:02:35', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1196, 23, 'lqs', '2023-05-11 09:02:35', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1197, 23, 'lqs', '2023-05-11 09:02:48', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1198, 23, 'lqs', '2023-05-11 09:02:48', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1199, 23, 'lqs', '2023-05-11 09:02:48', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1200, 23, 'lqs', '2023-05-11 09:02:48', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1201, 23, 'lqs', '2023-05-11 09:03:03', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1202, 23, 'lqs', '2023-05-11 09:03:03', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1203, 23, 'lqs', '2023-05-11 09:03:04', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1204, 23, 'lqs', '2023-05-11 09:03:04', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1205, 23, 'lqs', '2023-05-11 09:03:04', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1206, 23, 'lqs', '2023-05-11 09:03:04', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1207, 23, 'lqs', '2023-05-11 09:04:12', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1208, 23, 'lqs', '2023-05-11 09:04:12', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1209, 23, 'lqs', '2023-05-11 09:04:14', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1210, 23, 'lqs', '2023-05-11 09:04:14', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1211, 23, 'lqs', '2023-05-11 09:04:14', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1212, 23, 'lqs', '2023-05-11 09:04:14', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1213, 23, 'lqs', '2023-05-11 09:04:24', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1214, 23, 'lqs', '2023-05-11 09:04:24', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1215, 23, 'lqs', '2023-05-11 09:04:26', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1216, 23, 'lqs', '2023-05-11 09:04:26', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1217, 23, 'lqs', '2023-05-11 09:04:26', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1218, 23, 'lqs', '2023-05-11 09:04:26', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1219, 23, 'lqs', '2023-05-11 09:04:32', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1220, 23, 'lqs', '2023-05-11 09:04:32', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1221, 23, 'lqs', '2023-05-11 09:04:33', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1222, 23, 'lqs', '2023-05-11 09:04:33', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1223, 23, 'lqs', '2023-05-11 09:04:33', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1224, 23, 'lqs', '2023-05-11 09:04:33', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1225, 23, 'lqs', '2023-05-11 09:04:38', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (1226, 23, 'lqs', '2023-05-11 09:04:38', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (1227, 23, 'lqs', '2023-05-11 09:04:46', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1228, 23, 'lqs', '2023-05-11 09:04:46', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1229, 23, 'lqs', '2023-05-11 09:04:46', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1230, 23, 'lqs', '2023-05-11 09:04:46', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1231, 23, 'lqs', '2023-05-11 09:04:54', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1232, 23, 'lqs', '2023-05-11 09:04:54', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1233, 23, 'lqs', '2023-05-11 09:04:56', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1234, 23, 'lqs', '2023-05-11 09:04:56', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1235, 23, 'lqs', '2023-05-11 09:04:56', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1236, 23, 'lqs', '2023-05-11 09:04:56', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1237, 23, 'lqs', '2023-05-11 09:05:21', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1238, 23, 'lqs', '2023-05-11 09:05:21', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1239, 23, 'lqs', '2023-05-11 09:05:21', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1240, 23, 'lqs', '2023-05-11 09:05:21', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1241, 23, 'lqs', '2023-05-11 09:05:27', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1242, 23, 'lqs', '2023-05-11 09:05:27', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1243, 23, 'lqs', '2023-05-11 09:05:27', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1244, 23, 'lqs', '2023-05-11 09:05:27', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1245, 23, 'lqs', '2023-05-11 09:05:30', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1246, 23, 'lqs', '2023-05-11 09:05:30', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1247, 23, 'lqs', '2023-05-11 09:05:30', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1248, 23, 'lqs', '2023-05-11 09:05:30', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1249, 23, 'lqs', '2023-05-11 09:05:38', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1250, 23, 'lqs', '2023-05-11 09:05:38', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1251, 23, 'lqs', '2023-05-11 09:05:58', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1252, 23, 'lqs', '2023-05-11 09:05:59', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (1253, 23, 'lqs', '2023-05-11 09:06:01', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1254, 23, 'lqs', '2023-05-11 09:06:03', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1255, 23, 'lqs', '2023-05-11 09:06:03', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1256, 23, 'lqs', '2023-05-11 09:06:03', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1257, 23, 'lqs', '2023-05-11 09:06:03', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1258, 23, 'lqs', '2023-05-11 09:06:10', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1259, 23, 'lqs', '2023-05-11 09:06:10', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1260, 23, 'lqs', '2023-05-11 09:06:10', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1261, 23, 'lqs', '2023-05-11 09:06:10', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1262, 23, 'lqs', '2023-05-11 09:06:18', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1263, 23, 'lqs', '2023-05-11 09:06:18', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1264, 23, 'lqs', '2023-05-11 09:06:20', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1265, 23, 'lqs', '2023-05-11 09:06:20', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1266, 23, 'lqs', '2023-05-11 09:06:20', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1267, 23, 'lqs', '2023-05-11 09:06:20', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1268, 23, 'lqs', '2023-05-11 09:07:17', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1269, 23, 'lqs', '2023-05-11 09:07:17', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1270, 23, 'lqs', '2023-05-11 09:07:21', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1271, 23, 'lqs', '2023-05-11 09:07:21', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1272, 23, 'lqs', '2023-05-11 09:07:21', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1273, 23, 'lqs', '2023-05-11 09:07:21', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1274, 23, 'lqs', '2023-05-11 09:07:26', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1275, 23, 'lqs', '2023-05-11 09:07:26', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1276, 23, 'lqs', '2023-05-11 09:07:29', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1277, 23, 'lqs', '2023-05-11 09:07:29', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1278, 23, 'lqs', '2023-05-11 09:07:29', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1279, 23, 'lqs', '2023-05-11 09:07:29', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1280, 23, 'lqs', '2023-05-11 09:07:31', '用户服务', '编辑用户');
INSERT INTO `sys_log` VALUES (1281, 23, 'lqs', '2023-05-11 09:07:31', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1282, 23, 'lqs', '2023-05-11 09:07:49', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1283, 23, 'lqs', '2023-05-11 09:07:49', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1284, 23, 'lqs', '2023-05-11 09:07:49', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1285, 23, 'lqs', '2023-05-11 09:07:49', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1286, 23, 'lqs', '2023-05-11 09:07:54', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1287, 23, 'lqs', '2023-05-11 09:07:54', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1288, 23, 'lqs', '2023-05-11 09:07:54', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1289, 23, 'lqs', '2023-05-11 09:07:54', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1290, 23, 'lqs', '2023-05-11 09:07:58', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1291, 23, 'lqs', '2023-05-11 09:07:58', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1292, 23, 'lqs', '2023-05-11 09:07:58', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1293, 23, 'lqs', '2023-05-11 09:07:58', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1294, 23, 'lqs', '2023-05-11 09:09:06', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1295, 23, 'lqs', '2023-05-11 09:09:06', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1296, 23, 'lqs', '2023-05-11 09:09:07', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1297, 23, 'lqs', '2023-05-11 09:09:07', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1298, 23, 'lqs', '2023-05-11 09:09:07', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1299, 23, 'lqs', '2023-05-11 09:09:07', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1300, 23, 'lqs', '2023-05-11 09:10:33', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (1301, 23, 'lqs', '2023-05-11 09:10:33', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (1302, 23, 'lqs', '2023-05-11 09:10:39', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1303, 23, 'lqs', '2023-05-11 09:10:39', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1304, 23, 'lqs', '2023-05-11 09:10:39', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1305, 23, 'lqs', '2023-05-11 09:10:39', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1306, 23, 'lqs', '2023-05-11 09:12:39', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1307, 23, 'lqs', '2023-05-11 09:12:53', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1308, 23, 'lqs', '2023-05-11 09:12:56', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1309, 23, 'lqs', '2023-05-11 09:13:04', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1310, 23, 'lqs', '2023-05-11 09:13:13', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1311, 23, 'lqs', '2023-05-11 09:13:15', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1312, 23, 'lqs', '2023-05-11 09:13:56', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (1313, 23, 'lqs', '2023-05-11 09:13:56', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1314, 23, 'lqs', '2023-05-11 09:13:58', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1315, 23, 'lqs', '2023-05-11 09:14:07', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1316, 23, 'lqs', '2023-05-11 09:14:10', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1317, 23, 'lqs', '2023-05-11 09:14:40', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (1318, 23, 'lqs', '2023-05-11 09:14:40', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1319, 23, 'lqs', '2023-05-11 09:14:42', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1320, 23, 'lqs', '2023-05-11 09:16:11', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (1321, 23, 'lqs', '2023-05-11 09:16:11', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1322, 23, 'lqs', '2023-05-11 09:30:05', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1323, 23, 'lqs', '2023-05-11 09:33:03', '用户服务', '添加用户');
INSERT INTO `sys_log` VALUES (1324, 23, 'lqs', '2023-05-11 09:33:03', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1325, 23, 'lqs', '2023-05-11 09:33:07', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (1326, 23, 'lqs', '2023-05-11 09:33:07', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (1327, 23, 'lqs', '2023-05-11 09:33:47', '用户服务', '添加用户');
INSERT INTO `sys_log` VALUES (1328, 23, 'lqs', '2023-05-11 09:33:47', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1329, 23, 'lqs', '2023-05-11 09:33:51', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (1330, 23, 'lqs', '2023-05-11 09:33:52', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (1331, 23, 'lqs', '2023-05-11 09:34:06', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1332, 23, 'lqs', '2023-05-11 09:34:06', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1333, 23, 'lqs', '2023-05-11 09:34:06', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1334, 23, 'lqs', '2023-05-11 09:34:06', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1335, 23, 'lqs', '2023-05-18 09:49:30', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (1336, 23, 'lqs', '2023-05-18 09:49:32', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1337, 23, 'lqs', '2023-05-18 09:49:33', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (1338, 23, 'lqs', '2023-05-18 09:50:40', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (1339, 23, 'lqs', '2023-05-18 09:50:42', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1340, 23, 'lqs', '2023-05-18 09:50:44', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1341, 23, 'lqs', '2023-05-18 09:50:44', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1342, 23, 'lqs', '2023-05-18 09:50:44', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1343, 23, 'lqs', '2023-05-18 09:50:44', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1344, 23, 'lqs', '2023-05-18 09:50:48', '角色服务', '角色列表[授权]');
INSERT INTO `sys_log` VALUES (1345, 23, 'lqs', '2023-05-18 09:50:48', '权限服务', '权限列表[授权]');
INSERT INTO `sys_log` VALUES (1346, 23, 'lqs', '2023-05-18 09:50:48', '用户服务', '修改用户角色');
INSERT INTO `sys_log` VALUES (1347, 23, 'lqs', '2023-05-18 09:50:48', '用户服务', '修改用户权限');
INSERT INTO `sys_log` VALUES (1348, 23, 'lqs', '2023-05-18 09:50:52', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (1349, 23, 'lqs', '2023-05-18 09:50:52', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (1350, 23, 'lqs', '2023-05-18 09:50:56', '菜单服务', '菜单列表[授权]');
INSERT INTO `sys_log` VALUES (1351, 23, 'lqs', '2023-05-18 09:50:56', '菜单服务', '查询用户已有菜单权限');
INSERT INTO `sys_log` VALUES (1352, 23, 'lqs', '2023-05-18 09:50:59', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (1353, 23, 'lqs', '2023-05-18 09:51:00', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (1354, 23, 'lqs', '2023-05-18 09:51:01', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (1355, 23, 'lqs', '2023-05-18 09:51:01', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (1356, 23, 'lqs', '2023-05-18 09:51:03', '菜单服务', '获取根菜单');
INSERT INTO `sys_log` VALUES (1357, 23, 'lqs', '2023-05-18 09:51:04', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (1358, 23, 'lqs', '2023-05-18 09:51:06', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1359, 23, 'lqs', '2023-05-18 09:51:08', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1360, 23, 'lqs', '2023-05-18 09:51:09', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1361, 23, 'lqs', '2023-05-18 09:52:44', '文件服务', '所有文件列表[用户]');
INSERT INTO `sys_log` VALUES (1362, 23, 'lqs', '2023-05-18 09:52:45', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (1363, 23, 'lqs', '2023-05-18 10:58:09', '新闻服务', '查看');
INSERT INTO `sys_log` VALUES (1364, 23, 'lqs', '2023-05-18 10:58:46', '新闻服务', '查看');
INSERT INTO `sys_log` VALUES (1365, 23, 'lqs', '2023-05-18 11:01:46', '新闻服务', '查看');
INSERT INTO `sys_log` VALUES (1366, 23, 'lqs', '2023-05-18 11:03:05', '新闻服务', '查看');
INSERT INTO `sys_log` VALUES (1367, 23, 'lqs', '2023-05-18 11:03:06', '新闻服务', '查看');
INSERT INTO `sys_log` VALUES (1368, 23, 'lqs', '2023-05-18 11:03:12', '新闻服务', '查看');
INSERT INTO `sys_log` VALUES (1369, 23, 'lqs', '2023-05-18 11:24:33', '新闻服务', '查看中国经济网');
INSERT INTO `sys_log` VALUES (1370, 23, 'lqs', '2023-05-18 11:41:55', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1371, 23, 'lqs', '2023-05-18 11:41:58', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1372, 23, 'lqs', '2023-05-18 11:42:07', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1373, 23, 'lqs', '2023-05-18 11:42:10', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1374, 23, 'lqs', '2023-05-18 11:42:12', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1375, 23, 'lqs', '2023-05-18 11:42:16', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1376, 23, 'lqs', '2023-05-18 11:43:37', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (1377, 23, 'lqs', '2023-05-18 11:43:38', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1378, 23, 'lqs', '2023-05-18 11:43:59', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1379, 23, 'lqs', '2023-05-18 11:44:05', '系统字典服务', '添加字典');
INSERT INTO `sys_log` VALUES (1380, 23, 'lqs', '2023-05-18 11:44:05', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1381, 23, 'lqs', '2023-05-18 12:13:38', '新闻服务', '查看中国经济网IT要闻');
INSERT INTO `sys_log` VALUES (1382, 23, 'lqs', '2023-05-18 12:15:36', '新闻服务', '查看中国经济网IT要闻');
INSERT INTO `sys_log` VALUES (1383, 23, 'lqs', '2023-05-18 12:15:47', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (1384, 23, 'lqs', '2023-05-18 12:15:52', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1385, 23, 'lqs', '2023-05-18 12:19:29', '影视服务', '搜索影视:三体');
INSERT INTO `sys_log` VALUES (1386, 23, 'lqs', '2023-05-18 12:20:04', '影视服务', '搜索影视==安提');
INSERT INTO `sys_log` VALUES (1387, 23, 'lqs', '2023-05-18 12:22:19', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1388, 23, 'lqs', '2023-05-18 12:22:54', 'ChatGPT', '提问==hello');
INSERT INTO `sys_log` VALUES (1389, 23, 'lqs', '2023-05-18 12:23:40', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1390, 23, 'lqs', '2023-05-18 12:25:19', 'ChatGPT', '提问');
INSERT INTO `sys_log` VALUES (1391, 23, 'lqs', '2023-05-18 12:25:27', 'ChatGPT', '提问');
INSERT INTO `sys_log` VALUES (1392, 23, 'lqs', '2023-05-18 12:26:43', 'ChatGPT', '提问');
INSERT INTO `sys_log` VALUES (1393, 23, 'lqs', '2023-05-18 12:27:06', '新闻服务', '查看中国经济网IT要闻');
INSERT INTO `sys_log` VALUES (1394, 23, 'lqs', '2023-05-18 12:28:04', '新闻服务', '查看人民日报滚动要闻');
INSERT INTO `sys_log` VALUES (1395, 23, 'lqs', '2023-05-18 12:28:24', '新闻服务', '查看中国经济网IT要闻');
INSERT INTO `sys_log` VALUES (1396, 23, 'lqs', '2023-05-18 12:29:04', '新闻服务', '查看中国经济网IT要闻');
INSERT INTO `sys_log` VALUES (1397, 23, 'lqs', '2023-05-18 12:29:07', 'ChatGPT', '提问');
INSERT INTO `sys_log` VALUES (1398, 23, 'lqs', '2023-05-18 12:30:30', 'ChatGPT', '提问==你好你是我...');
INSERT INTO `sys_log` VALUES (1399, 23, 'lqs', '2023-05-18 12:30:55', 'ChatGPT', '提问==你好你是我的好朋友你...');
INSERT INTO `sys_log` VALUES (1400, 23, 'lqs', '2023-05-18 12:32:07', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (1401, 23, 'lqs', '2023-05-18 12:32:07', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (1402, 23, 'lqs', '2023-05-18 12:32:08', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (1403, 23, 'lqs', '2023-05-18 12:32:09', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (1404, 23, 'lqs', '2023-05-18 12:32:10', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1405, 23, 'lqs', '2023-05-18 12:32:11', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1406, 23, 'lqs', '2023-05-18 12:32:12', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (1407, 23, 'lqs', '2023-05-18 12:32:25', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1408, 23, 'lqs', '2023-05-18 12:32:29', '系统字典服务', '获取父级字典列表');
INSERT INTO `sys_log` VALUES (1409, 23, 'lqs', '2023-05-18 12:32:31', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1410, 23, 'lqs', '2023-05-18 12:35:28', '新闻服务', '查看中国经济网IT要闻');
INSERT INTO `sys_log` VALUES (1411, 23, 'lqs', '2023-05-18 12:35:32', '新闻服务', '查看人民日报滚动要闻');
INSERT INTO `sys_log` VALUES (1412, 23, 'lqs', '2023-05-18 12:35:35', '新闻服务', '查看今日头条热搜新闻');
INSERT INTO `sys_log` VALUES (1413, 23, 'lqs', '2023-05-18 12:35:36', '新闻服务', '查看微博热搜新闻');
INSERT INTO `sys_log` VALUES (1414, 23, 'lqs', '2023-05-18 12:35:44', '影视服务', '搜索影视==三体人');
INSERT INTO `sys_log` VALUES (1415, 23, 'lqs', '2023-05-18 12:36:05', 'ChatGPT', '提问==你是我的小苹果...');
INSERT INTO `sys_log` VALUES (1416, 23, 'lqs', '2023-05-18 12:36:39', '系统字典服务', '展示字典');
INSERT INTO `sys_log` VALUES (1417, 23, 'lqs', '2023-05-18 12:36:40', '文件服务', '所有文件列表[所有]');
INSERT INTO `sys_log` VALUES (1418, 23, 'lqs', '2023-05-18 12:36:41', '菜单服务', '菜单列表[展示]');
INSERT INTO `sys_log` VALUES (1419, 23, 'lqs', '2023-05-18 12:36:42', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (1420, 23, 'lqs', '2023-05-18 12:36:42', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (1421, 23, 'lqs', '2023-05-18 12:36:43', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1422, 23, 'lqs', '2023-05-18 12:37:26', '新闻服务', '查看中国经济网IT要闻');
INSERT INTO `sys_log` VALUES (1423, 23, 'lqs', '2023-05-18 12:37:26', '新闻服务', '查看人民日报滚动要闻');
INSERT INTO `sys_log` VALUES (1424, 23, 'lqs', '2023-05-18 12:37:27', '新闻服务', '查看今日头条热搜新闻');
INSERT INTO `sys_log` VALUES (1425, 23, 'lqs', '2023-05-18 12:37:28', '新闻服务', '查看微博热搜新闻');
INSERT INTO `sys_log` VALUES (1426, 23, 'lqs', '2023-05-18 12:37:50', '新闻服务', '查看今日头条热搜新闻');
INSERT INTO `sys_log` VALUES (1427, 23, 'lqs', '2023-05-18 12:37:51', '新闻服务', '查看人民日报滚动要闻');
INSERT INTO `sys_log` VALUES (1428, 23, 'lqs', '2023-05-18 12:37:53', '新闻服务', '查看中国经济网IT要闻');
INSERT INTO `sys_log` VALUES (1429, 23, 'lqs', '2023-05-18 12:38:41', '用户模块', '用户列表');
INSERT INTO `sys_log` VALUES (1430, 23, 'lqs', '2023-05-18 12:38:42', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (1431, 23, 'lqs', '2023-05-18 12:38:43', '权限服务', '权限列表[展示]');
INSERT INTO `sys_log` VALUES (1432, 23, 'lqs', '2023-05-18 12:44:19', 'ChatGPT', '提问==hello...');
INSERT INTO `sys_log` VALUES (1433, 23, 'lqs', '2023-05-18 12:44:58', '新闻服务', '查看中国经济网IT要闻');
INSERT INTO `sys_log` VALUES (1434, 23, 'lqs', '2023-05-18 12:45:03', 'ChatGPT', '提问==hello...');
INSERT INTO `sys_log` VALUES (1435, 23, 'lqs', '2023-05-18 12:45:51', 'ChatGPT', '提问==hello...');
INSERT INTO `sys_log` VALUES (1436, 23, 'lqs', '2023-05-18 12:50:52', 'ChatGPT', '提问==completion...==花费token==175');
INSERT INTO `sys_log` VALUES (1437, 23, 'lqs', '2023-05-18 12:51:43', 'ChatGPT', '提问==completion...  花费token==169');
INSERT INTO `sys_log` VALUES (1438, 23, 'lqs', '2023-05-18 12:51:44', '角色服务', '角色列表[展示]');
INSERT INTO `sys_log` VALUES (1439, 23, 'lqs', '2023-05-18 12:52:15', 'ChatGPT', '提问==completion...  花费token==254个');
INSERT INTO `sys_log` VALUES (1440, 23, 'lqs', '2023-05-18 12:58:41', 'ChatGPT', '提问==hellohello...  花费token==35个');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '性别',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `loginTime` datetime NOT NULL COMMENT '登录时间',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `isDelete` int NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (23, 'lqs', '$2a$10$ltNDgsagzDgAo2maKStbcuVHKfHGwJSgB75YV0ExLs0Tzf4dGzIXO', '男', '2023-03-24 11:13:56', '2023-05-18 09:52:40', '749062870@qq.com', 0);
INSERT INTO `user` VALUES (37, 'liubangqi', '$2a$10$nA01UPHntzeFxbUAK2gIl.uX53OPycKqQpLcovZ0E819NUG51VESy', '女', '2023-04-25 13:10:06', '2023-04-30 19:54:07', '749062870@qq.com', 0);
INSERT INTO `user` VALUES (38, 'guest', '$2a$10$p0UZ.4UEkrG8xISkpGDNFeOf2EUNBWB/e1m2pXbZosTqti8b3g07K', '男', '2023-04-30 19:13:24', '2023-05-10 22:31:10', '749062870@qq.com', 0);
INSERT INTO `user` VALUES (40, 'lh', '$2a$10$fo0rhCSzmB6dvYtZjZmaxuoO7V.uB2i4b1pLAx5nhX3YApOIwTobG', '男', '2023-05-01 01:44:16', '2023-05-10 22:29:27', '749062870@qq.com', 0);
INSERT INTO `user` VALUES (41, 'haha', '$2a$10$ygHxtB62rVwKakspVSxkMepVuSTL8N1mSAeBj9c9lB93UZeeh/HwG', '男', '2023-05-11 09:30:25', '2023-05-11 09:30:28', '749062870@qq.com', 0);
INSERT INTO `user` VALUES (42, 'cece', '$2a$10$DRE6rHIzkaeGR/Wh0wSSre/OYSZANoKu/fDN.nwuLFqoS9RCIU8MS', '女', '2023-05-11 09:33:29', '2023-05-11 09:33:29', '749062870@qq.com', 0);

-- ----------------------------
-- Table structure for user_file
-- ----------------------------
DROP TABLE IF EXISTS `user_file`;
CREATE TABLE `user_file`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userId` int NOT NULL COMMENT '用户id',
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件链接',
  `fileType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件类型',
  `isDelete` int NOT NULL DEFAULT 0 COMMENT '是否删除',
  `uploadTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `fileName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名',
  `deleteTime` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fru`(`userId` ASC) USING BTREE,
  CONSTRAINT `fru` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 423 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_file
-- ----------------------------
INSERT INTO `user_file` VALUES (421, 23, 'public/2023-04-25/be6e63f57d054fb2b8ce72625b973275.png', 'image/png', 0, '2023-04-25 13:24:16', 'ximiao', NULL);
INSERT INTO `user_file` VALUES (422, 23, 'public/2023-04-30/48e0ae33ab5f41e7bc0e30240dbeb19d.crt', 'application/x-x509-ca-cert', 0, '2023-04-30 19:16:34', 'ca', NULL);

-- ----------------------------
-- Table structure for user_menu
-- ----------------------------
DROP TABLE IF EXISTS `user_menu`;
CREATE TABLE `user_menu`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userId` int NOT NULL COMMENT '用户id',
  `menuId` int NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `urm`(`userId` ASC) USING BTREE,
  INDEX `mrm`(`menuId` ASC) USING BTREE,
  CONSTRAINT `mrm` FOREIGN KEY (`menuId`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `urm` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 488 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和菜单权限关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_menu
-- ----------------------------
INSERT INTO `user_menu` VALUES (331, 38, 1);
INSERT INTO `user_menu` VALUES (332, 38, 6);
INSERT INTO `user_menu` VALUES (333, 38, 19);
INSERT INTO `user_menu` VALUES (334, 38, 22);
INSERT INTO `user_menu` VALUES (335, 38, 23);
INSERT INTO `user_menu` VALUES (336, 38, 31);
INSERT INTO `user_menu` VALUES (337, 38, 32);
INSERT INTO `user_menu` VALUES (338, 38, 33);
INSERT INTO `user_menu` VALUES (339, 38, 34);
INSERT INTO `user_menu` VALUES (340, 38, 35);
INSERT INTO `user_menu` VALUES (341, 38, 36);
INSERT INTO `user_menu` VALUES (342, 38, 37);
INSERT INTO `user_menu` VALUES (343, 38, 38);
INSERT INTO `user_menu` VALUES (344, 38, 39);
INSERT INTO `user_menu` VALUES (345, 37, 1);
INSERT INTO `user_menu` VALUES (346, 37, 6);
INSERT INTO `user_menu` VALUES (347, 37, 19);
INSERT INTO `user_menu` VALUES (348, 37, 22);
INSERT INTO `user_menu` VALUES (349, 37, 23);
INSERT INTO `user_menu` VALUES (350, 37, 31);
INSERT INTO `user_menu` VALUES (351, 37, 32);
INSERT INTO `user_menu` VALUES (352, 37, 33);
INSERT INTO `user_menu` VALUES (353, 37, 34);
INSERT INTO `user_menu` VALUES (354, 37, 35);
INSERT INTO `user_menu` VALUES (355, 37, 36);
INSERT INTO `user_menu` VALUES (356, 37, 37);
INSERT INTO `user_menu` VALUES (357, 37, 38);
INSERT INTO `user_menu` VALUES (358, 37, 39);
INSERT INTO `user_menu` VALUES (359, 37, 2);
INSERT INTO `user_menu` VALUES (360, 37, 3);
INSERT INTO `user_menu` VALUES (361, 37, 4);
INSERT INTO `user_menu` VALUES (362, 37, 5);
INSERT INTO `user_menu` VALUES (363, 37, 7);
INSERT INTO `user_menu` VALUES (364, 37, 26);
INSERT INTO `user_menu` VALUES (365, 37, 27);
INSERT INTO `user_menu` VALUES (417, 23, 1);
INSERT INTO `user_menu` VALUES (418, 23, 2);
INSERT INTO `user_menu` VALUES (419, 23, 3);
INSERT INTO `user_menu` VALUES (420, 23, 4);
INSERT INTO `user_menu` VALUES (421, 23, 5);
INSERT INTO `user_menu` VALUES (422, 23, 6);
INSERT INTO `user_menu` VALUES (423, 23, 7);
INSERT INTO `user_menu` VALUES (424, 23, 19);
INSERT INTO `user_menu` VALUES (425, 23, 22);
INSERT INTO `user_menu` VALUES (426, 23, 23);
INSERT INTO `user_menu` VALUES (427, 23, 26);
INSERT INTO `user_menu` VALUES (428, 23, 27);
INSERT INTO `user_menu` VALUES (429, 23, 31);
INSERT INTO `user_menu` VALUES (430, 23, 32);
INSERT INTO `user_menu` VALUES (431, 23, 33);
INSERT INTO `user_menu` VALUES (432, 23, 34);
INSERT INTO `user_menu` VALUES (433, 23, 35);
INSERT INTO `user_menu` VALUES (434, 23, 36);
INSERT INTO `user_menu` VALUES (435, 23, 37);
INSERT INTO `user_menu` VALUES (436, 23, 38);
INSERT INTO `user_menu` VALUES (437, 23, 39);
INSERT INTO `user_menu` VALUES (440, 23, 43);
INSERT INTO `user_menu` VALUES (441, 40, 1);
INSERT INTO `user_menu` VALUES (442, 40, 6);
INSERT INTO `user_menu` VALUES (443, 40, 19);
INSERT INTO `user_menu` VALUES (444, 40, 22);
INSERT INTO `user_menu` VALUES (445, 40, 23);
INSERT INTO `user_menu` VALUES (446, 40, 31);
INSERT INTO `user_menu` VALUES (447, 40, 32);
INSERT INTO `user_menu` VALUES (448, 40, 33);
INSERT INTO `user_menu` VALUES (449, 40, 34);
INSERT INTO `user_menu` VALUES (450, 40, 35);
INSERT INTO `user_menu` VALUES (451, 40, 36);
INSERT INTO `user_menu` VALUES (452, 40, 37);
INSERT INTO `user_menu` VALUES (453, 40, 38);
INSERT INTO `user_menu` VALUES (454, 40, 39);
INSERT INTO `user_menu` VALUES (456, 41, 1);
INSERT INTO `user_menu` VALUES (457, 41, 6);
INSERT INTO `user_menu` VALUES (458, 41, 19);
INSERT INTO `user_menu` VALUES (459, 41, 22);
INSERT INTO `user_menu` VALUES (460, 41, 23);
INSERT INTO `user_menu` VALUES (461, 41, 31);
INSERT INTO `user_menu` VALUES (462, 41, 32);
INSERT INTO `user_menu` VALUES (463, 41, 33);
INSERT INTO `user_menu` VALUES (464, 41, 34);
INSERT INTO `user_menu` VALUES (465, 41, 35);
INSERT INTO `user_menu` VALUES (466, 41, 36);
INSERT INTO `user_menu` VALUES (467, 41, 37);
INSERT INTO `user_menu` VALUES (468, 41, 38);
INSERT INTO `user_menu` VALUES (469, 41, 39);
INSERT INTO `user_menu` VALUES (470, 41, 44);
INSERT INTO `user_menu` VALUES (471, 41, 45);
INSERT INTO `user_menu` VALUES (472, 42, 1);
INSERT INTO `user_menu` VALUES (473, 42, 6);
INSERT INTO `user_menu` VALUES (474, 42, 19);
INSERT INTO `user_menu` VALUES (475, 42, 22);
INSERT INTO `user_menu` VALUES (476, 42, 23);
INSERT INTO `user_menu` VALUES (477, 42, 31);
INSERT INTO `user_menu` VALUES (478, 42, 32);
INSERT INTO `user_menu` VALUES (479, 42, 33);
INSERT INTO `user_menu` VALUES (480, 42, 34);
INSERT INTO `user_menu` VALUES (481, 42, 35);
INSERT INTO `user_menu` VALUES (482, 42, 36);
INSERT INTO `user_menu` VALUES (483, 42, 37);
INSERT INTO `user_menu` VALUES (484, 42, 38);
INSERT INTO `user_menu` VALUES (485, 42, 39);
INSERT INTO `user_menu` VALUES (486, 42, 44);
INSERT INTO `user_menu` VALUES (487, 42, 45);

-- ----------------------------
-- Table structure for user_permission
-- ----------------------------
DROP TABLE IF EXISTS `user_permission`;
CREATE TABLE `user_permission`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userId` int NOT NULL COMMENT '用户id',
  `permissionId` int NOT NULL COMMENT '接口权限id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `prp`(`permissionId` ASC) USING BTREE,
  INDEX `urp`(`userId` ASC) USING BTREE,
  CONSTRAINT `prp` FOREIGN KEY (`permissionId`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `urp` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和接口权限关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_permission
-- ----------------------------
INSERT INTO `user_permission` VALUES (65, 37, 1);
INSERT INTO `user_permission` VALUES (66, 38, 1);
INSERT INTO `user_permission` VALUES (88, 40, 1);
INSERT INTO `user_permission` VALUES (89, 40, 4);
INSERT INTO `user_permission` VALUES (90, 40, 7);
INSERT INTO `user_permission` VALUES (91, 23, 1);
INSERT INTO `user_permission` VALUES (92, 23, 3);
INSERT INTO `user_permission` VALUES (93, 23, 4);
INSERT INTO `user_permission` VALUES (94, 23, 7);
INSERT INTO `user_permission` VALUES (95, 41, 1);
INSERT INTO `user_permission` VALUES (96, 42, 1);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userId` int NOT NULL COMMENT '用户id',
  `roleId` int NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `roleRelationRole`(`roleId` ASC) USING BTREE,
  INDEX `userRelationRole`(`userId` ASC) USING BTREE,
  CONSTRAINT `roleRelationRole` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userRelationRole` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 96 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (78, 37, 1);
INSERT INTO `user_role` VALUES (79, 38, 1);
INSERT INTO `user_role` VALUES (91, 40, 2);
INSERT INTO `user_role` VALUES (92, 40, 5);
INSERT INTO `user_role` VALUES (93, 23, 2);
INSERT INTO `user_role` VALUES (94, 41, 1);
INSERT INTO `user_role` VALUES (95, 42, 1);

SET FOREIGN_KEY_CHECKS = 1;
