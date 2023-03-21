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

 Date: 21/03/2023 22:26:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (23, 'lqs', '$2a$10$jUPktqPQ1LDKJkQzm3AXDu0CA8gcnCGoEQANPIwDYOZ/7EGYJzoki', '男');
INSERT INTO `user` VALUES (35, 'sx', '$2a$10$dev/PbUTlOkiK3jzY4dR.eN2HgFZxViwWb.UE/1zB1xEJIRrv.w2G', '男');

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
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fru`(`userId` ASC) USING BTREE,
  CONSTRAINT `fru` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 414 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_file
-- ----------------------------
INSERT INTO `user_file` VALUES (388, 23, 'public/2023-03-21/a4aa4b39dde34d3fbd4e0064b480bc42.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (389, 23, 'public/2023-03-21/1fabef110f1141c7aaa599c86a29fb5f.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (390, 23, 'public/2023-03-21/258cd1e4a3b34829b78129768686f093.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (391, 23, 'public/2023-03-21/07f7f21459394f1db04e78e3f1851673.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (392, 23, 'public/2023-03-21/b9d0e133dffc4634b8b6656637cb5bcb.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (393, 23, 'public/2023-03-21/51381516d1014c23905241cc69d31b8f.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (394, 23, 'public/2023-03-21/4f4ffff05b664cf1b3bdd685d5432ddc.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (395, 23, 'public/2023-03-21/a79045cd7c164e2d94135dd9802195cf.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (396, 23, 'public/2023-03-21/cd4914154f874a73a8f6479a0301eb74.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (397, 23, 'public/2023-03-21/33d921d6afac412f8de35c727d31b56a.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (398, 23, 'public/2023-03-21/b287f6fe8f25422ba102d659d8dace06.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (399, 23, 'public/2023-03-21/8a1207cc7ad7489c8f7b77227a4a3a85.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (400, 23, 'public/2023-03-21/91962a073bae457ab0ff217d288b2208.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (401, 23, 'public/2023-03-21/c37e2f47c2664898a857632499675e4b.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (402, 23, 'public/2023-03-21/bed87f1c7f0348dfbb6fff32483ca598.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (403, 23, 'public/2023-03-21/59e2dc67fc7d44d08204e018fc72586b.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (404, 35, 'public/2023-03-21/127de071281b4862835c98f04d26c2b8.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (405, 35, 'public/2023-03-21/6f71d331f1ff4896976ba943ac28a46c.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (406, 35, 'public/2023-03-21/4f5a73274384442fa4fe4f28b1d7365c.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (407, 35, 'public/2023-03-21/fc18cf7d3ccc415c8f418f69b41997c0.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (408, 35, 'public/2023-03-21/797510563b7e4911b1208123d2438c24.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (409, 35, 'public/2023-03-21/b82a8e526a504460996e80344f85e39e.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (410, 35, 'public/2023-03-21/94cd0739db824a4290a574389170b6bc.jpg', 'image/jpeg', 0);
INSERT INTO `user_file` VALUES (411, 35, 'public/2023-03-21/cbe53c73c4fe4134944e3d966651b897.jpg', 'image/jpeg', 1);
INSERT INTO `user_file` VALUES (412, 35, 'public/2023-03-21/ca375064fee54249b9473fdc63be3106.jpg', 'image/jpeg', 1);
INSERT INTO `user_file` VALUES (413, 35, 'public/2023-03-21/0b11de9192984919b7dc57b71413479c.jpg', 'image/jpeg', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 220 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_menu
-- ----------------------------
INSERT INTO `user_menu` VALUES (204, 35, 1);
INSERT INTO `user_menu` VALUES (205, 35, 6);
INSERT INTO `user_menu` VALUES (206, 35, 19);
INSERT INTO `user_menu` VALUES (207, 35, 22);
INSERT INTO `user_menu` VALUES (208, 35, 23);
INSERT INTO `user_menu` VALUES (209, 23, 1);
INSERT INTO `user_menu` VALUES (210, 23, 2);
INSERT INTO `user_menu` VALUES (211, 23, 3);
INSERT INTO `user_menu` VALUES (212, 23, 4);
INSERT INTO `user_menu` VALUES (213, 23, 5);
INSERT INTO `user_menu` VALUES (214, 23, 6);
INSERT INTO `user_menu` VALUES (215, 23, 7);
INSERT INTO `user_menu` VALUES (216, 23, 19);
INSERT INTO `user_menu` VALUES (217, 23, 22);
INSERT INTO `user_menu` VALUES (218, 23, 23);
INSERT INTO `user_menu` VALUES (219, 23, 26);

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
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_permission
-- ----------------------------
INSERT INTO `user_permission` VALUES (26, 23, 1);
INSERT INTO `user_permission` VALUES (27, 23, 3);
INSERT INTO `user_permission` VALUES (28, 23, 4);
INSERT INTO `user_permission` VALUES (29, 23, 7);
INSERT INTO `user_permission` VALUES (59, 35, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (43, 23, 1);
INSERT INTO `user_role` VALUES (44, 23, 2);
INSERT INTO `user_role` VALUES (45, 23, 5);
INSERT INTO `user_role` VALUES (73, 35, 1);

SET FOREIGN_KEY_CHECKS = 1;
