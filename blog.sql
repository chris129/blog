/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : 127.0.0.1:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 04/06/2018 18:51:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (5, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (8, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (9, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (10, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (11, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (12, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (17, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (18, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (19, 'Can add tag', 7, 'add_tag');
INSERT INTO `auth_permission` VALUES (20, 'Can change tag', 7, 'change_tag');
INSERT INTO `auth_permission` VALUES (21, 'Can delete tag', 7, 'delete_tag');
INSERT INTO `auth_permission` VALUES (22, 'Can add post', 8, 'add_post');
INSERT INTO `auth_permission` VALUES (23, 'Can change post', 8, 'change_post');
INSERT INTO `auth_permission` VALUES (24, 'Can delete post', 8, 'delete_post');
INSERT INTO `auth_permission` VALUES (25, 'Can add category', 9, 'add_category');
INSERT INTO `auth_permission` VALUES (26, 'Can change category', 9, 'change_category');
INSERT INTO `auth_permission` VALUES (27, 'Can delete category', 9, 'delete_category');
INSERT INTO `auth_permission` VALUES (28, 'Can add comment', 10, 'add_comment');
INSERT INTO `auth_permission` VALUES (29, 'Can change comment', 10, 'change_comment');
INSERT INTO `auth_permission` VALUES (30, 'Can delete comment', 10, 'delete_comment');
COMMIT;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
BEGIN;
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$30000$bVmyFiKMq9I6$hNC9QvqYyuAR6uRElkiA/SAPBkz4p1q9i+/H/fjLUFk=', NULL, 1, 'chris', '', '', 'chris@innjia.com', 1, 1, '2018-04-13 03:02:05.913039');
INSERT INTO `auth_user` VALUES (2, 'pbkdf2_sha256$30000$q9XYmm7mKzZz$DPq6NHLF+drqm3D1AJcjhDhpPEAGiGIx33yzrf88uLY=', '2018-06-04 05:21:06.128646', 1, 'admin', '', '', 'admin@innjia.com', 1, 1, '2018-04-13 03:02:21.688616');
COMMIT;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for blog_category
-- ----------------------------
DROP TABLE IF EXISTS `blog_category`;
CREATE TABLE `blog_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_category
-- ----------------------------
BEGIN;
INSERT INTO `blog_category` VALUES (1, '测试');
INSERT INTO `blog_category` VALUES (2, 'markdown');
INSERT INTO `blog_category` VALUES (3, '标签云');
COMMIT;

-- ----------------------------
-- Table structure for blog_post
-- ----------------------------
DROP TABLE IF EXISTS `blog_post`;
CREATE TABLE `blog_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(70) NOT NULL,
  `body` longtext NOT NULL,
  `created_time` date NOT NULL,
  `modified_time` date NOT NULL,
  `excerpt` varchar(200) NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `views` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_post_author_id_dd7a8485_fk_auth_user_id` (`author_id`),
  KEY `blog_post_category_id_c326dbf8_fk_blog_category_id` (`category_id`),
  CONSTRAINT `blog_post_author_id_dd7a8485_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `blog_post_category_id_c326dbf8_fk_blog_category_id` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_post
-- ----------------------------
BEGIN;
INSERT INTO `blog_post` VALUES (1, '第一篇文章', '第一篇测试文章', '2018-04-13', '2018-04-13', '测试', 2, 1, 7);
INSERT INTO `blog_post` VALUES (2, '第二篇文章', '第二篇文章', '2018-03-01', '2018-03-01', '分类', 1, 1, 2);
INSERT INTO `blog_post` VALUES (3, 'markdown测试', '# 一级标题\r\n## 二级标题\r\n### 三级标题\r\n- 列表项1\r\n- 列表项2\r\n- 列表项3\r\n> 这是一段引用\r\n\r\n```python\r\ncode 测试\r\n```', '2018-02-07', '2018-02-08', 'markdown', 2, 2, 12);
INSERT INTO `blog_post` VALUES (4, '第三篇文章', 'D3 是最流行的可视化库之一，它被很多其他的表格插件所使用。它允许绑定任意数据到DOM，然后将数据驱动转换应用到Document中。你可以使用它用一个数组创建基本的HTML表格，或是利用它的流体过度和交互，用相似的数据创建惊人的SVG条形图。D3-js D3JS', '2018-06-04', '2018-06-04', 'D3 是最流行的可视化库之一，它被很多其他的表格插件所使用。它允许绑定任意数据到DOM，然后将数据驱动转换应', 2, 1, 29);
INSERT INTO `blog_post` VALUES (5, 'python邮件测试', '```python\r\n#!/usr/bin/env python\r\n# -*- coding: utf-8 -*-\r\n \r\n__author__ = \'Zoa Chou\'\r\n# see http://www.mudoom.com/Article/show/id/29.html for detail\r\n \r\nimport logging\r\nimport smtplib\r\nimport mimetypes\r\nimport socket\r\nfrom email import encoders\r\nfrom email.header import Header\r\nfrom email.mime.text import MIMEText, MIMENonMultipart\r\nfrom email.mime.base import MIMEBase\r\nfrom email.utils import parseaddr, formataddr\r\n \r\n \r\nclass Mailer(object):\r\n    def __init__(self):\r\n        pass\r\n \r\n    def send_mail(self, smtp_server, from_address, to_address, subject, body, files=None):\r\n        \"\"\"\r\n        发送邮件主程序\r\n        :param smtp_server: dict 邮件服务器设置\r\n            :keyword  host: string smtp服务器地址\r\n            :keyword  port: int smtp服务器端口号\r\n            :keyword  user: string 用户名\r\n            :keyword  passwd: string 密码\r\n            :keyword  ssl: bool 是否启用ssl,默认False\r\n            :keyword  timeout: int 超时时间,默认10s\r\n        :param from_address: 发件人邮箱\r\n        :param to_address: 收件人邮箱\r\n        :param subject: 邮件标题\r\n        :param body: 邮件内容\r\n        :param files: 附件\r\n        :raise: NetworkError/MailerException\r\n        \"\"\"\r\n        # 格式化邮件内容\r\n        body = self._encode_utf8(body)\r\n        # 邮件类型\r\n        content_type = \'html\' if body.startswith(\'<html>\') else \'plain\'\r\n        msg = MIMENonMultipart() if files else MIMEText(body, content_type, \'utf-8\')\r\n        # 格式化邮件数据\r\n        msg[\'From\'] = self._format_address(from_address)\r\n        msg[\'To\'] = \', \'.join(self._format_list(to_address))\r\n        msg[\'subject\'] = self._encode_utf8(subject)\r\n \r\n        # 构造附件数据\r\n        if files:\r\n            msg.attach(MIMEText(body, content_type, \'utf-8\'))\r\n            cid = 0\r\n            for file_name, payload in files:\r\n                file_name = self._encode_utf8(file_name)\r\n                main_type, sub_type = self._get_file_type(file_name)\r\n                if hasattr(payload, \'read\'):\r\n                    payload = payload.read()\r\n                f_name = self._encode_header(file_name)\r\n                mime = MIMEBase(main_type, sub_type, filename=f_name)\r\n                mime.add_header(\'Content-Disposition\', \'attachment\', filename=f_name)\r\n                mime.add_header(\'Content-ID\', \'<%s>\' % cid)\r\n                mime.add_header(\'X-Attachment-Id\', \'%s\' % cid)\r\n                mime.set_payload(payload)\r\n                encoders.encode_base64(mime)\r\n                msg.attach(mime)\r\n                cid += 1\r\n \r\n        host = smtp_server.get(\'host\')\r\n        port = smtp_server.get(\'port\')\r\n        user = smtp_server.get(\'user\')\r\n        passwd = smtp_server.get(\'passwd\')\r\n        ssl = smtp_server.get(\'ssl\', False)\r\n        time_out = smtp_server.get(\'timeout\', 10)\r\n \r\n        # 没有输入端口则使用默认端口\r\n        if port is None or port == 0:\r\n            if ssl:\r\n                port = 465\r\n            else:\r\n                port = 25\r\n \r\n        logging.debug(\'Send mail form %s to %s\' % (msg[\'From\'], msg[\'To\']))\r\n \r\n        try:\r\n            if ssl:\r\n                # 开启ssl连接模式\r\n                server = smtplib.SMTP_SSL(\'%s:%d\' % (host, port), timeout=time_out)\r\n            else:\r\n                server = smtplib.SMTP(\'%s:%d\' % (host, port), timeout=time_out)\r\n            # 开启调试模式\r\n            # server.set_debuglevel(1)\r\n \r\n            # 如果存在用户名密码则尝试登录\r\n            if user and passwd:\r\n                server.login(user, passwd)\r\n \r\n            # 发送邮件\r\n            server.sendmail(from_address, to_address, msg.as_string())\r\n \r\n            logging.debug(\'Mail sent success.\')\r\n \r\n            # 关闭stmp连接\r\n            server.quit()\r\n \r\n        except socket.gaierror, e:\r\n            \"\"\" 网络无法连接 \"\"\"\r\n            logging.exception(e)\r\n            raise NetworkError(e)\r\n \r\n        except smtplib.SMTPServerDisconnected, e:\r\n            \"\"\" 网络连接异常 \"\"\"\r\n            logging.exception(e)\r\n            raise NetworkError(e)\r\n \r\n        except smtplib.SMTPException, e:\r\n            \"\"\" 邮件发送异常 \"\"\"\r\n            logging.exception(e)\r\n            raise MailerException(e)\r\n \r\n    def _format_address(self, s):\r\n        \"\"\"\r\n        格式化邮件地址\r\n        :param s:string 邮件地址\r\n        :return: string 格式化后的邮件地址\r\n        \"\"\"\r\n        name, address = parseaddr(s)\r\n        return formataddr((self._encode_header(name), self._encode_utf8(address)))\r\n \r\n    def _encode_header(self, s):\r\n        \"\"\"\r\n        格式化符合MIME的头部数据\r\n        :param s: string 待格式化数据\r\n        :return: 格式化后的数据\r\n        \"\"\"\r\n        return Header(s, \'utf-8\').encode()\r\n \r\n    def _encode_utf8(self, s):\r\n        \"\"\"\r\n        格式化成utf-8编码\r\n        :param s: string 待格式化数据\r\n        :return: string 格式化后的数据\r\n        \"\"\"\r\n        if isinstance(s, unicode):\r\n            return s.encode(\'utf-8\')\r\n        else:\r\n            return s\r\n \r\n    def _get_file_type(self, file_name):\r\n        \"\"\"\r\n        获取附件类型\r\n        :param file_name: 附件文件名\r\n        :return: dict 附件MIME\r\n        \"\"\"\r\n        s = file_name.lower()\r\n        pos = s.rfind(\'.\')\r\n        if pos == -1:\r\n            return \'application\', \'octet-stream\'\r\n \r\n        ext = s[pos:]\r\n        mime = mimetypes.types_map.get(ext, \'application/octet-stream\')\r\n        pos = mime.find(\'/\')\r\n        if pos == (-1):\r\n            return mime, \'\'\r\n        return mime[:pos], mime[pos+1:]\r\n \r\n    def _format_list(self, address):\r\n        \"\"\"\r\n        将收件人地址格式化成list\r\n        :param address: string/list 收件人邮箱\r\n        :return: list 收件人邮箱list\r\n        \"\"\"\r\n        l = address\r\n        if isinstance(l, basestring):\r\n            l = [l]\r\n        return [self._format_address(s) for s in l]\r\n \r\n \r\nclass MailerException(Exception):\r\n    \"\"\" 邮件发送异常类 \"\"\"\r\n    pass\r\n \r\n \r\nclass NetworkError(MailerException):\r\n    \"\"\" 网络异常类 \"\"\"\r\n    pass\r\n \r\n# test for @qq.com\r\nif __name__ == \'__main__\':\r\n    import sys\r\n \r\n    def prompt(prompt):\r\n        \"\"\"\r\n        接收终端输入的数据\r\n        \"\"\"\r\n        sys.stdout.write(prompt + \": \")\r\n        return sys.stdin.readline().strip()\r\n \r\n    from_address = prompt(\"From(Only @qq.com)\")\r\n    passwd = prompt(\"Password\")\r\n    to_address = prompt(\"To\").split(\',\')\r\n    subject = prompt(\"Subject\")\r\n    print \"Enter message, end with ^D:\"\r\n    msg = \'\'\r\n    while 1:\r\n        line = sys.stdin.readline()\r\n        if not line:\r\n            break\r\n        msg = msg + line\r\n    print \"Message length is %d\" % len(msg)\r\n    # QQ邮箱默认设置\r\n    smtp_server = {\'host\': \'smtp.qq.com\', \'port\': None, \'user\': from_address, \'passwd\': passwd, \'ssl\': True}\r\n    mailer = Mailer()\r\n \r\n    try:\r\n        mailer.send_mail(smtp_server, from_address, to_address, subject, msg)\r\n    except MailerException, e:\r\n        print(e)\r\n```', '2018-06-04', '2018-06-04', '#!/usr/bin/env python\n# -*- coding: utf-8 -*-\n\n__autho', 2, 1, 3);
INSERT INTO `blog_post` VALUES (6, 'python笔记之Rabbitmq', 'abbitMQ是一个在AMQP基础上完整的，可复用的企业消息系统。他遵循Mozilla Public License开源协议。\r\nMQ全称为Message Queue, 消息队列（MQ）是一种应用程序对应用程序的通信方法。应用程序通过读写出入队列的消息（针对应用程序的数据）来通信，而无需专用连接来链接它们。消 息传递指的是程序之间通过在消息中发送数据进行通信，而不是通过直接调用彼此来通信，直接调用通常是用于诸如远程过程调用的技术。排队指的是应用程序通过 队列来通信。队列的使用除去了接收和发送应用程序同时执行的要求。\r\n\r\nRabbitMQ安装\r\n\r\n1.linux\r\n安装配置epel源\r\n$ rpm -ivh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm\r\n安装erlang\r\n$ yum -y install erlang\r\n安装RabbitMQ\r\n$ yum -y install rabbitmq-server\r\nservice rabbitmq-server start/stop', '2018-06-04', '2018-06-04', 'abbitMQ是一个在AMQP基础上完整的，可复用的企业消息系统。他遵循Mozilla Public Lic', 2, 1, 4);
INSERT INTO `blog_post` VALUES (7, '开始rabbitMQ', '开始rabbitMQ\r\n对于RabbitMQ来说，生产和消费不再针对内存里的一个Queue对象，而是某台服务器上的RabbitMQ Server实现的消息队列。\r\n\r\n一、最基本的生产者消费者\r\n1.生产者代码\r\n```python\r\n#!/usr/bin/env python\r\nimport pika\r\n# ######################### 生产者 #########################\r\n#链接rabbit服务器（localhost是本机，如果是其他服务器请修改为ip地址）\r\nconnection = pika.BlockingConnection(pika.ConnectionParameters(host=\'localhost\'))\r\n#创建频道\r\nchannel = connection.channel()\r\n#创建一个队列名叫hello\r\nchannel.queue_declare(queue=\'hello\')\r\n#exchange -- 它使我们能够确切地指定消息应该到哪个队列去。\r\n#向队列插入数值 routing_key是队列名 body是要插入的内容\r\n\r\nchannel.basic_publish(exchange=\'\',\r\n                  routing_key=\'hello\',\r\n                  body=\'Hello World!\')\r\nprint(\"开始队列\")\r\n#缓冲区已经flush而且消息已经确认发送到了RabbitMQ中，关闭链接\r\nconnection.close()\r\n```', '2018-06-04', '2018-06-04', '开始rabbitMQ\n对于RabbitMQ来说，生产和消费不再针对内存里的一个Queue对象，而是某台服务器', 2, 1, 2);
INSERT INTO `blog_post` VALUES (8, '测试分页1', '测试分页1', '2018-06-04', '2018-06-04', '测试分页1', 2, 1, 0);
INSERT INTO `blog_post` VALUES (9, '测试分页2', '测试分页2', '2018-06-04', '2018-06-04', '测试分页2', 2, 1, 0);
INSERT INTO `blog_post` VALUES (10, '测试分页2', '测试分页3', '2018-06-04', '2018-06-04', '测试分页3', 2, 1, 0);
INSERT INTO `blog_post` VALUES (11, '测试分页4', '测试分页4', '2018-06-04', '2018-06-04', '测试分页4', 2, 1, 0);
INSERT INTO `blog_post` VALUES (12, '测试分页4', '测试分页5', '2018-06-04', '2018-06-04', '测试分页5', 2, 1, 0);
INSERT INTO `blog_post` VALUES (13, '测试分页6', '测试分页6', '2018-06-04', '2018-06-04', '测试分页6', 2, 2, 1);
INSERT INTO `blog_post` VALUES (14, '测试分页8', '测试分页8', '2018-06-04', '2018-06-04', '测试分页8', 2, 1, 0);
INSERT INTO `blog_post` VALUES (15, '测试分页9', '测试分页9', '2018-06-04', '2018-06-04', '测试分页9', 2, 1, 0);
INSERT INTO `blog_post` VALUES (16, '测试分页10', '测试分页10', '2018-06-04', '2018-06-04', '测试分页10', 2, 1, 0);
INSERT INTO `blog_post` VALUES (17, '测试分页11', '测试分页11', '2018-06-04', '2018-06-04', '测试分页11', 2, 1, 0);
INSERT INTO `blog_post` VALUES (18, '测试分页14', '测试分页14', '2018-06-04', '2018-06-04', '测试分页14', 2, 1, 0);
INSERT INTO `blog_post` VALUES (19, '标签云', '标签云测试', '2018-06-04', '2018-06-04', '标签云测试', 2, 3, 0);
INSERT INTO `blog_post` VALUES (20, '标签云测试2', '标签云测试2', '2018-06-04', '2018-06-04', '标签云测试2', 2, 3, 4);
COMMIT;

-- ----------------------------
-- Table structure for blog_post_tags
-- ----------------------------
DROP TABLE IF EXISTS `blog_post_tags`;
CREATE TABLE `blog_post_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_post_tags_post_id_4925ec37_uniq` (`post_id`,`tag_id`),
  KEY `blog_post_tags_tag_id_0875c551_fk_blog_tag_id` (`tag_id`),
  CONSTRAINT `blog_post_tags_post_id_a1c71c8a_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`),
  CONSTRAINT `blog_post_tags_tag_id_0875c551_fk_blog_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_post_tags
-- ----------------------------
BEGIN;
INSERT INTO `blog_post_tags` VALUES (1, 1, 1);
INSERT INTO `blog_post_tags` VALUES (2, 2, 1);
INSERT INTO `blog_post_tags` VALUES (3, 3, 2);
INSERT INTO `blog_post_tags` VALUES (4, 19, 1);
INSERT INTO `blog_post_tags` VALUES (5, 20, 3);
COMMIT;

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
BEGIN;
INSERT INTO `blog_tag` VALUES (1, '测试');
INSERT INTO `blog_tag` VALUES (2, 'markdown');
INSERT INTO `blog_tag` VALUES (3, '标签云');
COMMIT;

-- ----------------------------
-- Table structure for comments_comment
-- ----------------------------
DROP TABLE IF EXISTS `comments_comment`;
CREATE TABLE `comments_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `url` varchar(200) NOT NULL,
  `text` longtext NOT NULL,
  `created_time` date NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_comment_post_id_96a9ac05_fk_blog_post_id` (`post_id`),
  CONSTRAINT `comments_comment_post_id_96a9ac05_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comments_comment
-- ----------------------------
BEGIN;
INSERT INTO `comments_comment` VALUES (1, 'chris', 'chrisli129@gmail.com', 'http://www.coolinux.cn', '测试评论\r\n哈哈哈哈哈哈哈哈哈', '2018-04-13', 1);
INSERT INTO `comments_comment` VALUES (2, 'chris', 'chrisli129@gmail.com', 'http://www.coolinux.cn', '评论测试', '2018-05-22', 1);
COMMIT;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `django_admin_log` VALUES (1, '2018-04-13 03:04:08.026276', '1', '测试', 1, '[{\"added\": {}}]', 9, 2);
INSERT INTO `django_admin_log` VALUES (2, '2018-04-13 03:04:11.886859', '1', '测试', 1, '[{\"added\": {}}]', 7, 2);
INSERT INTO `django_admin_log` VALUES (3, '2018-04-13 03:04:15.282427', '1', '第一篇文章', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (4, '2018-04-13 03:04:41.733262', '2', '第二篇文章', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (5, '2018-04-13 03:06:04.867121', '2', 'markdown', 1, '[{\"added\": {}}]', 9, 2);
INSERT INTO `django_admin_log` VALUES (6, '2018-04-13 03:06:13.872548', '2', 'markdown', 1, '[{\"added\": {}}]', 7, 2);
INSERT INTO `django_admin_log` VALUES (7, '2018-04-13 03:06:17.272696', '3', 'markdown测试', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (8, '2018-04-13 03:06:38.683257', '3', 'markdown测试', 2, '[{\"changed\": {\"fields\": [\"body\"]}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (9, '2018-04-13 03:07:04.052731', '3', 'markdown测试', 2, '[{\"changed\": {\"fields\": [\"body\"]}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (10, '2018-04-13 03:07:28.847494', '3', 'markdown测试', 2, '[{\"changed\": {\"fields\": [\"body\"]}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (11, '2018-04-13 03:44:31.913604', '3', 'markdown测试', 2, '[{\"changed\": {\"fields\": [\"body\"]}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (12, '2018-04-13 03:45:02.297644', '3', 'markdown测试', 2, '[{\"changed\": {\"fields\": [\"body\"]}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (13, '2018-04-13 03:45:11.889096', '3', 'markdown测试', 2, '[{\"changed\": {\"fields\": [\"body\"]}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (14, '2018-04-13 03:45:21.349379', '3', 'markdown测试', 2, '[]', 8, 2);
INSERT INTO `django_admin_log` VALUES (15, '2018-06-04 05:21:47.993631', '4', '第三篇文章', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (16, '2018-06-04 05:23:13.132536', '5', 'python邮件测试', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (17, '2018-06-04 05:33:41.698261', '6', 'python笔记之Rabbitmq', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (18, '2018-06-04 05:34:39.960221', '7', '开始rabbitMQ', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (19, '2018-06-04 05:41:26.510105', '8', '测试分页1', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (20, '2018-06-04 05:41:35.073545', '9', '测试分页2', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (21, '2018-06-04 05:41:44.021540', '10', '测试分页2', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (22, '2018-06-04 05:41:53.489351', '11', '测试分页4', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (23, '2018-06-04 05:42:02.630909', '12', '测试分页4', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (24, '2018-06-04 05:42:13.608204', '13', '测试分页6', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (25, '2018-06-04 05:42:29.349155', '14', '测试分页8', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (26, '2018-06-04 05:42:39.924120', '15', '测试分页9', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (27, '2018-06-04 05:42:50.278934', '16', '测试分页10', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (28, '2018-06-04 05:43:05.015227', '17', '测试分页11', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (29, '2018-06-04 05:43:14.953660', '18', '测试分页14', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (30, '2018-06-04 07:27:57.233524', '3', '标签云', 1, '[{\"added\": {}}]', 9, 2);
INSERT INTO `django_admin_log` VALUES (31, '2018-06-04 07:28:04.539028', '19', '标签云', 1, '[{\"added\": {}}]', 8, 2);
INSERT INTO `django_admin_log` VALUES (32, '2018-06-04 07:39:30.671251', '3', '标签云', 1, '[{\"added\": {}}]', 7, 2);
INSERT INTO `django_admin_log` VALUES (33, '2018-06-04 07:39:37.314569', '20', '标签云测试2', 1, '[{\"added\": {}}]', 8, 2);
COMMIT;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (9, 'blog', 'category');
INSERT INTO `django_content_type` VALUES (8, 'blog', 'post');
INSERT INTO `django_content_type` VALUES (7, 'blog', 'tag');
INSERT INTO `django_content_type` VALUES (10, 'comments', 'comment');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2018-04-13 03:00:53.635698');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2018-04-13 03:00:53.915126');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2018-04-13 03:00:53.975928');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2018-04-13 03:00:53.998397');
INSERT INTO `django_migrations` VALUES (5, 'contenttypes', '0002_remove_content_type_name', '2018-04-13 03:00:54.074231');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0002_alter_permission_name_max_length', '2018-04-13 03:00:54.099099');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0003_alter_user_email_max_length', '2018-04-13 03:00:54.132867');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0004_alter_user_username_opts', '2018-04-13 03:00:54.143866');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0005_alter_user_last_login_null', '2018-04-13 03:00:54.166538');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0006_require_contenttypes_0002', '2018-04-13 03:00:54.171032');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0007_alter_validators_add_error_messages', '2018-04-13 03:00:54.184126');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0008_alter_user_username_max_length', '2018-04-13 03:00:54.209503');
INSERT INTO `django_migrations` VALUES (13, 'blog', '0001_initial', '2018-04-13 03:00:54.370241');
INSERT INTO `django_migrations` VALUES (14, 'sessions', '0001_initial', '2018-04-13 03:00:54.398624');
INSERT INTO `django_migrations` VALUES (15, 'comments', '0001_initial', '2018-04-13 07:45:29.134868');
INSERT INTO `django_migrations` VALUES (16, 'comments', '0002_auto_20180413_1653', '2018-04-13 08:53:27.700365');
INSERT INTO `django_migrations` VALUES (17, 'blog', '0002_auto_20180416_2045', '2018-05-29 05:46:40.210304');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` VALUES ('g653bm8y66oj34k85ligd3dgj26w9fc6', 'ZDk0ZWE0N2NkNzM3MzNmMzRkNWQ3YzY3YTZlNmUxNWExODA5MTRkNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYmYxZjcwZGI2Y2Y5ODMwYmM3N2ZhYzAxOTc1ZDY1MDlmODExZmI1In0=', '2018-06-18 05:21:06.132690');
INSERT INTO `django_session` VALUES ('zgqrm7c0trg74kzmo5aoo5vpy1x9buz0', 'ZDk0ZWE0N2NkNzM3MzNmMzRkNWQ3YzY3YTZlNmUxNWExODA5MTRkNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYmYxZjcwZGI2Y2Y5ODMwYmM3N2ZhYzAxOTc1ZDY1MDlmODExZmI1In0=', '2018-04-27 03:02:26.554260');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
