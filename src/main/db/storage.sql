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

 Date: 21/03/2023 18:47:19
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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (23, 'lqs', '$2a$10$jUPktqPQ1LDKJkQzm3AXDu0CA8gcnCGoEQANPIwDYOZ/7EGYJzoki', '男');

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
) ENGINE = InnoDB AUTO_INCREMENT = 388 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_file
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 204 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_menu
-- ----------------------------
INSERT INTO `user_menu` VALUES (133, 23, 1);
INSERT INTO `user_menu` VALUES (134, 23, 2);
INSERT INTO `user_menu` VALUES (135, 23, 3);
INSERT INTO `user_menu` VALUES (136, 23, 4);
INSERT INTO `user_menu` VALUES (137, 23, 5);
INSERT INTO `user_menu` VALUES (138, 23, 6);
INSERT INTO `user_menu` VALUES (139, 23, 7);
INSERT INTO `user_menu` VALUES (143, 23, 19);
INSERT INTO `user_menu` VALUES (144, 23, 22);
INSERT INTO `user_menu` VALUES (145, 23, 23);

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
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_permission
-- ----------------------------
INSERT INTO `user_permission` VALUES (26, 23, 1);
INSERT INTO `user_permission` VALUES (27, 23, 3);
INSERT INTO `user_permission` VALUES (28, 23, 4);
INSERT INTO `user_permission` VALUES (29, 23, 7);

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
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (43, 23, 1);
INSERT INTO `user_role` VALUES (44, 23, 2);
INSERT INTO `user_role` VALUES (45, 23, 5);

SET FOREIGN_KEY_CHECKS = 1;
