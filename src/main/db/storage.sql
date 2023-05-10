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

 Date: 10/05/2023 10:50:03
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
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统字典表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 749 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统日志表' ROW_FORMAT = DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (23, 'lqs', '$2a$10$ltNDgsagzDgAo2maKStbcuVHKfHGwJSgB75YV0ExLs0Tzf4dGzIXO', '男', '2023-03-24 11:13:56', '2023-05-02 15:26:26', '749062870@qq.com');
INSERT INTO `user` VALUES (37, 'liubangqi', '$2a$10$E0WDuyXOy8EdMXYNOihaauSJ//eq0SsrkPzdw81vX0CBynyaNOifi', '女', '2023-04-25 13:10:06', '2023-04-30 19:54:07', '749062870@qq.com');
INSERT INTO `user` VALUES (38, 'guest', '$2a$10$OEO4B8oGcvLnobQbAqLKoe/FJr3iuphz.GvFLYw89wkHjUcCYQbj.', '男', '2023-04-30 19:13:24', '2023-04-30 19:13:24', '749062870@qq.com');
INSERT INTO `user` VALUES (40, 'lh', '$2a$10$r9c/cQcyLflEt6mUQ4NoYuFkvOflGFWD68Om0RPEQABlccaVIditq', '男', '2023-05-01 01:44:16', '2023-05-01 01:44:39', '749062870@qq.com');

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fru`(`userId` ASC) USING BTREE,
  CONSTRAINT `fru` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 423 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_file
-- ----------------------------
INSERT INTO `user_file` VALUES (421, 23, 'public/2023-04-25/be6e63f57d054fb2b8ce72625b973275.png', 'image/png', 0, '2023-04-25 13:24:16', 'ximiao');
INSERT INTO `user_file` VALUES (422, 23, 'public/2023-04-30/48e0ae33ab5f41e7bc0e30240dbeb19d.crt', 'application/x-x509-ca-cert', 0, '2023-04-30 19:16:34', 'ca');

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
) ENGINE = InnoDB AUTO_INCREMENT = 441 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和菜单权限关联表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `user_menu` VALUES (377, 40, 1);
INSERT INTO `user_menu` VALUES (378, 40, 6);
INSERT INTO `user_menu` VALUES (379, 40, 19);
INSERT INTO `user_menu` VALUES (380, 40, 22);
INSERT INTO `user_menu` VALUES (381, 40, 23);
INSERT INTO `user_menu` VALUES (382, 40, 31);
INSERT INTO `user_menu` VALUES (383, 40, 32);
INSERT INTO `user_menu` VALUES (384, 40, 33);
INSERT INTO `user_menu` VALUES (385, 40, 34);
INSERT INTO `user_menu` VALUES (386, 40, 35);
INSERT INTO `user_menu` VALUES (387, 40, 36);
INSERT INTO `user_menu` VALUES (388, 40, 37);
INSERT INTO `user_menu` VALUES (389, 40, 38);
INSERT INTO `user_menu` VALUES (390, 40, 39);
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
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和接口权限关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_permission
-- ----------------------------
INSERT INTO `user_permission` VALUES (26, 23, 1);
INSERT INTO `user_permission` VALUES (27, 23, 3);
INSERT INTO `user_permission` VALUES (28, 23, 4);
INSERT INTO `user_permission` VALUES (29, 23, 7);
INSERT INTO `user_permission` VALUES (65, 37, 1);
INSERT INTO `user_permission` VALUES (66, 38, 1);
INSERT INTO `user_permission` VALUES (68, 40, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (43, 23, 1);
INSERT INTO `user_role` VALUES (44, 23, 2);
INSERT INTO `user_role` VALUES (45, 23, 5);
INSERT INTO `user_role` VALUES (78, 37, 1);
INSERT INTO `user_role` VALUES (79, 38, 1);
INSERT INTO `user_role` VALUES (81, 40, 1);

SET FOREIGN_KEY_CHECKS = 1;
