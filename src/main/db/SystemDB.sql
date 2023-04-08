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

 Date: 08/04/2023 10:19:44
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
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file_location
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (23, 'lqs', '$2a$10$jUPktqPQ1LDKJkQzm3AXDu0CA8gcnCGoEQANPIwDYOZ/7EGYJzoki', '男', '2023-03-24 11:13:56', '2023-04-01 07:18:33');
INSERT INTO `user` VALUES (35, 'sx', '$2a$10$dev/PbUTlOkiK3jzY4dR.eN2HgFZxViwWb.UE/1zB1xEJIRrv.w2G', '男', '2023-03-24 11:13:56', '2023-03-24 03:28:34');
INSERT INTO `user` VALUES (36, 'lbq', '$2a$10$7flCl4AqSkslQrzti1sHqeAhsSnmDgCEwAHPBhhQeC1beVYc3LX9y', '男', '2023-03-24 11:13:56', '2023-03-24 11:14:09');

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
) ENGINE = InnoDB AUTO_INCREMENT = 421 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_file
-- ----------------------------
INSERT INTO `user_file` VALUES (388, 23, 'public/2023-03-21/a4aa4b39dde34d3fbd4e0064b480bc42.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (389, 23, 'public/2023-03-21/1fabef110f1141c7aaa599c86a29fb5f.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (390, 23, 'public/2023-03-21/258cd1e4a3b34829b78129768686f093.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (391, 23, 'public/2023-03-21/07f7f21459394f1db04e78e3f1851673.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (392, 23, 'public/2023-03-21/b9d0e133dffc4634b8b6656637cb5bcb.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (393, 23, 'public/2023-03-21/51381516d1014c23905241cc69d31b8f.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (394, 23, 'public/2023-03-21/4f4ffff05b664cf1b3bdd685d5432ddc.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (395, 23, 'public/2023-03-21/a79045cd7c164e2d94135dd9802195cf.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (396, 23, 'public/2023-03-21/cd4914154f874a73a8f6479a0301eb74.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (397, 23, 'public/2023-03-21/33d921d6afac412f8de35c727d31b56a.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (398, 23, 'public/2023-03-21/b287f6fe8f25422ba102d659d8dace06.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (399, 23, 'public/2023-03-21/8a1207cc7ad7489c8f7b77227a4a3a85.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (400, 23, 'public/2023-03-21/91962a073bae457ab0ff217d288b2208.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (401, 23, 'public/2023-03-21/c37e2f47c2664898a857632499675e4b.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (402, 23, 'public/2023-03-21/bed87f1c7f0348dfbb6fff32483ca598.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (403, 23, 'public/2023-03-21/59e2dc67fc7d44d08204e018fc72586b.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (404, 35, 'public/2023-03-21/127de071281b4862835c98f04d26c2b8.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (405, 35, 'public/2023-03-21/6f71d331f1ff4896976ba943ac28a46c.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (406, 35, 'public/2023-03-21/4f5a73274384442fa4fe4f28b1d7365c.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (407, 35, 'public/2023-03-21/fc18cf7d3ccc415c8f418f69b41997c0.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (408, 35, 'public/2023-03-21/797510563b7e4911b1208123d2438c24.jpg', 'image/jpeg', 0, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (409, 35, 'public/2023-03-21/b82a8e526a504460996e80344f85e39e.jpg', 'image/jpeg', 1, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (410, 35, 'public/2023-03-21/94cd0739db824a4290a574389170b6bc.jpg', 'image/jpeg', 1, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (411, 35, 'public/2023-03-21/cbe53c73c4fe4134944e3d966651b897.jpg', 'image/jpeg', 1, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (412, 35, 'public/2023-03-21/ca375064fee54249b9473fdc63be3106.jpg', 'image/jpeg', 1, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (413, 35, 'public/2023-03-21/0b11de9192984919b7dc57b71413479c.jpg', 'image/jpeg', 1, '2023-03-23 10:31:33', 'demo');
INSERT INTO `user_file` VALUES (414, 23, 'public/2023-03-23/e6fbb3bd856a469680fd3d47e646c97a.mp4', 'video/mp4', 0, '2023-03-23 10:41:03', 'demo');
INSERT INTO `user_file` VALUES (415, 23, 'public/2023-03-23/866633c34b8e4488ab9c7e79ff07b920.mp3', 'audio/mpeg', 0, '2023-03-23 10:47:09', 'demo');
INSERT INTO `user_file` VALUES (416, 23, 'public/2023-03-23/8e69bd8e965b47a591d161ff8446d430.jpg', 'image/jpeg', 0, '2023-03-23 15:38:47', 'demo');
INSERT INTO `user_file` VALUES (417, 23, 'public/2023-03-23/a431b50c2a0e4b46bf49a7a0a8649f0c.jpg', 'image/jpeg', 0, '2023-03-23 15:41:07', 'demo');
INSERT INTO `user_file` VALUES (418, 23, 'public/2023-03-23/664c1cd9b40243ae8531e0beb4e9687b.jpg', 'image/jpeg', 0, '2023-03-23 15:42:03', 'demo');
INSERT INTO `user_file` VALUES (419, 23, 'public/2023-03-23/0486319a60804072bad7a9de80c41d9e.jpg', 'image/jpeg', 0, '2023-03-23 15:45:33', 'demo');
INSERT INTO `user_file` VALUES (420, 23, 'public/2023-03-23/e0bd9171c8ff425f87a329207505ee84.jpg', 'image/jpeg', 1, '2023-03-23 15:53:08', '6');

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
) ENGINE = InnoDB AUTO_INCREMENT = 259 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_menu
-- ----------------------------
INSERT INTO `user_menu` VALUES (220, 35, 1);
INSERT INTO `user_menu` VALUES (221, 35, 6);
INSERT INTO `user_menu` VALUES (222, 35, 19);
INSERT INTO `user_menu` VALUES (223, 35, 22);
INSERT INTO `user_menu` VALUES (224, 35, 23);
INSERT INTO `user_menu` VALUES (225, 35, 2);
INSERT INTO `user_menu` VALUES (226, 35, 3);
INSERT INTO `user_menu` VALUES (227, 35, 4);
INSERT INTO `user_menu` VALUES (228, 35, 5);
INSERT INTO `user_menu` VALUES (229, 35, 7);
INSERT INTO `user_menu` VALUES (230, 35, 26);
INSERT INTO `user_menu` VALUES (236, 36, 1);
INSERT INTO `user_menu` VALUES (237, 36, 6);
INSERT INTO `user_menu` VALUES (238, 36, 19);
INSERT INTO `user_menu` VALUES (239, 36, 22);
INSERT INTO `user_menu` VALUES (240, 36, 23);
INSERT INTO `user_menu` VALUES (241, 36, 2);
INSERT INTO `user_menu` VALUES (242, 36, 3);
INSERT INTO `user_menu` VALUES (243, 36, 4);
INSERT INTO `user_menu` VALUES (244, 36, 5);
INSERT INTO `user_menu` VALUES (245, 36, 7);
INSERT INTO `user_menu` VALUES (246, 36, 26);
INSERT INTO `user_menu` VALUES (247, 23, 1);
INSERT INTO `user_menu` VALUES (248, 23, 2);
INSERT INTO `user_menu` VALUES (249, 23, 3);
INSERT INTO `user_menu` VALUES (250, 23, 4);
INSERT INTO `user_menu` VALUES (251, 23, 5);
INSERT INTO `user_menu` VALUES (252, 23, 6);
INSERT INTO `user_menu` VALUES (253, 23, 7);
INSERT INTO `user_menu` VALUES (254, 23, 19);
INSERT INTO `user_menu` VALUES (255, 23, 22);
INSERT INTO `user_menu` VALUES (256, 23, 23);
INSERT INTO `user_menu` VALUES (257, 23, 26);
INSERT INTO `user_menu` VALUES (258, 23, 27);

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
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_permission
-- ----------------------------
INSERT INTO `user_permission` VALUES (26, 23, 1);
INSERT INTO `user_permission` VALUES (27, 23, 3);
INSERT INTO `user_permission` VALUES (28, 23, 4);
INSERT INTO `user_permission` VALUES (29, 23, 7);
INSERT INTO `user_permission` VALUES (60, 35, 1);
INSERT INTO `user_permission` VALUES (61, 35, 3);
INSERT INTO `user_permission` VALUES (62, 35, 4);
INSERT INTO `user_permission` VALUES (63, 35, 7);
INSERT INTO `user_permission` VALUES (64, 36, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (43, 23, 1);
INSERT INTO `user_role` VALUES (44, 23, 2);
INSERT INTO `user_role` VALUES (45, 23, 5);
INSERT INTO `user_role` VALUES (74, 35, 1);
INSERT INTO `user_role` VALUES (75, 35, 2);
INSERT INTO `user_role` VALUES (76, 35, 5);
INSERT INTO `user_role` VALUES (77, 36, 1);

SET FOREIGN_KEY_CHECKS = 1;
