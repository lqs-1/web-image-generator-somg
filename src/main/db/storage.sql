/*
 Navicat Premium Data Transfer

 Source Server         : 888
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32-0ubuntu0.20.04.2)
 Source Host           : 192.227.225.111:3306
 Source Schema         : storage

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32-0ubuntu0.20.04.2)
 File Encoding         : 65001

 Date: 29/04/2023 18:01:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for file_location
-- ----------------------------
DROP TABLE IF EXISTS `file_location`;
CREATE TABLE `file_location`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `imagePath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file_location
-- ----------------------------
INSERT INTO `file_location` VALUES (35, '/home/somg/img/local/5ff0709b07c54ee2b16695de6200aa85.png');
INSERT INTO `file_location` VALUES (36, '/home/somg/img/scale/e86419a986914c8997dc139aea8072a5.png');

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `menuIndex` int NULL DEFAULT NULL,
  `menuPath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `menuName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `parentIndex` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
  `id` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'common');
INSERT INTO `role` VALUES (2, 'supermanager');
INSERT INTO `role` VALUES (5, 'admin');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `time` datetime NOT NULL,
  `serverName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`, `userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 309 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createTime` datetime NOT NULL,
  `loginTime` datetime NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (23, 'lqs', '$2a$10$ltNDgsagzDgAo2maKStbcuVHKfHGwJSgB75YV0ExLs0Tzf4dGzIXO', '男', '2023-03-24 11:13:56', '2023-04-29 17:42:06', '749062870@qq.com');
INSERT INTO `user` VALUES (37, 'liubangqi', '$2a$10$E0WDuyXOy8EdMXYNOihaauSJ//eq0SsrkPzdw81vX0CBynyaNOifi', '女', '2023-04-25 13:10:06', '2023-04-25 13:10:06', '749062870@qq.com');

-- ----------------------------
-- Table structure for user_file
-- ----------------------------
DROP TABLE IF EXISTS `user_file`;
CREATE TABLE `user_file`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fileType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `isDelete` int NOT NULL DEFAULT 0,
  `uploadTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fileName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fru`(`userId` ASC) USING BTREE,
  CONSTRAINT `fru` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 422 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_file
-- ----------------------------
INSERT INTO `user_file` VALUES (421, 23, 'public/2023-04-25/be6e63f57d054fb2b8ce72625b973275.png', 'image/png', 0, '2023-04-25 13:24:16', 'ximiao');

-- ----------------------------
-- Table structure for user_menu
-- ----------------------------
DROP TABLE IF EXISTS `user_menu`;
CREATE TABLE `user_menu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `menuId` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `urm`(`userId` ASC) USING BTREE,
  INDEX `mrm`(`menuId` ASC) USING BTREE,
  CONSTRAINT `mrm` FOREIGN KEY (`menuId`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `urm` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 308 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_menu
-- ----------------------------
INSERT INTO `user_menu` VALUES (273, 23, 1);
INSERT INTO `user_menu` VALUES (274, 23, 2);
INSERT INTO `user_menu` VALUES (275, 23, 3);
INSERT INTO `user_menu` VALUES (276, 23, 4);
INSERT INTO `user_menu` VALUES (277, 23, 5);
INSERT INTO `user_menu` VALUES (278, 23, 6);
INSERT INTO `user_menu` VALUES (279, 23, 7);
INSERT INTO `user_menu` VALUES (280, 23, 19);
INSERT INTO `user_menu` VALUES (281, 23, 22);
INSERT INTO `user_menu` VALUES (282, 23, 23);
INSERT INTO `user_menu` VALUES (283, 23, 26);
INSERT INTO `user_menu` VALUES (284, 23, 27);
INSERT INTO `user_menu` VALUES (285, 23, 31);
INSERT INTO `user_menu` VALUES (286, 23, 32);
INSERT INTO `user_menu` VALUES (287, 23, 33);
INSERT INTO `user_menu` VALUES (288, 23, 34);
INSERT INTO `user_menu` VALUES (289, 23, 35);
INSERT INTO `user_menu` VALUES (290, 23, 36);
INSERT INTO `user_menu` VALUES (291, 23, 37);
INSERT INTO `user_menu` VALUES (292, 23, 39);
INSERT INTO `user_menu` VALUES (293, 23, 38);
INSERT INTO `user_menu` VALUES (294, 37, 1);
INSERT INTO `user_menu` VALUES (295, 37, 6);
INSERT INTO `user_menu` VALUES (296, 37, 19);
INSERT INTO `user_menu` VALUES (297, 37, 22);
INSERT INTO `user_menu` VALUES (298, 37, 23);
INSERT INTO `user_menu` VALUES (299, 37, 31);
INSERT INTO `user_menu` VALUES (300, 37, 32);
INSERT INTO `user_menu` VALUES (301, 37, 33);
INSERT INTO `user_menu` VALUES (302, 37, 34);
INSERT INTO `user_menu` VALUES (303, 37, 35);
INSERT INTO `user_menu` VALUES (304, 37, 36);
INSERT INTO `user_menu` VALUES (305, 37, 37);
INSERT INTO `user_menu` VALUES (306, 37, 38);
INSERT INTO `user_menu` VALUES (307, 37, 39);

-- ----------------------------
-- Table structure for user_permission
-- ----------------------------
DROP TABLE IF EXISTS `user_permission`;
CREATE TABLE `user_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `permissionId` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `prp`(`permissionId` ASC) USING BTREE,
  INDEX `urp`(`userId` ASC) USING BTREE,
  CONSTRAINT `prp` FOREIGN KEY (`permissionId`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `urp` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_permission
-- ----------------------------
INSERT INTO `user_permission` VALUES (26, 23, 1);
INSERT INTO `user_permission` VALUES (27, 23, 3);
INSERT INTO `user_permission` VALUES (28, 23, 4);
INSERT INTO `user_permission` VALUES (29, 23, 7);
INSERT INTO `user_permission` VALUES (65, 37, 1);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `roleId` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `roleRelationRole`(`roleId` ASC) USING BTREE,
  INDEX `userRelationRole`(`userId` ASC) USING BTREE,
  CONSTRAINT `roleRelationRole` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userRelationRole` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (43, 23, 1);
INSERT INTO `user_role` VALUES (44, 23, 2);
INSERT INTO `user_role` VALUES (45, 23, 5);
INSERT INTO `user_role` VALUES (78, 37, 1);

SET FOREIGN_KEY_CHECKS = 1;
