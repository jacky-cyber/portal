-- phpMyAdmin SQL Dump
-- version 4.4.7
-- http://www.phpmyadmin.net
--
-- Host: 192.168.6.95:3306
-- Generation Time: Jun 02, 2015 at 10:21 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.12-2ubuntu4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
set foreign_key_checks=0;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `portal2`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`yu`@`%` FUNCTION `currval`(seq_name VARCHAR(50)) RETURNS varchar(40) CHARSET utf8
BEGIN
DECLARE valuep VARCHAR(40);
SELECT current_value INTO valuep FROM t_sequence WHERE NAME = seq_name; UPDATE t_sequence SET current_value = current_value + 1 WHERE NAME = seq_name;
RETURN valuep;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `c3p0_test_donot_delete`
--

CREATE TABLE IF NOT EXISTS `c3p0_test_donot_delete` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_address`
--

CREATE TABLE IF NOT EXISTS `jc_address` (
  `Id` bigint(20) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父节点',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '城市名称',
  `priority` int(11) DEFAULT '10' COMMENT '排序'
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='省、市、县表';

--
-- Dumping data for table `jc_address`
--

INSERT INTO `jc_address` (`Id`, `parent_id`, `name`, `priority`) VALUES
(1, NULL, '江西省', 1),
(7, 1, '南昌', 10),
(8, 7, '西湖区', 10),
(9, NULL, '安徽省', 10),
(10, NULL, '北京市', 10),
(11, NULL, '上海市', 2),
(12, 1, '抚州市', NULL),
(13, 12, '南丰县', NULL),
(14, 12, '南城县', NULL),
(15, 10, '通州区', NULL),
(16, 15, '中仓街道', NULL),
(17, 11, '黄浦区', NULL),
(18, 17, '南京东路区域', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_admin`
--

CREATE TABLE IF NOT EXISTS `jc_core_admin` (
  `admin_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_viewonly_admin` tinyint(3) DEFAULT '0' COMMENT '是否只读用户'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='核心管理员表';

--
-- Dumping data for table `jc_core_admin`
--

INSERT INTO `jc_core_admin` (`admin_id`, `website_id`, `user_id`, `create_time`, `is_disabled`, `is_viewonly_admin`) VALUES
(1, 1, 1, '2009-06-13 00:00:00', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_admin_role`
--

CREATE TABLE IF NOT EXISTS `jc_core_admin_role` (
  `role_id` int(11) NOT NULL DEFAULT '0',
  `admin_id` bigint(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jc_core_admin_role`
--

INSERT INTO `jc_core_admin_role` (`role_id`, `admin_id`) VALUES
(1, 1),
(1, 30),
(1, 31),
(1, 32),
(1, 33),
(1, 37),
(1, 41),
(1, 42),
(1, 44),
(1, 45),
(1, 46),
(1, 47),
(1, 48),
(1, 49),
(1, 50),
(1, 58),
(1, 59),
(1, 60),
(1, 61),
(1, 62),
(1, 63),
(1, 65),
(1, 66),
(1, 72),
(1, 74),
(1, 75),
(2, 48),
(3, 67),
(4, 68);

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_global`
--

CREATE TABLE IF NOT EXISTS `jc_core_global` (
  `global_id` bigint(20) NOT NULL,
  `context_path` varchar(20) DEFAULT NULL COMMENT '部署路径',
  `port` int(11) DEFAULT NULL COMMENT '端口号',
  `treaty` longtext COMMENT '用户协议',
  `activescore` int(11) NOT NULL COMMENT '激活积分',
  `stock_warning` int(11) NOT NULL DEFAULT '5' COMMENT '库存预警值',
  `def_img` varchar(255) NOT NULL DEFAULT '/r/gou/u/no_picture.gif' COMMENT '图片不存在时默认图片'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='核心全局表';

--
-- Dumping data for table `jc_core_global`
--

INSERT INTO `jc_core_global` (`global_id`, `context_path`, `port`, `treaty`, `activescore`, `stock_warning`, `def_img`) VALUES
(1, '', 8080, '<p><br />\n	&nbsp;</p>\n<p>&nbsp;</p>\n<table align="center" border="0" cellpadding="0" cellspacing="0" class="border_blue mt20" width="650">\n	<tbody>\n		<tr>\n			<td class="left_title2">\n				<strong class="blue14">服务协议</strong></td>\n		</tr>\n		<tr>\n			<td align="left" class="list_b">\n				<div class="Section1 mlr15" style="layout-grid:  15.6pt none">\n					<p>待修改------------</p>\n					<p>《服务协议》（以下简称&ldquo;本协议&rdquo;）是由上海益实多电子商务有限公司在提供域名为www.yihaodian.com（以下简称&ldquo;1号店&rdquo;）的网站服务时与1号店用户达成的关于使用1号店网站的各项规则、条款和条件。本协议在1号店用户接受注册时生效。<br />\n						请在成为1号店用户前，仔细阅读本协议中所述的所有规则、条款和条件，包括被本协议提及而纳入本协议的其他条款和条件。建议阅读本协议时，同时阅读本协议中提及的其他网页所包含的内容，因为其可能包含适用于1号店用户的其他条款和条件。<br />\n						<br />\n						<strong>一、</strong><strong> </strong><strong>用户注册：</strong><strong> </strong><br />\n						1. 用户注册是指用户登陆1号店网站，按要求填写相关信息并确认同意本服务协议的过程。用户因进行交易、获取有偿服务等而发生的所有应纳税赋由用户自行承担。<br />\n						2. 1号店用户必须是具有完全民事行为能力的自然人，或者是具有合法经营资格的实体组织。无民事行为能力人、限制民事行为能力人以及无经营或特定经营资格的组织不得注册为1号店用户或超过其民事权利或行为能力范围与1号店进行交易，如与1号店进行交易的，则服务协议自始无效，1号店有权立即停止与该用户的交易、注销该用户账户，并有权要求其承担相应法律责任。<br />\n						&nbsp;</p>\n				</div>\n			</td>\n		</tr>\n	</tbody>\n</table>\n<p>&nbsp;</p>', 10, 100, '/r/gou/u/no_picture.gif');

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_log`
--

CREATE TABLE IF NOT EXISTS `jc_core_log` (
  `log_id` int(11) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `website_id` bigint(20) DEFAULT NULL,
  `category` int(11) NOT NULL COMMENT '日志类型',
  `log_time` datetime NOT NULL COMMENT '日志时间',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL地址',
  `title` varchar(255) DEFAULT NULL COMMENT '日志标题',
  `content` varchar(255) DEFAULT NULL COMMENT '日志内容'
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='jspgou日志表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_member`
--

CREATE TABLE IF NOT EXISTS `jc_core_member` (
  `member_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_active` tinyint(1) NOT NULL COMMENT '是否激活',
  `activation_Code` char(32) DEFAULT NULL COMMENT '激活码'
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='核心会员表';

--
-- Dumping data for table `jc_core_member`
--

INSERT INTO `jc_core_member` (`member_id`, `user_id`, `website_id`, `create_time`, `is_disabled`, `is_active`, `activation_Code`) VALUES
(1, 1, 1, '2009-07-06 00:00:00', 0, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_message_tpl`
--

CREATE TABLE IF NOT EXISTS `jc_core_message_tpl` (
  `website_id` bigint(20) NOT NULL,
  `message_name` varchar(50) NOT NULL COMMENT '信息名称',
  `message_subject` varchar(255) DEFAULT NULL COMMENT '信息主题',
  `message_text` longtext COMMENT '信息内容',
  `active_title` varchar(255) DEFAULT NULL COMMENT '用户激活标题',
  `active_txt` longtext COMMENT '用户激活内容'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息模板';

--
-- Dumping data for table `jc_core_message_tpl`
--

INSERT INTO `jc_core_message_tpl` (`website_id`, `message_name`, `message_subject`, `message_text`, `active_title`, `active_txt`) VALUES
(1, 'resetPassword', '找回密码请求', '<p>您好</p>\r\n<p>${username}: 我们收到您的发出的找回密码请求。如果这不是您本人发出的请求，可以不予理会；如果您频繁收到这样的邮件，请尽快与管理员联系。</p>\r\n<p>新密码为：${resetPwd} 点击此地址，新密码即可生效：${base}/reset_password.jspx?uid=${uid}&amp;activationCode=${activationCode}</p>\r\n<p>百年老店</p>\r\n<table border="0" cellpadding="0" cellspacing="0" width="650">\r\n	<tbody>\r\n		<tr>\r\n			<td align="center" rowspan="2">\r\n				<a href="http://www.yihaodian.com?node=1&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="1"><img alt="" border="0" height="61" src="http://www.yihaodian.com/images/edm/logo.gif" title="1号店网上超市" width="65" /></a></td>\r\n			<td align="left" rowspan="2">\r\n				<a href="http://www.yihaodian.com?node=2&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="2"><img alt="" border="0" src="http://www.yihaodian.com/images/pengpeng/slogen.jpg" style="margin-top: 5px" /></a></td>\r\n			<td align="right" height="38">\r\n				<a href="http://www.yihaodian.com?node=3&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: underline" target="_blank" yihaodiannode="3">如果邮件没有显示，请点击此处&gt;&gt;</a></td>\r\n			<td>\r\n				&nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td align="right" style="color: #cccccc; font-size: 12px">\r\n				<img align="absMiddle" alt="" height="14" src="http://www.yihaodian.com/images/edm/icon1.gif" width="15" /> <a href="https://passport.yihaodian.com/passport/login_input.do?node=4&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="4">购物车</a> | <img align="absMiddle" alt="" height="14" src="http://www.yihaodian.com/images/edm/icon2.gif" width="15" /> <a href="http://www.yihaodian.com/cms/view.do?topicId=9864&amp;node=5&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="5">帮助中心</a> | <img align="absMiddle" alt="" height="14" src="http://www.yihaodian.com/images/edm/icon3.gif" width="15" /> <a href="http://www.yihaodian.com/usermanager/order/myIndex.do?node=6&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="6">我的账号</a> | <img alt="" border="0" height="14" src="http://www.yihaodian.com/images/tongxiao/wm/edm/sina-logo.jpg" width="15" /> <a href="http://weibo.com/yihaodian?node=7&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="7">新浪微博分享你购物快乐</a></td>\r\n			<td>\r\n				&nbsp;</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n<table border="0" cellpadding="0" cellspacing="0" style="margin-top: 2px; height: 28px; overflow: hidden" width="650">\r\n	<tbody>\r\n		<tr>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com?node=8&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="8">首页</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=5135&amp;merchant=1&amp;node=9&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="9">食品饮料</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=8644&amp;merchant=1&amp;node=10&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="10">进口食品</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=5009&amp;merchant=1&amp;node=11&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="11">美容护理</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=5117&amp;merchant=1&amp;node=12&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="12">母婴</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=5134&amp;merchant=1&amp;node=13&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="13">厨卫清洁</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/dajiadian?node=14&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="14">电器</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/shouji?node=15&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="15">手机数码</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/diannao?node=16&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="16">电脑</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/fuzhuang/clothes/index.action?merchant=1&amp;node=17&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="17">服饰</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=8704&amp;node=18&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="18">保健</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://search.yihaodian.com/s/c22906?node=19&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="19">钟表</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/tushu?node=20&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="20">图书音像</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/qiche?node=21&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="21">汽车生活</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/lipin?node=22&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="22">礼品卡</a></td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n<table border="0" cellpadding="0" cellspacing="0" width="650">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=23&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="1号店周年庆1千万热销单品免费领" yihaodiannode="23"><img alt="" border="0" height="203" src="http://www.yihaodian.com/images/tongxiao/lp/0704_1.jpg" style="vertical-align: bottom" width="650" /></a></td>\r\n		</tr>\r\n		<tr>\r\n			<td style="background: #c00102">\r\n				<div style="border-bottom: #addd28 12px solid; border-left: #addd28 12px solid; padding-bottom: 5px; margin: 0px 8px; padding-left: 0px; width: 608px; padding-right: 0px; background: #fff; border-top: #addd28 12px solid; border-right: #addd28 12px solid; padding-top: 5px">\r\n					<table border="0" cellpadding="0" cellspacing="0" style="background: #fff" width="100%">\r\n						<tbody>\r\n							<tr>\r\n								<td width="316">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=24&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="1号店周年庆1千万热销单品免费领" yihaodiannode="24"><img alt="" border="0" height="234" src="http://www.yihaodian.com/images/tongxiao/lp/0704_2.jpg" style="vertical-align: bottom" width="316" /></a></td>\r\n								<td align="left">\r\n									<table align="center" border="0" cellpadding="0" cellspacing="0" style="line-height: 22px; font-family: ''微软雅黑''; font-size: 12px" width="85%">\r\n										<tbody>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=25&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="25">A：蒙牛特仑苏纯牛奶250ml/包 X 3 组合装</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=26&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="26">B：Paiter鼻毛修剪器</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=27&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="27">C：李锦记卤水汁115ml</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=28&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="28">D：丝路宝典(新疆红马奶葡萄干220g）</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=29&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="29">E：凌仕 男士醒体沐浴露-诱因 50ml</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<div align="right"><a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=30&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="30">领取更多免费商品</a><br />\r\n														<br />\r\n														1号店店粉们,每天免费商品有变化,需天天关注</div>\r\n												</td>\r\n											</tr>\r\n										</tbody>\r\n									</table>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="background: #c00102">\r\n				<div style="border-bottom: #ef5608 12px solid; border-left: #ef5608 12px solid; padding-bottom: 5px; margin: 10px 8px; padding-left: 0px; width: 608px; padding-right: 0px; font-family: ''微软雅黑''; background: #fff; font-size: 14px; border-top: #ef5608 12px solid; font-weight: bold; border-right: #ef5608 12px solid; padding-top: 5px">\r\n					<table border="0" cellpadding="0" cellspacing="0" style="background: #fff" width="100%">\r\n						<tbody>\r\n							<tr>\r\n								<td align="center" width="18%">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=31&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="iPhone4S (16G黑)非合约版4688元 （限50件）" yihaodiannode="31"><img alt="" border="0" height="117" src="http://www.yihaodian.com/images/tongxiao/lp/0704_3.jpg" style="vertical-align: bottom" width="84" /></a></td>\r\n								<td width="30%">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=32&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="32">iPhone4S (16G黑)非合约版</a><br />\r\n									<span style="color: #ef5608">4688元（限50件）</span></td>\r\n								<td width="52%">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=33&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="iPad2 16G WIFI版 白色2578元(限392件)" yihaodiannode="33"><img alt="" border="0" height="139" src="http://www.yihaodian.com/images/tongxiao/lp/0704_4.jpg" style="vertical-align: bottom" width="295" /></a></td>\r\n							</tr>\r\n							<tr>\r\n								<td>\r\n									&nbsp;</td>\r\n								<td>\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=34&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="限时抢" yihaodiannode="34"><img alt="" border="0" height="46" src="http://www.yihaodian.com/images/tongxiao/lp/0704_5.jpg" style="vertical-align: bottom" width="143" /></a></td>\r\n								<td style="padding-left: 100px">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=35&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="35">iPad2 16G WIFI版 白色</a><br />\r\n									<span style="color: #ef5608">2578元（限392件）</span></td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<img alt="" border="0" height="118" src="http://www.yihaodian.com/images/100104/EDM/20120601093427_01.jpg" width="650" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td align="left" height="26" style="line-height: 20px; padding-left: 15px; color: #666666; font-size: 12px">\r\n				4. 您如果不愿收到邮件，请<a href="http://www.yihaodian.com/subscriber/unsubscribe.do?email=1244860016%40qq.com&amp;&amp;node=36&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; text-decoration: underline" yihaodiannode="36">点击这里</a>退订邮件。</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n<p style="background-color: #dc3538; margin: 0px; width: 650px; display: block; font-family: Arial, Helvetica, sans-serif; color: #ffffff; font-size: 12px; padding-top: 5px"><a href="http://www.yihaodian.com/cms/view.do?topicId=8101&amp;node=37&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; text-decoration: none" target="_blank" yihaodiannode="37">1号店 只为更好的生活</a></p>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; <img alt="" height="8" src="http://www.yihaodian.com/images/edm/img_bottom.gif" style="display: block" width="650" /> <img alt="" src="http://tracker.yihaodian.com/tracker/info.do?1=1&amp;edmActivity=Y" style="display: block" width="0" /></p>', '欢迎您注册金融云平台用户', '<p>${userName}您好：</p>\r\n<p>欢迎您注册金融云平台系统会员请点击以下链接进行激活 ${base}/active.jspx?userName=${userName}&amp;activationCode=${activationCode}</p>\r\n<p>请在24小时内进行激活，否则注册无效。</p>\r\n<p>&nbsp;</p>\r\n<table border="0" cellpadding="0" cellspacing="0" width="650">\r\n	<tbody>\r\n		<tr>\r\n			<td align="center" rowspan="2">\r\n				<a href="http://www.yihaodian.com?node=1&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="1"><img alt="" border="0" height="61" src="http://www.yihaodian.com/images/edm/logo.gif" title="1号店网上超市" width="65" /></a></td>\r\n			<td align="left" rowspan="2">\r\n				<a href="http://www.yihaodian.com?node=2&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="2"><img alt="" border="0" src="http://www.yihaodian.com/images/pengpeng/slogen.jpg" style="margin-top: 5px" /></a></td>\r\n			<td align="right" height="38">\r\n				<a href="http://www.yihaodian.com?node=3&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: underline" target="_blank" yihaodiannode="3">如果邮件没有显示，请点击此处&gt;&gt;</a></td>\r\n			<td>\r\n				&nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td align="right" style="color: #cccccc; font-size: 12px">\r\n				<img align="absMiddle" alt="" height="14" src="http://www.yihaodian.com/images/edm/icon1.gif" width="15" /> <a href="https://passport.yihaodian.com/passport/login_input.do?node=4&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="4">购物车</a> | <img align="absMiddle" alt="" height="14" src="http://www.yihaodian.com/images/edm/icon2.gif" width="15" /> <a href="http://www.yihaodian.com/cms/view.do?topicId=9864&amp;node=5&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="5">帮助中心</a> | <img align="absMiddle" alt="" height="14" src="http://www.yihaodian.com/images/edm/icon3.gif" width="15" /> <a href="http://www.yihaodian.com/usermanager/order/myIndex.do?node=6&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="6">我的账号</a> | <img alt="" border="0" height="14" src="http://www.yihaodian.com/images/tongxiao/wm/edm/sina-logo.jpg" width="15" /> <a href="http://weibo.com/yihaodian?node=7&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="7">新浪微博分享你购物快乐</a></td>\r\n			<td>\r\n				&nbsp;</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>&nbsp;</p>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n<p>&nbsp;</p>\r\n<table border="0" cellpadding="0" cellspacing="0" style="margin-top: 2px; height: 28px; overflow: hidden" width="650">\r\n	<tbody>\r\n		<tr>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com?node=8&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="8">首页</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=5135&amp;merchant=1&amp;node=9&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="9">食品饮料</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=8644&amp;merchant=1&amp;node=10&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="10">进口食品</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=5009&amp;merchant=1&amp;node=11&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="11">美容护理</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=5117&amp;merchant=1&amp;node=12&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="12">母婴</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=5134&amp;merchant=1&amp;node=13&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="13">厨卫清洁</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/dajiadian?node=14&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="14">电器</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/shouji?node=15&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="15">手机数码</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/diannao?node=16&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="16">电脑</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/fuzhuang/clothes/index.action?merchant=1&amp;node=17&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="17">服饰</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://www.yihaodian.com/channel/channelPage.do?channelId=8704&amp;node=18&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="18">保健</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://search.yihaodian.com/s/c22906?node=19&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="19">钟表</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/tushu?node=20&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="20">图书音像</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/qiche?node=21&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="21">汽车生活</a></td>\r\n			<td align="center">\r\n				<img alt="" height="12" src="http://www.yihaodian.com/images/edm/nav_bg.gif" width="2" /></td>\r\n			<td align="center">\r\n				<a href="http://channel.yihaodian.com/lipin?node=22&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; font-size: 12px; text-decoration: none" target="_blank" yihaodiannode="22">礼品卡</a></td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>&nbsp;</p>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n<p>&nbsp;</p>\r\n<table border="0" cellpadding="0" cellspacing="0" width="650">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=23&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="1号店周年庆1千万热销单品免费领" yihaodiannode="23"><img alt="" border="0" height="203" src="http://www.yihaodian.com/images/tongxiao/lp/0704_1.jpg" style="vertical-align: bottom" width="650" /></a></td>\r\n		</tr>\r\n		<tr>\r\n			<td style="background: #c00102">\r\n				<div style="border-bottom: #addd28 12px solid; border-left: #addd28 12px solid; padding-bottom: 5px; margin: 0px 8px; padding-left: 0px; width: 608px; padding-right: 0px; background: #fff; border-top: #addd28 12px solid; border-right: #addd28 12px solid; padding-top: 5px">\r\n					<table border="0" cellpadding="0" cellspacing="0" style="background: #fff" width="100%">\r\n						<tbody>\r\n							<tr>\r\n								<td width="316">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=24&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="1号店周年庆1千万热销单品免费领" yihaodiannode="24"><img alt="" border="0" height="234" src="http://www.yihaodian.com/images/tongxiao/lp/0704_2.jpg" style="vertical-align: bottom" width="316" /></a></td>\r\n								<td align="left">\r\n									<table align="center" border="0" cellpadding="0" cellspacing="0" style="line-height: 22px; font-family: ''微软雅黑''; font-size: 12px" width="85%">\r\n										<tbody>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=25&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="25">A：蒙牛特仑苏纯牛奶250ml/包 X 3 组合装</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=26&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="26">B：Paiter鼻毛修剪器</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=27&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="27">C：李锦记卤水汁115ml</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=28&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="28">D：丝路宝典(新疆红马奶葡萄干220g）</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=29&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="29">E：凌仕 男士醒体沐浴露-诱因 50ml</a></td>\r\n											</tr>\r\n											<tr>\r\n												<td>\r\n													<div align="right"><a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=30&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="30">领取更多免费商品</a><br />\r\n														<br />\r\n														1号店店粉们,每天免费商品有变化,需天天关注</div>\r\n												</td>\r\n											</tr>\r\n										</tbody>\r\n									</table>\r\n								</td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="background: #c00102">\r\n				<div style="border-bottom: #ef5608 12px solid; border-left: #ef5608 12px solid; padding-bottom: 5px; margin: 10px 8px; padding-left: 0px; width: 608px; padding-right: 0px; font-family: ''微软雅黑''; background: #fff; font-size: 14px; border-top: #ef5608 12px solid; font-weight: bold; border-right: #ef5608 12px solid; padding-top: 5px">\r\n					<table border="0" cellpadding="0" cellspacing="0" style="background: #fff" width="100%">\r\n						<tbody>\r\n							<tr>\r\n								<td align="center" width="18%">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=31&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="iPhone4S (16G黑)非合约版4688元 （限50件）" yihaodiannode="31"><img alt="" border="0" height="117" src="http://www.yihaodian.com/images/tongxiao/lp/0704_3.jpg" style="vertical-align: bottom" width="84" /></a></td>\r\n								<td width="30%">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=32&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="32">iPhone4S (16G黑)非合约版</a><br />\r\n									<span style="color: #ef5608">4688元（限50件）</span></td>\r\n								<td width="52%">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=33&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="iPad2 16G WIFI版 白色2578元(限392件)" yihaodiannode="33"><img alt="" border="0" height="139" src="http://www.yihaodian.com/images/tongxiao/lp/0704_4.jpg" style="vertical-align: bottom" width="295" /></a></td>\r\n							</tr>\r\n							<tr>\r\n								<td>\r\n									&nbsp;</td>\r\n								<td>\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=34&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" title="限时抢" yihaodiannode="34"><img alt="" border="0" height="46" src="http://www.yihaodian.com/images/tongxiao/lp/0704_5.jpg" style="vertical-align: bottom" width="143" /></a></td>\r\n								<td style="padding-left: 100px">\r\n									<a href="http://www.yihaodian.com/cmsPage/show.do?pageId=6558&amp;node=35&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" target="_blank" yihaodiannode="35">iPad2 16G WIFI版 白色</a><br />\r\n									<span style="color: #ef5608">2578元（限392件）</span></td>\r\n							</tr>\r\n						</tbody>\r\n					</table>\r\n				</div>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<img alt="" border="0" height="118" src="http://www.yihaodian.com/images/100104/EDM/20120601093427_01.jpg" width="650" /></td>\r\n		</tr>\r\n		<tr>\r\n			<td align="left" height="26" style="line-height: 20px; padding-left: 15px; color: #666666; font-size: 12px">\r\n				4. 您如果不愿收到邮件，请<a href="http://www.yihaodian.com/subscriber/unsubscribe.do?email=1244860016%40qq.com&amp;&amp;node=36&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #666666; text-decoration: underline" yihaodiannode="36">点击这里</a>退订邮件。</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>&nbsp;</p>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\r\n<p style="background-color: #dc3538; margin: 0px; width: 650px; display: block; font-family: Arial, Helvetica, sans-serif; color: #ffffff; font-size: 12px; padding-top: 5px"><a href="http://www.yihaodian.com/cms/view.do?topicId=8101&amp;node=37&amp;templateid=12284&amp;tracker_u=3310&amp;tracker_src=24635&amp;website_id=24635&amp;tracker_type=5&amp;edmEmail=1244860016@qq.com&amp;userid=117046088&amp;randNum=&amp;couponNum=null&amp;userName=1%E5%8F%B7%E5%BA%97%E7%94%A8%E6%88%B7" style="color: #ffffff; text-decoration: none" target="_blank" yihaodiannode="37">1号店 只为更好的生活</a></p>\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; <img alt="" height="8" src="http://www.yihaodian.com/images/edm/img_bottom.gif" style="display: block" width="650" /> <img alt="" src="http://tracker.yihaodian.com/tracker/info.do?1=1&amp;edmActivity=Y" style="display: block" width="0" /></p>');

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_role`
--

CREATE TABLE IF NOT EXISTS `jc_core_role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `priority` int(11) DEFAULT '10' COMMENT '排列顺序',
  `is_super` char(1) DEFAULT '0' COMMENT '拥有所有权限'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jc_core_role`
--

INSERT INTO `jc_core_role` (`role_id`, `role_name`, `priority`, `is_super`) VALUES
(1, '管理员', 10, '1'),
(3, '渠道', 10, '0'),
(4, '商户操作员', 10, '0');

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_role_permission`
--

CREATE TABLE IF NOT EXISTS `jc_core_role_permission` (
  `role_id` int(11) NOT NULL DEFAULT '0',
  `uri` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色授权表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_user`
--

CREATE TABLE IF NOT EXISTS `jc_core_user` (
  `user_id` bigint(20) NOT NULL,
  `username` varchar(100) NOT NULL COMMENT '登录名',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `password` char(32) NOT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `login_count` bigint(20) DEFAULT '0' COMMENT '总共登录次数',
  `register_ip` varchar(50) DEFAULT NULL COMMENT '注册IP',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) DEFAULT NULL COMMENT '最后登录IP',
  `current_login_time` datetime DEFAULT NULL COMMENT '当前登录时间',
  `current_login_ip` varchar(50) DEFAULT NULL COMMENT '当前登录IP',
  `reset_key` char(32) DEFAULT NULL COMMENT '找回密码KEY',
  `reset_pwd` char(10) DEFAULT NULL COMMENT '重置密码',
  `errTime` datetime DEFAULT NULL COMMENT '登入错误时间',
  `errCount` int(11) DEFAULT '0' COMMENT '登入错误次数',
  `channelId` varchar(60) DEFAULT NULL COMMENT '渠道id',
  `commerceId` varchar(60) DEFAULT NULL COMMENT '商户id',
  `channelName` varchar(20) DEFAULT NULL COMMENT '渠道名称',
  `commerceName` varchar(20) DEFAULT NULL COMMENT '商户名称',
  `store_front` varchar(60) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='统一用户表';

--
-- Dumping data for table `jc_core_user`
--

INSERT INTO `jc_core_user` (`user_id`, `username`, `email`, `password`, `create_time`, `login_count`, `register_ip`, `last_login_time`, `last_login_ip`, `current_login_time`, `current_login_ip`, `reset_key`, `reset_pwd`, `errTime`, `errCount`, `channelId`, `commerceId`, `channelName`, `commerceName`, `store_front`) VALUES
(1, 'admin', 'admin@hotmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', '2009-08-22 00:00:00', 4043, NULL, '2015-06-02 10:18:17', '127.0.0.1', '2015-06-02 10:19:21', '172.17.42.1', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jc_core_website`
--

CREATE TABLE IF NOT EXISTS `jc_core_website` (
  `website_id` bigint(20) NOT NULL,
  `admin_id` bigint(20) DEFAULT NULL COMMENT '创始人ID',
  `global_id` bigint(20) NOT NULL COMMENT '全局表ID',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父站点ID',
  `domain` varchar(100) NOT NULL COMMENT '域名',
  `name` varchar(150) NOT NULL COMMENT '站点名称',
  `additionalTitle` varchar(255) DEFAULT NULL COMMENT '附加标题',
  `current_system` varchar(20) NOT NULL COMMENT '当前系统（jeecms,jeeshop,jeeshop）',
  `suffix` varchar(20) NOT NULL DEFAULT '.jhtml' COMMENT '访问后缀',
  `lft` int(11) NOT NULL DEFAULT '1' COMMENT '树左边',
  `rgt` int(11) NOT NULL DEFAULT '2' COMMENT '树右边',
  `create_time` datetime NOT NULL COMMENT '站点创建时间',
  `base_domain` varchar(100) DEFAULT NULL COMMENT '根域名',
  `domain_alias` varchar(255) DEFAULT NULL COMMENT '多个别名用;分割',
  `short_name` varchar(20) DEFAULT NULL COMMENT '站点简称',
  `close_reason` varchar(255) DEFAULT '' COMMENT '关闭原因',
  `is_close` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否关闭网站（后台仍可访问）',
  `front_encoding` varchar(20) NOT NULL DEFAULT 'GBK' COMMENT '前台编码',
  `front_content_type` varchar(50) NOT NULL DEFAULT 'text/html; charset=gb2312' COMMENT '前台Content-Type',
  `locale_front` varchar(20) NOT NULL DEFAULT 'zh_CN' COMMENT '前台本地化信息',
  `locale_admin` varchar(20) NOT NULL DEFAULT 'zh_CN' COMMENT '后台本地化信息',
  `control_reserved` longtext COMMENT '用户信息保留字',
  `control_name_minlen` int(11) NOT NULL DEFAULT '4' COMMENT '用户名最短几个字符',
  `control_front_ips` longtext COMMENT '前台允许访问的IP',
  `control_admin_ips` longtext COMMENT '后台允许访问的IP',
  `company` varchar(255) NOT NULL DEFAULT '' COMMENT '公司名称',
  `copyright` varchar(255) NOT NULL DEFAULT '' COMMENT '版权信息',
  `record_code` varchar(255) NOT NULL DEFAULT '' COMMENT '备案号',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `phone` varchar(255) NOT NULL DEFAULT '' COMMENT '电话号码',
  `mobile` varchar(255) NOT NULL DEFAULT '' COMMENT '手机号码',
  `is_relative_path` tinyint(1) NOT NULL DEFAULT '0' COMMENT '使用相对路径',
  `email_host` varchar(50) DEFAULT NULL COMMENT '邮件发送服务器',
  `email_encoding` varchar(20) DEFAULT NULL COMMENT '邮件发送编码',
  `email_username` varchar(100) DEFAULT NULL COMMENT '邮箱用户名',
  `email_personal` varchar(100) DEFAULT NULL COMMENT '邮箱发件人',
  `email_password` varchar(100) DEFAULT NULL COMMENT '邮箱密码',
  `version` varchar(255) DEFAULT NULL COMMENT '版本信息',
  `restart` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='站点表';

--
-- Dumping data for table `jc_core_website`
--

INSERT INTO `jc_core_website` (`website_id`, `admin_id`, `global_id`, `parent_id`, `domain`, `name`, `additionalTitle`, `current_system`, `suffix`, `lft`, `rgt`, `create_time`, `base_domain`, `domain_alias`, `short_name`, `close_reason`, `is_close`, `front_encoding`, `front_content_type`, `locale_front`, `locale_admin`, `control_reserved`, `control_name_minlen`, `control_front_ips`, `control_admin_ips`, `company`, `copyright`, `record_code`, `email`, `phone`, `mobile`, `is_relative_path`, `email_host`, `email_encoding`, `email_username`, `email_personal`, `email_password`, `version`, `restart`) VALUES
(1, 1, 1, NULL, 'dev.ifunpay.com/', 'portal开发站', '- Powered by JSPGOU', 'jspgou', '.htm', 1, 2, '2009-06-13 00:00:00', '', NULL, NULL, '网站暂时关闭', 0, 'GBK', 'text/html; charset=gbk', 'zh_CN', 'zh_CN', NULL, 4, NULL, NULL, '', '', '', '', '', '', 1, 'smtp.163.com', 'UTF-8', 'zhengjiang@ifunpay.com', '百年老店', 'password', '4.5', 0);

-- --------------------------------------------------------

--
-- Table structure for table `jc_data_backup`
--

CREATE TABLE IF NOT EXISTS `jc_data_backup` (
  `Id` int(11) NOT NULL,
  `dataBasePath` varchar(255) DEFAULT NULL COMMENT '数据库路径',
  `address` varchar(255) DEFAULT NULL COMMENT '数据库地址',
  `dataBaseName` varchar(255) DEFAULT NULL COMMENT '数据库名称',
  `username` varchar(255) DEFAULT NULL COMMENT '数据库用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '数据库密码'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='数据备份信息';

--
-- Dumping data for table `jc_data_backup`
--

INSERT INTO `jc_data_backup` (`Id`, `dataBasePath`, `address`, `dataBaseName`, `username`, `password`) VALUES
(1, 'C:\\\\Program Files\\\\MySQL\\\\MySQL Server 5.0\\\\bin\\\\', 'localhost', 'gou', 'root', 'password');

-- --------------------------------------------------------

--
-- Table structure for table `jc_online_customerservice`
--

CREATE TABLE IF NOT EXISTS `jc_online_customerservice` (
  `Id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '在线客服昵称',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT 'QQ号',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `is_disable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `type` varchar(255) DEFAULT NULL COMMENT '类型'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='在线客服';

-- --------------------------------------------------------

--
-- Table structure for table `jc_popularity_group`
--

CREATE TABLE IF NOT EXISTS `jc_popularity_group` (
  `Id` bigint(20) NOT NULL,
  `name` varchar(150) DEFAULT NULL COMMENT '名称',
  `price` double(11,2) DEFAULT NULL COMMENT '组合价格',
  `description` varchar(255) DEFAULT NULL COMMENT '活动描述',
  `privilege` double(11,2) DEFAULT NULL COMMENT '优惠'
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='人气组合';

-- --------------------------------------------------------

--
-- Table structure for table `jc_popularity_group_product`
--

CREATE TABLE IF NOT EXISTS `jc_popularity_group_product` (
  `Id` bigint(20) NOT NULL DEFAULT '0' COMMENT '组合购买Id',
  `product_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品Id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合购买商品表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_popularity_item`
--

CREATE TABLE IF NOT EXISTS `jc_popularity_item` (
  `popularityitem_id` bigint(20) NOT NULL,
  `cart_id` bigint(20) NOT NULL COMMENT '购物车ID',
  `count` int(11) NOT NULL COMMENT '数量',
  `popularity_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物车';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_admin`
--

CREATE TABLE IF NOT EXISTS `jc_shop_admin` (
  `admin_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `firstname` varchar(100) DEFAULT NULL COMMENT '名',
  `lastname` varchar(100) DEFAULT NULL COMMENT '姓'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城管理员';

--
-- Dumping data for table `jc_shop_admin`
--

INSERT INTO `jc_shop_admin` (`admin_id`, `website_id`, `firstname`, `lastname`) VALUES
(1, 1, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_advertise`
--

CREATE TABLE IF NOT EXISTS `jc_shop_advertise` (
  `Id` int(11) NOT NULL,
  `adspace_id` int(11) DEFAULT NULL COMMENT '广告位',
  `name` varchar(50) DEFAULT NULL COMMENT '广告名字',
  `weight` int(1) DEFAULT NULL COMMENT '广告权重',
  `display_count` int(11) DEFAULT NULL COMMENT '展现次数',
  `click_count` int(11) DEFAULT NULL COMMENT '点击次数',
  `starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `endTime` datetime DEFAULT NULL COMMENT '节束时间',
  `is_enabled` char(1) DEFAULT NULL COMMENT '是否启用'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='广告';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_advertise_attr`
--

CREATE TABLE IF NOT EXISTS `jc_shop_advertise_attr` (
  `Id` int(11) NOT NULL DEFAULT '0',
  `attr_name` varchar(100) DEFAULT NULL COMMENT '属性名字',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '属性值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_advertise_space`
--

CREATE TABLE IF NOT EXISTS `jc_shop_advertise_space` (
  `Id` int(11) NOT NULL,
  `ad_name` varchar(50) DEFAULT NULL COMMENT '版位名字',
  `description` varchar(255) DEFAULT NULL COMMENT '版位描述',
  `is_enabled` char(1) DEFAULT NULL COMMENT '是否启用'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='广告版位';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_article`
--

CREATE TABLE IF NOT EXISTS `jc_shop_article` (
  `article_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL,
  `channel_id` bigint(20) NOT NULL,
  `title` varchar(150) NOT NULL COMMENT '标题',
  `publish_time` datetime NOT NULL COMMENT '发布时间',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `link` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `param2` varchar(255) DEFAULT NULL COMMENT '扩展数据2',
  `param3` varchar(255) DEFAULT NULL COMMENT '扩展数据3'
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='商城文章表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_article_content`
--

CREATE TABLE IF NOT EXISTS `jc_shop_article_content` (
  `article_id` bigint(20) NOT NULL,
  `content` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城文章内容';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_brand`
--

CREATE TABLE IF NOT EXISTS `jc_shop_brand` (
  `brand_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `alias` varchar(255) DEFAULT NULL COMMENT '别名',
  `web_url` varchar(255) DEFAULT NULL COMMENT '网址',
  `logo_path` varchar(255) DEFAULT NULL COMMENT 'LOGO',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `is_sift` tinyint(3) DEFAULT NULL COMMENT '是否精选',
  `is_disabled` tinyint(3) NOT NULL COMMENT '是否禁用',
  `firstcharacter` varchar(255) NOT NULL COMMENT '品牌首字母'
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='品牌';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_brand_text`
--

CREATE TABLE IF NOT EXISTS `jc_shop_brand_text` (
  `brand_id` bigint(20) NOT NULL,
  `text` longtext COMMENT '详细信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_cardgift`
--

CREATE TABLE IF NOT EXISTS `jc_shop_cardgift` (
  `Id` int(11) NOT NULL,
  `cartId` bigint(20) DEFAULT NULL COMMENT '所属购物车',
  `websiteId` bigint(20) DEFAULT NULL COMMENT '所属站点',
  `giftId` bigint(20) DEFAULT NULL COMMENT '礼品id',
  `count` int(11) DEFAULT NULL COMMENT '礼品数量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_cart`
--

CREATE TABLE IF NOT EXISTS `jc_shop_cart` (
  `cart_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `total_items` int(11) NOT NULL DEFAULT '0' COMMENT '商品总数量',
  `total_gifts` int(11) DEFAULT NULL COMMENT '礼品总数量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物车';

--
-- Dumping data for table `jc_shop_cart`
--

INSERT INTO `jc_shop_cart` (`cart_id`, `website_id`, `total_items`, `total_gifts`) VALUES
(1, 1, 1, NULL),
(8, 1, 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_cart_item`
--

CREATE TABLE IF NOT EXISTS `jc_shop_cart_item` (
  `cartitem_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '站点ID',
  `cart_id` bigint(20) NOT NULL COMMENT '购物车ID',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `productFash_id` bigint(20) DEFAULT NULL COMMENT '商品款式外键（新加的[wangzewu]）',
  `count` int(11) NOT NULL COMMENT '数量',
  `score` int(11) DEFAULT NULL COMMENT '购物车商品预送积分',
  `popularity_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='购物车';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_category`
--

CREATE TABLE IF NOT EXISTS `jc_shop_category` (
  `category_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `ptype_id` bigint(20) NOT NULL COMMENT '类型ID',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父类别ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `path` varchar(100) NOT NULL COMMENT '访问路径',
  `lft` int(11) NOT NULL DEFAULT '1' COMMENT '树左边',
  `rgt` int(11) NOT NULL DEFAULT '2' COMMENT '树右边',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `keywords` varchar(255) DEFAULT NULL COMMENT '页面关键字',
  `description` varchar(255) DEFAULT NULL COMMENT '页面描述',
  `tpl_channel` varchar(50) DEFAULT NULL COMMENT '栏目页模板',
  `tpl_content` varchar(50) DEFAULT NULL COMMENT '内容页模板',
  `image_path` varchar(100) DEFAULT NULL COMMENT '图片路径',
  `title` varchar(255) DEFAULT NULL COMMENT '页面标题',
  `is_colorsize` tinyint(1) DEFAULT '0' COMMENT '是否需要尺寸和样式'
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='类别';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_category_attr`
--

CREATE TABLE IF NOT EXISTS `jc_shop_category_attr` (
  `category_id` bigint(20) NOT NULL DEFAULT '0',
  `attr_name` varchar(30) NOT NULL DEFAULT '' COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='jspgou类型扩展属性表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_category_brand`
--

CREATE TABLE IF NOT EXISTS `jc_shop_category_brand` (
  `brand_id` bigint(22) NOT NULL DEFAULT '0',
  `category_id` bigint(22) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_category_property`
--

CREATE TABLE IF NOT EXISTS `jc_shop_category_property` (
  `Id` int(11) NOT NULL,
  `category_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '关联类型Id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '属性名称',
  `is_start` int(11) NOT NULL DEFAULT '0' COMMENT '是否启用',
  `is_notNull` int(11) NOT NULL DEFAULT '0' COMMENT '是否必填',
  `priority` varchar(255) NOT NULL DEFAULT '10' COMMENT '排序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='类型属性表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_category_sdtype`
--

CREATE TABLE IF NOT EXISTS `jc_shop_category_sdtype` (
  `category_id` bigint(20) NOT NULL DEFAULT '0',
  `standardtype_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='类别和规则类型关联表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_channel`
--

CREATE TABLE IF NOT EXISTS `jc_shop_channel` (
  `channel_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL,
  `path` varchar(50) DEFAULT NULL COMMENT '访问路径',
  `name` varchar(100) NOT NULL COMMENT '栏目名称',
  `type` int(11) NOT NULL COMMENT '栏目类型',
  `outer_url` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `tpl_channel` varchar(50) DEFAULT NULL COMMENT '栏目页模板',
  `tpl_content` varchar(50) DEFAULT NULL COMMENT '内容页模板',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父栏目ID',
  `lft` int(11) NOT NULL DEFAULT '1' COMMENT '树左边',
  `rgt` int(11) NOT NULL DEFAULT '2' COMMENT '树右边',
  `is_blank` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否新窗口打开',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `param1` varchar(255) DEFAULT NULL COMMENT '扩展数据1',
  `param2` varchar(255) DEFAULT NULL COMMENT '扩展数据2',
  `param3` varchar(255) DEFAULT NULL COMMENT '扩展数据3'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='商城栏目表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_channel_content`
--

CREATE TABLE IF NOT EXISTS `jc_shop_channel_content` (
  `channel_id` bigint(20) NOT NULL,
  `content` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目内容';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_collect`
--

CREATE TABLE IF NOT EXISTS `jc_shop_collect` (
  `Id` int(11) NOT NULL,
  `member_id` bigint(20) DEFAULT NULL COMMENT '收藏人',
  `product_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品Id',
  `fashion_id` bigint(20) DEFAULT NULL COMMENT '收藏商品款式',
  `time` datetime DEFAULT NULL COMMENT '收藏时间'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='收藏商品';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_config`
--

CREATE TABLE IF NOT EXISTS `jc_shop_config` (
  `config_id` bigint(20) NOT NULL,
  `shop_price_name` varchar(50) NOT NULL DEFAULT '商城价' COMMENT '商城价名称',
  `market_price_name` varchar(50) NOT NULL DEFAULT '市场价' COMMENT '市场价名称',
  `favorite_size` int(11) NOT NULL DEFAULT '200' COMMENT '收藏夹大小',
  `register_group_id` bigint(20) NOT NULL COMMENT '默认注册会员组ID',
  `register_auto` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否自动注册'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城配置表';

--
-- Dumping data for table `jc_shop_config`
--

INSERT INTO `jc_shop_config` (`config_id`, `shop_price_name`, `market_price_name`, `favorite_size`, `register_group_id`, `register_auto`) VALUES
(1, '商城价', '市场价', 200, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_consult`
--

CREATE TABLE IF NOT EXISTS `jc_shop_consult` (
  `Id` int(11) NOT NULL,
  `consult` varchar(255) DEFAULT NULL COMMENT '咨询内容',
  `adminReplay` varchar(255) DEFAULT NULL COMMENT 'admin回复',
  `time` datetime DEFAULT NULL COMMENT '咨询时间',
  `member_id` bigint(11) DEFAULT NULL COMMENT '咨询会员',
  `product_id` bigint(11) DEFAULT NULL COMMENT '对应商品'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购买商品咨询表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_coupon`
--

CREATE TABLE IF NOT EXISTS `jc_shop_coupon` (
  `Id` bigint(11) NOT NULL,
  `website_id` bigint(20) DEFAULT NULL COMMENT '站点Id',
  `coupon_name` varchar(50) DEFAULT NULL COMMENT '优惠劵名称',
  `coupon_begintime` datetime DEFAULT NULL COMMENT '开始时间',
  `coupon_endTime` datetime DEFAULT NULL COMMENT '结束时间',
  `coupon_pic` varchar(50) DEFAULT NULL COMMENT '图片地址',
  `is_using` tinyint(3) DEFAULT NULL COMMENT '是否启用',
  `coupon_price` decimal(10,2) DEFAULT NULL COMMENT '优惠倦值',
  `coupon_leastPrice` decimal(10,2) DEFAULT NULL COMMENT '至少消费',
  `coupon_count` int(11) DEFAULT NULL COMMENT '数量'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='优惠劵';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_dictionary`
--

CREATE TABLE IF NOT EXISTS `jc_shop_dictionary` (
  `Id` bigint(20) NOT NULL,
  `type_id` int(11) NOT NULL DEFAULT '0' COMMENT '字典表类型ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序'
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='字典表';

--
-- Dumping data for table `jc_shop_dictionary`
--

INSERT INTO `jc_shop_dictionary` (`Id`, `type_id`, `name`, `priority`) VALUES
(1, 1, '学生', 10),
(2, 1, '在职', 10),
(3, 1, '自由职业', 10),
(4, 1, '家庭主妇', 10),
(5, 1, '退休', 10),
(6, 2, '1人', 10),
(7, 2, '2人', 10),
(8, 2, '3人', 10),
(9, 2, '4人以上', 10),
(10, 3, '2000元及以下', 10),
(11, 3, '2000―5000元(包含5000元)', 10),
(12, 3, '5000―10000元(包含10000元)', 10),
(13, 3, '10000―20000元(包含20000元)', 10),
(14, 3, '20000―40000元(包含40000元)', 10),
(15, 3, '40000元以上', 10),
(16, 5, '高中以下', 1),
(17, 5, '中专', 10),
(18, 5, '大专', 10),
(19, 5, '本科', 10),
(20, 5, '硕士', 10),
(21, 5, '博士', 10),
(22, 4, '1年', 10),
(23, 4, '2年', 10),
(24, 4, '3年', 10),
(25, 4, '4年以上', 10),
(26, 6, '缺货', 10),
(27, 6, '协商一致退款', 10),
(28, 6, '未按约定时间发货', 10),
(29, 6, '其他', 10),
(30, 7, '卖家未发货，全额退款', 10),
(31, 8, '质量有问题', 10),
(32, 9, '我的账户', 10),
(33, 9, '支付宝', 10);

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_dictionary_type`
--

CREATE TABLE IF NOT EXISTS `jc_shop_dictionary_type` (
  `Id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '字典表的类型'
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='字典表的类型';

--
-- Dumping data for table `jc_shop_dictionary_type`
--

INSERT INTO `jc_shop_dictionary_type` (`Id`, `name`) VALUES
(1, '身份'),
(2, '家庭成员'),
(3, '个人收入状况'),
(4, '工作年限'),
(5, '教育程度'),
(6, '未发货退款原因'),
(7, '退款类型'),
(8, '已收获退款原因'),
(9, '退款方式类型');

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_discuss`
--

CREATE TABLE IF NOT EXISTS `jc_shop_discuss` (
  `Id` bigint(22) NOT NULL,
  `content` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `time` datetime DEFAULT NULL COMMENT '评论时间',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员',
  `product_id` bigint(20) DEFAULT NULL COMMENT '商品id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品评论表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_exended`
--

CREATE TABLE IF NOT EXISTS `jc_shop_exended` (
  `exended_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `field` varchar(255) DEFAULT NULL COMMENT '字段名称',
  `dataType` tinyint(3) NOT NULL DEFAULT '0' COMMENT '数据类型',
  `priority` int(11) DEFAULT NULL COMMENT '排序'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商品扩展属性';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_exended_item`
--

CREATE TABLE IF NOT EXISTS `jc_shop_exended_item` (
  `Id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '属性值',
  `priority` int(11) DEFAULT NULL COMMENT '排序',
  `exended_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_fashion_standard`
--

CREATE TABLE IF NOT EXISTS `jc_shop_fashion_standard` (
  `fashion_id` bigint(11) NOT NULL,
  `standard_id` bigint(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='商品规格表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_favorable`
--

CREATE TABLE IF NOT EXISTS `jc_shop_favorable` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `scanningPrice` int(20) DEFAULT NULL COMMENT '一拍支付价格',
  `littlePrice` int(20) DEFAULT NULL COMMENT '小额支付价格',
  `flashPrice` int(20) DEFAULT NULL COMMENT '闪付价格',
  `screenPrice` int(20) DEFAULT NULL COMMENT '银联支付价格',
  `favorableType` int(2) DEFAULT NULL COMMENT '优惠方式',
  `beforeN` int(11) unsigned DEFAULT '0' COMMENT '前N笔优惠',
  `weeks` varchar(60) DEFAULT NULL COMMENT '固定周优惠',
  `months` varchar(100) DEFAULT NULL COMMENT '固定月优惠',
  `startTime` datetime DEFAULT NULL COMMENT '开始时间',
  `endTime` datetime DEFAULT NULL COMMENT '结束时间',
  `channelId` varchar(60) DEFAULT NULL COMMENT '渠道id',
  `channelName` varchar(60) DEFAULT NULL COMMENT '渠道名称'
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_gift`
--

CREATE TABLE IF NOT EXISTS `jc_shop_gift` (
  `Id` bigint(20) NOT NULL,
  `giftName` varchar(100) DEFAULT NULL COMMENT '礼品名称',
  `giftScore` int(11) DEFAULT NULL COMMENT '礼品换取所需积分',
  `giftStock` int(11) DEFAULT NULL COMMENT '礼品库存',
  `giftPicture` varchar(100) DEFAULT NULL COMMENT '礼品图片',
  `isgift` tinyint(3) DEFAULT NULL COMMENT '是否发放',
  `introduced` longtext
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_gift_exchange`
--

CREATE TABLE IF NOT EXISTS `jc_shop_gift_exchange` (
  `Id` int(11) NOT NULL,
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员',
  `gift_id` bigint(20) DEFAULT NULL COMMENT '礼品',
  `score` int(11) DEFAULT NULL COMMENT '积分',
  `amount` int(11) DEFAULT NULL COMMENT '数量',
  `create_time` datetime DEFAULT NULL COMMENT '兑换时间',
  `total_score` int(11) DEFAULT NULL COMMENT '总积分',
  `detailaddress` varchar(255) DEFAULT NULL COMMENT '收货地址',
  `status` tinyint(3) DEFAULT NULL COMMENT '状态（1.待发货2.已发货3.完成）',
  `waybill` varchar(255) DEFAULT NULL COMMENT '货运单号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分兑换';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_image`
--

CREATE TABLE IF NOT EXISTS `jc_shop_image` (
  `id` varchar(255) NOT NULL COMMENT '主键、图片路径',
  `createTime` datetime DEFAULT NULL COMMENT '上传时间',
  `md5` varchar(100) DEFAULT NULL COMMENT 'md5值',
  `imageName` varchar(50) DEFAULT NULL COMMENT '图片名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_keyword_q`
--

CREATE TABLE IF NOT EXISTS `jc_shop_keyword_q` (
  `Id` int(11) NOT NULL,
  `keyword` varchar(50) DEFAULT NULL COMMENT '关键字',
  `times` int(11) DEFAULT NULL COMMENT '收索次数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_logistics`
--

CREATE TABLE IF NOT EXISTS `jc_shop_logistics` (
  `logistics_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `web_url` varchar(255) DEFAULT NULL COMMENT '网址',
  `logo_path` varchar(255) DEFAULT NULL COMMENT 'LOGO',
  `priority` int(11) DEFAULT NULL COMMENT '排序'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='物流';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_logistics_text`
--

CREATE TABLE IF NOT EXISTS `jc_shop_logistics_text` (
  `logistics_id` bigint(20) NOT NULL,
  `text` longtext COMMENT '详细信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_member`
--

CREATE TABLE IF NOT EXISTS `jc_shop_member` (
  `member_id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL COMMENT '会员组ID',
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `userdegree_id` bigint(20) DEFAULT NULL COMMENT '字典表身份ID',
  `familymembers_id` bigint(20) DEFAULT NULL COMMENT '字典表家庭成员',
  `incomedesc_id` bigint(20) DEFAULT NULL COMMENT '字典表个人收入情况',
  `workseniority_id` bigint(20) DEFAULT NULL COMMENT '字典表工作年限',
  `degree_id` bigint(20) DEFAULT NULL COMMENT '字典表教育程度',
  `realname` varchar(100) DEFAULT NULL COMMENT '真实姓名',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日日期',
  `mobile` varchar(30) DEFAULT NULL COMMENT '手机',
  `tel` varchar(30) DEFAULT NULL COMMENT '电话',
  `score` int(11) DEFAULT NULL COMMENT '积分',
  `freezeScore` int(11) DEFAULT '0' COMMENT '冻结的积分',
  `money` double(11,2) DEFAULT NULL COMMENT '账户金额',
  `company` varchar(100) DEFAULT NULL COMMENT '公司',
  `avatar` varchar(100) DEFAULT NULL COMMENT '会员头像',
  `marriage` tinyint(1) DEFAULT NULL COMMENT '婚姻状况(空,保密;1,已婚;0,未婚)',
  `is_car` tinyint(1) DEFAULT NULL COMMENT '是否有车(0:无 1：有)',
  `position` varchar(255) DEFAULT NULL COMMENT '职位',
  `schoolTag` varchar(255) DEFAULT NULL COMMENT '毕业学校',
  `schoolTagDate` date DEFAULT NULL COMMENT '毕业时间',
  `favoriteBrand` varchar(255) DEFAULT NULL COMMENT '最喜爱的品牌',
  `favoriteStar` varchar(255) DEFAULT NULL COMMENT '最喜爱的明星',
  `favoriteMovie` varchar(255) DEFAULT NULL COMMENT '最喜爱的电影',
  `favoritePersonage` varchar(255) DEFAULT NULL COMMENT '最喜爱的人物',
  `address` varchar(255) DEFAULT NULL COMMENT '地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城会员';

--
-- Dumping data for table `jc_shop_member`
--

INSERT INTO `jc_shop_member` (`member_id`, `group_id`, `website_id`, `userdegree_id`, `familymembers_id`, `incomedesc_id`, `workseniority_id`, `degree_id`, `realname`, `gender`, `birthday`, `mobile`, `tel`, `score`, `freezeScore`, `money`, `company`, `avatar`, `marriage`, `is_car`, `position`, `schoolTag`, `schoolTagDate`, `favoriteBrand`, `favoriteStar`, `favoriteMovie`, `favoritePersonage`, `address`) VALUES
(1, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', 40, 0, 4798.00, NULL, '/jspgou/u/201406/18140736wuc5.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_member_address`
--

CREATE TABLE IF NOT EXISTS `jc_shop_member_address` (
  `address_id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL COMMENT '会员',
  `province_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '省份',
  `city_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '城市Id',
  `country_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '县Id',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '姓名',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别',
  `detailaddress` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `postcode` varchar(20) DEFAULT NULL COMMENT '邮编',
  `tel` varchar(30) DEFAULT NULL COMMENT '手机',
  `areacode` varchar(30) DEFAULT NULL COMMENT '电话区号',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话部分',
  `extnumber` varchar(255) DEFAULT NULL COMMENT '分机号',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是默认地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='地址';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_member_coupon`
--

CREATE TABLE IF NOT EXISTS `jc_shop_member_coupon` (
  `Id` int(11) NOT NULL,
  `code` varchar(11) DEFAULT NULL COMMENT '优惠劵验证码',
  `is_use` tinyint(3) DEFAULT NULL COMMENT '是否使用',
  `member_id` bigint(20) DEFAULT NULL COMMENT '对应的会员',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '对应的优惠劵'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jc_shop_member_coupon`
--

INSERT INTO `jc_shop_member_coupon` (`Id`, `code`, `is_use`, `member_id`, `coupon_id`) VALUES
(1, NULL, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_member_favorite`
--

CREATE TABLE IF NOT EXISTS `jc_shop_member_favorite` (
  `product_id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品收藏夹';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_member_group`
--

CREATE TABLE IF NOT EXISTS `jc_shop_member_group` (
  `group_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '最低积分',
  `discount` int(11) NOT NULL DEFAULT '100' COMMENT '折扣'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商城会员组';

--
-- Dumping data for table `jc_shop_member_group`
--

INSERT INTO `jc_shop_member_group` (`group_id`, `website_id`, `name`, `score`, `discount`) VALUES
(1, 1, '普通会员', 0, 90),
(2, 1, '高级会员', 5, 80),
(3, 1, '金牌会员', 10, 70);

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_money`
--

CREATE TABLE IF NOT EXISTS `jc_shop_money` (
  `Id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '会员Id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '来源/用途',
  `money` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0是支出，1,是收入',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户记录';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_order`
--

CREATE TABLE IF NOT EXISTS `jc_shop_order` (
  `order_id` bigint(20) NOT NULL,
  `website_id` bigint(20) DEFAULT NULL COMMENT '站点ID',
  `payment_id` bigint(20) NOT NULL COMMENT '支付方式',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员ID',
  `shipping_id` bigint(20) DEFAULT '0' COMMENT '配送方式',
  `product_id` bigint(20) DEFAULT NULL,
  `code` varchar(20) NOT NULL DEFAULT '0' COMMENT '订单号',
  `status` int(11) DEFAULT '1' COMMENT '订单状态,1-未确认,2-已确认，3-已取消，4-已完成',
  `payment_status` int(11) DEFAULT '1' COMMENT '支付状态 :1-未支付，2-已支付，3- 已退款，4-退款失败',
  `shipping_status` int(11) DEFAULT '1' COMMENT '配送状态:1-未发货，2-已发货，3-已退货',
  `product_price` int(11) DEFAULT NULL COMMENT '商品总价格(分)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '商品重量',
  `freight` double(11,2) DEFAULT NULL COMMENT '运费',
  `total` int(11) NOT NULL DEFAULT '0' COMMENT '订单总额(分)',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '订单积分',
  `ip` varchar(50) NOT NULL COMMENT 'IP地址',
  `create_time` datetime NOT NULL COMMENT '下单日期',
  `finished_time` datetime DEFAULT NULL COMMENT '结单日期',
  `last_modified` datetime NOT NULL COMMENT '最后修改时间',
  `comments` varchar(255) DEFAULT NULL COMMENT '订单附言',
  `shipping_time` datetime DEFAULT NULL COMMENT '发货日期',
  `coupon_price` double(11,2) DEFAULT NULL,
  `productName` varchar(500) DEFAULT NULL COMMENT '订单商品名字的组合',
  `tradeno` varchar(255) DEFAULT NULL COMMENT '支付宝交易号',
  `return_id` bigint(1) DEFAULT NULL COMMENT '退款Id',
  `receive_name` varchar(255) DEFAULT NULL COMMENT '收货人姓名',
  `receive_address` varchar(255) DEFAULT NULL COMMENT '收货人地址',
  `receive_zip` varchar(255) DEFAULT NULL COMMENT '收货人邮编',
  `receive_phone` varchar(255) DEFAULT NULL COMMENT '收货人电话号码',
  `receive_mobile` varchar(255) DEFAULT NULL COMMENT '收货人手机号码',
  `payment_code` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `order_type` int(20) DEFAULT NULL COMMENT '订单类型 1.本地商品，2.虚拟商品，3.商城商品，4.金融商品',
  `del` int(4) DEFAULT '0' COMMENT '该订单是否删除 1-删除；0-未删除',
  `terminal_id` varchar(50) DEFAULT NULL,
  `member_user_id` varchar(50) DEFAULT NULL,
  `terminal_order_id` varchar(50) DEFAULT NULL COMMENT '终端订单号',
  `serial_no` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_order_gathering`
--

CREATE TABLE IF NOT EXISTS `jc_shop_order_gathering` (
  `Id` int(11) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `bank` varchar(255) DEFAULT NULL COMMENT '银行',
  `accounts` varchar(255) DEFAULT NULL COMMENT '帐号',
  `money` double DEFAULT NULL COMMENT '金额',
  `drawee` varchar(255) DEFAULT NULL COMMENT '付款人',
  `comment` varchar(255) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收款';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_order_item`
--

CREATE TABLE IF NOT EXISTS `jc_shop_order_item` (
  `orderitem_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `website_id` bigint(20) DEFAULT '0',
  `product_id` bigint(20) NOT NULL,
  `productFash_id` bigint(11) DEFAULT NULL COMMENT '商品款式外键（wangzewu）',
  `count` int(11) NOT NULL COMMENT '数量',
  `sale_price` double(11,2) DEFAULT NULL COMMENT '销售价',
  `member_price` double(11,2) DEFAULT NULL COMMENT '会员价',
  `cost_price` double(11,2) DEFAULT NULL COMMENT '成本价',
  `final_price` double(11,2) DEFAULT NULL COMMENT '成交价',
  `seckillprice` double(11,2) DEFAULT NULL COMMENT '秒杀价'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单项';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_order_return`
--

CREATE TABLE IF NOT EXISTS `jc_shop_order_return` (
  `return_id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '退款编码',
  `order_id` bigint(20) NOT NULL DEFAULT '0',
  `reason_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '退款选项原因',
  `payType` int(11) NOT NULL DEFAULT '0' COMMENT '退款支付类型',
  `returnType` int(11) NOT NULL DEFAULT '0' COMMENT '退款类型',
  `alipayId` varchar(255) DEFAULT NULL COMMENT '支付宝账号',
  `reason` varchar(500) DEFAULT NULL COMMENT '退款书面原因',
  `status` int(3) NOT NULL DEFAULT '0' COMMENT '1待审，2已审，3拒绝',
  `money` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '退款数额',
  `sellerMoney` double(11,2) DEFAULT '0.00' COMMENT '支付给卖家的钱',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '申请退款时间',
  `finished_time` datetime DEFAULT NULL COMMENT '退款完成时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FComment';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_order_return_picture`
--

CREATE TABLE IF NOT EXISTS `jc_shop_order_return_picture` (
  `return_id` bigint(20) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0' COMMENT '排列顺序',
  `img_path` varchar(100) NOT NULL DEFAULT '' COMMENT '图片地址',
  `description` varchar(255) DEFAULT NULL COMMENT '描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款图片表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_order_shipments`
--

CREATE TABLE IF NOT EXISTS `jc_shop_order_shipments` (
  `Id` int(11) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `waybill` varchar(255) DEFAULT NULL COMMENT '货运单号',
  `money` double DEFAULT NULL COMMENT '金额',
  `receiving` varchar(255) DEFAULT NULL COMMENT '收货信息',
  `comment` varchar(255) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发货信息';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_pay`
--

CREATE TABLE IF NOT EXISTS `jc_shop_pay` (
  `Id` int(11) NOT NULL,
  `address` varchar(100) DEFAULT NULL COMMENT '公司地址',
  `bankNum` varchar(100) DEFAULT NULL COMMENT '银行账户',
  `bankid` varchar(100) DEFAULT NULL COMMENT '网银在线商户id',
  `bankkey` varchar(100) DEFAULT NULL COMMENT '网银在线key'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='订单付款';

--
-- Dumping data for table `jc_shop_pay`
--

INSERT INTO `jc_shop_pay` (`Id`, `address`, `bankNum`, `bankid`, `bankkey`) VALUES
(1, '南昌×××.', '农业银行:3621×××,工商银行:121×××', '22304030', 'abcdefg');

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_payment`
--

CREATE TABLE IF NOT EXISTS `jc_shop_payment` (
  `payment_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `name` varchar(150) NOT NULL COMMENT '支付名称',
  `description` longtext COMMENT '描述',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是默认',
  `type` tinyint(3) DEFAULT NULL COMMENT '支付类型',
  `introduce` varchar(255) DEFAULT NULL COMMENT '介绍'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='支付方式';

--
-- Dumping data for table `jc_shop_payment`
--

INSERT INTO `jc_shop_payment` (`payment_id`, `website_id`, `name`, `description`, `priority`, `is_disabled`, `is_default`, `type`, `introduce`) VALUES
(1, 1, '网上支付', '<p>支持支付宝、财付通、以及大多数网上银行支付</p>', 1, 0, 1, 1, '支持支付宝、财付通、以及大多数网上银行支付'),
(2, 1, '银行汇款', '<table align="center" border="0" cellpadding="0" cellspacing="0" style="line-height: 25px; margin-top: 20px">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<table bgcolor="#67a9e5" border="0" cellpadding="0" cellspacing="1" width="600">\r\n					<tbody>\r\n						<tr>\r\n							<td align="middle" background="3C92DF" bgcolor="#3c92df" height="28" width="260">\r\n								<strong style="color: #ffffff">支付方式</strong></td>\r\n							<td align="middle" background="3C92DF" bgcolor="#3c92df" width="340">\r\n								<strong style="color: #ffffff">帐户信息</strong></td>\r\n						</tr>\r\n						<tr>\r\n							<td align="middle" bgcolor="#ffffff" height="70">\r\n								<img alt="商业购买" src="http://www.jeecms.com/res_base/jeecms_com_www/default/article/img/bank/nh.jpg" /></td>\r\n							<td bgcolor="#ffffff" style="line-height: 22px">\r\n								&nbsp;户 名：黄春荣<br />\r\n								&nbsp;卡 号：6228　4809　2010　9896　414<br />\r\n								&nbsp;开 户：南昌市洪城大市场支行</td>\r\n						</tr>\r\n						<tr>\r\n							<td align="middle" bgcolor="#ffffff" height="70">\r\n								<img alt="商业购买" height="50" src="http://www.jeecms.com/res_base/jeecms_com_www/default/article/img/bank/jh.jpg" width="200" /></td>\r\n							<td bgcolor="#ffffff" style="line-height: 22px">\r\n								&nbsp;户 名：黄春荣<br />\r\n								&nbsp;卡 号：6227　0020　2158　0046　990<br />\r\n								&nbsp;开 户：南昌市洪城分理处</td>\r\n						</tr>\r\n						<tr>\r\n							<td align="middle" bgcolor="#ffffff" height="70">\r\n								<img alt="商业购买" height="50" src="http://www.jeecms.com/res_base/jeecms_com_www/default/article/img/bank/gh.jpg" width="200" /></td>\r\n							<td bgcolor="#ffffff" style="line-height: 22px">\r\n								&nbsp;户 名：叶媛<br />\r\n								&nbsp;卡 号：9558　8215　0200　1391　515<br />\r\n								&nbsp;开 户：南昌市青山湖支行</td>\r\n						</tr>\r\n						<tr>\r\n							<td align="middle" bgcolor="#ffffff" height="70">\r\n								<img alt="商业购买" height="50" src="http://www.jeecms.com/res_base/jeecms_com_www/default/article/img/bank/alipay.gif" width="180" /></td>\r\n							<td bgcolor="#ffffff" style="line-height: 22px">\r\n								&nbsp;户 名：叶媛<br />\r\n								&nbsp;帐 号：yeyuan823@163.com<br />\r\n								&nbsp;开 户：支付宝</td>\r\n						</tr>\r\n						<tr>\r\n							<td align="middle" bgcolor="#ffffff" height="70">\r\n								对公帐号</td>\r\n							<td bgcolor="#ffffff" style="line-height: 22px">\r\n								&nbsp;户 名：江西金磊科技发展有限公司<br />\r\n								&nbsp;帐 号：1502 　2010 　0900 　4557 　361<br />\r\n								&nbsp;开 户：工商银行南昌市中山路支行</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<br />\r\n				<table border="0" cellpadding="0" cellspacing="0" style="line-height: 30px" width="600">\r\n					<tbody>\r\n						<tr>\r\n							<td>\r\n								　　使用网上银行转帐更加方便快捷，相关情况请到各银行营业厅咨询办理。推荐您使用支付宝方式付款，可以为您节省手续费。 银行汇款时请注意带些零头，以作区分。如原来需汇1000元就实存1000.5元。汇款成功后，请保留存款收据。 汇完款后及时跟我们联系确认汇款，以便我们及时为您提供服务。</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>&nbsp;</p>', 2, 0, 0, 2, '支持工行、建行、农行汇款支付，收款时间一般为汇款后的1-2个工作日'),
(3, 1, '货到付款', '<p>由快递公司送货上门，您签收后直接将货款交付给快递员</p>', 10, 0, 0, 2, '由快递公司送货上门，您签收后直接将货款交付给快递员'),
(4, 1, '一拍支付', '', 3, 0, 0, 1, '扫描商品二维码后，用手机客户端进行支付'),
(5, 1, '小额支付', '<p>小额支付</p>', 5, 0, 0, 1, '小额支付'),
(6, 1, '银联支付', '<p>银联支付</p>', 4, 0, 0, 1, '银联支付'),
(7, 1, '闪付', '<p>闪付</p>', 6, 0, 0, 1, '闪付');

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_payment_plugins`
--

CREATE TABLE IF NOT EXISTS `jc_shop_payment_plugins` (
  `plugins_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `description` longtext COMMENT '描述',
  `priority` int(11) DEFAULT NULL COMMENT '排列顺序',
  `partner` varchar(255) DEFAULT NULL COMMENT '合作身份者ID',
  `seller_email` varchar(255) DEFAULT NULL COMMENT '签约账号',
  `seller_key` varchar(255) DEFAULT NULL COMMENT '交易安全检验码',
  `img_path` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `code` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='支付插件';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_payment_shipping`
--

CREATE TABLE IF NOT EXISTS `jc_shop_payment_shipping` (
  `payment_id` bigint(20) NOT NULL,
  `shipping_id` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jc_shop_payment_shipping`
--

INSERT INTO `jc_shop_payment_shipping` (`payment_id`, `shipping_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(2, 6),
(3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_poster`
--

CREATE TABLE IF NOT EXISTS `jc_shop_poster` (
  `Id` int(11) NOT NULL,
  `picUrl` varchar(255) DEFAULT NULL COMMENT '图片路径',
  `time` datetime DEFAULT NULL COMMENT '时间',
  `interUrl` varchar(100) DEFAULT NULL COMMENT '链接地址'
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product` (
  `product_id` bigint(20) NOT NULL,
  `ptype_id` bigint(20) NOT NULL COMMENT '类型ID',
  `brand_id` bigint(20) DEFAULT NULL COMMENT '品牌ID',
  `category_id` bigint(20) NOT NULL COMMENT '类别ID',
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `config_id` bigint(20) NOT NULL COMMENT '配置ID',
  `name` varchar(150) NOT NULL COMMENT '商品名称',
  `market_price` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `sale_price` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '销售价',
  `cost_price` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '成本价',
  `view_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `sale_count` int(11) NOT NULL DEFAULT '0' COMMENT '销售量',
  `stock_count` int(11) NOT NULL DEFAULT '10' COMMENT '库存',
  `alert_inventory` int(11) DEFAULT NULL COMMENT '警戒库存',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `expire_time` datetime DEFAULT NULL COMMENT '到期时间',
  `checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核通过',
  `on_sale` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否上架',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_special` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否特价',
  `is_hotsale` tinyint(3) NOT NULL COMMENT '是否热卖',
  `is_newProduct` tinyint(3) NOT NULL COMMENT '是否新品',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '商品送积分',
  `shareContent` varchar(255) NOT NULL COMMENT '分享内容',
  `lack_remind` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否库存预警',
  `li_run` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '利润',
  `channelId` varchar(60) DEFAULT NULL COMMENT '渠道id',
  `commerceId` varchar(60) DEFAULT NULL COMMENT '商户id',
  `channelName` varchar(64) DEFAULT NULL COMMENT '渠道名称',
  `commerceName` varchar(64) DEFAULT NULL COMMENT '商户名称',
  `scanning_price` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '一拍支付价格',
  `little_price` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '小额支付价格',
  `flash_price` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '闪付价格',
  `screen_price` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '银联支付价格',
  `productStamp` int(2) DEFAULT NULL COMMENT '商品类型，1.本地商品，2.虚拟商品，3.商城商品，4.金融商品',
  `sendMassage` int(1) DEFAULT '0' COMMENT '是否发短信  0不发，1发'
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='商品';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_attr`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_attr` (
  `product_id` bigint(20) NOT NULL DEFAULT '0',
  `attr_name` varchar(30) NOT NULL DEFAULT '' COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='jspgou商品扩展属性表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_exended`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_exended` (
  `product_id` bigint(20) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `attr_name` varchar(30) NOT NULL DEFAULT '' COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品和规则属性关联表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_ext`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_ext` (
  `product_id` bigint(20) NOT NULL,
  `code` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品编号',
  `description` varchar(255) DEFAULT NULL COMMENT '商品简介',
  `mtitle` varchar(255) DEFAULT NULL COMMENT '页面TITLE',
  `mkeywords` varchar(255) DEFAULT NULL COMMENT '页面KEYWORDS',
  `mdescription` varchar(255) DEFAULT NULL COMMENT '页面DESCRIPTION',
  `detail_img` varchar(150) DEFAULT '' COMMENT '详细图',
  `list_img` varchar(150) DEFAULT NULL COMMENT '列表图',
  `min_img` varchar(150) DEFAULT NULL COMMENT '最小图',
  `cover_img` varchar(255) DEFAULT NULL COMMENT '封面图片',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '重量(g)',
  `unit` varchar(20) NOT NULL DEFAULT '' COMMENT '单位',
  `product_imgs` longtext COMMENT '商品全方位图片',
  `product_img_desc` longtext COMMENT '全方位图片描述',
  `is_limitTime` tinyint(3) DEFAULT NULL COMMENT '是否限时购买',
  `limitTime` datetime DEFAULT NULL COMMENT '限时时间',
  `seckillprice` double(11,2) DEFAULT NULL COMMENT '秒杀价'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_fashion`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_fashion` (
  `fashion_id` bigint(11) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `stock_count` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `on_sale` int(1) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `market_price` double(10,2) DEFAULT NULL COMMENT '市场价',
  `sale_price` double(10,2) DEFAULT NULL COMMENT '销售价',
  `cost_price` double(10,2) DEFAULT NULL COMMENT '成本价',
  `fashion_style` longtext,
  `sale_count` int(11) DEFAULT NULL COMMENT '销量',
  `product_code` varchar(255) DEFAULT NULL COMMENT '商品编号',
  `lackRemind` int(1) DEFAULT '1' COMMENT '是否提醒库存预警（作废）',
  `fashion_pic` varchar(255) DEFAULT NULL,
  `fashion_color` varchar(50) DEFAULT NULL COMMENT '商品款式颜色',
  `fashion_size` varchar(50) DEFAULT NULL COMMENT '商品款式尺码',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否问默认显示款式',
  `nature` varchar(255) DEFAULT NULL,
  `attitude` varchar(255) DEFAULT NULL,
  `scanning_price` double(10,0) DEFAULT NULL COMMENT '一拍支付价额',
  `little_price` double(10,0) DEFAULT NULL COMMENT '小额支付价格',
  `flash_price` double(10,0) DEFAULT NULL COMMENT '闪付价格',
  `screen_price` double(10,0) DEFAULT NULL COMMENT '银联支付价格'
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='商品款式';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_favorable`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_favorable` (
  `id` bigint(20) NOT NULL,
  `productId` bigint(20) DEFAULT NULL COMMENT '商品id',
  `productStamp` int(2) DEFAULT NULL COMMENT '商品类型',
  `favorableId` bigint(20) DEFAULT NULL COMMENT '优惠策略id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_keyword`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_keyword` (
  `product_id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `priority` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品关键字';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_picture`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_picture` (
  `product_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品Id',
  `priority` int(11) NOT NULL DEFAULT '0' COMMENT '排列顺序',
  `picture_path` varchar(255) DEFAULT NULL COMMENT '商品款式图',
  `bigpicture_path` varchar(255) DEFAULT NULL COMMENT '大图',
  `apppicture_path` varchar(255) DEFAULT NULL COMMENT '放大图'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品图片';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_standard`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_standard` (
  `ps_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '与商品外键',
  `standard_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '与颜色规则外键',
  `dataType` tinyint(1) DEFAULT NULL COMMENT '数据类型',
  `type_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '规格类型Id',
  `img_path` varchar(255) DEFAULT NULL COMMENT '颜色图片'
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8 COMMENT='商品规则存储表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_tag`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_tag` (
  `stag_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_product_text`
--

CREATE TABLE IF NOT EXISTS `jc_shop_product_text` (
  `product_id` bigint(20) NOT NULL,
  `text` longtext,
  `text1` longtext,
  `text2` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品详情';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_ptype`
--

CREATE TABLE IF NOT EXISTS `jc_shop_ptype` (
  `ptype_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `name` varchar(150) NOT NULL COMMENT '类型名称',
  `path` varchar(150) DEFAULT NULL COMMENT '访问路径',
  `alias` varchar(255) DEFAULT NULL COMMENT '类型别名',
  `channel_prefix` varchar(20) NOT NULL DEFAULT 'channel' COMMENT '栏目页模板前缀',
  `content_prefix` varchar(20) NOT NULL DEFAULT 'content' COMMENT '内容页模板前缀',
  `props` longtext COMMENT '属性',
  `detail_img_width` int(11) NOT NULL DEFAULT '310' COMMENT '详细图宽',
  `detail_img_height` int(11) NOT NULL DEFAULT '310' COMMENT '详细图高',
  `list_img_width` int(11) NOT NULL DEFAULT '140' COMMENT '列表图宽',
  `list_img_height` int(11) NOT NULL DEFAULT '140' COMMENT '列表图高',
  `min_img_width` int(11) NOT NULL DEFAULT '100' COMMENT '缩略图宽',
  `min_img_height` int(11) NOT NULL DEFAULT '100' COMMENT '缩略图高'
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='商品类型';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_ptype_exended`
--

CREATE TABLE IF NOT EXISTS `jc_shop_ptype_exended` (
  `ptype_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品类型Id',
  `exended_id` int(11) NOT NULL DEFAULT '0' COMMENT '扩展属性Id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品类型和扩展属性关联表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_ptype_property`
--

CREATE TABLE IF NOT EXISTS `jc_shop_ptype_property` (
  `type_property_id` bigint(20) NOT NULL,
  `ptype_id` bigint(20) DEFAULT NULL,
  `field` varchar(255) NOT NULL DEFAULT '' COMMENT '字段',
  `property_name` varchar(255) DEFAULT NULL COMMENT '属性名',
  `sort` int(11) DEFAULT NULL COMMENT '排序顺序',
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `opt_value` varchar(255) DEFAULT NULL COMMENT '可选项',
  `area_rows` varchar(255) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(255) DEFAULT NULL COMMENT '文本列数',
  `is_start` int(1) DEFAULT NULL COMMENT '是否启用',
  `is_notNull` int(1) DEFAULT NULL COMMENT '是否必填',
  `data_type` varchar(255) NOT NULL DEFAULT '1' COMMENT '数据类型',
  `is_single` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否独占一行',
  `is_category` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否类别模型项',
  `is_custom` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否自定义'
) ENGINE=InnoDB AUTO_INCREMENT=950 DEFAULT CHARSET=utf8 COMMENT='商品类型属性表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_score`
--

CREATE TABLE IF NOT EXISTS `jc_shop_score` (
  `Id` bigint(20) NOT NULL,
  `member_id` bigint(20) DEFAULT '0' COMMENT '会员关联',
  `name` varchar(255) DEFAULT NULL COMMENT '积分来源/用途',
  `score` int(11) DEFAULT NULL COMMENT '积分',
  `scoreTime` datetime DEFAULT NULL COMMENT '积分生成时间',
  `scoreType` int(11) NOT NULL DEFAULT '0' COMMENT '积分的类型',
  `useStatus` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0为收入，1为支出',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '积分状况（0为冻结，1为可用）',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `code` varchar(255) DEFAULT NULL COMMENT '订单号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分明细';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_shipping`
--

CREATE TABLE IF NOT EXISTS `jc_shop_shipping` (
  `shipping_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL COMMENT '名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `uniform_price` double(11,2) DEFAULT NULL COMMENT '统一价格',
  `first_weight` int(11) DEFAULT NULL COMMENT '首重量(g)',
  `first_price` double(11,2) DEFAULT NULL COMMENT '首重价',
  `additional_weight` int(11) DEFAULT NULL COMMENT '续重量(g)',
  `additional_price` double(11,2) DEFAULT NULL COMMENT '续重价',
  `method` int(11) NOT NULL DEFAULT '1' COMMENT '1:固定价格;2按重量计价;:3:按国家计价;',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认',
  `logistics_id` bigint(20) DEFAULT NULL,
  `logistics_type` varchar(255) DEFAULT NULL COMMENT '物流类型'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='发货方式';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_tag`
--

CREATE TABLE IF NOT EXISTS `jc_shop_tag` (
  `stag_id` bigint(20) NOT NULL,
  `website_id` bigint(20) NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '关联商品个数'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='标签';

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_weixin`
--

CREATE TABLE IF NOT EXISTS `jc_shop_weixin` (
  `weixin_id` bigint(1) NOT NULL,
  `appkey` varchar(255) DEFAULT NULL COMMENT 'AppKey',
  `appSecret` varchar(255) DEFAULT NULL COMMENT 'AppSecret',
  `url` varchar(255) DEFAULT NULL COMMENT '接口url',
  `token` varchar(255) DEFAULT NULL COMMENT '接口token'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_shop_weixinmenu`
--

CREATE TABLE IF NOT EXISTS `jc_shop_weixinmenu` (
  `weixinmenu_id` bigint(20) NOT NULL,
  `wm_name` varchar(255) DEFAULT NULL COMMENT '微信菜单名称',
  `wm_type` varchar(255) DEFAULT NULL COMMENT '微信菜单类别',
  `wm_url` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `wm_key` varchar(255) DEFAULT NULL COMMENT '点击key',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父节点'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jc_standard`
--

CREATE TABLE IF NOT EXISTS `jc_standard` (
  `standard_id` bigint(20) NOT NULL,
  `type_id` int(11) NOT NULL DEFAULT '0' COMMENT '规格类型Id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '规格名称',
  `color` varchar(10) DEFAULT NULL COMMENT '颜色',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序'
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='商品规格表';

-- --------------------------------------------------------

--
-- Table structure for table `jc_standard_type`
--

CREATE TABLE IF NOT EXISTS `jc_standard_type` (
  `standardtype_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '规格类型名称',
  `field` varchar(255) NOT NULL DEFAULT '' COMMENT '字段名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `dataType` tinyint(1) DEFAULT NULL COMMENT '数据类型',
  `priority` int(11) DEFAULT NULL COMMENT '排序'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='商品规格类型表';

-- --------------------------------------------------------

--
-- Table structure for table `n_bank_pay_info`
--

CREATE TABLE IF NOT EXISTS `n_bank_pay_info` (
  `id` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `merchant_id` varchar(40) DEFAULT NULL,
  `web_counter` varchar(40) DEFAULT NULL,
  `mobile_counter` varchar(40) DEFAULT NULL,
  `branch` varchar(40) DEFAULT NULL,
  `app` varchar(40) DEFAULT NULL,
  `name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `n_lottery_ticket_item`
--

CREATE TABLE IF NOT EXISTS `n_lottery_ticket_item` (
  `id` varchar(200) NOT NULL,
  `order_id` varchar(200) DEFAULT NULL,
  `ticket_code` varchar(50) DEFAULT NULL,
  `ticket_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- --------------------------------------------------------

--
-- Table structure for table `n_lottery_ticket_order`
--

CREATE TABLE IF NOT EXISTS `n_lottery_ticket_order` (
  `id` varchar(200) NOT NULL,
  `ticket_count` int(11) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `provider` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- --------------------------------------------------------

--
-- Table structure for table `n_member_addr`
--

CREATE TABLE IF NOT EXISTS `n_member_addr` (
  `id` int(11) NOT NULL,
  `memberId` varchar(40) DEFAULT NULL COMMENT '用户id',
  `phone` varchar(15) DEFAULT NULL COMMENT '联系电话',
  `name` varchar(60) DEFAULT NULL COMMENT '联系人名称',
  `province` varchar(15) DEFAULT NULL COMMENT '省份',
  `city` varchar(15) DEFAULT NULL COMMENT '城市',
  `detail` varchar(15) DEFAULT NULL COMMENT '详细地址',
  `createTime` datetime DEFAULT NULL COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `n_member_user`
--

CREATE TABLE IF NOT EXISTS `n_member_user` (
  `id` varchar(40) NOT NULL,
  `name` varchar(40) NOT NULL,
  `phone` varchar(15) DEFAULT NULL COMMENT '手机号',
  `email` varchar(40) DEFAULT NULL COMMENT '用户邮箱',
  `register_date` datetime DEFAULT NULL COMMENT '注册时间',
  `sex` char(1) DEFAULT NULL COMMENT '性别,0表示男,1表示女',
  `register_ip` varchar(40) DEFAULT NULL COMMENT '注册IP',
  `user_status` char(1) DEFAULT NULL COMMENT '用户状态,0表示删除,1表示正常,2表示未注册',
  `origin` char(1) DEFAULT NULL COMMENT '来源,0表示建行,1表示其他,2表示民生银行',
  `last_login` datetime DEFAULT NULL COMMENT '最后一次登录的时间',
  `last_login_ip` varchar(40) DEFAULT NULL COMMENT '最后一次登录的IP',
  `password` varchar(120) DEFAULT NULL,
  `user_id` varchar(40) DEFAULT NULL,
  `cmbc_user_id` varchar(64) DEFAULT NULL COMMENT '民生银行md5用户唯一标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- --------------------------------------------------------

--
-- Table structure for table `n_order_pay_refund`
--

CREATE TABLE IF NOT EXISTS `n_order_pay_refund` (
  `id` varchar(40) NOT NULL COMMENT 'id',
  `is_pay` char(1) NOT NULL COMMENT '1-付款；0-退款',
  `order_id` varchar(40) NOT NULL COMMENT '订单号',
  `amount` int(10) NOT NULL DEFAULT '0' COMMENT '金额(分)',
  `serial_number` varchar(40) NOT NULL DEFAULT '00000000001' COMMENT '付款流水',
  `pay_method` varchar(40) NOT NULL COMMENT '支付类型',
  `account_number` varchar(40) NOT NULL COMMENT '帐号',
  `pay_time` datetime NOT NULL COMMENT '支付时间',
  `pay_status` int(40) DEFAULT NULL COMMENT '支付状态 :1-未支付，2-已支付，3- 已退款，4-退款失败',
  `refund_serial_number` varchar(20) DEFAULT NULL,
  `operator` varchar(20) DEFAULT NULL,
  `account_name` varchar(40) DEFAULT NULL,
  `pos_number` varchar(20) DEFAULT NULL COMMENT 'pos机编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sms_log`
--

CREATE TABLE IF NOT EXISTS `sms_log` (
  `id` int(11) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `is_success` bit(1) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `server_response_message` varchar(255) DEFAULT NULL,
  `send_time` datetime DEFAULT NULL,
  `status_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- --------------------------------------------------------

--
-- Table structure for table `t_channel`
--

CREATE TABLE IF NOT EXISTS `t_channel` (
  `id` int(11) NOT NULL,
  `CHANNEL_ID` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `CHANNEL_NAME` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `CHANNEL_CODE` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '渠道编号',
  `CHANNEL_PARENT` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '父渠道',
  `DESCRIPTION` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `CREATE_DATE` datetime NOT NULL COMMENT '创建时间',
  `CREATOR_ID` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人ID',
  `MODIFY_DATE` datetime DEFAULT NULL COMMENT '编辑时间',
  `MODIFIER_ID` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑人ID',
  `STATUS` char(1) COLLATE utf8_bin NOT NULL COMMENT '状态 1.启用 2.禁用',
  `PAY_METHOD` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '支付方式',
  `delStatus` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '逻辑删除 0表示正常 1表示删除',
  `collaborate_start_time` datetime DEFAULT NULL COMMENT '合作开始时间',
  `collaborate_end_time` datetime DEFAULT NULL COMMENT '合作结束时间',
  `bank_pay_info_id` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '银行支付方式',
  `uuid` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `chan_parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='渠道表';

--
-- Dumping data for table `t_channel`
--

INSERT INTO `t_channel` (`id`, `CHANNEL_ID`, `CHANNEL_NAME`, `CHANNEL_CODE`, `CHANNEL_PARENT`, `DESCRIPTION`, `CREATE_DATE`, `CREATOR_ID`, `MODIFY_DATE`, `MODIFIER_ID`, `STATUS`, `PAY_METHOD`, `delStatus`, `collaborate_start_time`, `collaborate_end_time`, `bank_pay_info_id`, `uuid`, `chan_parent_id`) VALUES
(1, NULL, '无', NULL, NULL, NULL, '2015-06-02 10:20:17', NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `t_commerce`
--

CREATE TABLE IF NOT EXISTS `t_commerce` (
  `id` int(11) NOT NULL,
  `COMMERCE_ID` char(11) COLLATE utf8_bin DEFAULT NULL,
  `STATUS` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态 1.启用 2.禁用',
  `NAME` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '商户名称',
  `MOBILE_PHONE` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '手机',
  `EMAIL` varchar(36) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `AREA` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '总部所属区域',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATOR_ID` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人id',
  `MODIFY_DATE` datetime DEFAULT NULL COMMENT '编辑时间',
  `MODIFIER_ID` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑人id',
  `CHANNEL_ID` char(36) COLLATE utf8_bin NOT NULL COMMENT '渠道ID',
  `CODE` varchar(36) COLLATE utf8_bin DEFAULT NULL COMMENT '商户代码',
  `DESCRIPTION` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '商户说明',
  `SYN_STATUS` char(1) COLLATE utf8_bin NOT NULL COMMENT '同步状态 1.同步 2.未同步',
  `delStatus` char(1) COLLATE utf8_bin NOT NULL COMMENT '逻辑删除状态 0表示正常 1表示删除',
  `collaborate_start_time` datetime DEFAULT NULL COMMENT '合作开始时间',
  `collaborate_end_time` datetime DEFAULT NULL COMMENT '合作结束时间',
  `checked` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '审核  1.未审核  2.审核',
  `EXPRESS` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '物流公司',
  `special` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '是否特约商户,0为否，1为是',
  `sort` varchar(8) COLLATE utf8_bin DEFAULT NULL COMMENT '排序',
  `ADDRESS` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '详细地址',
  `LINKMAN` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '联系人',
  `ACCOUNT` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '清算账号',
  `ROUND_DAY` int(11) DEFAULT NULL COMMENT '清算周期',
  `RATE` double DEFAULT '0' COMMENT '费率',
  `province` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '省份',
  `city` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '城市',
  `detailed` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '详细地址',
  `uuid` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `chan_id_rela` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='商户表\r\n';

-- --------------------------------------------------------

--
-- Table structure for table `t_n_voucher`
--

CREATE TABLE IF NOT EXISTS `t_n_voucher` (
  `ID` char(36) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `VOUCHER_CODE` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '凭证号',
  `ORDER_ID` char(36) CHARACTER SET utf8 NOT NULL COMMENT '订单ID',
  `COST` int(6) DEFAULT '0' COMMENT '商品成本',
  `USER_ID` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '用户号',
  `SEND_MOBILE` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '发送手机',
  `SMS_SUB` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '短信标题',
  `SMS_TEXT` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '短信内容',
  `MAX_USE_TIMES` tinyint(2) DEFAULT '1' COMMENT '凭证最大使用次数',
  `VALI_DATE_TIMES` tinyint(2) DEFAULT '0' COMMENT '已验证次数',
  `SMS_COUNT` tinyint(2) DEFAULT '0' COMMENT '短信发送次数',
  `STATUS` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '凭证状态 0：未使用 1：已使用 2：过期结算 3：已作废',
  `USE_TIME` datetime DEFAULT NULL COMMENT '凭证使用时间',
  `SEND_TIME` datetime DEFAULT NULL COMMENT '凭证发送时间',
  `START_DATE` datetime DEFAULT NULL COMMENT '凭证有效期开始时间',
  `END_DATE` datetime DEFAULT NULL COMMENT '凭证有效期结束时间',
  `INVALID_DESC` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '作废原因',
  `MOBILE` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '用户手机号',
  `PIONT_IDS` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '兑换点ID的集合',
  `PRODUCT_NAME` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品名称',
  `operator` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `commerce_name` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `store_name` varchar(100) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='新凭证表';

-- --------------------------------------------------------

--
-- Table structure for table `t_order`
--

CREATE TABLE IF NOT EXISTS `t_order` (
  `id` int(36) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '名称',
  `value` varchar(50) NOT NULL COMMENT 'order_id',
  `order_id` varchar(36) NOT NULL COMMENT '订单ID',
  `t_mark` varchar(500) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `t_pub_area`
--

CREATE TABLE IF NOT EXISTS `t_pub_area` (
  `id` char(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `AREA_NAME` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '地区名称',
  `PARENT_AREA_ID` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '上级地区编号',
  `AREA_LEVEL` char(1) COLLATE utf8_bin NOT NULL COMMENT '地区级别',
  `STATUS` char(1) COLLATE utf8_bin NOT NULL COMMENT '是否开放',
  `AREA_REGION` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '电话区号',
  `IS_INTERNAL` char(1) COLLATE utf8_bin NOT NULL COMMENT '是否是国内城市'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='地区管理表';

--
-- Dumping data for table `t_pub_area`
--

INSERT INTO `t_pub_area` (`id`, `AREA_NAME`, `PARENT_AREA_ID`, `AREA_LEVEL`, `STATUS`, `AREA_REGION`, `IS_INTERNAL`) VALUES
('110000', '北京', 'CN9999', '2', '1', NULL, '1'),
('110100', '北京市', '110000', '3', '1', '010', '1'),
('110101', '东城区', '110100', '4', '1', '010', '1'),
('110102', '西城区', '110100', '4', '1', '010', '1'),
('110103', '崇文区', '110100', '4', '1', '010', '1'),
('110104', '宣武区', '110100', '4', '1', '010', '1'),
('110105', '朝阳区', '110100', '4', '1', '010', '1'),
('110106', '丰台区', '110100', '4', '1', '010', '1'),
('110107', '石景山区', '110100', '4', '1', '010', '1'),
('110108', '海淀区', '110100', '4', '1', '010', '1'),
('110109', '门头沟区', '110100', '4', '1', '010', '1'),
('110111', '房山区', '110100', '4', '1', '010', '1'),
('110112', '通州区', '110100', '4', '1', '010', '1'),
('110113', '顺义区', '110100', '4', '1', '010', '1'),
('110114', '昌平区', '110100', '4', '1', '010', '1'),
('110115', '大兴区', '110100', '4', '1', '010', '1'),
('110116', '怀柔区', '110100', '4', '1', '010', '1'),
('110117', '平谷区', '110100', '4', '1', '010', '1'),
('110228', '密云县', '110100', '4', '1', '010', '1'),
('110229', '延庆县', '110100', '4', '1', '010', '1'),
('120000', '天津', 'CN9999', '2', '1', NULL, '1'),
('120100', '天津市', '120000', '3', '1', '022', '1'),
('120101', '和平区', '120100', '4', '1', '022', '1'),
('120102', '河东区', '120100', '4', '1', '022', '1'),
('120103', '河西区', '120100', '4', '1', '022', '1'),
('120104', '南开区', '120100', '4', '1', '022', '1'),
('120105', '河北区', '120100', '4', '1', '022', '1'),
('120106', '红桥区', '120100', '4', '1', '022', '1'),
('120107', '塘沽区', '120100', '4', '1', '022', '1'),
('120108', '汉沽区', '120100', '4', '1', '022', '1'),
('120109', '大港区', '120100', '4', '1', '022', '1'),
('120110', '东丽区', '120100', '4', '1', '022', '1'),
('120111', '西青区', '120100', '4', '1', '022', '1'),
('120112', '津南区', '120100', '4', '1', '022', '1'),
('120113', '北辰区', '120100', '4', '1', '022', '1'),
('120114', '武清区', '120100', '4', '1', '022', '1'),
('120115', '宝坻区', '120100', '4', '1', '022', '1'),
('120221', '宁河县', '120100', '4', '1', '022', '1'),
('120223', '静海县', '120100', '4', '1', '022', '1'),
('120225', '蓟县', '120100', '4', '1', '022', '1'),
('130000', '河北省', 'CN9999', '2', '1', NULL, '1'),
('130100', '石家庄市', '130000', '3', '1', '0311', '1'),
('130102', '长安区', '130100', '4', '1', '0311', '1'),
('130103', '桥东区', '130100', '4', '1', '0311', '1'),
('130104', '桥西区', '130100', '4', '1', '0311', '1'),
('130105', '新华区', '130100', '4', '1', '0311', '1'),
('130107', '井陉矿区', '130100', '4', '1', '0311', '1'),
('130108', '裕华区', '130100', '4', '1', '0311', '1'),
('130121', '井陉县', '130100', '4', '1', '0311', '1'),
('130123', '正定县', '130100', '4', '1', '0311', '1'),
('130124', '栾城县', '130100', '4', '1', '0311', '1'),
('130125', '行唐县', '130100', '4', '1', '0311', '1'),
('130126', '灵寿县', '130100', '4', '1', '0311', '1'),
('130127', '高邑县', '130100', '4', '1', '0311', '1'),
('130128', '深泽县', '130100', '4', '1', '0311', '1'),
('130129', '赞皇县', '130100', '4', '1', '0311', '1'),
('130130', '无极县', '130100', '4', '1', '0311', '1'),
('130131', '平山县', '130100', '4', '1', '0311', '1'),
('130132', '元氏县', '130100', '4', '1', '0311', '1'),
('130133', '赵县', '130100', '4', '1', '0311', '1'),
('130181', '辛集市', '130100', '4', '1', '0311', '1'),
('130182', '藁城市', '130100', '4', '1', '0311', '1'),
('130183', '晋州市', '130100', '4', '1', '0311', '1'),
('130184', '新乐市', '130100', '4', '1', '0311', '1'),
('130185', '鹿泉市', '130100', '4', '1', '0311', '1'),
('130200', '唐山市', '130000', '3', '0', '0315', '1'),
('130202', '路南区', '130200', '4', '1', '0315', '1'),
('130203', '路北区', '130200', '4', '1', '0315', '1'),
('130204', '古冶区', '130200', '4', '1', '0315', '1'),
('130205', '开平区', '130200', '4', '1', '0315', '1'),
('130207', '丰南区', '130200', '4', '1', '0315', '1'),
('130208', '丰润区', '130200', '4', '1', '0315', '1'),
('130223', '滦县', '130200', '4', '1', '0315', '1'),
('130224', '滦南县', '130200', '4', '1', '0315', '1'),
('130225', '乐亭县', '130200', '4', '1', '0315', '1'),
('130227', '迁西县', '130200', '4', '1', '0315', '1'),
('130229', '玉田县', '130200', '4', '1', '0315', '1'),
('130230', '唐海县', '130200', '4', '1', '0315', '1'),
('130281', '遵化市', '130200', '4', '1', '0315', '1'),
('130283', '迁安市', '130200', '4', '1', '0315', '1'),
('130300', '秦皇岛市', '130000', '3', '0', '0335', '1'),
('130302', '海港区', '130300', '4', '1', '0335', '1'),
('130303', '山海关区', '130300', '4', '1', '0335', '1'),
('130304', '北戴河区', '130300', '4', '1', '0335', '1'),
('130321', '青龙满族自治县', '130300', '4', '1', '0335', '1'),
('130322', '昌黎县', '130300', '4', '1', '0335', '1'),
('130323', '抚宁县', '130300', '4', '1', '0335', '1'),
('130324', '卢龙县', '130300', '4', '1', '0335', '1'),
('130400', '邯郸市', '130000', '3', '1', '0310', '1'),
('130402', '邯山区', '130400', '4', '1', '0310', '1'),
('130403', '丛台区', '130400', '4', '1', '0310', '1'),
('130404', '复兴区', '130400', '4', '1', '0310', '1'),
('130406', '峰峰矿区', '130400', '4', '1', '0310', '1'),
('130421', '邯郸县', '130400', '4', '1', '0310', '1'),
('130423', '临漳县', '130400', '4', '1', '0310', '1'),
('130424', '成安县', '130400', '4', '1', '0310', '1'),
('130425', '大名县', '130400', '4', '1', '0310', '1'),
('130426', '涉县', '130400', '4', '1', '0310', '1'),
('130427', '磁县', '130400', '4', '1', '0310', '1'),
('130428', '肥乡县', '130400', '4', '1', '0310', '1'),
('130429', '永年县', '130400', '4', '1', '0310', '1'),
('130430', '邱县', '130400', '4', '1', '0310', '1'),
('130431', '鸡泽县', '130400', '4', '1', '0310', '1'),
('130432', '广平县', '130400', '4', '1', '0310', '1'),
('130433', '馆陶县', '130400', '4', '1', '0310', '1'),
('130434', '魏县', '130400', '4', '1', '0310', '1'),
('130435', '曲周县', '130400', '4', '1', '0310', '1'),
('130481', '武安市', '130400', '4', '1', '0310', '1'),
('130500', '邢台市', '130000', '3', '1', '0319', '1'),
('130502', '桥东区', '130500', '4', '1', '0319', '1'),
('130503', '桥西区', '130500', '4', '1', '0319', '1'),
('130521', '邢台县', '130500', '4', '1', '0319', '1'),
('130522', '临城县', '130500', '4', '1', '0319', '1'),
('130523', '内丘县', '130500', '4', '1', '0319', '1'),
('130524', '柏乡县', '130500', '4', '1', '0319', '1'),
('130525', '隆尧县', '130500', '4', '1', '0319', '1'),
('130526', '任县', '130500', '4', '1', '0319', '1'),
('130527', '南和县', '130500', '4', '1', '0319', '1'),
('130528', '宁晋县', '130500', '4', '1', '0319', '1'),
('130529', '巨鹿县', '130500', '4', '1', '0319', '1'),
('130530', '新河县', '130500', '4', '1', '0319', '1'),
('130531', '广宗县', '130500', '4', '1', '0319', '1'),
('130532', '平乡县', '130500', '4', '1', '0319', '1'),
('130533', '威县', '130500', '4', '1', '0319', '1'),
('130534', '清河县', '130500', '4', '1', '0319', '1'),
('130535', '临西县', '130500', '4', '1', '0319', '1'),
('130581', '南宫市', '130500', '4', '1', '0319', '1'),
('130582', '沙河市', '130500', '4', '1', '0319', '1'),
('130600', '保定市', '130000', '3', '1', '0312', '1'),
('130602', '新市区', '130600', '4', '1', '0312', '1'),
('130603', '北市区', '130600', '4', '1', '0312', '1'),
('130604', '南市区', '130600', '4', '1', '0312', '1'),
('130621', '满城县', '130600', '4', '1', '0312', '1'),
('130622', '清苑县', '130600', '4', '1', '0312', '1'),
('130623', '涞水县', '130600', '4', '1', '0312', '1'),
('130624', '阜平县', '130600', '4', '1', '0312', '1'),
('130625', '徐水县', '130600', '4', '1', '0312', '1'),
('130626', '定兴县', '130600', '4', '1', '0312', '1'),
('130627', '唐县', '130600', '4', '1', '0312', '1'),
('130628', '高阳县', '130600', '4', '1', '0312', '1'),
('130629', '容城县', '130600', '4', '1', '0312', '1'),
('130630', '涞源县', '130600', '4', '1', '0312', '1'),
('130631', '望都县', '130600', '4', '1', '0312', '1'),
('130632', '安新县', '130600', '4', '1', '0312', '1'),
('130633', '易县', '130600', '4', '1', '0312', '1'),
('130634', '曲阳县', '130600', '4', '1', '0312', '1'),
('130635', '蠡县', '130600', '4', '1', '0312', '1'),
('130636', '顺平县', '130600', '4', '1', '0312', '1'),
('130637', '博野县', '130600', '4', '1', '0312', '1'),
('130638', '雄县', '130600', '4', '1', '0312', '1'),
('130681', '涿州市', '130600', '4', '1', '0312', '1'),
('130682', '定州市', '130600', '4', '1', '0312', '1'),
('130683', '安国市', '130600', '4', '1', '0312', '1'),
('130684', '高碑店市', '130600', '4', '1', '0312', '1'),
('130700', '张家口市', '130000', '3', '1', '0313', '1'),
('130702', '桥东区', '130700', '4', '1', '0313', '1'),
('130703', '桥西区', '130700', '4', '1', '0313', '1'),
('130705', '宣化区', '130700', '4', '1', '0313', '1'),
('130706', '下花园区', '130700', '4', '1', '0313', '1'),
('130721', '宣化县', '130700', '4', '1', '0313', '1'),
('130722', '张北县', '130700', '4', '1', '0313', '1'),
('130723', '康保县', '130700', '4', '1', '0313', '1'),
('130724', '沽源县', '130700', '4', '1', '0313', '1'),
('130725', '尚义县', '130700', '4', '1', '0313', '1'),
('130726', '蔚县', '130700', '4', '1', '0313', '1'),
('130727', '阳原县', '130700', '4', '1', '0313', '1'),
('130728', '怀安县', '130700', '4', '1', '0313', '1'),
('130729', '万全县', '130700', '4', '1', '0313', '1'),
('130730', '怀来县', '130700', '4', '1', '0313', '1'),
('130731', '涿鹿县', '130700', '4', '1', '0313', '1'),
('130732', '赤城县', '130700', '4', '1', '0313', '1'),
('130733', '崇礼县', '130700', '4', '1', '0313', '1'),
('130800', '承德市', '130000', '3', '1', '0314', '1'),
('130802', '双桥区', '130800', '4', '1', '0314', '1'),
('130803', '双滦区', '130800', '4', '1', '0314', '1'),
('130804', '鹰手营子矿区', '130800', '4', '1', '0314', '1'),
('130821', '承德县', '130800', '4', '1', '0314', '1'),
('130822', '兴隆县', '130800', '4', '1', '0314', '1'),
('130823', '平泉县', '130800', '4', '1', '0314', '1'),
('130824', '滦平县', '130800', '4', '1', '0314', '1'),
('130825', '隆化县', '130800', '4', '1', '0314', '1'),
('130826', '丰宁满族自治县', '130800', '4', '1', '0314', '1'),
('130827', '宽城满族自治县', '130800', '4', '1', '0314', '1'),
('130828', '围场满族蒙古族自治县', '130800', '4', '1', '0314', '1'),
('130900', '沧州市', '130000', '3', '1', '0317', '1'),
('130902', '新华区', '130900', '4', '1', '0317', '1'),
('130903', '运河区', '130900', '4', '1', '0317', '1'),
('130921', '沧县', '130900', '4', '1', '0317', '1'),
('130922', '青县', '130900', '4', '1', '0317', '1'),
('130923', '东光县', '130900', '4', '1', '0317', '1'),
('130924', '海兴县', '130900', '4', '1', '0317', '1'),
('130925', '盐山县', '130900', '4', '1', '0317', '1'),
('130926', '肃宁县', '130900', '4', '1', '0317', '1'),
('130927', '南皮县', '130900', '4', '1', '0317', '1'),
('130928', '吴桥县', '130900', '4', '1', '0317', '1'),
('130929', '献县', '130900', '4', '1', '0317', '1'),
('130930', '孟村回族自治县', '130900', '4', '1', '0317', '1'),
('130981', '泊头市', '130900', '4', '1', '0317', '1'),
('130982', '任丘市', '130900', '4', '1', '0317', '1'),
('130983', '黄骅市', '130900', '4', '1', '0317', '1'),
('130984', '河间市', '130900', '4', '1', '0317', '1'),
('131000', '廊坊市', '130000', '3', '1', '0316', '1'),
('131002', '安次区', '131000', '4', '1', '0316', '1'),
('131003', '广阳区', '131000', '4', '1', '0316', '1'),
('131022', '固安县', '131000', '4', '1', '0316', '1'),
('131023', '永清县', '131000', '4', '1', '0316', '1'),
('131024', '香河县', '131000', '4', '1', '0316', '1'),
('131025', '大城县', '131000', '4', '1', '0316', '1'),
('131026', '文安县', '131000', '4', '1', '0316', '1'),
('131028', '大厂回族自治县', '131000', '4', '1', '0316', '1'),
('131081', '霸州市', '131000', '4', '1', '0316', '1'),
('131082', '三河市', '131000', '4', '1', '0316', '1'),
('131100', '衡水市', '130000', '3', '1', '0318', '1'),
('131102', '桃城区', '131100', '4', '1', '0318', '1'),
('131121', '枣强县', '131100', '4', '1', '0318', '1'),
('131122', '武邑县', '131100', '4', '1', '0318', '1'),
('131123', '武强县', '131100', '4', '1', '0318', '1'),
('131124', '饶阳县', '131100', '4', '1', '0318', '1'),
('131125', '安平县', '131100', '4', '1', '0318', '1'),
('131126', '故城县', '131100', '4', '1', '0318', '1'),
('131127', '景县', '131100', '4', '1', '0318', '1'),
('131128', '阜城县', '131100', '4', '1', '0318', '1'),
('131181', '冀州市', '131100', '4', '1', '0318', '1'),
('131182', '深州市', '131100', '4', '1', '0318', '1'),
('140000', '山西省', 'CN9999', '2', '1', NULL, '1'),
('140100', '太原市', '140000', '3', '1', '0351', '1'),
('140105', '小店区', '140100', '4', '1', '0351', '1'),
('140106', '迎泽区', '140100', '4', '1', '0351', '1'),
('140107', '杏花岭区', '140100', '4', '1', '0351', '1'),
('140108', '尖草坪区', '140100', '4', '1', '0351', '1'),
('140109', '万柏林区', '140100', '4', '1', '0351', '1'),
('140110', '晋源区', '140100', '4', '1', '0351', '1'),
('140121', '清徐县', '140100', '4', '1', '0351', '1'),
('140122', '阳曲县', '140100', '4', '1', '0351', '1'),
('140123', '娄烦县', '140100', '4', '1', '0351', '1'),
('140181', '古交市', '140100', '4', '1', '0351', '1'),
('140200', '大同市', '140000', '3', '1', '0352', '1'),
('140202', '城区', '140200', '4', '1', '0352', '1'),
('140203', '矿区', '140200', '4', '1', '0352', '1'),
('140211', '南郊区', '140200', '4', '1', '0352', '1'),
('140212', '新荣区', '140200', '4', '1', '0352', '1'),
('140221', '阳高县', '140200', '4', '1', '0352', '1'),
('140222', '天镇县', '140200', '4', '1', '0352', '1'),
('140223', '广灵县', '140200', '4', '1', '0352', '1'),
('140224', '灵丘县', '140200', '4', '1', '0352', '1'),
('140225', '浑源县', '140200', '4', '1', '0352', '1'),
('140226', '左云县', '140200', '4', '1', '0352', '1'),
('140227', '大同县', '140200', '4', '1', '0352', '1'),
('140300', '阳泉市', '140000', '3', '1', '0353', '1'),
('140302', '城区', '140300', '4', '1', '0353', '1'),
('140303', '矿区', '140300', '4', '1', '0353', '1'),
('140311', '郊区', '140300', '4', '1', '0353', '1'),
('140321', '平定县', '140300', '4', '1', '0353', '1'),
('140322', '盂县', '140300', '4', '1', '0353', '1'),
('140400', '长治市', '140000', '3', '1', '0355', '1'),
('140402', '城区', '140400', '4', '1', '0355', '1'),
('140411', '郊区', '140400', '4', '1', '0355', '1'),
('140421', '长治县', '140400', '4', '1', '0355', '1'),
('140423', '襄垣县', '140400', '4', '1', '0355', '1'),
('140424', '屯留县', '140400', '4', '1', '0355', '1'),
('140425', '平顺县', '140400', '4', '1', '0355', '1'),
('140426', '黎城县', '140400', '4', '1', '0355', '1'),
('140427', '壶关县', '140400', '4', '1', '0355', '1'),
('140428', '长子县', '140400', '4', '1', '0355', '1'),
('140429', '武乡县', '140400', '4', '1', '0355', '1'),
('140430', '沁县', '140400', '4', '1', '0355', '1'),
('140431', '沁源县', '140400', '4', '1', '0355', '1'),
('140481', '潞城市', '140400', '4', '1', '0355', '1'),
('140500', '晋城市', '140000', '3', '1', '0356', '1'),
('140502', '城区', '140500', '4', '1', '0356', '1'),
('140521', '沁水县', '140500', '4', '1', '0356', '1'),
('140522', '阳城县', '140500', '4', '1', '0356', '1'),
('140524', '陵川县', '140500', '4', '1', '0356', '1'),
('140525', '泽州县', '140500', '4', '1', '0356', '1'),
('140581', '高平市', '140500', '4', '1', '0356', '1'),
('140600', '朔州市', '140000', '3', '1', '0349', '1'),
('140602', '朔城区', '140600', '4', '1', '0349', '1'),
('140603', '平鲁区', '140600', '4', '1', '0349', '1'),
('140621', '山阴县', '140600', '4', '1', '0349', '1'),
('140622', '应县', '140600', '4', '1', '0349', '1'),
('140623', '右玉县', '140600', '4', '1', '0349', '1'),
('140624', '怀仁县', '140600', '4', '1', '0349', '1'),
('140700', '晋中市', '140000', '3', '1', '0354', '1'),
('140702', '榆次区', '140700', '4', '1', '0354', '1'),
('140721', '榆社县', '140700', '4', '1', '0354', '1'),
('140722', '左权县', '140700', '4', '1', '0354', '1'),
('140723', '和顺县', '140700', '4', '1', '0354', '1'),
('140724', '昔阳县', '140700', '4', '1', '0354', '1'),
('140725', '寿阳县', '140700', '4', '1', '0354', '1'),
('140726', '太谷县', '140700', '4', '1', '0354', '1'),
('140727', '祁县', '140700', '4', '1', '0354', '1'),
('140728', '平遥县', '140700', '4', '1', '0354', '1'),
('140729', '灵石县', '140700', '4', '1', '0354', '1'),
('140781', '介休市', '140700', '4', '1', '0354', '1'),
('140800', '运城市', '140000', '3', '1', '0359', '1'),
('140802', '盐湖区', '140800', '4', '1', '0359', '1'),
('140821', '临猗县', '140800', '4', '1', '0359', '1'),
('140822', '万荣县', '140800', '4', '1', '0359', '1'),
('140823', '闻喜县', '140800', '4', '1', '0359', '1'),
('140824', '稷山县', '140800', '4', '1', '0359', '1'),
('140825', '新绛县', '140800', '4', '1', '0359', '1'),
('140826', '绛县', '140800', '4', '1', '0359', '1'),
('140827', '垣曲县', '140800', '4', '1', '0359', '1'),
('140828', '夏县', '140800', '4', '1', '0359', '1'),
('140829', '平陆县', '140800', '4', '1', '0359', '1'),
('140830', '芮城县', '140800', '4', '1', '0359', '1'),
('140881', '永济市', '140800', '4', '1', '0359', '1'),
('140882', '河津市', '140800', '4', '1', '0359', '1'),
('140900', '忻州市', '140000', '3', '1', '0350', '1'),
('140902', '忻府区', '140900', '4', '1', '0350', '1'),
('140921', '定襄县', '140900', '4', '1', '0350', '1'),
('140922', '五台县', '140900', '4', '1', '0350', '1'),
('140923', '代县', '140900', '4', '1', '0350', '1'),
('140924', '繁峙县', '140900', '4', '1', '0350', '1'),
('140925', '宁武县', '140900', '4', '1', '0350', '1'),
('140926', '静乐县', '140900', '4', '1', '0350', '1'),
('140927', '神池县', '140900', '4', '1', '0350', '1'),
('140928', '五寨县', '140900', '4', '1', '0350', '1'),
('140929', '岢岚县', '140900', '4', '1', '0350', '1'),
('140930', '河曲县', '140900', '4', '1', '0350', '1'),
('140931', '保德县', '140900', '4', '1', '0350', '1'),
('140932', '偏关县', '140900', '4', '1', '0350', '1'),
('140981', '原平市', '140900', '4', '1', '0350', '1'),
('141000', '临汾市', '140000', '3', '1', '0357', '1'),
('141002', '尧都区', '141000', '4', '1', '0357', '1'),
('141021', '曲沃县', '141000', '4', '1', '0357', '1'),
('141022', '翼城县', '141000', '4', '1', '0357', '1'),
('141023', '襄汾县', '141000', '4', '1', '0357', '1'),
('141024', '洪洞县', '141000', '4', '1', '0357', '1'),
('141025', '古县', '141000', '4', '1', '0357', '1'),
('141026', '安泽县', '141000', '4', '1', '0357', '1'),
('141027', '浮山县', '141000', '4', '1', '0357', '1'),
('141028', '吉县', '141000', '4', '1', '0357', '1'),
('141029', '乡宁县', '141000', '4', '1', '0357', '1'),
('141030', '大宁县', '141000', '4', '1', '0357', '1'),
('141031', '隰县', '141000', '4', '1', '0357', '1'),
('141032', '永和县', '141000', '4', '1', '0357', '1'),
('141033', '蒲县', '141000', '4', '1', '0357', '1'),
('141034', '汾西县', '141000', '4', '1', '0357', '1'),
('141081', '侯马市', '141000', '4', '1', '0357', '1'),
('141082', '霍州市', '141000', '4', '1', '0357', '1'),
('141100', '吕梁市', '140000', '3', '1', NULL, '1'),
('141102', '离石区', '141100', '4', '1', NULL, '1'),
('141121', '文水县', '141100', '4', '1', NULL, '1'),
('141122', '交城县', '141100', '4', '1', NULL, '1'),
('141123', '兴县', '141100', '4', '1', NULL, '1'),
('141124', '临县', '141100', '4', '1', NULL, '1'),
('141125', '柳林县', '141100', '4', '1', NULL, '1'),
('141126', '石楼县', '141100', '4', '1', NULL, '1'),
('141127', '岚县', '141100', '4', '1', NULL, '1'),
('141128', '方山县', '141100', '4', '1', NULL, '1'),
('141129', '中阳县', '141100', '4', '1', NULL, '1'),
('141130', '交口县', '141100', '4', '1', NULL, '1'),
('141181', '孝义市', '141100', '4', '1', NULL, '1'),
('141182', '汾阳市', '141100', '4', '1', NULL, '1'),
('150000', '内蒙古自治区', 'CN9999', '2', '1', NULL, '1'),
('150100', '呼和浩特市', '150000', '3', '1', '0471', '1'),
('150102', '新城区', '150100', '4', '1', '0471', '1'),
('150103', '回民区', '150100', '4', '1', '0471', '1'),
('150104', '玉泉区', '150100', '4', '1', '0471', '1'),
('150105', '赛罕区', '150100', '4', '1', '0471', '1'),
('150121', '土默特左旗', '150100', '4', '1', '0471', '1'),
('150122', '托克托县', '150100', '4', '1', '0471', '1'),
('150123', '和林格尔县', '150100', '4', '1', '0471', '1'),
('150124', '清水河县', '150100', '4', '1', '0471', '1'),
('150125', '武川县', '150100', '4', '1', '0471', '1'),
('150200', '包头市', '150000', '3', '1', '0472', '1'),
('150202', '东河区', '150200', '4', '1', '0472', '1'),
('150203', '昆都仑区', '150200', '4', '1', '0472', '1'),
('150204', '青山区', '150200', '4', '1', '0472', '1'),
('150205', '石拐区', '150200', '4', '1', '0472', '1'),
('150206', '白云鄂博矿区', '150200', '4', '1', '0472', '1'),
('150207', '九原区', '150200', '4', '1', '0472', '1'),
('150221', '土默特右旗', '150200', '4', '1', '0472', '1'),
('150222', '固阳县', '150200', '4', '1', '0472', '1'),
('150223', '达尔罕茂明安联合旗', '150200', '4', '1', '0472', '1'),
('150300', '乌海市', '150000', '3', '1', '0473', '1'),
('150302', '海勃湾区', '150300', '4', '1', '0473', '1'),
('150303', '海南区', '150300', '4', '1', '0473', '1'),
('150304', '乌达区', '150300', '4', '1', '0473', '1'),
('150400', '赤峰市', '150000', '3', '1', '0476', '1'),
('150402', '红山区', '150400', '4', '1', '0476', '1'),
('150403', '元宝山区', '150400', '4', '1', '0476', '1'),
('150404', '松山区', '150400', '4', '1', '0476', '1'),
('150421', '阿鲁科尔沁旗', '150400', '4', '1', '0476', '1'),
('150422', '巴林左旗', '150400', '4', '1', '0476', '1'),
('150423', '巴林右旗', '150400', '4', '1', '0476', '1'),
('150424', '林西县', '150400', '4', '1', '0476', '1'),
('150425', '克什克腾旗', '150400', '4', '1', '0476', '1'),
('150426', '翁牛特旗', '150400', '4', '1', '0476', '1'),
('150428', '喀喇沁旗', '150400', '4', '1', '0476', '1'),
('150429', '宁城县', '150400', '4', '1', '0476', '1'),
('150430', '敖汉旗', '150400', '4', '1', '0476', '1'),
('150500', '通辽市', '150000', '3', '1', '0475', '1'),
('150502', '科尔沁区', '150500', '4', '1', '0475', '1'),
('150521', '科尔沁左翼中旗', '150500', '4', '1', '0475', '1'),
('150522', '科尔沁左翼后旗', '150500', '4', '1', '0475', '1'),
('150523', '开鲁县', '150500', '4', '1', '0475', '1'),
('150524', '库伦旗', '150500', '4', '1', '0475', '1'),
('150525', '奈曼旗', '150500', '4', '1', '0475', '1'),
('150526', '扎鲁特旗', '150500', '4', '1', '0475', '1'),
('150581', '霍林郭勒市', '150500', '4', '1', '0475', '1'),
('150600', '鄂尔多斯市', '150000', '3', '1', '0477', '1'),
('150602', '东胜区', '150600', '4', '1', '0477', '1'),
('150621', '达拉特旗', '150600', '4', '1', '0477', '1'),
('150622', '准格尔旗', '150600', '4', '1', '0477', '1'),
('150623', '鄂托克前旗', '150600', '4', '1', '0477', '1'),
('150624', '鄂托克旗', '150600', '4', '1', '0477', '1'),
('150625', '杭锦旗', '150600', '4', '1', '0477', '1'),
('150626', '乌审旗', '150600', '4', '1', '0477', '1'),
('150627', '伊金霍洛旗', '150600', '4', '1', '0477', '1'),
('150700', '呼伦贝尔市', '150000', '3', '1', '0470', '1'),
('150702', '海拉尔区', '150700', '4', '1', '0470', '1'),
('150721', '阿荣旗', '150700', '4', '1', '0470', '1'),
('150722', '莫力达瓦达斡尔族自治旗', '150700', '4', '1', '0470', '1'),
('150723', '鄂伦春自治旗', '150700', '4', '1', '0470', '1'),
('150724', '鄂温克族自治旗', '150700', '4', '1', '0470', '1'),
('150725', '陈巴尔虎旗', '150700', '4', '1', '0470', '1'),
('150726', '新巴尔虎左旗', '150700', '4', '1', '0470', '1'),
('150727', '新巴尔虎右旗', '150700', '4', '1', '0470', '1'),
('150781', '满洲里市', '150700', '4', '1', '0470', '1'),
('150782', '牙克石市', '150700', '4', '1', '0470', '1'),
('150783', '扎兰屯市', '150700', '4', '1', '0470', '1'),
('150784', '额尔古纳市', '150700', '4', '1', '0470', '1'),
('150785', '根河市', '150700', '4', '1', '0470', '1'),
('150800', '巴彦淖尔市', '150000', '3', '1', NULL, '1'),
('150802', '临河区', '150800', '4', '1', NULL, '1'),
('150821', '五原县', '150800', '4', '1', NULL, '1'),
('150822', '磴口县', '150800', '4', '1', NULL, '1'),
('150823', '乌拉特前旗', '150800', '4', '1', NULL, '1'),
('150824', '乌拉特中旗', '150800', '4', '1', NULL, '1'),
('150825', '乌拉特后旗', '150800', '4', '1', NULL, '1'),
('150826', '杭锦后旗', '150800', '4', '1', NULL, '1'),
('150900', '乌兰察布市', '150000', '3', '1', NULL, '1'),
('150902', '集宁区', '150900', '4', '1', NULL, '1'),
('150921', '卓资县', '150900', '4', '1', NULL, '1'),
('150922', '化德县', '150900', '4', '1', NULL, '1'),
('150923', '商都县', '150900', '4', '1', NULL, '1'),
('150924', '兴和县', '150900', '4', '1', NULL, '1'),
('150925', '凉城县', '150900', '4', '1', NULL, '1'),
('150926', '察哈尔右翼前旗', '150900', '4', '1', NULL, '1'),
('150927', '察哈尔右翼中旗', '150900', '4', '1', NULL, '1'),
('150928', '察哈尔右翼后旗', '150900', '4', '1', NULL, '1'),
('150929', '四子王旗', '150900', '4', '1', NULL, '1'),
('150981', '丰镇市', '150900', '4', '1', NULL, '1'),
('152200', '兴安盟', '150000', '3', '1', '0482', '1'),
('152201', '乌兰浩特市', '152200', '4', '1', '0482', '1'),
('152202', '阿尔山市', '152200', '4', '1', '0482', '1'),
('152221', '科尔沁右翼前旗', '152200', '4', '1', '0482', '1'),
('152222', '科尔沁右翼中旗', '152200', '4', '1', '0482', '1'),
('152223', '扎赉特旗', '152200', '4', '1', '0482', '1'),
('152224', '突泉县', '152200', '4', '1', '0482', '1'),
('152500', '锡林郭勒盟', '150000', '3', '1', '0479', '1'),
('152501', '二连浩特市', '152500', '4', '1', '0479', '1'),
('152502', '锡林浩特市', '152500', '4', '1', '0479', '1'),
('152522', '阿巴嘎旗', '152500', '4', '1', '0479', '1'),
('152523', '苏尼特左旗', '152500', '4', '1', '0479', '1'),
('152524', '苏尼特右旗', '152500', '4', '1', '0479', '1'),
('152525', '东乌珠穆沁旗', '152500', '4', '1', '0479', '1'),
('152526', '西乌珠穆沁旗', '152500', '4', '1', '0479', '1'),
('152527', '太仆寺旗', '152500', '4', '1', '0479', '1'),
('152528', '镶黄旗', '152500', '4', '1', '0479', '1'),
('152529', '正镶白旗', '152500', '4', '1', '0479', '1'),
('152530', '正蓝旗', '152500', '4', '1', '0479', '1'),
('152531', '多伦县', '152500', '4', '1', '0479', '1'),
('152900', '阿拉善盟', '150000', '3', '1', '0483', '1'),
('152921', '阿拉善左旗', '152900', '4', '1', '0483', '1'),
('152922', '阿拉善右旗', '152900', '4', '1', '0483', '1'),
('152923', '额济纳旗', '152900', '4', '1', '0483', '1'),
('210000', '辽宁省', 'CN9999', '2', '1', NULL, '1'),
('210100', '沈阳市', '210000', '3', '1', '024', '1'),
('210102', '和平区', '210100', '4', '1', '024', '1'),
('210103', '沈河区', '210100', '4', '1', '024', '1'),
('210104', '大东区', '210100', '4', '1', '024', '1'),
('210105', '皇姑区', '210100', '4', '1', '024', '1'),
('210106', '铁西区', '210100', '4', '1', '024', '1'),
('210111', '苏家屯区', '210100', '4', '1', '024', '1'),
('210112', '东陵区', '210100', '4', '1', '024', '1'),
('210113', '沈北新区', '210100', '4', '1', '024', '1'),
('210114', '于洪区', '210100', '4', '1', '024', '1'),
('210122', '辽中县', '210100', '4', '1', '024', '1'),
('210123', '康平县', '210100', '4', '1', '024', '1'),
('210124', '法库县', '210100', '4', '1', '024', '1'),
('210181', '新民市', '210100', '4', '1', '024', '1'),
('210200', '大连市', '210000', '3', '1', '0411', '1'),
('210202', '中山区', '210200', '4', '1', '0411', '1'),
('210203', '西岗区', '210200', '4', '1', '0411', '1'),
('210204', '沙河口区', '210200', '4', '1', '0411', '1'),
('210211', '甘井子区', '210200', '4', '1', '0411', '1'),
('210212', '旅顺口区', '210200', '4', '1', '0411', '1'),
('210213', '金州区', '210200', '4', '1', '0411', '1'),
('210224', '长海县', '210200', '4', '1', '0411', '1'),
('210281', '瓦房店市', '210200', '4', '1', '0411', '1'),
('210282', '普兰店市', '210200', '4', '1', '0411', '1'),
('210283', '庄河市', '210200', '4', '1', '0411', '1'),
('210300', '鞍山市', '210000', '3', '1', '0412', '1'),
('210302', '铁东区', '210300', '4', '1', '0412', '1'),
('210303', '铁西区', '210300', '4', '1', '0412', '1'),
('210304', '立山区', '210300', '4', '1', '0412', '1'),
('210311', '千山区', '210300', '4', '1', '0412', '1'),
('210321', '台安县', '210300', '4', '1', '0412', '1'),
('210323', '岫岩满族自治县', '210300', '4', '1', '0412', '1'),
('210381', '海城市', '210300', '4', '1', '0412', '1'),
('210400', '抚顺市', '210000', '3', '1', '0413', '1'),
('210402', '新抚区', '210400', '4', '1', '0413', '1'),
('210403', '东洲区', '210400', '4', '1', '0413', '1'),
('210404', '望花区', '210400', '4', '1', '0413', '1'),
('210411', '顺城区', '210400', '4', '1', '0413', '1'),
('210421', '抚顺县', '210400', '4', '1', '0413', '1'),
('210422', '新宾满族自治县', '210400', '4', '1', '0413', '1'),
('210423', '清原满族自治县', '210400', '4', '1', '0413', '1'),
('210500', '本溪市', '210000', '3', '1', '0414', '1'),
('210502', '平山区', '210500', '4', '1', '0414', '1'),
('210503', '溪湖区', '210500', '4', '1', '0414', '1'),
('210504', '明山区', '210500', '4', '1', '0414', '1'),
('210505', '南芬区', '210500', '4', '1', '0414', '1'),
('210521', '本溪满族自治县', '210500', '4', '1', '0414', '1'),
('210522', '桓仁满族自治县', '210500', '4', '1', '0414', '1'),
('210600', '丹东市', '210000', '3', '1', '0415', '1'),
('210602', '元宝区', '210600', '4', '1', '0415', '1'),
('210603', '振兴区', '210600', '4', '1', '0415', '1'),
('210604', '振安区', '210600', '4', '1', '0415', '1'),
('210624', '宽甸满族自治县', '210600', '4', '1', '0415', '1'),
('210681', '东港市', '210600', '4', '1', '0415', '1'),
('210682', '凤城市', '210600', '4', '1', '0415', '1'),
('210700', '锦州市', '210000', '3', '1', '0416', '1'),
('210702', '古塔区', '210700', '4', '1', '0416', '1'),
('210703', '凌河区', '210700', '4', '1', '0416', '1'),
('210711', '太和区', '210700', '4', '1', '0416', '1'),
('210726', '黑山县', '210700', '4', '1', '0416', '1'),
('210727', '义县', '210700', '4', '1', '0416', '1'),
('210781', '凌海市', '210700', '4', '1', '0416', '1'),
('210782', '北镇市', '210700', '4', '1', '0416', '1'),
('210800', '营口市', '210000', '3', '1', '0417', '1'),
('210802', '站前区', '210800', '4', '1', '0417', '1'),
('210803', '西市区', '210800', '4', '1', '0417', '1'),
('210804', '鲅鱼圈区', '210800', '4', '1', '0417', '1'),
('210811', '老边区', '210800', '4', '1', '0417', '1'),
('210881', '盖州市', '210800', '4', '1', '0417', '1'),
('210882', '大石桥市', '210800', '4', '1', '0417', '1'),
('210900', '阜新市', '210000', '3', '1', '0418', '1'),
('210902', '海州区', '210900', '4', '1', '0418', '1'),
('210903', '新邱区', '210900', '4', '1', '0418', '1'),
('210904', '太平区', '210900', '4', '1', '0418', '1'),
('210905', '清河门区', '210900', '4', '1', '0418', '1'),
('210911', '细河区', '210900', '4', '1', '0418', '1'),
('210921', '阜新蒙古族自治县', '210900', '4', '1', '0418', '1'),
('210922', '彰武县', '210900', '4', '1', '0418', '1'),
('211000', '辽阳市', '210000', '3', '1', '0419', '1'),
('211002', '白塔区', '211000', '4', '1', '0419', '1'),
('211003', '文圣区', '211000', '4', '1', '0419', '1'),
('211004', '宏伟区', '211000', '4', '1', '0419', '1'),
('211005', '弓长岭区', '211000', '4', '1', '0419', '1'),
('211011', '太子河区', '211000', '4', '1', '0419', '1'),
('211021', '辽阳县', '211000', '4', '1', '0419', '1'),
('211081', '灯塔市', '211000', '4', '1', '0419', '1'),
('211100', '盘锦市', '210000', '3', '1', '0427', '1'),
('211102', '双台子区', '211100', '4', '1', '0427', '1'),
('211103', '兴隆台区', '211100', '4', '1', '0427', '1'),
('211121', '大洼县', '211100', '4', '1', '0427', '1'),
('211122', '盘山县', '211100', '4', '1', '0427', '1'),
('211200', '铁岭市', '210000', '3', '1', '0410', '1'),
('211202', '银州区', '211200', '4', '1', '0410', '1'),
('211204', '清河区', '211200', '4', '1', '0410', '1'),
('211221', '铁岭县', '211200', '4', '1', '0410', '1'),
('211223', '西丰县', '211200', '4', '1', '0410', '1'),
('211224', '昌图县', '211200', '4', '1', '0410', '1'),
('211281', '调兵山市', '211200', '4', '1', '0410', '1'),
('211282', '开原市', '211200', '4', '1', '0410', '1'),
('211300', '朝阳市', '210000', '3', '1', '0421', '1'),
('211302', '双塔区', '211300', '4', '1', '0421', '1'),
('211303', '龙城区', '211300', '4', '1', '0421', '1'),
('211321', '朝阳县', '211300', '4', '1', '0421', '1'),
('211322', '建平县', '211300', '4', '1', '0421', '1'),
('211324', '喀喇沁左翼蒙古族自治县', '211300', '4', '1', '0421', '1'),
('211381', '北票市', '211300', '4', '1', '0421', '1'),
('211382', '凌源市', '211300', '4', '1', '0421', '1'),
('211400', '葫芦岛市', '210000', '3', '1', '0429', '1'),
('211402', '连山区', '211400', '4', '1', '0429', '1'),
('211403', '龙港区', '211400', '4', '1', '0429', '1'),
('211404', '南票区', '211400', '4', '1', '0429', '1'),
('211421', '绥中县', '211400', '4', '1', '0429', '1'),
('211422', '建昌县', '211400', '4', '1', '0429', '1'),
('211481', '兴城市', '211400', '4', '1', '0429', '1'),
('220000', '吉林省', 'CN9999', '2', '1', NULL, '1'),
('220100', '长春市', '220000', '3', '1', '0431', '1'),
('220102', '南关区', '220100', '4', '1', '0431', '1'),
('220103', '宽城区', '220100', '4', '1', '0431', '1'),
('220104', '朝阳区', '220100', '4', '1', '0431', '1'),
('220105', '二道区', '220100', '4', '1', '0431', '1'),
('220106', '绿园区', '220100', '4', '1', '0431', '1'),
('220112', '双阳区', '220100', '4', '1', '0431', '1'),
('220122', '农安县', '220100', '4', '1', '0431', '1'),
('220181', '九台市', '220100', '4', '1', '0431', '1'),
('220182', '榆树市', '220100', '4', '1', '0431', '1'),
('220183', '德惠市', '220100', '4', '1', '0431', '1'),
('220200', '吉林市', '220000', '3', '1', '0432', '1'),
('220202', '昌邑区', '220200', '4', '1', '0432', '1'),
('220203', '龙潭区', '220200', '4', '1', '0432', '1'),
('220204', '船营区', '220200', '4', '1', '0432', '1'),
('220211', '丰满区', '220200', '4', '1', '0432', '1'),
('220221', '永吉县', '220200', '4', '1', '0432', '1'),
('220281', '蛟河市', '220200', '4', '1', '0432', '1'),
('220282', '桦甸市', '220200', '4', '1', '0432', '1'),
('220283', '舒兰市', '220200', '4', '1', '0432', '1'),
('220284', '磐石市', '220200', '4', '1', '0432', '1'),
('220300', '四平市', '220000', '3', '1', '0434', '1'),
('220302', '铁西区', '220300', '4', '1', '0434', '1'),
('220303', '铁东区', '220300', '4', '1', '0434', '1'),
('220322', '梨树县', '220300', '4', '1', '0434', '1'),
('220323', '伊通满族自治县', '220300', '4', '1', '0434', '1'),
('220381', '公主岭市', '220300', '4', '1', '0434', '1'),
('220382', '双辽市', '220300', '4', '1', '0434', '1'),
('220400', '辽源市', '220000', '3', '1', '0437', '1'),
('220402', '龙山区', '220400', '4', '1', '0437', '1'),
('220403', '西安区', '220400', '4', '1', '0437', '1'),
('220421', '东丰县', '220400', '4', '1', '0437', '1'),
('220422', '东辽县', '220400', '4', '1', '0437', '1'),
('220500', '通化市', '220000', '3', '1', '0435', '1'),
('220502', '东昌区', '220500', '4', '1', '0435', '1'),
('220503', '二道江区', '220500', '4', '1', '0435', '1'),
('220521', '通化县', '220500', '4', '1', '0435', '1'),
('220523', '辉南县', '220500', '4', '1', '0435', '1'),
('220524', '柳河县', '220500', '4', '1', '0435', '1'),
('220581', '梅河口市', '220500', '4', '1', '0435', '1'),
('220582', '集安市', '220500', '4', '1', '0435', '1'),
('220600', '白山市', '220000', '3', '1', '0439', '1'),
('220602', '八道江区', '220600', '4', '1', '0439', '1'),
('220605', '江源区', '220600', '4', '1', '0439', '1'),
('220621', '抚松县', '220600', '4', '1', '0439', '1'),
('220622', '靖宇县', '220600', '4', '1', '0439', '1'),
('220623', '长白朝鲜族自治县', '220600', '4', '1', '0439', '1'),
('220681', '临江市', '220600', '4', '1', '0439', '1'),
('220700', '松原市', '220000', '3', '1', '0438', '1'),
('220702', '宁江区', '220700', '4', '1', '0438', '1'),
('220721', '前郭尔罗斯蒙古族自治县', '220700', '4', '1', '0438', '1'),
('220722', '长岭县', '220700', '4', '1', '0438', '1'),
('220723', '乾安县', '220700', '4', '1', '0438', '1'),
('220724', '扶余县', '220700', '4', '1', '0438', '1'),
('220800', '白城市', '220000', '3', '1', '0436', '1'),
('220802', '洮北区', '220800', '4', '1', '0436', '1'),
('220821', '镇赉县', '220800', '4', '1', '0436', '1'),
('220822', '通榆县', '220800', '4', '1', '0436', '1'),
('220881', '洮南市', '220800', '4', '1', '0436', '1'),
('220882', '大安市', '220800', '4', '1', '0436', '1'),
('222400', '延边朝鲜族自治州', '220000', '3', '1', '0433', '1'),
('222401', '延吉市', '222400', '4', '1', '0433', '1'),
('222402', '图们市', '222400', '4', '1', '0433', '1'),
('222403', '敦化市', '222400', '4', '1', '0433', '1'),
('222404', '珲春市', '222400', '4', '1', '0433', '1'),
('222405', '龙井市', '222400', '4', '1', '0433', '1'),
('222406', '和龙市', '222400', '4', '1', '0433', '1'),
('222424', '汪清县', '222400', '4', '1', '0433', '1'),
('222426', '安图县', '222400', '4', '1', '0433', '1'),
('230000', '黑龙江省', 'CN9999', '2', '1', NULL, '1'),
('230100', '哈尔滨市', '230000', '3', '1', '0451', '1'),
('230102', '道里区', '230100', '4', '1', '0451', '1'),
('230103', '南岗区', '230100', '4', '1', '0451', '1'),
('230104', '道外区', '230100', '4', '1', '0451', '1'),
('230108', '平房区', '230100', '4', '1', '0451', '1'),
('230109', '松北区', '230100', '4', '1', '0451', '1'),
('230110', '香坊区', '230100', '4', '1', '0451', '1'),
('230111', '呼兰区', '230100', '4', '1', '0451', '1'),
('230112', '阿城区', '230100', '4', '1', '0451', '1'),
('230123', '依兰县', '230100', '4', '1', '0451', '1'),
('230124', '方正县', '230100', '4', '1', '0451', '1'),
('230125', '宾县', '230100', '4', '1', '0451', '1'),
('230126', '巴彦县', '230100', '4', '1', '0451', '1'),
('230127', '木兰县', '230100', '4', '1', '0451', '1'),
('230128', '通河县', '230100', '4', '1', '0451', '1'),
('230129', '延寿县', '230100', '4', '1', '0451', '1'),
('230182', '双城市', '230100', '4', '1', '0451', '1'),
('230183', '尚志市', '230100', '4', '1', '0451', '1'),
('230184', '五常市', '230100', '4', '1', '0451', '1'),
('230200', '齐齐哈尔市', '230000', '3', '1', '0452', '1'),
('230202', '龙沙区', '230200', '4', '1', '0452', '1'),
('230203', '建华区', '230200', '4', '1', '0452', '1'),
('230204', '铁锋区', '230200', '4', '1', '0452', '1'),
('230205', '昂昂溪区', '230200', '4', '1', '0452', '1'),
('230206', '富拉尔基区', '230200', '4', '1', '0452', '1'),
('230207', '碾子山区', '230200', '4', '1', '0452', '1'),
('230208', '梅里斯达斡尔族区', '230200', '4', '1', '0452', '1'),
('230221', '龙江县', '230200', '4', '1', '0452', '1'),
('230223', '依安县', '230200', '4', '1', '0452', '1'),
('230224', '泰来县', '230200', '4', '1', '0452', '1'),
('230225', '甘南县', '230200', '4', '1', '0452', '1'),
('230227', '富裕县', '230200', '4', '1', '0452', '1'),
('230229', '克山县', '230200', '4', '1', '0452', '1'),
('230230', '克东县', '230200', '4', '1', '0452', '1'),
('230231', '拜泉县', '230200', '4', '1', '0452', '1'),
('230281', '讷河市', '230200', '4', '1', '0452', '1'),
('230300', '鸡西市', '230000', '3', '1', '0467', '1'),
('230302', '鸡冠区', '230300', '4', '1', '0467', '1'),
('230303', '恒山区', '230300', '4', '1', '0467', '1'),
('230304', '滴道区', '230300', '4', '1', '0467', '1'),
('230305', '梨树区', '230300', '4', '1', '0467', '1'),
('230306', '城子河区', '230300', '4', '1', '0467', '1'),
('230307', '麻山区', '230300', '4', '1', '0467', '1'),
('230321', '鸡东县', '230300', '4', '1', '0467', '1'),
('230381', '虎林市', '230300', '4', '1', '0467', '1'),
('230382', '密山市', '230300', '4', '1', '0467', '1'),
('230400', '鹤岗市', '230000', '3', '1', '0468', '1'),
('230402', '向阳区', '230400', '4', '1', '0468', '1'),
('230403', '工农区', '230400', '4', '1', '0468', '1'),
('230404', '南山区', '230400', '4', '1', '0468', '1'),
('230405', '兴安区', '230400', '4', '1', '0468', '1'),
('230406', '东山区', '230400', '4', '1', '0468', '1'),
('230407', '兴山区', '230400', '4', '1', '0468', '1'),
('230421', '萝北县', '230400', '4', '1', '0468', '1'),
('230422', '绥滨县', '230400', '4', '1', '0468', '1'),
('230500', '双鸭山市', '230000', '3', '1', '0469', '1'),
('230502', '尖山区', '230500', '4', '1', '0469', '1'),
('230503', '岭东区', '230500', '4', '1', '0469', '1'),
('230505', '四方台区', '230500', '4', '1', '0469', '1'),
('230506', '宝山区', '230500', '4', '1', '0469', '1'),
('230521', '集贤县', '230500', '4', '1', '0469', '1'),
('230522', '友谊县', '230500', '4', '1', '0469', '1'),
('230523', '宝清县', '230500', '4', '1', '0469', '1'),
('230524', '饶河县', '230500', '4', '1', '0469', '1'),
('230600', '大庆市', '230000', '3', '1', '0459', '1'),
('230602', '萨尔图区', '230600', '4', '1', '0459', '1'),
('230603', '龙凤区', '230600', '4', '1', '0459', '1'),
('230604', '让胡路区', '230600', '4', '1', '0459', '1'),
('230605', '红岗区', '230600', '4', '1', '0459', '1'),
('230606', '大同区', '230600', '4', '1', '0459', '1'),
('230621', '肇州县', '230600', '4', '1', '0459', '1'),
('230622', '肇源县', '230600', '4', '1', '0459', '1'),
('230623', '林甸县', '230600', '4', '1', '0459', '1'),
('230624', '杜尔伯特蒙古族自治县', '230600', '4', '1', '0459', '1'),
('230700', '伊春市', '230000', '3', '1', '0458', '1'),
('230702', '伊春区', '230700', '4', '1', '0458', '1'),
('230703', '南岔区', '230700', '4', '1', '0458', '1'),
('230704', '友好区', '230700', '4', '1', '0458', '1'),
('230705', '西林区', '230700', '4', '1', '0458', '1'),
('230706', '翠峦区', '230700', '4', '1', '0458', '1'),
('230707', '新青区', '230700', '4', '1', '0458', '1'),
('230708', '美溪区', '230700', '4', '1', '0458', '1'),
('230709', '金山屯区', '230700', '4', '1', '0458', '1'),
('230710', '五营区', '230700', '4', '1', '0458', '1'),
('230711', '乌马河区', '230700', '4', '1', '0458', '1'),
('230712', '汤旺河区', '230700', '4', '1', '0458', '1'),
('230713', '带岭区', '230700', '4', '1', '0458', '1'),
('230714', '乌伊岭区', '230700', '4', '1', '0458', '1'),
('230715', '红星区', '230700', '4', '1', '0458', '1'),
('230716', '上甘岭区', '230700', '4', '1', '0458', '1'),
('230722', '嘉荫县', '230700', '4', '1', '0458', '1'),
('230781', '铁力市', '230700', '4', '1', '0458', '1'),
('230800', '佳木斯市', '230000', '3', '1', '0454', '1'),
('230803', '向阳区', '230800', '4', '1', '0454', '1'),
('230804', '前进区', '230800', '4', '1', '0454', '1'),
('230805', '东风区', '230800', '4', '1', '0454', '1'),
('230811', '郊区', '230800', '4', '1', '0454', '1'),
('230822', '桦南县', '230800', '4', '1', '0454', '1'),
('230826', '桦川县', '230800', '4', '1', '0454', '1'),
('230828', '汤原县', '230800', '4', '1', '0454', '1'),
('230833', '抚远县', '230800', '4', '1', '0454', '1'),
('230881', '同江市', '230800', '4', '1', '0454', '1'),
('230882', '富锦市', '230800', '4', '1', '0454', '1'),
('230900', '七台河市', '230000', '3', '1', '0464', '1'),
('230902', '新兴区', '230900', '4', '1', '0464', '1'),
('230903', '桃山区', '230900', '4', '1', '0464', '1'),
('230904', '茄子河区', '230900', '4', '1', '0464', '1'),
('230921', '勃利县', '230900', '4', '1', '0464', '1'),
('231000', '牡丹江市', '230000', '3', '1', '0453', '1'),
('231002', '东安区', '231000', '4', '1', '0453', '1'),
('231003', '阳明区', '231000', '4', '1', '0453', '1'),
('231004', '爱民区', '231000', '4', '1', '0453', '1'),
('231005', '西安区', '231000', '4', '1', '0453', '1'),
('231024', '东宁县', '231000', '4', '1', '0453', '1'),
('231025', '林口县', '231000', '4', '1', '0453', '1'),
('231081', '绥芬河市', '231000', '4', '1', '0453', '1'),
('231083', '海林市', '231000', '4', '1', '0453', '1'),
('231084', '宁安市', '231000', '4', '1', '0453', '1'),
('231085', '穆棱市', '231000', '4', '1', '0453', '1'),
('231100', '黑河市', '230000', '3', '1', '0456', '1'),
('231102', '爱辉区', '231100', '4', '1', '0456', '1'),
('231121', '嫩江县', '231100', '4', '1', '0456', '1'),
('231123', '逊克县', '231100', '4', '1', '0456', '1'),
('231124', '孙吴县', '231100', '4', '1', '0456', '1'),
('231181', '北安市', '231100', '4', '1', '0456', '1'),
('231182', '五大连池市', '231100', '4', '1', '0456', '1'),
('231200', '绥化市', '230000', '3', '1', '0455', '1'),
('231202', '北林区', '231200', '4', '1', '0455', '1'),
('231221', '望奎县', '231200', '4', '1', '0455', '1'),
('231222', '兰西县', '231200', '4', '1', '0455', '1'),
('231223', '青冈县', '231200', '4', '1', '0455', '1'),
('231224', '庆安县', '231200', '4', '1', '0455', '1'),
('231225', '明水县', '231200', '4', '1', '0455', '1'),
('231226', '绥棱县', '231200', '4', '1', '0455', '1'),
('231281', '安达市', '231200', '4', '1', '0455', '1'),
('231282', '肇东市', '231200', '4', '1', '0455', '1'),
('231283', '海伦市', '231200', '4', '1', '0455', '1'),
('232700', '大兴安岭地区', '230000', '3', '1', '0457', '1'),
('232701', '加格达奇区', '232700', '4', '1', '0457', '1'),
('232702', '松岭区', '232700', '4', '1', '0457', '1'),
('232703', '新林区', '232700', '4', '1', '0457', '1'),
('232704', '呼中区', '232700', '4', '1', '0457', '1'),
('232721', '呼玛县', '232700', '4', '1', '0457', '1'),
('232722', '塔河县', '232700', '4', '1', '0457', '1'),
('232723', '漠河县', '232700', '4', '1', '0457', '1'),
('310000', '上海', 'CN9999', '2', '1', NULL, '1'),
('310100', '上海市', '310000', '3', '1', '021', '1'),
('310101', '黄浦区', '310100', '4', '1', '021', '1'),
('310103', '卢湾区', '310100', '4', '1', '021', '1'),
('310104', '徐汇区', '310100', '4', '1', '021', '1'),
('310105', '长宁区', '310100', '4', '1', '021', '1'),
('310106', '静安区', '310100', '4', '1', '021', '1'),
('310107', '普陀区', '310100', '4', '1', '021', '1'),
('310108', '闸北区', '310100', '4', '1', '021', '1'),
('310109', '虹口区', '310100', '4', '1', '021', '1'),
('310110', '杨浦区', '310100', '4', '1', '021', '1'),
('310112', '闵行区', '310100', '4', '1', '021', '1'),
('310113', '宝山区', '310100', '4', '1', '021', '1'),
('310114', '嘉定区', '310100', '4', '1', '021', '1'),
('310115', '浦东新区', '310100', '4', '1', '021', '1'),
('310116', '金山区', '310100', '4', '1', '021', '1'),
('310117', '松江区', '310100', '4', '1', '021', '1'),
('310118', '青浦区', '310100', '4', '1', '021', '1'),
('310119', '南汇区', '310100', '4', '1', '021', '1'),
('310120', '奉贤区', '310100', '4', '1', '021', '1'),
('310230', '崇明县', '310100', '4', '1', '021', '1'),
('320000', '江苏省', 'CN9999', '2', '1', NULL, '1'),
('320100', '南京市', '320000', '3', '1', '025', '1'),
('320102', '玄武区', '320100', '4', '1', '025', '1'),
('320103', '白下区', '320100', '4', '1', '025', '1'),
('320104', '秦淮区', '320100', '4', '1', '025', '1'),
('320105', '建邺区', '320100', '4', '1', '025', '1'),
('320106', '鼓楼区', '320100', '4', '1', '025', '1'),
('320107', '下关区', '320100', '4', '1', '025', '1'),
('320111', '浦口区', '320100', '4', '1', '025', '1'),
('320113', '栖霞区', '320100', '4', '1', '025', '1'),
('320114', '雨花台区', '320100', '4', '1', '025', '1'),
('320115', '江宁区', '320100', '4', '1', '025', '1'),
('320116', '六合区', '320100', '4', '1', '025', '1'),
('320124', '溧水县', '320100', '4', '1', '025', '1'),
('320125', '高淳县', '320100', '4', '1', '025', '1'),
('320200', '无锡市', '320000', '3', '1', '0510', '1'),
('320202', '崇安区', '320200', '4', '1', '0510', '1'),
('320203', '南长区', '320200', '4', '1', '0510', '1'),
('320204', '北塘区', '320200', '4', '1', '0510', '1'),
('320205', '锡山区', '320200', '4', '1', '0510', '1'),
('320206', '惠山区', '320200', '4', '1', '0510', '1'),
('320211', '滨湖区', '320200', '4', '1', '0510', '1'),
('320281', '江阴市', '320200', '4', '1', '0510', '1'),
('320282', '宜兴市', '320200', '4', '1', '0510', '1'),
('320300', '徐州市', '320000', '3', '1', '0516', '1'),
('320302', '鼓楼区', '320300', '4', '1', '0516', '1'),
('320303', '云龙区', '320300', '4', '1', '0516', '1'),
('320304', '九里区', '320300', '4', '1', '0516', '1'),
('320305', '贾汪区', '320300', '4', '1', '0516', '1'),
('320311', '泉山区', '320300', '4', '1', '0516', '1'),
('320321', '丰县', '320300', '4', '1', '0516', '1'),
('320322', '沛县', '320300', '4', '1', '0516', '1'),
('320323', '铜山县', '320300', '4', '1', '0516', '1'),
('320324', '睢宁县', '320300', '4', '1', '0516', '1'),
('320381', '新沂市', '320300', '4', '1', '0516', '1'),
('320382', '邳州市', '320300', '4', '1', '0516', '1'),
('320400', '常州市', '320000', '3', '1', '0519', '1'),
('320402', '天宁区', '320400', '4', '1', '0519', '1'),
('320404', '钟楼区', '320400', '4', '1', '0519', '1'),
('320405', '戚墅堰区', '320400', '4', '1', '0519', '1'),
('320411', '新北区', '320400', '4', '1', '0519', '1'),
('320412', '武进区', '320400', '4', '1', '0519', '1'),
('320481', '溧阳市', '320400', '4', '1', '0519', '1'),
('320482', '金坛市', '320400', '4', '1', '0519', '1'),
('320500', '苏州市', '320000', '3', '1', '0512', '1'),
('320502', '沧浪区', '320500', '4', '1', '0512', '1'),
('320503', '平江区', '320500', '4', '1', '0512', '1'),
('320504', '金阊区', '320500', '4', '1', '0512', '1'),
('320505', '虎丘区', '320500', '4', '1', '0512', '1'),
('320506', '吴中区', '320500', '4', '1', '0512', '1'),
('320507', '相城区', '320500', '4', '1', '0512', '1'),
('320581', '常熟市', '320500', '4', '1', '0512', '1'),
('320582', '张家港市', '320500', '4', '1', '0512', '1'),
('320583', '昆山市', '320500', '4', '1', '0512', '1'),
('320584', '吴江市', '320500', '4', '1', '0512', '1'),
('320585', '太仓市', '320500', '4', '1', '0512', '1'),
('320600', '南通市', '320000', '3', '1', '0513', '1'),
('320602', '崇川区', '320600', '4', '1', '0513', '1'),
('320611', '港闸区', '320600', '4', '1', '0513', '1'),
('320621', '海安县', '320600', '4', '1', '0513', '1'),
('320623', '如东县', '320600', '4', '1', '0513', '1'),
('320681', '启东市', '320600', '4', '1', '0513', '1'),
('320682', '如皋市', '320600', '4', '1', '0513', '1'),
('320683', '通州市', '320600', '4', '1', '0513', '1'),
('320684', '海门市', '320600', '4', '1', '0513', '1'),
('320700', '连云港市', '320000', '3', '1', '0518', '1'),
('320703', '连云区', '320700', '4', '1', '0518', '1'),
('320705', '新浦区', '320700', '4', '1', '0518', '1'),
('320706', '海州区', '320700', '4', '1', '0518', '1'),
('320721', '赣榆县', '320700', '4', '1', '0518', '1'),
('320722', '东海县', '320700', '4', '1', '0518', '1'),
('320723', '灌云县', '320700', '4', '1', '0518', '1'),
('320724', '灌南县', '320700', '4', '1', '0518', '1'),
('320800', '淮安市', '320000', '3', '1', '0517', '1'),
('320802', '清河区', '320800', '4', '1', '0517', '1'),
('320803', '楚州区', '320800', '4', '1', '0517', '1'),
('320804', '淮阴区', '320800', '4', '1', '0517', '1'),
('320811', '清浦区', '320800', '4', '1', '0517', '1'),
('320826', '涟水县', '320800', '4', '1', '0517', '1'),
('320829', '洪泽县', '320800', '4', '1', '0517', '1'),
('320830', '盱眙县', '320800', '4', '1', '0517', '1'),
('320831', '金湖县', '320800', '4', '1', '0517', '1'),
('320900', '盐城市', '320000', '3', '1', '0515', '1'),
('320902', '亭湖区', '320900', '4', '1', '0515', '1'),
('320903', '盐都区', '320900', '4', '1', '0515', '1'),
('320921', '响水县', '320900', '4', '1', '0515', '1'),
('320922', '滨海县', '320900', '4', '1', '0515', '1'),
('320923', '阜宁县', '320900', '4', '1', '0515', '1'),
('320924', '射阳县', '320900', '4', '1', '0515', '1'),
('320925', '建湖县', '320900', '4', '1', '0515', '1'),
('320981', '东台市', '320900', '4', '1', '0515', '1'),
('320982', '大丰市', '320900', '4', '1', '0515', '1'),
('321000', '扬州市', '320000', '3', '1', '0514', '1'),
('321002', '广陵区', '321000', '4', '1', '0514', '1'),
('321003', '邗江区', '321000', '4', '1', '0514', '1'),
('321011', '维扬区', '321000', '4', '1', '0514', '1'),
('321023', '宝应县', '321000', '4', '1', '0514', '1'),
('321081', '仪征市', '321000', '4', '1', '0514', '1'),
('321084', '高邮市', '321000', '4', '1', '0514', '1'),
('321088', '江都市', '321000', '4', '1', '0514', '1'),
('321100', '镇江市', '320000', '3', '1', '0511', '1'),
('321102', '京口区', '321100', '4', '1', '0511', '1'),
('321111', '润州区', '321100', '4', '1', '0511', '1'),
('321112', '丹徒区', '321100', '4', '1', '0511', '1'),
('321181', '丹阳市', '321100', '4', '1', '0511', '1'),
('321182', '扬中市', '321100', '4', '1', '0511', '1'),
('321183', '句容市', '321100', '4', '1', '0511', '1'),
('321200', '泰州市', '320000', '3', '1', '0523', '1'),
('321202', '海陵区', '321200', '4', '1', '0523', '1'),
('321203', '高港区', '321200', '4', '1', '0523', '1'),
('321281', '兴化市', '321200', '4', '1', '0523', '1'),
('321282', '靖江市', '321200', '4', '1', '0523', '1'),
('321283', '泰兴市', '321200', '4', '1', '0523', '1'),
('321284', '姜堰市', '321200', '4', '1', '0523', '1'),
('321300', '宿迁市', '320000', '3', '1', '0527', '1'),
('321302', '宿城区', '321300', '4', '1', '0527', '1'),
('321311', '宿豫区', '321300', '4', '1', '0527', '1'),
('321322', '沭阳县', '321300', '4', '1', '0527', '1'),
('321323', '泗阳县', '321300', '4', '1', '0527', '1'),
('321324', '泗洪县', '321300', '4', '1', '0527', '1'),
('330000', '浙江省', 'CN9999', '2', '1', NULL, '1'),
('330100', '杭州市', '330000', '3', '1', '0571', '1'),
('330102', '上城区', '330100', '4', '1', '0571', '1'),
('330103', '下城区', '330100', '4', '1', '0571', '1'),
('330104', '江干区', '330100', '4', '1', '0571', '1'),
('330105', '拱墅区', '330100', '4', '1', '0571', '1'),
('330106', '西湖区', '330100', '4', '1', '0571', '1'),
('330108', '滨江区', '330100', '4', '1', '0571', '1'),
('330109', '萧山区', '330100', '4', '1', '0571', '1'),
('330110', '余杭区', '330100', '4', '1', '0571', '1'),
('330122', '桐庐县', '330100', '4', '1', '0571', '1'),
('330127', '淳安县', '330100', '4', '1', '0571', '1'),
('330182', '建德市', '330100', '4', '1', '0571', '1'),
('330183', '富阳市', '330100', '4', '1', '0571', '1'),
('330185', '临安市', '330100', '4', '1', '0571', '1'),
('330200', '宁波市', '330000', '3', '1', '0574', '1'),
('330203', '海曙区', '330200', '4', '1', '0574', '1'),
('330204', '江东区', '330200', '4', '1', '0574', '1'),
('330205', '江北区', '330200', '4', '1', '0574', '1'),
('330206', '北仑区', '330200', '4', '1', '0574', '1'),
('330211', '镇海区', '330200', '4', '1', '0574', '1'),
('330212', '鄞州区', '330200', '4', '1', '0574', '1'),
('330225', '象山县', '330200', '4', '1', '0574', '1'),
('330226', '宁海县', '330200', '4', '1', '0574', '1'),
('330281', '余姚市', '330200', '4', '1', '0574', '1'),
('330282', '慈溪市', '330200', '4', '1', '0574', '1'),
('330283', '奉化市', '330200', '4', '1', '0574', '1'),
('330300', '温州市', '330000', '3', '1', '0577', '1'),
('330302', '鹿城区', '330300', '4', '1', '0577', '1'),
('330303', '龙湾区', '330300', '4', '1', '0577', '1'),
('330304', '瓯海区', '330300', '4', '1', '0577', '1'),
('330322', '洞头县', '330300', '4', '1', '0577', '1'),
('330324', '永嘉县', '330300', '4', '1', '0577', '1'),
('330326', '平阳县', '330300', '4', '1', '0577', '1'),
('330327', '苍南县', '330300', '4', '1', '0577', '1'),
('330328', '文成县', '330300', '4', '1', '0577', '1'),
('330329', '泰顺县', '330300', '4', '1', '0577', '1'),
('330381', '瑞安市', '330300', '4', '1', '0577', '1'),
('330382', '乐清市', '330300', '4', '1', '0577', '1'),
('330400', '嘉兴市', '330000', '3', '1', '0573', '1'),
('330402', '南湖区', '330400', '4', '1', '0573', '1'),
('330411', '秀洲区', '330400', '4', '1', '0573', '1'),
('330421', '嘉善县', '330400', '4', '1', '0573', '1'),
('330424', '海盐县', '330400', '4', '1', '0573', '1'),
('330481', '海宁市', '330400', '4', '1', '0573', '1'),
('330482', '平湖市', '330400', '4', '1', '0573', '1'),
('330483', '桐乡市', '330400', '4', '1', '0573', '1'),
('330500', '湖州市', '330000', '3', '1', '0572', '1'),
('330502', '吴兴区', '330500', '4', '1', '0572', '1'),
('330503', '南浔区', '330500', '4', '1', '0572', '1'),
('330521', '德清县', '330500', '4', '1', '0572', '1'),
('330522', '长兴县', '330500', '4', '1', '0572', '1'),
('330523', '安吉县', '330500', '4', '1', '0572', '1'),
('330600', '绍兴市', '330000', '3', '1', '0575', '1');
INSERT INTO `t_pub_area` (`id`, `AREA_NAME`, `PARENT_AREA_ID`, `AREA_LEVEL`, `STATUS`, `AREA_REGION`, `IS_INTERNAL`) VALUES
('330602', '越城区', '330600', '4', '1', '0575', '1'),
('330621', '绍兴县', '330600', '4', '1', '0575', '1'),
('330624', '新昌县', '330600', '4', '1', '0575', '1'),
('330681', '诸暨市', '330600', '4', '1', '0575', '1'),
('330682', '上虞市', '330600', '4', '1', '0575', '1'),
('330683', '嵊州市', '330600', '4', '1', '0575', '1'),
('330700', '金华市', '330000', '3', '1', '0579', '1'),
('330702', '婺城区', '330700', '4', '1', '0579', '1'),
('330703', '金东区', '330700', '4', '1', '0579', '1'),
('330723', '武义县', '330700', '4', '1', '0579', '1'),
('330726', '浦江县', '330700', '4', '1', '0579', '1'),
('330727', '磐安县', '330700', '4', '1', '0579', '1'),
('330781', '兰溪市', '330700', '4', '1', '0579', '1'),
('330782', '义乌市', '330700', '4', '1', '0579', '1'),
('330783', '东阳市', '330700', '4', '1', '0579', '1'),
('330784', '永康市', '330700', '4', '1', '0579', '1'),
('330800', '衢州市', '330000', '3', '1', '0570', '1'),
('330802', '柯城区', '330800', '4', '1', '0570', '1'),
('330803', '衢江区', '330800', '4', '1', '0570', '1'),
('330822', '常山县', '330800', '4', '1', '0570', '1'),
('330824', '开化县', '330800', '4', '1', '0570', '1'),
('330825', '龙游县', '330800', '4', '1', '0570', '1'),
('330881', '江山市', '330800', '4', '1', '0570', '1'),
('330900', '舟山市', '330000', '3', '1', '0580', '1'),
('330902', '定海区', '330900', '4', '1', '0580', '1'),
('330903', '普陀区', '330900', '4', '1', '0580', '1'),
('330921', '岱山县', '330900', '4', '1', '0580', '1'),
('330922', '嵊泗县', '330900', '4', '1', '0580', '1'),
('331000', '台州市', '330000', '3', '1', '0576', '1'),
('331002', '椒江区', '331000', '4', '1', '0576', '1'),
('331003', '黄岩区', '331000', '4', '1', '0576', '1'),
('331004', '路桥区', '331000', '4', '1', '0576', '1'),
('331021', '玉环县', '331000', '4', '1', '0576', '1'),
('331022', '三门县', '331000', '4', '1', '0576', '1'),
('331023', '天台县', '331000', '4', '1', '0576', '1'),
('331024', '仙居县', '331000', '4', '1', '0576', '1'),
('331081', '温岭市', '331000', '4', '1', '0576', '1'),
('331082', '临海市', '331000', '4', '1', '0576', '1'),
('331100', '丽水市', '330000', '3', '1', '0578', '1'),
('331102', '莲都区', '331100', '4', '1', '0578', '1'),
('331121', '青田县', '331100', '4', '1', '0578', '1'),
('331122', '缙云县', '331100', '4', '1', '0578', '1'),
('331123', '遂昌县', '331100', '4', '1', '0578', '1'),
('331124', '松阳县', '331100', '4', '1', '0578', '1'),
('331125', '云和县', '331100', '4', '1', '0578', '1'),
('331126', '庆元县', '331100', '4', '1', '0578', '1'),
('331127', '景宁畲族自治县', '331100', '4', '1', '0578', '1'),
('331181', '龙泉市', '331100', '4', '1', '0578', '1'),
('331200', '义乌市', '330000', '3', '1', '0579', '1'),
('340000', '安徽省', 'CN9999', '2', '1', NULL, '1'),
('340100', '合肥市', '340000', '3', '1', '0551', '1'),
('340102', '瑶海区', '340100', '4', '1', '0551', '1'),
('340103', '庐阳区', '340100', '4', '1', '0551', '1'),
('340104', '蜀山区', '340100', '4', '1', '0551', '1'),
('340111', '包河区', '340100', '4', '1', '0551', '1'),
('340121', '长丰县', '340100', '4', '1', '0551', '1'),
('340122', '肥东县', '340100', '4', '1', '0551', '1'),
('340123', '肥西县', '340100', '4', '1', '0551', '1'),
('340200', '芜湖市', '340000', '3', '1', '0553', '1'),
('340202', '镜湖区', '340200', '4', '1', '0553', '1'),
('340203', '弋江区', '340200', '4', '1', '0553', '1'),
('340207', '鸠江区', '340200', '4', '1', '0553', '1'),
('340208', '三山区', '340200', '4', '1', '0553', '1'),
('340221', '芜湖县', '340200', '4', '1', '0553', '1'),
('340222', '繁昌县', '340200', '4', '1', '0553', '1'),
('340223', '南陵县', '340200', '4', '1', '0553', '1'),
('340300', '蚌埠市', '340000', '3', '1', '0552', '1'),
('340302', '龙子湖区', '340300', '4', '1', '0552', '1'),
('340303', '蚌山区', '340300', '4', '1', '0552', '1'),
('340304', '禹会区', '340300', '4', '1', '0552', '1'),
('340311', '淮上区', '340300', '4', '1', '0552', '1'),
('340321', '怀远县', '340300', '4', '1', '0552', '1'),
('340322', '五河县', '340300', '4', '1', '0552', '1'),
('340323', '固镇县', '340300', '4', '1', '0552', '1'),
('340400', '淮南市', '340000', '3', '1', '0554', '1'),
('340402', '大通区', '340400', '4', '1', '0554', '1'),
('340403', '田家庵区', '340400', '4', '1', '0554', '1'),
('340404', '谢家集区', '340400', '4', '1', '0554', '1'),
('340405', '八公山区', '340400', '4', '1', '0554', '1'),
('340406', '潘集区', '340400', '4', '1', '0554', '1'),
('340421', '凤台县', '340400', '4', '1', '0554', '1'),
('340500', '马鞍山市', '340000', '3', '1', '0555', '1'),
('340502', '金家庄区', '340500', '4', '1', '0555', '1'),
('340503', '花山区', '340500', '4', '1', '0555', '1'),
('340504', '雨山区', '340500', '4', '1', '0555', '1'),
('340521', '当涂县', '340500', '4', '1', '0555', '1'),
('340600', '淮北市', '340000', '3', '1', '0561', '1'),
('340602', '杜集区', '340600', '4', '1', '0561', '1'),
('340603', '相山区', '340600', '4', '1', '0561', '1'),
('340604', '烈山区', '340600', '4', '1', '0561', '1'),
('340621', '濉溪县', '340600', '4', '1', '0561', '1'),
('340700', '铜陵市', '340000', '3', '1', '0562', '1'),
('340702', '铜官山区', '340700', '4', '1', '0562', '1'),
('340703', '狮子山区', '340700', '4', '1', '0562', '1'),
('340711', '郊区', '340700', '4', '1', '0562', '1'),
('340721', '铜陵县', '340700', '4', '1', '0562', '1'),
('340800', '安庆市', '340000', '3', '1', '0556', '1'),
('340802', '迎江区', '340800', '4', '1', '0556', '1'),
('340803', '大观区', '340800', '4', '1', '0556', '1'),
('340811', '宜秀区', '340800', '4', '1', '0556', '1'),
('340822', '怀宁县', '340800', '4', '1', '0556', '1'),
('340823', '枞阳县', '340800', '4', '1', '0556', '1'),
('340824', '潜山县', '340800', '4', '1', '0556', '1'),
('340825', '太湖县', '340800', '4', '1', '0556', '1'),
('340826', '宿松县', '340800', '4', '1', '0556', '1'),
('340827', '望江县', '340800', '4', '1', '0556', '1'),
('340828', '岳西县', '340800', '4', '1', '0556', '1'),
('340881', '桐城市', '340800', '4', '1', '0556', '1'),
('341000', '黄山市', '340000', '3', '1', '0559', '1'),
('341002', '屯溪区', '341000', '4', '1', '0559', '1'),
('341003', '黄山区', '341000', '4', '1', '0559', '1'),
('341004', '徽州区', '341000', '4', '1', '0559', '1'),
('341021', '歙县', '341000', '4', '1', '0559', '1'),
('341022', '休宁县', '341000', '4', '1', '0559', '1'),
('341023', '黟县', '341000', '4', '1', '0559', '1'),
('341024', '祁门县', '341000', '4', '1', '0559', '1'),
('341100', '滁州市', '340000', '3', '1', '0550', '1'),
('341102', '琅琊区', '341100', '4', '1', '0550', '1'),
('341103', '南谯区', '341100', '4', '1', '0550', '1'),
('341122', '来安县', '341100', '4', '1', '0550', '1'),
('341124', '全椒县', '341100', '4', '1', '0550', '1'),
('341125', '定远县', '341100', '4', '1', '0550', '1'),
('341126', '凤阳县', '341100', '4', '1', '0550', '1'),
('341181', '天长市', '341100', '4', '1', '0550', '1'),
('341182', '明光市', '341100', '4', '1', '0550', '1'),
('341200', '阜阳市', '340000', '3', '1', '0558', '1'),
('341202', '颍州区', '341200', '4', '1', '0558', '1'),
('341203', '颍东区', '341200', '4', '1', '0558', '1'),
('341204', '颍泉区', '341200', '4', '1', '0558', '1'),
('341221', '临泉县', '341200', '4', '1', '0558', '1'),
('341222', '太和县', '341200', '4', '1', '0558', '1'),
('341225', '阜南县', '341200', '4', '1', '0558', '1'),
('341226', '颍上县', '341200', '4', '1', '0558', '1'),
('341282', '界首市', '341200', '4', '1', '0558', '1'),
('341300', '宿州市', '340000', '3', '1', '0557', '1'),
('341302', '埇桥区', '341300', '4', '1', '0557', '1'),
('341321', '砀山县', '341300', '4', '1', '0557', '1'),
('341322', '萧县', '341300', '4', '1', '0557', '1'),
('341323', '灵璧县', '341300', '4', '1', '0557', '1'),
('341324', '泗县', '341300', '4', '1', '0557', '1'),
('341400', '巢湖市', '340000', '3', '1', '0565', '1'),
('341402', '居巢区', '341400', '4', '1', '0565', '1'),
('341421', '庐江县', '341400', '4', '1', '0565', '1'),
('341422', '无为县', '341400', '4', '1', '0565', '1'),
('341423', '含山县', '341400', '4', '1', '0565', '1'),
('341424', '和县', '341400', '4', '1', '0565', '1'),
('341500', '六安市', '340000', '3', '1', '0564', '1'),
('341502', '金安区', '341500', '4', '1', '0564', '1'),
('341503', '裕安区', '341500', '4', '1', '0564', '1'),
('341521', '寿县', '341500', '4', '1', '0564', '1'),
('341522', '霍邱县', '341500', '4', '1', '0564', '1'),
('341523', '舒城县', '341500', '4', '1', '0564', '1'),
('341524', '金寨县', '341500', '4', '1', '0564', '1'),
('341525', '霍山县', '341500', '4', '1', '0564', '1'),
('341600', '亳州市', '340000', '3', '1', '0558', '1'),
('341602', '谯城区', '341600', '4', '1', '0558', '1'),
('341621', '涡阳县', '341600', '4', '1', '0558', '1'),
('341622', '蒙城县', '341600', '4', '1', '0558', '1'),
('341623', '利辛县', '341600', '4', '1', '0558', '1'),
('341700', '池州市', '340000', '3', '1', '0566', '1'),
('341702', '贵池区', '341700', '4', '1', '0566', '1'),
('341721', '东至县', '341700', '4', '1', '0566', '1'),
('341722', '石台县', '341700', '4', '1', '0566', '1'),
('341723', '青阳县', '341700', '4', '1', '0566', '1'),
('341800', '宣城市', '340000', '3', '1', '0563', '1'),
('341802', '宣州区', '341800', '4', '1', '0563', '1'),
('341821', '郎溪县', '341800', '4', '1', '0563', '1'),
('341822', '广德县', '341800', '4', '1', '0563', '1'),
('341823', '泾县', '341800', '4', '1', '0563', '1'),
('341824', '绩溪县', '341800', '4', '1', '0563', '1'),
('341825', '旌德县', '341800', '4', '1', '0563', '1'),
('341881', '宁国市', '341800', '4', '1', '0563', '1'),
('350000', '福建省', 'CN9999', '2', '1', NULL, '1'),
('350100', '福州市', '350000', '3', '1', '0591', '1'),
('350102', '鼓楼区', '350100', '4', '1', '0591', '1'),
('350103', '台江区', '350100', '4', '1', '0591', '1'),
('350104', '仓山区', '350100', '4', '1', '0591', '1'),
('350105', '马尾区', '350100', '4', '1', '0591', '1'),
('350111', '晋安区', '350100', '4', '1', '0591', '1'),
('350121', '闽侯县', '350100', '4', '1', '0591', '1'),
('350122', '连江县', '350100', '4', '1', '0591', '1'),
('350123', '罗源县', '350100', '4', '1', '0591', '1'),
('350124', '闽清县', '350100', '4', '1', '0591', '1'),
('350125', '永泰县', '350100', '4', '1', '0591', '1'),
('350128', '平潭县', '350100', '4', '1', '0591', '1'),
('350181', '福清市', '350100', '4', '1', '0591', '1'),
('350182', '长乐市', '350100', '4', '1', '0591', '1'),
('350200', '厦门市', '350000', '3', '1', '0592', '1'),
('350203', '思明区', '350200', '4', '1', '0592', '1'),
('350205', '海沧区', '350200', '4', '1', '0592', '1'),
('350206', '湖里区', '350200', '4', '1', '0592', '1'),
('350211', '集美区', '350200', '4', '1', '0592', '1'),
('350212', '同安区', '350200', '4', '1', '0592', '1'),
('350213', '翔安区', '350200', '4', '1', '0592', '1'),
('350300', '莆田市', '350000', '3', '1', '0594', '1'),
('350302', '城厢区', '350300', '4', '1', '0594', '1'),
('350303', '涵江区', '350300', '4', '1', '0594', '1'),
('350304', '荔城区', '350300', '4', '1', '0594', '1'),
('350305', '秀屿区', '350300', '4', '1', '0594', '1'),
('350322', '仙游县', '350300', '4', '1', '0594', '1'),
('350400', '三明市', '350000', '3', '1', '0598', '1'),
('350402', '梅列区', '350400', '4', '1', '0598', '1'),
('350403', '三元区', '350400', '4', '1', '0598', '1'),
('350421', '明溪县', '350400', '4', '1', '0598', '1'),
('350423', '清流县', '350400', '4', '1', '0598', '1'),
('350424', '宁化县', '350400', '4', '1', '0598', '1'),
('350425', '大田县', '350400', '4', '1', '0598', '1'),
('350426', '尤溪县', '350400', '4', '1', '0598', '1'),
('350427', '沙县', '350400', '4', '1', '0598', '1'),
('350428', '将乐县', '350400', '4', '1', '0598', '1'),
('350429', '泰宁县', '350400', '4', '1', '0598', '1'),
('350430', '建宁县', '350400', '4', '1', '0598', '1'),
('350481', '永安市', '350400', '4', '1', '0598', '1'),
('350500', '泉州市', '350000', '3', '1', '0595', '1'),
('350502', '鲤城区', '350500', '4', '1', '0595', '1'),
('350503', '丰泽区', '350500', '4', '1', '0595', '1'),
('350504', '洛江区', '350500', '4', '1', '0595', '1'),
('350505', '泉港区', '350500', '4', '1', '0595', '1'),
('350521', '惠安县', '350500', '4', '1', '0595', '1'),
('350524', '安溪县', '350500', '4', '1', '0595', '1'),
('350525', '永春县', '350500', '4', '1', '0595', '1'),
('350526', '德化县', '350500', '4', '1', '0595', '1'),
('350527', '金门县', '350500', '4', '1', '0595', '1'),
('350581', '石狮市', '350500', '4', '1', '0595', '1'),
('350582', '晋江市', '350500', '4', '1', '0595', '1'),
('350583', '南安市', '350500', '4', '1', '0595', '1'),
('350600', '漳州市', '350000', '3', '1', '0596', '1'),
('350602', '芗城区', '350600', '4', '1', '0596', '1'),
('350603', '龙文区', '350600', '4', '1', '0596', '1'),
('350622', '云霄县', '350600', '4', '1', '0596', '1'),
('350623', '漳浦县', '350600', '4', '1', '0596', '1'),
('350624', '诏安县', '350600', '4', '1', '0596', '1'),
('350625', '长泰县', '350600', '4', '1', '0596', '1'),
('350626', '东山县', '350600', '4', '1', '0596', '1'),
('350627', '南靖县', '350600', '4', '1', '0596', '1'),
('350628', '平和县', '350600', '4', '1', '0596', '1'),
('350629', '华安县', '350600', '4', '1', '0596', '1'),
('350681', '龙海市', '350600', '4', '1', '0596', '1'),
('350700', '南平市', '350000', '3', '1', '0599', '1'),
('350702', '延平区', '350700', '4', '1', '0599', '1'),
('350721', '顺昌县', '350700', '4', '1', '0599', '1'),
('350722', '浦城县', '350700', '4', '1', '0599', '1'),
('350723', '光泽县', '350700', '4', '1', '0599', '1'),
('350724', '松溪县', '350700', '4', '1', '0599', '1'),
('350725', '政和县', '350700', '4', '1', '0599', '1'),
('350781', '邵武市', '350700', '4', '1', '0599', '1'),
('350782', '武夷山市', '350700', '4', '1', '0599', '1'),
('350783', '建瓯市', '350700', '4', '1', '0599', '1'),
('350784', '建阳市', '350700', '4', '1', '0599', '1'),
('350800', '龙岩市', '350000', '3', '1', '0597', '1'),
('350802', '新罗区', '350800', '4', '1', '0597', '1'),
('350821', '长汀县', '350800', '4', '1', '0597', '1'),
('350822', '永定县', '350800', '4', '1', '0597', '1'),
('350823', '上杭县', '350800', '4', '1', '0597', '1'),
('350824', '武平县', '350800', '4', '1', '0597', '1'),
('350825', '连城县', '350800', '4', '1', '0597', '1'),
('350881', '漳平市', '350800', '4', '1', '0597', '1'),
('350900', '宁德市', '350000', '3', '1', '0593', '1'),
('350902', '蕉城区', '350900', '4', '1', '0593', '1'),
('350921', '霞浦县', '350900', '4', '1', '0593', '1'),
('350922', '古田县', '350900', '4', '1', '0593', '1'),
('350923', '屏南县', '350900', '4', '1', '0593', '1'),
('350924', '寿宁县', '350900', '4', '1', '0593', '1'),
('350925', '周宁县', '350900', '4', '1', '0593', '1'),
('350926', '柘荣县', '350900', '4', '1', '0593', '1'),
('350981', '福安市', '350900', '4', '1', '0593', '1'),
('350982', '福鼎市', '350900', '4', '1', '0593', '1'),
('360000', '江西省', 'CN9999', '2', '1', NULL, '1'),
('360100', '南昌市', '360000', '3', '1', '0791', '1'),
('360102', '东湖区', '360100', '4', '1', '0791', '1'),
('360103', '西湖区', '360100', '4', '1', '0791', '1'),
('360104', '青云谱区', '360100', '4', '1', '0791', '1'),
('360105', '湾里区', '360100', '4', '1', '0791', '1'),
('360111', '青山湖区', '360100', '4', '1', '0791', '1'),
('360121', '南昌县', '360100', '4', '1', '0791', '1'),
('360122', '新建县', '360100', '4', '1', '0791', '1'),
('360123', '安义县', '360100', '4', '1', '0791', '1'),
('360124', '进贤县', '360100', '4', '1', '0791', '1'),
('360200', '景德镇市', '360000', '3', '1', '0798', '1'),
('360202', '昌江区', '360200', '4', '1', '0798', '1'),
('360203', '珠山区', '360200', '4', '1', '0798', '1'),
('360222', '浮梁县', '360200', '4', '1', '0798', '1'),
('360281', '乐平市', '360200', '4', '1', '0798', '1'),
('360300', '萍乡市', '360000', '3', '1', '0799', '1'),
('360302', '安源区', '360300', '4', '1', '0799', '1'),
('360313', '湘东区', '360300', '4', '1', '0799', '1'),
('360321', '莲花县', '360300', '4', '1', '0799', '1'),
('360322', '上栗县', '360300', '4', '1', '0799', '1'),
('360323', '芦溪县', '360300', '4', '1', '0799', '1'),
('360400', '九江市', '360000', '3', '1', '0792', '1'),
('360402', '庐山区', '360400', '4', '1', '0792', '1'),
('360403', '浔阳区', '360400', '4', '1', '0792', '1'),
('360421', '九江县', '360400', '4', '1', '0792', '1'),
('360423', '武宁县', '360400', '4', '1', '0792', '1'),
('360424', '修水县', '360400', '4', '1', '0792', '1'),
('360425', '永修县', '360400', '4', '1', '0792', '1'),
('360426', '德安县', '360400', '4', '1', '0792', '1'),
('360427', '星子县', '360400', '4', '1', '0792', '1'),
('360428', '都昌县', '360400', '4', '1', '0792', '1'),
('360429', '湖口县', '360400', '4', '1', '0792', '1'),
('360430', '彭泽县', '360400', '4', '1', '0792', '1'),
('360481', '瑞昌市', '360400', '4', '1', '0792', '1'),
('360500', '新余市', '360000', '3', '1', '0790', '1'),
('360502', '渝水区', '360500', '4', '1', '0790', '1'),
('360521', '分宜县', '360500', '4', '1', '0790', '1'),
('360600', '鹰潭市', '360000', '3', '1', '0701', '1'),
('360602', '月湖区', '360600', '4', '1', '0701', '1'),
('360622', '余江县', '360600', '4', '1', '0701', '1'),
('360681', '贵溪市', '360600', '4', '1', '0701', '1'),
('360700', '赣州市', '360000', '3', '1', '0797', '1'),
('360702', '章贡区', '360700', '4', '1', '0797', '1'),
('360721', '赣县', '360700', '4', '1', '0797', '1'),
('360722', '信丰县', '360700', '4', '1', '0797', '1'),
('360723', '大余县', '360700', '4', '1', '0797', '1'),
('360724', '上犹县', '360700', '4', '1', '0797', '1'),
('360725', '崇义县', '360700', '4', '1', '0797', '1'),
('360726', '安远县', '360700', '4', '1', '0797', '1'),
('360727', '龙南县', '360700', '4', '1', '0797', '1'),
('360728', '定南县', '360700', '4', '1', '0797', '1'),
('360729', '全南县', '360700', '4', '1', '0797', '1'),
('360730', '宁都县', '360700', '4', '1', '0797', '1'),
('360731', '于都县', '360700', '4', '1', '0797', '1'),
('360732', '兴国县', '360700', '4', '1', '0797', '1'),
('360733', '会昌县', '360700', '4', '1', '0797', '1'),
('360734', '寻乌县', '360700', '4', '1', '0797', '1'),
('360735', '石城县', '360700', '4', '1', '0797', '1'),
('360781', '瑞金市', '360700', '4', '1', '0797', '1'),
('360782', '南康市', '360700', '4', '1', '0797', '1'),
('360800', '吉安市', '360000', '3', '1', '0796', '1'),
('360802', '吉州区', '360800', '4', '1', '0796', '1'),
('360803', '青原区', '360800', '4', '1', '0796', '1'),
('360821', '吉安县', '360800', '4', '1', '0796', '1'),
('360822', '吉水县', '360800', '4', '1', '0796', '1'),
('360823', '峡江县', '360800', '4', '1', '0796', '1'),
('360824', '新干县', '360800', '4', '1', '0796', '1'),
('360825', '永丰县', '360800', '4', '1', '0796', '1'),
('360826', '泰和县', '360800', '4', '1', '0796', '1'),
('360827', '遂川县', '360800', '4', '1', '0796', '1'),
('360828', '万安县', '360800', '4', '1', '0796', '1'),
('360829', '安福县', '360800', '4', '1', '0796', '1'),
('360830', '永新县', '360800', '4', '1', '0796', '1'),
('360881', '井冈山市', '360800', '4', '1', '0796', '1'),
('360900', '宜春市', '360000', '3', '1', '0795', '1'),
('360902', '袁州区', '360900', '4', '1', '0795', '1'),
('360921', '奉新县', '360900', '4', '1', '0795', '1'),
('360922', '万载县', '360900', '4', '1', '0795', '1'),
('360923', '上高县', '360900', '4', '1', '0795', '1'),
('360924', '宜丰县', '360900', '4', '1', '0795', '1'),
('360925', '靖安县', '360900', '4', '1', '0795', '1'),
('360926', '铜鼓县', '360900', '4', '1', '0795', '1'),
('360981', '丰城市', '360900', '4', '1', '0795', '1'),
('360982', '樟树市', '360900', '4', '1', '0795', '1'),
('360983', '高安市', '360900', '4', '1', '0795', '1'),
('361000', '抚州市', '360000', '3', '1', '0794', '1'),
('361002', '临川区', '361000', '4', '1', '0794', '1'),
('361021', '南城县', '361000', '4', '1', '0794', '1'),
('361022', '黎川县', '361000', '4', '1', '0794', '1'),
('361023', '南丰县', '361000', '4', '1', '0794', '1'),
('361024', '崇仁县', '361000', '4', '1', '0794', '1'),
('361025', '乐安县', '361000', '4', '1', '0794', '1'),
('361026', '宜黄县', '361000', '4', '1', '0794', '1'),
('361027', '金溪县', '361000', '4', '1', '0794', '1'),
('361028', '资溪县', '361000', '4', '1', '0794', '1'),
('361029', '东乡县', '361000', '4', '1', '0794', '1'),
('361030', '广昌县', '361000', '4', '1', '0794', '1'),
('361100', '上饶市', '360000', '3', '1', '0793', '1'),
('361102', '信州区', '361100', '4', '1', '0793', '1'),
('361121', '上饶县', '361100', '4', '1', '0793', '1'),
('361122', '广丰县', '361100', '4', '1', '0793', '1'),
('361123', '玉山县', '361100', '4', '1', '0793', '1'),
('361124', '铅山县', '361100', '4', '1', '0793', '1'),
('361125', '横峰县', '361100', '4', '1', '0793', '1'),
('361126', '弋阳县', '361100', '4', '1', '0793', '1'),
('361127', '余干县', '361100', '4', '1', '0793', '1'),
('361128', '鄱阳县', '361100', '4', '1', '0793', '1'),
('361129', '万年县', '361100', '4', '1', '0793', '1'),
('361130', '婺源县', '361100', '4', '1', '0793', '1'),
('361181', '德兴市', '361100', '4', '1', '0793', '1'),
('370000', '山东省', 'CN9999', '2', '1', NULL, '1'),
('370100', '济南市', '370000', '3', '1', '0531', '1'),
('370102', '历下区', '370100', '4', '1', '0531', '1'),
('370103', '市中区', '370100', '4', '1', '0531', '1'),
('370104', '槐荫区', '370100', '4', '1', '0531', '1'),
('370105', '天桥区', '370100', '4', '1', '0531', '1'),
('370112', '历城区', '370100', '4', '1', '0531', '1'),
('370113', '长清区', '370100', '4', '1', '0531', '1'),
('370124', '平阴县', '370100', '4', '1', '0531', '1'),
('370125', '济阳县', '370100', '4', '1', '0531', '1'),
('370126', '商河县', '370100', '4', '1', '0531', '1'),
('370181', '章丘市', '370100', '4', '1', '0531', '1'),
('370200', '青岛市', '370000', '3', '1', '0532', '1'),
('370202', '市南区', '370200', '4', '1', '0532', '1'),
('370203', '市北区', '370200', '4', '1', '0532', '1'),
('370205', '四方区', '370200', '4', '1', '0532', '1'),
('370211', '黄岛区', '370200', '4', '1', '0532', '1'),
('370212', '崂山区', '370200', '4', '1', '0532', '1'),
('370213', '李沧区', '370200', '4', '1', '0532', '1'),
('370214', '城阳区', '370200', '4', '1', '0532', '1'),
('370281', '胶州市', '370200', '4', '1', '0532', '1'),
('370282', '即墨市', '370200', '4', '1', '0532', '1'),
('370283', '平度市', '370200', '4', '1', '0532', '1'),
('370284', '胶南市', '370200', '4', '1', '0532', '1'),
('370285', '莱西市', '370200', '4', '1', '0532', '1'),
('370300', '淄博市', '370000', '3', '1', '0533', '1'),
('370302', '淄川区', '370300', '4', '1', '0533', '1'),
('370303', '张店区', '370300', '4', '1', '0533', '1'),
('370304', '博山区', '370300', '4', '1', '0533', '1'),
('370305', '临淄区', '370300', '4', '1', '0533', '1'),
('370306', '周村区', '370300', '4', '1', '0533', '1'),
('370321', '桓台县', '370300', '4', '1', '0533', '1'),
('370322', '高青县', '370300', '4', '1', '0533', '1'),
('370323', '沂源县', '370300', '4', '1', '0533', '1'),
('370400', '枣庄市', '370000', '3', '1', '0632', '1'),
('370402', '市中区', '370400', '4', '1', '0632', '1'),
('370403', '薛城区', '370400', '4', '1', '0632', '1'),
('370404', '峄城区', '370400', '4', '1', '0632', '1'),
('370405', '台儿庄区', '370400', '4', '1', '0632', '1'),
('370406', '山亭区', '370400', '4', '1', '0632', '1'),
('370481', '滕州市', '370400', '4', '1', '0632', '1'),
('370500', '东营市', '370000', '3', '1', '0546', '1'),
('370502', '东营区', '370500', '4', '1', '0546', '1'),
('370503', '河口区', '370500', '4', '1', '0546', '1'),
('370521', '垦利县', '370500', '4', '1', '0546', '1'),
('370522', '利津县', '370500', '4', '1', '0546', '1'),
('370523', '广饶县', '370500', '4', '1', '0546', '1'),
('370600', '烟台市', '370000', '3', '1', '0535', '1'),
('370602', '芝罘区', '370600', '4', '1', '0535', '1'),
('370611', '福山区', '370600', '4', '1', '0535', '1'),
('370612', '牟平区', '370600', '4', '1', '0535', '1'),
('370613', '莱山区', '370600', '4', '1', '0535', '1'),
('370634', '长岛县', '370600', '4', '1', '0535', '1'),
('370681', '龙口市', '370600', '4', '1', '0535', '1'),
('370682', '莱阳市', '370600', '4', '1', '0535', '1'),
('370683', '莱州市', '370600', '4', '1', '0535', '1'),
('370684', '蓬莱市', '370600', '4', '1', '0535', '1'),
('370685', '招远市', '370600', '4', '1', '0535', '1'),
('370686', '栖霞市', '370600', '4', '1', '0535', '1'),
('370687', '海阳市', '370600', '4', '1', '0535', '1'),
('370700', '潍坊市', '370000', '3', '1', '0536', '1'),
('370702', '潍城区', '370700', '4', '1', '0536', '1'),
('370703', '寒亭区', '370700', '4', '1', '0536', '1'),
('370704', '坊子区', '370700', '4', '1', '0536', '1'),
('370705', '奎文区', '370700', '4', '1', '0536', '1'),
('370724', '临朐县', '370700', '4', '1', '0536', '1'),
('370725', '昌乐县', '370700', '4', '1', '0536', '1'),
('370781', '青州市', '370700', '4', '1', '0536', '1'),
('370782', '诸城市', '370700', '4', '1', '0536', '1'),
('370783', '寿光市', '370700', '4', '1', '0536', '1'),
('370784', '安丘市', '370700', '4', '1', '0536', '1'),
('370785', '高密市', '370700', '4', '1', '0536', '1'),
('370786', '昌邑市', '370700', '4', '1', '0536', '1'),
('370800', '济宁市', '370000', '3', '1', '0537', '1'),
('370802', '市中区', '370800', '4', '1', '0537', '1'),
('370811', '任城区', '370800', '4', '1', '0537', '1'),
('370826', '微山县', '370800', '4', '1', '0537', '1'),
('370827', '鱼台县', '370800', '4', '1', '0537', '1'),
('370828', '金乡县', '370800', '4', '1', '0537', '1'),
('370829', '嘉祥县', '370800', '4', '1', '0537', '1'),
('370830', '汶上县', '370800', '4', '1', '0537', '1'),
('370831', '泗水县', '370800', '4', '1', '0537', '1'),
('370832', '梁山县', '370800', '4', '1', '0537', '1'),
('370881', '曲阜市', '370800', '4', '1', '0537', '1'),
('370882', '兖州市', '370800', '4', '1', '0537', '1'),
('370883', '邹城市', '370800', '4', '1', '0537', '1'),
('370900', '泰安市', '370000', '3', '1', '0538', '1'),
('370902', '泰山区', '370900', '4', '1', '0538', '1'),
('370911', '岱岳区', '370900', '4', '1', '0538', '1'),
('370921', '宁阳县', '370900', '4', '1', '0538', '1'),
('370923', '东平县', '370900', '4', '1', '0538', '1'),
('370982', '新泰市', '370900', '4', '1', '0538', '1'),
('370983', '肥城市', '370900', '4', '1', '0538', '1'),
('371000', '威海市', '370000', '3', '1', '0631', '1'),
('371002', '环翠区', '371000', '4', '1', '0631', '1'),
('371081', '文登市', '371000', '4', '1', '0631', '1'),
('371082', '荣成市', '371000', '4', '1', '0631', '1'),
('371083', '乳山市', '371000', '4', '1', '0631', '1'),
('371100', '日照市', '370000', '3', '1', '0633', '1'),
('371102', '东港区', '371100', '4', '1', '0633', '1'),
('371103', '岚山区', '371100', '4', '1', '0633', '1'),
('371121', '五莲县', '371100', '4', '1', '0633', '1'),
('371122', '莒县', '371100', '4', '1', '0633', '1'),
('371200', '莱芜市', '370000', '3', '1', '0634', '1'),
('371202', '莱城区', '371200', '4', '1', '0634', '1'),
('371203', '钢城区', '371200', '4', '1', '0634', '1'),
('371300', '临沂市', '370000', '3', '1', '0539', '1'),
('371302', '兰山区', '371300', '4', '1', '0539', '1'),
('371311', '罗庄区', '371300', '4', '1', '0539', '1'),
('371312', '河东区', '371300', '4', '1', '0539', '1'),
('371321', '沂南县', '371300', '4', '1', '0539', '1'),
('371322', '郯城县', '371300', '4', '1', '0539', '1'),
('371323', '沂水县', '371300', '4', '1', '0539', '1'),
('371324', '苍山县', '371300', '4', '1', '0539', '1'),
('371325', '费县', '371300', '4', '1', '0539', '1'),
('371326', '平邑县', '371300', '4', '1', '0539', '1'),
('371327', '莒南县', '371300', '4', '1', '0539', '1'),
('371328', '蒙阴县', '371300', '4', '1', '0539', '1'),
('371329', '临沭县', '371300', '4', '1', '0539', '1'),
('371400', '德州市', '370000', '3', '1', '0534', '1'),
('371402', '德城区', '371400', '4', '1', '0534', '1'),
('371421', '陵县', '371400', '4', '1', '0534', '1'),
('371422', '宁津县', '371400', '4', '1', '0534', '1'),
('371423', '庆云县', '371400', '4', '1', '0534', '1'),
('371424', '临邑县', '371400', '4', '1', '0534', '1'),
('371425', '齐河县', '371400', '4', '1', '0534', '1'),
('371426', '平原县', '371400', '4', '1', '0534', '1'),
('371427', '夏津县', '371400', '4', '1', '0534', '1'),
('371428', '武城县', '371400', '4', '1', '0534', '1'),
('371481', '乐陵市', '371400', '4', '1', '0534', '1'),
('371482', '禹城市', '371400', '4', '1', '0534', '1'),
('371500', '聊城市', '370000', '3', '1', '0635', '1'),
('371502', '东昌府区', '371500', '4', '1', '0635', '1'),
('371521', '阳谷县', '371500', '4', '1', '0635', '1'),
('371522', '莘县', '371500', '4', '1', '0635', '1'),
('371523', '茌平县', '371500', '4', '1', '0635', '1'),
('371524', '东阿县', '371500', '4', '1', '0635', '1'),
('371525', '冠县', '371500', '4', '1', '0635', '1'),
('371526', '高唐县', '371500', '4', '1', '0635', '1'),
('371581', '临清市', '371500', '4', '1', '0635', '1'),
('371600', '滨州市', '370000', '3', '1', '0543', '1'),
('371602', '滨城区', '371600', '4', '1', '0543', '1'),
('371621', '惠民县', '371600', '4', '1', '0543', '1'),
('371622', '阳信县', '371600', '4', '1', '0543', '1'),
('371623', '无棣县', '371600', '4', '1', '0543', '1'),
('371624', '沾化县', '371600', '4', '1', '0543', '1'),
('371625', '博兴县', '371600', '4', '1', '0543', '1'),
('371626', '邹平县', '371600', '4', '1', '0543', '1'),
('371700', '菏泽市', '370000', '3', '1', '0530', '1'),
('371702', '牡丹区', '371700', '4', '1', '0530', '1'),
('371721', '曹县', '371700', '4', '1', '0530', '1'),
('371722', '单县', '371700', '4', '1', '0530', '1'),
('371723', '成武县', '371700', '4', '1', '0530', '1'),
('371724', '巨野县', '371700', '4', '1', '0530', '1'),
('371725', '郓城县', '371700', '4', '1', '0530', '1'),
('371726', '鄄城县', '371700', '4', '1', '0530', '1'),
('371727', '定陶县', '371700', '4', '1', '0530', '1'),
('371728', '东明县', '371700', '4', '1', '0530', '1'),
('410000', '河南省', 'CN9999', '2', '1', NULL, '1'),
('410100', '郑州市', '410000', '3', '1', '0371', '1'),
('410102', '中原区', '410100', '4', '1', '0371', '1'),
('410103', '二七区', '410100', '4', '1', '0371', '1'),
('410104', '管城回族区', '410100', '4', '1', '0371', '1'),
('410105', '金水区', '410100', '4', '1', '0371', '1'),
('410106', '上街区', '410100', '4', '1', '0371', '1'),
('410108', '惠济区', '410100', '4', '1', '0371', '1'),
('410122', '中牟县', '410100', '4', '1', '0371', '1'),
('410181', '巩义市', '410100', '4', '1', '0371', '1'),
('410182', '荥阳市', '410100', '4', '1', '0371', '1'),
('410183', '新密市', '410100', '4', '1', '0371', '1'),
('410184', '新郑市', '410100', '4', '1', '0371', '1'),
('410185', '登封市', '410100', '4', '1', '0371', '1'),
('410200', '开封市', '410000', '3', '1', '0378', '1'),
('410202', '龙亭区', '410200', '4', '1', '0378', '1'),
('410203', '顺河回族区', '410200', '4', '1', '0378', '1'),
('410204', '鼓楼区', '410200', '4', '1', '0378', '1'),
('410205', '禹王台区', '410200', '4', '1', '0378', '1'),
('410211', '金明区', '410200', '4', '1', '0378', '1'),
('410221', '杞县', '410200', '4', '1', '0378', '1'),
('410222', '通许县', '410200', '4', '1', '0378', '1'),
('410223', '尉氏县', '410200', '4', '1', '0378', '1'),
('410224', '开封县', '410200', '4', '1', '0378', '1'),
('410225', '兰考县', '410200', '4', '1', '0378', '1'),
('410300', '洛阳市', '410000', '3', '1', '0379', '1'),
('410302', '老城区', '410300', '4', '1', '0379', '1'),
('410303', '西工区', '410300', '4', '1', '0379', '1'),
('410304', '瀍河回族区', '410300', '4', '1', '0379', '1'),
('410305', '涧西区', '410300', '4', '1', '0379', '1'),
('410306', '吉利区', '410300', '4', '1', '0379', '1'),
('410311', '洛龙区', '410300', '4', '1', '0379', '1'),
('410322', '孟津县', '410300', '4', '1', '0379', '1'),
('410323', '新安县', '410300', '4', '1', '0379', '1'),
('410324', '栾川县', '410300', '4', '1', '0379', '1'),
('410325', '嵩县', '410300', '4', '1', '0379', '1'),
('410326', '汝阳县', '410300', '4', '1', '0379', '1'),
('410327', '宜阳县', '410300', '4', '1', '0379', '1'),
('410328', '洛宁县', '410300', '4', '1', '0379', '1'),
('410329', '伊川县', '410300', '4', '1', '0379', '1'),
('410381', '偃师市', '410300', '4', '1', '0379', '1'),
('410400', '平顶山市', '410000', '3', '1', '0375', '1'),
('410402', '新华区', '410400', '4', '1', '0375', '1'),
('410403', '卫东区', '410400', '4', '1', '0375', '1'),
('410404', '石龙区', '410400', '4', '1', '0375', '1'),
('410411', '湛河区', '410400', '4', '1', '0375', '1'),
('410421', '宝丰县', '410400', '4', '1', '0375', '1'),
('410422', '叶县', '410400', '4', '1', '0375', '1'),
('410423', '鲁山县', '410400', '4', '1', '0375', '1'),
('410425', '郏县', '410400', '4', '1', '0375', '1'),
('410481', '舞钢市', '410400', '4', '1', '0375', '1'),
('410482', '汝州市', '410400', '4', '1', '0375', '1'),
('410500', '安阳市', '410000', '3', '1', '0372', '1'),
('410502', '文峰区', '410500', '4', '1', '0372', '1'),
('410503', '北关区', '410500', '4', '1', '0372', '1'),
('410505', '殷都区', '410500', '4', '1', '0372', '1'),
('410506', '龙安区', '410500', '4', '1', '0372', '1'),
('410522', '安阳县', '410500', '4', '1', '0372', '1'),
('410523', '汤阴县', '410500', '4', '1', '0372', '1'),
('410526', '滑县', '410500', '4', '1', '0372', '1'),
('410527', '内黄县', '410500', '4', '1', '0372', '1'),
('410581', '林州市', '410500', '4', '1', '0372', '1'),
('410600', '鹤壁市', '410000', '3', '1', '0392', '1'),
('410602', '鹤山区', '410600', '4', '1', '0392', '1'),
('410603', '山城区', '410600', '4', '1', '0392', '1'),
('410611', '淇滨区', '410600', '4', '1', '0392', '1'),
('410621', '浚县', '410600', '4', '1', '0392', '1'),
('410622', '淇县', '410600', '4', '1', '0392', '1'),
('410700', '新乡市', '410000', '3', '1', '0373', '1'),
('410702', '红旗区', '410700', '4', '1', '0373', '1'),
('410703', '卫滨区', '410700', '4', '1', '0373', '1'),
('410704', '凤泉区', '410700', '4', '1', '0373', '1'),
('410711', '牧野区', '410700', '4', '1', '0373', '1'),
('410721', '新乡县', '410700', '4', '1', '0373', '1'),
('410724', '获嘉县', '410700', '4', '1', '0373', '1'),
('410725', '原阳县', '410700', '4', '1', '0373', '1'),
('410726', '延津县', '410700', '4', '1', '0373', '1'),
('410727', '封丘县', '410700', '4', '1', '0373', '1'),
('410728', '长垣县', '410700', '4', '1', '0373', '1'),
('410781', '卫辉市', '410700', '4', '1', '0373', '1'),
('410782', '辉县市', '410700', '4', '1', '0373', '1'),
('410800', '焦作市', '410000', '3', '1', '0391', '1'),
('410802', '解放区', '410800', '4', '1', '0391', '1'),
('410803', '中站区', '410800', '4', '1', '0391', '1'),
('410804', '马村区', '410800', '4', '1', '0391', '1'),
('410811', '山阳区', '410800', '4', '1', '0391', '1'),
('410821', '修武县', '410800', '4', '1', '0391', '1'),
('410822', '博爱县', '410800', '4', '1', '0391', '1'),
('410823', '武陟县', '410800', '4', '1', '0391', '1'),
('410825', '温县', '410800', '4', '1', '0391', '1'),
('410882', '沁阳市', '410800', '4', '1', '0391', '1'),
('410883', '孟州市', '410800', '4', '1', '0391', '1'),
('410900', '濮阳市', '410000', '3', '1', '0393', '1'),
('410902', '华龙区', '410900', '4', '1', '0393', '1'),
('410922', '清丰县', '410900', '4', '1', '0393', '1'),
('410923', '南乐县', '410900', '4', '1', '0393', '1'),
('410926', '范县', '410900', '4', '1', '0393', '1'),
('410927', '台前县', '410900', '4', '1', '0393', '1'),
('410928', '濮阳县', '410900', '4', '1', '0393', '1'),
('411000', '许昌市', '410000', '3', '1', '0374', '1'),
('411002', '魏都区', '411000', '4', '1', '0374', '1'),
('411023', '许昌县', '411000', '4', '1', '0374', '1'),
('411024', '鄢陵县', '411000', '4', '1', '0374', '1'),
('411025', '襄城县', '411000', '4', '1', '0374', '1'),
('411081', '禹州市', '411000', '4', '1', '0374', '1'),
('411082', '长葛市', '411000', '4', '1', '0374', '1'),
('411100', '漯河市', '410000', '3', '1', '0395', '1'),
('411102', '源汇区', '411100', '4', '1', '0395', '1'),
('411103', '郾城区', '411100', '4', '1', '0395', '1'),
('411104', '召陵区', '411100', '4', '1', '0395', '1'),
('411121', '舞阳县', '411100', '4', '1', '0395', '1'),
('411122', '临颍县', '411100', '4', '1', '0395', '1'),
('411200', '三门峡市', '410000', '3', '1', '0398', '1'),
('411202', '湖滨区', '411200', '4', '1', '0398', '1'),
('411221', '渑池县', '411200', '4', '1', '0398', '1'),
('411222', '陕县', '411200', '4', '1', '0398', '1'),
('411224', '卢氏县', '411200', '4', '1', '0398', '1'),
('411281', '义马市', '411200', '4', '1', '0398', '1'),
('411282', '灵宝市', '411200', '4', '1', '0398', '1'),
('411300', '南阳市', '410000', '3', '1', '0377', '1'),
('411302', '宛城区', '411300', '4', '1', '0377', '1'),
('411303', '卧龙区', '411300', '4', '1', '0377', '1'),
('411321', '南召县', '411300', '4', '1', '0377', '1'),
('411322', '方城县', '411300', '4', '1', '0377', '1'),
('411323', '西峡县', '411300', '4', '1', '0377', '1'),
('411324', '镇平县', '411300', '4', '1', '0377', '1'),
('411325', '内乡县', '411300', '4', '1', '0377', '1'),
('411326', '淅川县', '411300', '4', '1', '0377', '1'),
('411327', '社旗县', '411300', '4', '1', '0377', '1'),
('411328', '唐河县', '411300', '4', '1', '0377', '1'),
('411329', '新野县', '411300', '4', '1', '0377', '1'),
('411330', '桐柏县', '411300', '4', '1', '0377', '1'),
('411381', '邓州市', '411300', '4', '1', '0377', '1'),
('411400', '商丘市', '410000', '3', '1', '0370', '1'),
('411402', '梁园区', '411400', '4', '1', '0370', '1'),
('411403', '睢阳区', '411400', '4', '1', '0370', '1'),
('411421', '民权县', '411400', '4', '1', '0370', '1'),
('411422', '?∠?', '411400', '4', '1', '0370', '1'),
('411423', '宁陵县', '411400', '4', '1', '0370', '1'),
('411424', '柘城县', '411400', '4', '1', '0370', '1'),
('411425', '虞城县', '411400', '4', '1', '0370', '1'),
('411426', '夏邑县', '411400', '4', '1', '0370', '1'),
('411481', '永城市', '411400', '4', '1', '0370', '1'),
('411500', '信阳市', '410000', '3', '1', '0376', '1'),
('411502', '浉河区', '411500', '4', '1', '0376', '1'),
('411503', '平桥区', '411500', '4', '1', '0376', '1'),
('411521', '罗山县', '411500', '4', '1', '0376', '1'),
('411522', '光山县', '411500', '4', '1', '0376', '1'),
('411523', '新县', '411500', '4', '1', '0376', '1'),
('411524', '商城县', '411500', '4', '1', '0376', '1'),
('411525', '固始县', '411500', '4', '1', '0376', '1'),
('411526', '潢川县', '411500', '4', '1', '0376', '1'),
('411527', '淮滨县', '411500', '4', '1', '0376', '1'),
('411528', '息县', '411500', '4', '1', '0376', '1'),
('411600', '周口市', '410000', '3', '1', '0394', '1'),
('411602', '川汇区', '411600', '4', '1', '0394', '1'),
('411621', '扶沟县', '411600', '4', '1', '0394', '1'),
('411622', '西华县', '411600', '4', '1', '0394', '1'),
('411623', '商水县', '411600', '4', '1', '0394', '1'),
('411624', '沈丘县', '411600', '4', '1', '0394', '1'),
('411625', '郸城县', '411600', '4', '1', '0394', '1'),
('411626', '淮阳县', '411600', '4', '1', '0394', '1'),
('411627', '太康县', '411600', '4', '1', '0394', '1'),
('411628', '鹿邑县', '411600', '4', '1', '0394', '1'),
('411681', '项城市', '411600', '4', '1', '0394', '1'),
('411700', '驻马店市', '410000', '3', '1', '0396', '1'),
('411702', '驿城区', '411700', '4', '1', '0396', '1'),
('411721', '西平县', '411700', '4', '1', '0396', '1'),
('411722', '上蔡县', '411700', '4', '1', '0396', '1'),
('411723', '平舆县', '411700', '4', '1', '0396', '1'),
('411724', '正阳县', '411700', '4', '1', '0396', '1'),
('411725', '确山县', '411700', '4', '1', '0396', '1'),
('411726', '泌阳县', '411700', '4', '1', '0396', '1'),
('411727', '汝南县', '411700', '4', '1', '0396', '1'),
('411728', '遂平县', '411700', '4', '1', '0396', '1'),
('411729', '新蔡县', '411700', '4', '1', '0396', '1'),
('419001', '济源市', '410000', '3', '1', NULL, '1'),
('420000', '湖北省', 'CN9999', '2', '1', NULL, '1'),
('420100', '武汉市', '420000', '3', '1', '027', '1'),
('420102', '江岸区', '420100', '4', '1', '027', '1'),
('420103', '江汉区', '420100', '4', '1', '027', '1'),
('420104', '硚口区', '420100', '4', '1', '027', '1'),
('420105', '汉阳区', '420100', '4', '1', '027', '1'),
('420106', '武昌区', '420100', '4', '1', '027', '1'),
('420107', '青山区', '420100', '4', '1', '027', '1'),
('420111', '洪山区', '420100', '4', '1', '027', '1'),
('420112', '东西湖区', '420100', '4', '1', '027', '1'),
('420113', '汉南区', '420100', '4', '1', '027', '1'),
('420114', '蔡甸区', '420100', '4', '1', '027', '1'),
('420115', '江夏区', '420100', '4', '1', '027', '1'),
('420116', '黄陂区', '420100', '4', '1', '027', '1'),
('420117', '新洲区', '420100', '4', '1', '027', '1'),
('420200', '黄石市', '420000', '3', '1', '0714', '1'),
('420202', '黄石港区', '420200', '4', '1', '0714', '1'),
('420203', '西塞山区', '420200', '4', '1', '0714', '1'),
('420204', '下陆区', '420200', '4', '1', '0714', '1'),
('420205', '铁山区', '420200', '4', '1', '0714', '1'),
('420222', '阳新县', '420200', '4', '1', '0714', '1'),
('420281', '大冶市', '420200', '4', '1', '0714', '1'),
('420300', '十堰市', '420000', '3', '1', '0719', '1'),
('420302', '茅箭区', '420300', '4', '1', '0719', '1'),
('420303', '张湾区', '420300', '4', '1', '0719', '1'),
('420321', '郧县', '420300', '4', '1', '0719', '1'),
('420322', '郧西县', '420300', '4', '1', '0719', '1'),
('420323', '竹山县', '420300', '4', '1', '0719', '1'),
('420324', '竹溪县', '420300', '4', '1', '0719', '1'),
('420325', '房县', '420300', '4', '1', '0719', '1'),
('420381', '丹江口市', '420300', '4', '1', '0719', '1'),
('420500', '宜昌市', '420000', '3', '1', '0717', '1'),
('420502', '西陵区', '420500', '4', '1', '0717', '1'),
('420503', '伍家岗区', '420500', '4', '1', '0717', '1'),
('420504', '点军区', '420500', '4', '1', '0717', '1'),
('420505', '猇亭区', '420500', '4', '1', '0717', '1'),
('420506', '夷陵区', '420500', '4', '1', '0717', '1'),
('420525', '远安县', '420500', '4', '1', '0717', '1'),
('420526', '兴山县', '420500', '4', '1', '0717', '1'),
('420527', '秭归县', '420500', '4', '1', '0717', '1'),
('420528', '长阳土家族自治县', '420500', '4', '1', '0717', '1'),
('420529', '五峰土家族自治县', '420500', '4', '1', '0717', '1'),
('420581', '宜都市', '420500', '4', '1', '0717', '1'),
('420582', '当阳市', '420500', '4', '1', '0717', '1'),
('420583', '枝江市', '420500', '4', '1', '0717', '1'),
('420600', '襄樊市', '420000', '3', '1', '0710', '1'),
('420602', '襄城区', '420600', '4', '1', '0710', '1'),
('420606', '樊城区', '420600', '4', '1', '0710', '1'),
('420607', '襄阳区', '420600', '4', '1', '0710', '1'),
('420624', '南漳县', '420600', '4', '1', '0710', '1'),
('420625', '谷城县', '420600', '4', '1', '0710', '1'),
('420626', '保康县', '420600', '4', '1', '0710', '1'),
('420682', '老河口市', '420600', '4', '1', '0710', '1'),
('420683', '枣阳市', '420600', '4', '1', '0710', '1'),
('420684', '宜城市', '420600', '4', '1', '0710', '1'),
('420700', '鄂州市', '420000', '3', '1', '0711', '1'),
('420702', '梁子湖区', '420700', '4', '1', '0711', '1'),
('420703', '华容区', '420700', '4', '1', '0711', '1'),
('420704', '鄂城区', '420700', '4', '1', '0711', '1'),
('420800', '荆门市', '420000', '3', '1', '0724', '1'),
('420802', '东宝区', '420800', '4', '1', '0724', '1'),
('420804', '掇刀区', '420800', '4', '1', '0724', '1'),
('420821', '京山县', '420800', '4', '1', '0724', '1'),
('420822', '沙洋县', '420800', '4', '1', '0724', '1'),
('420881', '钟祥市', '420800', '4', '1', '0724', '1'),
('420900', '孝感市', '420000', '3', '1', '0712', '1'),
('420902', '孝南区', '420900', '4', '1', '0712', '1'),
('420921', '孝昌县', '420900', '4', '1', '0712', '1'),
('420922', '大悟县', '420900', '4', '1', '0712', '1'),
('420923', '云梦县', '420900', '4', '1', '0712', '1'),
('420981', '应城市', '420900', '4', '1', '0712', '1'),
('420982', '安陆市', '420900', '4', '1', '0712', '1'),
('420984', '汉川市', '420900', '4', '1', '0712', '1'),
('421000', '荆州市', '420000', '3', '1', '0716', '1'),
('421002', '沙市区', '421000', '4', '1', '0716', '1'),
('421003', '荆州区', '421000', '4', '1', '0716', '1'),
('421022', '公安县', '421000', '4', '1', '0716', '1'),
('421023', '监利县', '421000', '4', '1', '0716', '1'),
('421024', '江陵县', '421000', '4', '1', '0716', '1'),
('421081', '石首市', '421000', '4', '1', '0716', '1'),
('421083', '洪湖市', '421000', '4', '1', '0716', '1'),
('421087', '松滋市', '421000', '4', '1', '0716', '1'),
('421100', '黄冈市', '420000', '3', '1', '0713', '1'),
('421102', '黄州区', '421100', '4', '1', '0713', '1'),
('421121', '团风县', '421100', '4', '1', '0713', '1'),
('421122', '红安县', '421100', '4', '1', '0713', '1'),
('421123', '罗田县', '421100', '4', '1', '0713', '1'),
('421124', '英山县', '421100', '4', '1', '0713', '1'),
('421125', '浠水县', '421100', '4', '1', '0713', '1'),
('421126', '蕲春县', '421100', '4', '1', '0713', '1'),
('421127', '黄梅县', '421100', '4', '1', '0713', '1'),
('421181', '麻城市', '421100', '4', '1', '0713', '1'),
('421182', '武穴市', '421100', '4', '1', '0713', '1'),
('421200', '咸宁市', '420000', '3', '1', '0715', '1'),
('421202', '咸安区', '421200', '4', '1', '0715', '1'),
('421221', '嘉鱼县', '421200', '4', '1', '0715', '1'),
('421222', '通城县', '421200', '4', '1', '0715', '1'),
('421223', '崇阳县', '421200', '4', '1', '0715', '1'),
('421224', '通山县', '421200', '4', '1', '0715', '1'),
('421281', '赤壁市', '421200', '4', '1', '0715', '1'),
('421300', '随州市', '420000', '3', '1', '0722', '1'),
('421302', '曾都区', '421300', '4', '1', '0722', '1'),
('421381', '广水市', '421300', '4', '1', '0722', '1'),
('422800', '恩施土家族苗族自治州', '420000', '3', '1', '0718', '1'),
('422801', '恩施市', '422800', '4', '1', '0718', '1'),
('422802', '利川市', '422800', '4', '1', '0718', '1'),
('422822', '建始县', '422800', '4', '1', '0718', '1'),
('422823', '巴东县', '422800', '4', '1', '0718', '1'),
('422825', '宣恩县', '422800', '4', '1', '0718', '1'),
('422826', '咸丰县', '422800', '4', '1', '0718', '1'),
('422827', '来凤县', '422800', '4', '1', '0718', '1'),
('422828', '鹤峰县', '422800', '4', '1', '0718', '1'),
('429004', '仙桃市', '420000', '3', '1', '0728', '1'),
('429005', '潜江市', '420000', '3', '1', '0728', '1'),
('429006', '天门市', '420000', '3', '1', '0728', '1'),
('429021', '神农架林区', '420000', '3', '1', '0719', '1'),
('430000', '湖南省', 'CN9999', '2', '1', NULL, '1'),
('430100', '长沙市', '430000', '3', '1', '0731', '1'),
('430102', '芙蓉区', '430100', '4', '1', '0731', '1'),
('430103', '天心区', '430100', '4', '1', '0731', '1'),
('430104', '岳麓区', '430100', '4', '1', '0731', '1'),
('430105', '开福区', '430100', '4', '1', '0731', '1'),
('430111', '雨花区', '430100', '4', '1', '0731', '1'),
('430121', '长沙县', '430100', '4', '1', '0731', '1'),
('430122', '望城县', '430100', '4', '1', '0731', '1'),
('430124', '宁乡县', '430100', '4', '1', '0731', '1'),
('430181', '浏阳市', '430100', '4', '1', '0731', '1'),
('430200', '株洲市', '430000', '3', '1', '0733', '1'),
('430202', '荷塘区', '430200', '4', '1', '0733', '1'),
('430203', '芦淞区', '430200', '4', '1', '0733', '1'),
('430204', '石峰区', '430200', '4', '1', '0733', '1'),
('430211', '天元区', '430200', '4', '1', '0733', '1'),
('430221', '株洲县', '430200', '4', '1', '0733', '1'),
('430223', '攸县', '430200', '4', '1', '0733', '1'),
('430224', '茶陵县', '430200', '4', '1', '0733', '1'),
('430225', '炎陵县', '430200', '4', '1', '0733', '1'),
('430281', '醴陵市', '430200', '4', '1', '0733', '1'),
('430300', '湘潭市', '430000', '3', '1', '0732', '1'),
('430302', '雨湖区', '430300', '4', '1', '0732', '1'),
('430304', '岳塘区', '430300', '4', '1', '0732', '1'),
('430321', '湘潭县', '430300', '4', '1', '0732', '1'),
('430381', '湘乡市', '430300', '4', '1', '0732', '1'),
('430382', '韶山市', '430300', '4', '1', '0732', '1'),
('430400', '衡阳市', '430000', '3', '1', '0734', '1'),
('430405', '珠晖区', '430400', '4', '1', '0734', '1'),
('430406', '雁峰区', '430400', '4', '1', '0734', '1'),
('430407', '石鼓区', '430400', '4', '1', '0734', '1'),
('430408', '蒸湘区', '430400', '4', '1', '0734', '1'),
('430412', '南岳区', '430400', '4', '1', '0734', '1'),
('430421', '衡阳县', '430400', '4', '1', '0734', '1'),
('430422', '衡南县', '430400', '4', '1', '0734', '1'),
('430423', '衡山县', '430400', '4', '1', '0734', '1'),
('430424', '衡东县', '430400', '4', '1', '0734', '1'),
('430426', '祁东县', '430400', '4', '1', '0734', '1'),
('430481', '耒阳市', '430400', '4', '1', '0734', '1'),
('430482', '常宁市', '430400', '4', '1', '0734', '1'),
('430500', '邵阳市', '430000', '3', '1', '0739', '1'),
('430502', '双清区', '430500', '4', '1', '0739', '1'),
('430503', '大祥区', '430500', '4', '1', '0739', '1'),
('430511', '北塔区', '430500', '4', '1', '0739', '1'),
('430521', '邵东县', '430500', '4', '1', '0739', '1'),
('430522', '新邵县', '430500', '4', '1', '0739', '1'),
('430523', '邵阳县', '430500', '4', '1', '0739', '1'),
('430524', '隆回县', '430500', '4', '1', '0739', '1'),
('430525', '洞口县', '430500', '4', '1', '0739', '1'),
('430527', '绥宁县', '430500', '4', '1', '0739', '1'),
('430528', '新宁县', '430500', '4', '1', '0739', '1'),
('430529', '城步苗族自治县', '430500', '4', '1', '0739', '1'),
('430581', '武冈市', '430500', '4', '1', '0739', '1'),
('430600', '岳阳市', '430000', '3', '1', '0730', '1'),
('430602', '岳阳楼区', '430600', '4', '1', '0730', '1'),
('430603', '云溪区', '430600', '4', '1', '0730', '1'),
('430611', '君山区', '430600', '4', '1', '0730', '1'),
('430621', '岳阳县', '430600', '4', '1', '0730', '1'),
('430623', '华容县', '430600', '4', '1', '0730', '1'),
('430624', '湘阴县', '430600', '4', '1', '0730', '1'),
('430626', '平江县', '430600', '4', '1', '0730', '1'),
('430681', '汨罗市', '430600', '4', '1', '0730', '1'),
('430682', '临湘市', '430600', '4', '1', '0730', '1'),
('430700', '常德市', '430000', '3', '1', '0736', '1'),
('430702', '武陵区', '430700', '4', '1', '0736', '1'),
('430703', '鼎城区', '430700', '4', '1', '0736', '1'),
('430721', '安乡县', '430700', '4', '1', '0736', '1'),
('430722', '汉寿县', '430700', '4', '1', '0736', '1'),
('430723', '澧县', '430700', '4', '1', '0736', '1'),
('430724', '临澧县', '430700', '4', '1', '0736', '1'),
('430725', '桃源县', '430700', '4', '1', '0736', '1'),
('430726', '石门县', '430700', '4', '1', '0736', '1'),
('430781', '津市市', '430700', '4', '1', '0736', '1'),
('430800', '张家界市', '430000', '3', '1', '0744', '1'),
('430802', '永定区', '430800', '4', '1', '0744', '1'),
('430811', '武陵源区', '430800', '4', '1', '0744', '1'),
('430821', '慈利县', '430800', '4', '1', '0744', '1'),
('430822', '桑植县', '430800', '4', '1', '0744', '1'),
('430900', '益阳市', '430000', '3', '1', '0737', '1'),
('430902', '资阳区', '430900', '4', '1', '0737', '1'),
('430903', '赫山区', '430900', '4', '1', '0737', '1'),
('430921', '南县', '430900', '4', '1', '0737', '1'),
('430922', '桃江县', '430900', '4', '1', '0737', '1'),
('430923', '安化县', '430900', '4', '1', '0737', '1'),
('430981', '沅江市', '430900', '4', '1', '0737', '1'),
('431000', '郴州市', '430000', '3', '1', '0735', '1'),
('431002', '北湖区', '431000', '4', '1', '0735', '1'),
('431003', '苏仙区', '431000', '4', '1', '0735', '1'),
('431021', '桂阳县', '431000', '4', '1', '0735', '1'),
('431022', '宜章县', '431000', '4', '1', '0735', '1'),
('431023', '永兴县', '431000', '4', '1', '0735', '1'),
('431024', '嘉禾县', '431000', '4', '1', '0735', '1'),
('431025', '临武县', '431000', '4', '1', '0735', '1'),
('431026', '汝城县', '431000', '4', '1', '0735', '1'),
('431027', '桂东县', '431000', '4', '1', '0735', '1'),
('431028', '安仁县', '431000', '4', '1', '0735', '1'),
('431081', '资兴市', '431000', '4', '1', '0735', '1'),
('431100', '永州市', '430000', '3', '1', '0746', '1'),
('431102', '零陵区', '431100', '4', '1', '0746', '1'),
('431103', '冷水滩区', '431100', '4', '1', '0746', '1'),
('431121', '祁阳县', '431100', '4', '1', '0746', '1'),
('431122', '东安县', '431100', '4', '1', '0746', '1'),
('431123', '双牌县', '431100', '4', '1', '0746', '1'),
('431124', '道县', '431100', '4', '1', '0746', '1'),
('431125', '江永县', '431100', '4', '1', '0746', '1'),
('431126', '宁远县', '431100', '4', '1', '0746', '1'),
('431127', '蓝山县', '431100', '4', '1', '0746', '1'),
('431128', '新田县', '431100', '4', '1', '0746', '1'),
('431129', '江华瑶族自治县', '431100', '4', '1', '0746', '1'),
('431200', '怀化市', '430000', '3', '1', '0745', '1'),
('431202', '鹤城区', '431200', '4', '1', '0745', '1'),
('431221', '中方县', '431200', '4', '1', '0745', '1'),
('431222', '沅陵县', '431200', '4', '1', '0745', '1'),
('431223', '辰溪县', '431200', '4', '1', '0745', '1'),
('431224', '溆浦县', '431200', '4', '1', '0745', '1'),
('431225', '会同县', '431200', '4', '1', '0745', '1'),
('431226', '麻阳苗族自治县', '431200', '4', '1', '0745', '1'),
('431227', '新晃侗族自治县', '431200', '4', '1', '0745', '1'),
('431228', '芷江侗族自治县', '431200', '4', '1', '0745', '1'),
('431229', '靖州苗族侗族自治县', '431200', '4', '1', '0745', '1'),
('431230', '通道侗族自治县', '431200', '4', '1', '0745', '1'),
('431281', '洪江市', '431200', '4', '1', '0745', '1'),
('431300', '娄底市', '430000', '3', '1', '0738', '1'),
('431302', '娄星区', '431300', '4', '1', '0738', '1'),
('431321', '双峰县', '431300', '4', '1', '0738', '1'),
('431322', '新化县', '431300', '4', '1', '0738', '1'),
('431381', '冷水江市', '431300', '4', '1', '0738', '1'),
('431382', '涟源市', '431300', '4', '1', '0738', '1'),
('433100', '湘西土家族苗族自治州', '430000', '3', '1', '0743', '1'),
('433101', '吉首市', '433100', '4', '1', '0743', '1'),
('433122', '泸溪县', '433100', '4', '1', '0743', '1'),
('433123', '凤凰县', '433100', '4', '1', '0743', '1'),
('433124', '花垣县', '433100', '4', '1', '0743', '1'),
('433125', '保靖县', '433100', '4', '1', '0743', '1'),
('433126', '古丈县', '433100', '4', '1', '0743', '1'),
('433127', '永顺县', '433100', '4', '1', '0743', '1'),
('433130', '龙山县', '433100', '4', '1', '0743', '1'),
('440000', '广东省', 'CN9999', '2', '1', NULL, '1'),
('440100', '广州市', '440000', '3', '1', '020', '1'),
('440103', '荔湾区', '440100', '4', '1', '020', '1'),
('440104', '越秀区', '440100', '4', '1', '020', '1'),
('440105', '海珠区', '440100', '4', '1', '020', '1'),
('440106', '天河区', '440100', '4', '1', '020', '1'),
('440111', '白云区', '440100', '4', '1', '020', '1'),
('440112', '黄埔区', '440100', '4', '1', '020', '1'),
('440113', '番禺区', '440100', '4', '1', '020', '1'),
('440114', '花都区', '440100', '4', '1', '020', '1'),
('440115', '南沙区', '440100', '4', '1', '020', '1'),
('440116', '萝岗区', '440100', '4', '1', '020', '1'),
('440183', '增城市', '440100', '4', '1', '020', '1'),
('440184', '从化市', '440100', '4', '1', '020', '1'),
('440200', '韶关市', '440000', '3', '1', '0751', '1'),
('440203', '武江区', '440200', '4', '1', '0751', '1'),
('440204', '浈江区', '440200', '4', '1', '0751', '1'),
('440205', '曲江区', '440200', '4', '1', '0751', '1'),
('440222', '始兴县', '440200', '4', '1', '0751', '1'),
('440224', '仁化县', '440200', '4', '1', '0751', '1'),
('440229', '翁源县', '440200', '4', '1', '0751', '1'),
('440232', '乳源瑶族自治县', '440200', '4', '1', '0751', '1'),
('440233', '新丰县', '440200', '4', '1', '0751', '1'),
('440281', '乐昌市', '440200', '4', '1', '0751', '1'),
('440282', '南雄市', '440200', '4', '1', '0751', '1'),
('440300', '深圳市', '440000', '3', '1', '0755', '1'),
('440303', '罗湖区', '440300', '4', '1', '0755', '1'),
('440304', '福田区', '440300', '4', '1', '0755', '1'),
('440305', '南山区', '440300', '4', '1', '0755', '1'),
('440306', '宝安区', '440300', '4', '1', '0755', '1'),
('440307', '龙岗区', '440300', '4', '1', '0755', '1');
INSERT INTO `t_pub_area` (`id`, `AREA_NAME`, `PARENT_AREA_ID`, `AREA_LEVEL`, `STATUS`, `AREA_REGION`, `IS_INTERNAL`) VALUES
('440308', '盐田区', '440300', '4', '1', '0755', '1'),
('440400', '珠海市', '440000', '3', '1', '0756', '1'),
('440402', '香洲区', '440400', '4', '1', '0756', '1'),
('440403', '斗门区', '440400', '4', '1', '0756', '1'),
('440404', '金湾区', '440400', '4', '1', '0756', '1'),
('440500', '汕头市', '440000', '3', '1', '0754', '1'),
('440507', '龙湖区', '440500', '4', '1', '0754', '1'),
('440511', '金平区', '440500', '4', '1', '0754', '1'),
('440512', '濠江区', '440500', '4', '1', '0754', '1'),
('440513', '潮阳区', '440500', '4', '1', '0754', '1'),
('440514', '潮南区', '440500', '4', '1', '0754', '1'),
('440515', '澄海区', '440500', '4', '1', '0754', '1'),
('440523', '南澳县', '440500', '4', '1', '0754', '1'),
('440600', '佛山市', '440000', '3', '1', '0757', '1'),
('440604', '禅城区', '440600', '4', '1', '0757', '1'),
('440605', '南海区', '440600', '4', '1', '0757', '1'),
('440606', '顺德区', '440600', '4', '1', '0757', '1'),
('440607', '三水区', '440600', '4', '1', '0757', '1'),
('440608', '高明区', '440600', '4', '1', '0757', '1'),
('440700', '江门市', '440000', '3', '1', '0750', '1'),
('440703', '蓬江区', '440700', '4', '1', '0750', '1'),
('440704', '江海区', '440700', '4', '1', '0750', '1'),
('440705', '新会区', '440700', '4', '1', '0750', '1'),
('440781', '台山市', '440700', '4', '1', '0750', '1'),
('440783', '开平市', '440700', '4', '1', '0750', '1'),
('440784', '鹤山市', '440700', '4', '1', '0750', '1'),
('440785', '恩平市', '440700', '4', '1', '0750', '1'),
('440800', '湛江市', '440000', '3', '1', '0759', '1'),
('440802', '赤坎区', '440800', '4', '1', '0759', '1'),
('440803', '霞山区', '440800', '4', '1', '0759', '1'),
('440804', '坡头区', '440800', '4', '1', '0759', '1'),
('440811', '麻章区', '440800', '4', '1', '0759', '1'),
('440823', '遂溪县', '440800', '4', '1', '0759', '1'),
('440825', '徐闻县', '440800', '4', '1', '0759', '1'),
('440881', '廉江市', '440800', '4', '1', '0759', '1'),
('440882', '雷州市', '440800', '4', '1', '0759', '1'),
('440883', '吴川市', '440800', '4', '1', '0759', '1'),
('440900', '茂名市', '440000', '3', '1', '0668', '1'),
('440902', '茂南区', '440900', '4', '1', '0668', '1'),
('440903', '茂港区', '440900', '4', '1', '0668', '1'),
('440923', '电白县', '440900', '4', '1', '0668', '1'),
('440981', '高州市', '440900', '4', '1', '0668', '1'),
('440982', '化州市', '440900', '4', '1', '0668', '1'),
('440983', '信宜市', '440900', '4', '1', '0668', '1'),
('441200', '肇庆市', '440000', '3', '1', '0758', '1'),
('441202', '端州区', '441200', '4', '1', '0758', '1'),
('441203', '鼎湖区', '441200', '4', '1', '0758', '1'),
('441223', '广宁县', '441200', '4', '1', '0758', '1'),
('441224', '怀集县', '441200', '4', '1', '0758', '1'),
('441225', '封开县', '441200', '4', '1', '0758', '1'),
('441226', '德庆县', '441200', '4', '1', '0758', '1'),
('441283', '高要市', '441200', '4', '1', '0758', '1'),
('441284', '四会市', '441200', '4', '1', '0758', '1'),
('441300', '惠州市', '440000', '3', '1', '0752', '1'),
('441302', '惠城区', '441300', '4', '1', '0752', '1'),
('441303', '惠阳区', '441300', '4', '1', '0752', '1'),
('441322', '博罗县', '441300', '4', '1', '0752', '1'),
('441323', '惠东县', '441300', '4', '1', '0752', '1'),
('441324', '龙门县', '441300', '4', '1', '0752', '1'),
('441400', '梅州市', '440000', '3', '1', '0753', '1'),
('441402', '梅江区', '441400', '4', '1', '0753', '1'),
('441421', '梅县', '441400', '4', '1', '0753', '1'),
('441422', '大埔县', '441400', '4', '1', '0753', '1'),
('441423', '丰顺县', '441400', '4', '1', '0753', '1'),
('441424', '五华县', '441400', '4', '1', '0753', '1'),
('441426', '平远县', '441400', '4', '1', '0753', '1'),
('441427', '蕉岭县', '441400', '4', '1', '0753', '1'),
('441481', '兴宁市', '441400', '4', '1', '0753', '1'),
('441500', '汕尾市', '440000', '3', '1', '0660', '1'),
('441502', '城区', '441500', '4', '1', '0660', '1'),
('441521', '海丰县', '441500', '4', '1', '0660', '1'),
('441523', '陆河县', '441500', '4', '1', '0660', '1'),
('441581', '陆丰市', '441500', '4', '1', '0660', '1'),
('441600', '河源市', '440000', '3', '1', '0762', '1'),
('441602', '源城区', '441600', '4', '1', '0762', '1'),
('441621', '紫金县', '441600', '4', '1', '0762', '1'),
('441622', '龙川县', '441600', '4', '1', '0762', '1'),
('441623', '连平县', '441600', '4', '1', '0762', '1'),
('441624', '和平县', '441600', '4', '1', '0762', '1'),
('441625', '东源县', '441600', '4', '1', '0762', '1'),
('441700', '阳江市', '440000', '3', '1', '0662', '1'),
('441702', '江城区', '441700', '4', '1', '0662', '1'),
('441721', '阳西县', '441700', '4', '1', '0662', '1'),
('441723', '阳东县', '441700', '4', '1', '0662', '1'),
('441781', '阳春市', '441700', '4', '1', '0662', '1'),
('441800', '清远市', '440000', '3', '1', '0763', '1'),
('441802', '清城区', '441800', '4', '1', '0763', '1'),
('441821', '佛冈县', '441800', '4', '1', '0763', '1'),
('441823', '阳山县', '441800', '4', '1', '0763', '1'),
('441825', '连山壮族瑶族自治县', '441800', '4', '1', '0763', '1'),
('441826', '连南瑶族自治县', '441800', '4', '1', '0763', '1'),
('441827', '清新县', '441800', '4', '1', '0763', '1'),
('441881', '英德市', '441800', '4', '1', '0763', '1'),
('441882', '连州市', '441800', '4', '1', '0763', '1'),
('441900', '东莞市', '440000', '3', '1', '0769', '1'),
('442000', '中山市', '440000', '3', '1', '0760', '1'),
('445100', '潮州市', '440000', '3', '1', '0768', '1'),
('445102', '湘桥区', '445100', '4', '1', '0768', '1'),
('445121', '潮安县', '445100', '4', '1', '0768', '1'),
('445122', '饶平县', '445100', '4', '1', '0768', '1'),
('445200', '揭阳市', '440000', '3', '1', '0663', '1'),
('445202', '榕城区', '445200', '4', '1', '0663', '1'),
('445221', '揭东县', '445200', '4', '1', '0663', '1'),
('445222', '揭西县', '445200', '4', '1', '0663', '1'),
('445224', '惠来县', '445200', '4', '1', '0663', '1'),
('445281', '普宁市', '445200', '4', '1', '0663', '1'),
('445300', '云浮市', '440000', '3', '1', '0766', '1'),
('445302', '云城区', '445300', '4', '1', '0766', '1'),
('445321', '新兴县', '445300', '4', '1', '0766', '1'),
('445322', '郁南县', '445300', '4', '1', '0766', '1'),
('445323', '云安县', '445300', '4', '1', '0766', '1'),
('445381', '罗定市', '445300', '4', '1', '0766', '1'),
('450000', '广西壮族自治区', 'CN9999', '2', '1', NULL, '1'),
('450100', '南宁市', '450000', '3', '1', '0771', '1'),
('450102', '兴宁区', '450100', '4', '1', '0771', '1'),
('450103', '青秀区', '450100', '4', '1', '0771', '1'),
('450105', '江南区', '450100', '4', '1', '0771', '1'),
('450107', '西乡塘区', '450100', '4', '1', '0771', '1'),
('450108', '良庆区', '450100', '4', '1', '0771', '1'),
('450109', '邕宁区', '450100', '4', '1', '0771', '1'),
('450122', '武鸣县', '450100', '4', '1', '0771', '1'),
('450123', '隆安县', '450100', '4', '1', '0771', '1'),
('450124', '马山县', '450100', '4', '1', '0771', '1'),
('450125', '上林县', '450100', '4', '1', '0771', '1'),
('450126', '宾阳县', '450100', '4', '1', '0771', '1'),
('450127', '横县', '450100', '4', '1', '0771', '1'),
('450200', '柳州市', '450000', '3', '1', '0772', '1'),
('450202', '城中区', '450200', '4', '1', '0772', '1'),
('450203', '鱼峰区', '450200', '4', '1', '0772', '1'),
('450204', '柳南区', '450200', '4', '1', '0772', '1'),
('450205', '柳北区', '450200', '4', '1', '0772', '1'),
('450221', '柳江县', '450200', '4', '1', '0772', '1'),
('450222', '柳城县', '450200', '4', '1', '0772', '1'),
('450223', '鹿寨县', '450200', '4', '1', '0772', '1'),
('450224', '融安县', '450200', '4', '1', '0772', '1'),
('450225', '融水苗族自治县', '450200', '4', '1', '0772', '1'),
('450226', '三江侗族自治县', '450200', '4', '1', '0772', '1'),
('450300', '桂林市', '450000', '3', '1', '0773', '1'),
('450302', '秀峰区', '450300', '4', '1', '0773', '1'),
('450303', '叠彩区', '450300', '4', '1', '0773', '1'),
('450304', '象山区', '450300', '4', '1', '0773', '1'),
('450305', '七星区', '450300', '4', '1', '0773', '1'),
('450311', '雁山区', '450300', '4', '1', '0773', '1'),
('450321', '阳朔县', '450300', '4', '1', '0773', '1'),
('450322', '临桂县', '450300', '4', '1', '0773', '1'),
('450323', '灵川县', '450300', '4', '1', '0773', '1'),
('450324', '全州县', '450300', '4', '1', '0773', '1'),
('450325', '兴安县', '450300', '4', '1', '0773', '1'),
('450326', '永福县', '450300', '4', '1', '0773', '1'),
('450327', '灌阳县', '450300', '4', '1', '0773', '1'),
('450328', '龙胜各族自治县', '450300', '4', '1', '0773', '1'),
('450329', '资源县', '450300', '4', '1', '0773', '1'),
('450330', '平乐县', '450300', '4', '1', '0773', '1'),
('450331', '荔蒲县', '450300', '4', '1', '0773', '1'),
('450332', '恭城瑶族自治县', '450300', '4', '1', '0773', '1'),
('450400', '梧州市', '450000', '3', '1', '0774', '1'),
('450403', '万秀区', '450400', '4', '1', '0774', '1'),
('450404', '蝶山区', '450400', '4', '1', '0774', '1'),
('450405', '长洲区', '450400', '4', '1', '0774', '1'),
('450421', '苍梧县', '450400', '4', '1', '0774', '1'),
('450422', '藤县', '450400', '4', '1', '0774', '1'),
('450423', '蒙山县', '450400', '4', '1', '0774', '1'),
('450481', '岑溪市', '450400', '4', '1', '0774', '1'),
('450500', '北海市', '450000', '3', '1', '0779', '1'),
('450502', '海城区', '450500', '4', '1', '0779', '1'),
('450503', '银海区', '450500', '4', '1', '0779', '1'),
('450512', '铁山港区', '450500', '4', '1', '0779', '1'),
('450521', '合浦县', '450500', '4', '1', '0779', '1'),
('450600', '防城港市', '450000', '3', '1', '0770', '1'),
('450602', '港口区', '450600', '4', '1', '0770', '1'),
('450603', '防城区', '450600', '4', '1', '0770', '1'),
('450621', '上思县', '450600', '4', '1', '0770', '1'),
('450681', '东兴市', '450600', '4', '1', '0770', '1'),
('450700', '钦州市', '450000', '3', '1', '0777', '1'),
('450702', '钦南区', '450700', '4', '1', '0777', '1'),
('450703', '钦北区', '450700', '4', '1', '0777', '1'),
('450721', '灵山县', '450700', '4', '1', '0777', '1'),
('450722', '浦北县', '450700', '4', '1', '0777', '1'),
('450800', '贵港市', '450000', '3', '1', '0775', '1'),
('450802', '港北区', '450800', '4', '1', '0775', '1'),
('450803', '港南区', '450800', '4', '1', '0775', '1'),
('450804', '覃塘区', '450800', '4', '1', '0775', '1'),
('450821', '平南县', '450800', '4', '1', '0775', '1'),
('450881', '桂平市', '450800', '4', '1', '0775', '1'),
('450900', '玉林市', '450000', '3', '1', '0775', '1'),
('450902', '玉州区', '450900', '4', '1', '0775', '1'),
('450921', '容县', '450900', '4', '1', '0775', '1'),
('450922', '陆川县', '450900', '4', '1', '0775', '1'),
('450923', '博白县', '450900', '4', '1', '0775', '1'),
('450924', '兴业县', '450900', '4', '1', '0775', '1'),
('450981', '北流市', '450900', '4', '1', '0775', '1'),
('451000', '百色市', '450000', '3', '1', '0776', '1'),
('451002', '右江区', '451000', '4', '1', '0776', '1'),
('451021', '田阳县', '451000', '4', '1', '0776', '1'),
('451022', '田东县', '451000', '4', '1', '0776', '1'),
('451023', '平果县', '451000', '4', '1', '0776', '1'),
('451024', '德保县', '451000', '4', '1', '0776', '1'),
('451025', '靖西县', '451000', '4', '1', '0776', '1'),
('451026', '那坡县', '451000', '4', '1', '0776', '1'),
('451027', '凌云县', '451000', '4', '1', '0776', '1'),
('451028', '乐业县', '451000', '4', '1', '0776', '1'),
('451029', '田林县', '451000', '4', '1', '0776', '1'),
('451030', '西林县', '451000', '4', '1', '0776', '1'),
('451031', '隆林各族自治县', '451000', '4', '1', '0776', '1'),
('451100', '贺州市', '450000', '3', '1', NULL, '1'),
('451102', '八步区', '451100', '4', '1', NULL, '1'),
('451121', '昭平县', '451100', '4', '1', NULL, '1'),
('451122', '钟山县', '451100', '4', '1', NULL, '1'),
('451123', '富川瑶族自治县', '451100', '4', '1', NULL, '1'),
('451200', '河池市', '450000', '3', '1', '0778', '1'),
('451202', '金城江区', '451200', '4', '1', '0778', '1'),
('451221', '南丹县', '451200', '4', '1', '0778', '1'),
('451222', '天峨县', '451200', '4', '1', '0778', '1'),
('451223', '凤山县', '451200', '4', '1', '0778', '1'),
('451224', '东兰县', '451200', '4', '1', '0778', '1'),
('451225', '罗城仫佬族自治县', '451200', '4', '1', '0778', '1'),
('451226', '环江毛南族自治县', '451200', '4', '1', '0778', '1'),
('451227', '巴马瑶族自治县', '451200', '4', '1', '0778', '1'),
('451228', '都安瑶族自治县', '451200', '4', '1', '0778', '1'),
('451229', '大化瑶族自治县', '451200', '4', '1', '0778', '1'),
('451281', '宜州市', '451200', '4', '1', '0778', '1'),
('451300', '来宾市', '450000', '3', '1', NULL, '1'),
('451302', '兴宾区', '451300', '4', '1', NULL, '1'),
('451321', '忻城县', '451300', '4', '1', NULL, '1'),
('451322', '象州县', '451300', '4', '1', NULL, '1'),
('451323', '武宣县', '451300', '4', '1', NULL, '1'),
('451324', '金秀瑶族自治县', '451300', '4', '1', NULL, '1'),
('451381', '合山市', '451300', '4', '1', NULL, '1'),
('451400', '崇左市', '450000', '3', '1', NULL, '1'),
('451402', '江洲区', '451400', '4', '1', NULL, '1'),
('451421', '扶绥县', '451400', '4', '1', NULL, '1'),
('451422', '宁明县', '451400', '4', '1', NULL, '1'),
('451423', '龙州县', '451400', '4', '1', NULL, '1'),
('451424', '大新县', '451400', '4', '1', NULL, '1'),
('451425', '天等县', '451400', '4', '1', NULL, '1'),
('451481', '凭祥市', '451400', '4', '1', NULL, '1'),
('460000', '海南省', 'CN9999', '2', '1', NULL, '1'),
('460100', '海口市', '460000', '3', '1', '0898', '1'),
('460105', '秀英区', '460100', '4', '1', '0898', '1'),
('460106', '龙华区', '460100', '4', '1', '0898', '1'),
('460107', '琼山区', '460100', '4', '1', '0898', '1'),
('460108', '美兰区', '460100', '4', '1', '0898', '1'),
('460200', '三亚市', '460000', '3', '1', '0899', '1'),
('469001', '五指山市', '460000', '3', '1', NULL, '1'),
('469002', '琼海市', '460000', '3', '1', NULL, '1'),
('469003', '儋州市', '460000', '3', '1', '0890', '1'),
('469005', '文昌市', '460000', '3', '1', NULL, '1'),
('469006', '万宁市', '460000', '3', '1', NULL, '1'),
('469007', '东方市', '460000', '3', '1', NULL, '1'),
('469021', '定安县', '460000', '3', '1', NULL, '1'),
('469022', '屯昌县', '460000', '3', '1', NULL, '1'),
('469023', '澄迈县', '460000', '3', '1', NULL, '1'),
('469024', '临高县', '460000', '3', '1', NULL, '1'),
('469025', '白沙黎族自治县', '460000', '3', '1', NULL, '1'),
('469026', '昌江黎族自治县', '460000', '3', '1', NULL, '1'),
('469027', '乐东黎族自治县', '460000', '3', '1', NULL, '1'),
('469028', '陵水黎族自治县', '460000', '3', '1', NULL, '1'),
('469029', '保亭黎族苗族自治县', '460000', '3', '1', NULL, '1'),
('469030', '琼中黎族苗族自治县', '460000', '3', '1', NULL, '1'),
('469031', '西沙群岛', '460000', '3', '1', NULL, '1'),
('469032', '南沙群岛', '460000', '3', '1', NULL, '1'),
('469033', '中沙群岛的岛礁及其海域', '460000', '3', '1', NULL, '1'),
('500000', '重庆', 'CN9999', '2', '1', NULL, '1'),
('500100', '重庆市', '500000', '3', '1', '0811', '1'),
('500101', '万州区', '500100', '4', '1', '0811', '1'),
('500102', '涪陵区', '500100', '4', '1', '0811', '1'),
('500103', '渝中区', '500100', '4', '1', '0811', '1'),
('500104', '大渡口区', '500100', '4', '1', '0811', '1'),
('500105', '江北区', '500100', '4', '1', '0811', '1'),
('500106', '沙坪坝区', '500100', '4', '1', '0811', '1'),
('500107', '九龙坡区', '500100', '4', '1', '0811', '1'),
('500108', '南岸区', '500100', '4', '1', '0811', '1'),
('500109', '北碚区', '500100', '4', '1', '0811', '1'),
('500110', '万盛区', '500100', '4', '1', '0811', '1'),
('500111', '双桥区', '500100', '4', '1', '0811', '1'),
('500112', '渝北区', '500100', '4', '1', '0811', '1'),
('500113', '巴南区', '500100', '4', '1', '0811', '1'),
('500114', '黔江区', '500100', '4', '1', '0811', '1'),
('500115', '长寿区', '500100', '4', '1', '0811', '1'),
('500116', '江津区', '500100', '4', '1', '0811', '1'),
('500117', '合川区', '500100', '4', '1', '0811', '1'),
('500118', '永川区', '500100', '4', '1', '0811', '1'),
('500119', '南川区', '500100', '4', '1', '0811', '1'),
('500222', '綦江县', '500100', '4', '1', '0811', '1'),
('500223', '潼南县', '500100', '4', '1', '0811', '1'),
('500224', '铜梁县', '500100', '4', '1', '0811', '1'),
('500225', '大足县', '500100', '4', '1', '0811', '1'),
('500226', '荣昌县', '500100', '4', '1', '0811', '1'),
('500227', '璧山县', '500100', '4', '1', '0811', '1'),
('500228', '梁平县', '500100', '4', '1', '0811', '1'),
('500229', '城口县', '500100', '4', '1', '0811', '1'),
('500230', '丰都县', '500100', '4', '1', '0811', '1'),
('500231', '垫江县', '500100', '4', '1', '0811', '1'),
('500232', '武隆县', '500100', '4', '1', '0811', '1'),
('500233', '忠县', '500100', '4', '1', '0811', '1'),
('500234', '开县', '500100', '4', '1', '0811', '1'),
('500235', '云阳县', '500100', '4', '1', '0811', '1'),
('500236', '奉节县', '500100', '4', '1', '0811', '1'),
('500237', '巫山县', '500100', '4', '1', '0811', '1'),
('500238', '巫溪县', '500100', '4', '1', '0811', '1'),
('500240', '石柱土家族自治县', '500100', '4', '1', '0811', '1'),
('500241', '秀山土家族苗族自治县', '500100', '4', '1', '0811', '1'),
('500242', '酉阳土家族苗族自治县', '500100', '4', '1', '0811', '1'),
('500243', '彭水苗族土家族自治县', '500100', '4', '1', '0811', '1'),
('510000', '四川省', 'CN9999', '2', '1', NULL, '1'),
('510100', '成都市', '510000', '3', '1', '028', '1'),
('510104', '锦江区', '510100', '4', '1', '028', '1'),
('510105', '青羊区', '510100', '4', '1', '028', '1'),
('510106', '金牛区', '510100', '4', '1', '028', '1'),
('510107', '武侯区', '510100', '4', '1', '028', '1'),
('510108', '成华区', '510100', '4', '1', '028', '1'),
('510112', '龙泉驿区', '510100', '4', '1', '028', '1'),
('510113', '青白江区', '510100', '4', '1', '028', '1'),
('510114', '新都区', '510100', '4', '1', '028', '1'),
('510115', '温江区', '510100', '4', '1', '028', '1'),
('510121', '金堂县', '510100', '4', '1', '028', '1'),
('510122', '双流县', '510100', '4', '1', '028', '1'),
('510124', '郫县', '510100', '4', '1', '028', '1'),
('510129', '大邑县', '510100', '4', '1', '028', '1'),
('510131', '蒲江县', '510100', '4', '1', '028', '1'),
('510132', '新津县', '510100', '4', '1', '028', '1'),
('510181', '都江堰市', '510100', '4', '1', '028', '1'),
('510182', '彭州市', '510100', '4', '1', '028', '1'),
('510183', '邛崃市', '510100', '4', '1', '028', '1'),
('510184', '崇州市', '510100', '4', '1', '028', '1'),
('510300', '自贡市', '510000', '3', '1', '0813', '1'),
('510302', '自流井区', '510300', '4', '1', '0813', '1'),
('510303', '贡井区', '510300', '4', '1', '0813', '1'),
('510304', '大安区', '510300', '4', '1', '0813', '1'),
('510311', '沿滩区', '510300', '4', '1', '0813', '1'),
('510321', '荣县', '510300', '4', '1', '0813', '1'),
('510322', '富顺县', '510300', '4', '1', '0813', '1'),
('510400', '攀枝花市', '510000', '3', '1', '0812', '1'),
('510402', '东区', '510400', '4', '1', '0812', '1'),
('510403', '西区', '510400', '4', '1', '0812', '1'),
('510411', '仁和区', '510400', '4', '1', '0812', '1'),
('510421', '米易县', '510400', '4', '1', '0812', '1'),
('510422', '盐边县', '510400', '4', '1', '0812', '1'),
('510500', '泸州市', '510000', '3', '1', '0840', '1'),
('510502', '江阳区', '510500', '4', '1', '0840', '1'),
('510503', '纳溪区', '510500', '4', '1', '0840', '1'),
('510504', '龙马潭区', '510500', '4', '1', '0840', '1'),
('510521', '泸县', '510500', '4', '1', '0840', '1'),
('510522', '合江县', '510500', '4', '1', '0840', '1'),
('510524', '叙永县', '510500', '4', '1', '0840', '1'),
('510525', '古蔺县', '510500', '4', '1', '0840', '1'),
('510600', '德阳市', '510000', '3', '1', '0838', '1'),
('510603', '旌阳区', '510600', '4', '1', '0838', '1'),
('510623', '中江县', '510600', '4', '1', '0838', '1'),
('510626', '罗江县', '510600', '4', '1', '0838', '1'),
('510681', '广汉市', '510600', '4', '1', '0838', '1'),
('510682', '什邡市', '510600', '4', '1', '0838', '1'),
('510683', '绵竹市', '510600', '4', '1', '0838', '1'),
('510700', '绵阳市', '510000', '3', '1', '0816', '1'),
('510703', '涪城区', '510700', '4', '1', '0816', '1'),
('510704', '游仙区', '510700', '4', '1', '0816', '1'),
('510722', '三台县', '510700', '4', '1', '0816', '1'),
('510723', '盐亭县', '510700', '4', '1', '0816', '1'),
('510724', '安县', '510700', '4', '1', '0816', '1'),
('510725', '梓潼县', '510700', '4', '1', '0816', '1'),
('510726', '北川羌族自治县', '510700', '4', '1', '0816', '1'),
('510727', '平武县', '510700', '4', '1', '0816', '1'),
('510781', '江油市', '510700', '4', '1', '0816', '1'),
('510800', '广元市', '510000', '3', '1', '0839', '1'),
('510802', '市中区', '510800', '4', '1', '0839', '1'),
('510811', '元坝区', '510800', '4', '1', '0839', '1'),
('510812', '朝天区', '510800', '4', '1', '0839', '1'),
('510821', '旺苍县', '510800', '4', '1', '0839', '1'),
('510822', '青川县', '510800', '4', '1', '0839', '1'),
('510823', '剑阁县', '510800', '4', '1', '0839', '1'),
('510824', '苍溪县', '510800', '4', '1', '0839', '1'),
('510900', '遂宁市', '510000', '3', '1', '0825', '1'),
('510903', '船山区', '510900', '4', '1', '0825', '1'),
('510904', '安居区', '510900', '4', '1', '0825', '1'),
('510921', '蓬溪县', '510900', '4', '1', '0825', '1'),
('510922', '射洪县', '510900', '4', '1', '0825', '1'),
('510923', '大英县', '510900', '4', '1', '0825', '1'),
('511000', '内江市', '510000', '3', '1', '0832', '1'),
('511002', '市中区', '511000', '4', '1', '0832', '1'),
('511011', '东兴区', '511000', '4', '1', '0832', '1'),
('511024', '威远县', '511000', '4', '1', '0832', '1'),
('511025', '资中县', '511000', '4', '1', '0832', '1'),
('511028', '隆昌县', '511000', '4', '1', '0832', '1'),
('511100', '乐山市', '510000', '3', '1', '0833', '1'),
('511102', '市中区', '511100', '4', '1', '0833', '1'),
('511111', '沙湾区', '511100', '4', '1', '0833', '1'),
('511112', '五通桥区', '511100', '4', '1', '0833', '1'),
('511113', '金口河区', '511100', '4', '1', '0833', '1'),
('511123', '犍为县', '511100', '4', '1', '0833', '1'),
('511124', '井研县', '511100', '4', '1', '0833', '1'),
('511126', '夹江县', '511100', '4', '1', '0833', '1'),
('511129', '沐川县', '511100', '4', '1', '0833', '1'),
('511132', '峨边彝族自治县', '511100', '4', '1', '0833', '1'),
('511133', '马边彝族自治县', '511100', '4', '1', '0833', '1'),
('511181', '峨眉山市', '511100', '4', '1', '0833', '1'),
('511300', '南充市', '510000', '3', '1', '0817', '1'),
('511302', '顺庆区', '511300', '4', '1', '0817', '1'),
('511303', '高坪区', '511300', '4', '1', '0817', '1'),
('511304', '嘉陵区', '511300', '4', '1', '0817', '1'),
('511321', '南部县', '511300', '4', '1', '0817', '1'),
('511322', '营山县', '511300', '4', '1', '0817', '1'),
('511323', '蓬安县', '511300', '4', '1', '0817', '1'),
('511324', '仪陇县', '511300', '4', '1', '0817', '1'),
('511325', '西充县', '511300', '4', '1', '0817', '1'),
('511381', '阆中市', '511300', '4', '1', '0817', '1'),
('511400', '眉山市', '510000', '3', '1', '0833', '1'),
('511402', '东坡区', '511400', '4', '1', '0833', '1'),
('511421', '仁寿县', '511400', '4', '1', '0833', '1'),
('511422', '彭山县', '511400', '4', '1', '0833', '1'),
('511423', '洪雅县', '511400', '4', '1', '0833', '1'),
('511424', '丹棱县', '511400', '4', '1', '0833', '1'),
('511425', '青神县', '511400', '4', '1', '0833', '1'),
('511500', '宜宾市', '510000', '3', '1', '0831', '1'),
('511502', '翠屏区', '511500', '4', '1', '0831', '1'),
('511521', '宜宾县', '511500', '4', '1', '0831', '1'),
('511522', '南溪县', '511500', '4', '1', '0831', '1'),
('511523', '江安县', '511500', '4', '1', '0831', '1'),
('511524', '长宁县', '511500', '4', '1', '0831', '1'),
('511525', '高县', '511500', '4', '1', '0831', '1'),
('511526', '珙县', '511500', '4', '1', '0831', '1'),
('511527', '筠连县', '511500', '4', '1', '0831', '1'),
('511528', '兴文县', '511500', '4', '1', '0831', '1'),
('511529', '屏山县', '511500', '4', '1', '0831', '1'),
('511600', '广安市', '510000', '3', '1', '0826', '1'),
('511602', '广安区', '511600', '4', '1', '0826', '1'),
('511621', '岳池县', '511600', '4', '1', '0826', '1'),
('511622', '武胜县', '511600', '4', '1', '0826', '1'),
('511623', '邻水县', '511600', '4', '1', '0826', '1'),
('511681', '华蓥市', '511600', '4', '1', '0826', '1'),
('511700', '达州市', '510000', '3', '1', '0818', '1'),
('511702', '通川区', '511700', '4', '1', '0818', '1'),
('511721', '达县', '511700', '4', '1', '0818', '1'),
('511722', '宣汉县', '511700', '4', '1', '0818', '1'),
('511723', '开江县', '511700', '4', '1', '0818', '1'),
('511724', '大竹县', '511700', '4', '1', '0818', '1'),
('511725', '渠县', '511700', '4', '1', '0818', '1'),
('511781', '万源市', '511700', '4', '1', '0818', '1'),
('511800', '雅安市', '510000', '3', '1', '0835', '1'),
('511802', '雨城区', '511800', '4', '1', '0835', '1'),
('511821', '名山县', '511800', '4', '1', '0835', '1'),
('511822', '荥经县', '511800', '4', '1', '0835', '1'),
('511823', '汉源县', '511800', '4', '1', '0835', '1'),
('511824', '石棉县', '511800', '4', '1', '0835', '1'),
('511825', '天全县', '511800', '4', '1', '0835', '1'),
('511826', '芦山县', '511800', '4', '1', '0835', '1'),
('511827', '宝兴县', '511800', '4', '1', '0835', '1'),
('511900', '巴中市', '510000', '3', '1', '0827', '1'),
('511902', '巴州区', '511900', '4', '1', '0827', '1'),
('511921', '通江县', '511900', '4', '1', '0827', '1'),
('511922', '南江县', '511900', '4', '1', '0827', '1'),
('511923', '平昌县', '511900', '4', '1', '0827', '1'),
('512000', '资阳市', '510000', '3', '1', '0832', '1'),
('512002', '雁江区', '512000', '4', '1', '0832', '1'),
('512021', '安岳县', '512000', '4', '1', '0832', '1'),
('512022', '乐至县', '512000', '4', '1', '0832', '1'),
('512081', '简阳市', '512000', '4', '1', '0832', '1'),
('513200', '阿坝藏族羌族自治州', '510000', '3', '1', '0837', '1'),
('513221', '汶川县', '513200', '4', '1', '0837', '1'),
('513222', '理县', '513200', '4', '1', '0837', '1'),
('513223', '茂县', '513200', '4', '1', '0837', '1'),
('513224', '松潘县', '513200', '4', '1', '0837', '1'),
('513225', '九寨沟县', '513200', '4', '1', '0837', '1'),
('513226', '金川县', '513200', '4', '1', '0837', '1'),
('513227', '小金县', '513200', '4', '1', '0837', '1'),
('513228', '黑水县', '513200', '4', '1', '0837', '1'),
('513229', '马尔康县', '513200', '4', '1', '0837', '1'),
('513230', '壤塘县', '513200', '4', '1', '0837', '1'),
('513231', '阿坝县', '513200', '4', '1', '0837', '1'),
('513232', '若尔盖县', '513200', '4', '1', '0837', '1'),
('513233', '红原县', '513200', '4', '1', '0837', '1'),
('513300', '甘孜藏族自治州', '510000', '3', '1', '0836', '1'),
('513321', '康定县', '513300', '4', '1', '0836', '1'),
('513322', '泸定县', '513300', '4', '1', '0836', '1'),
('513323', '丹巴县', '513300', '4', '1', '0836', '1'),
('513324', '九龙县', '513300', '4', '1', '0836', '1'),
('513325', '雅江县', '513300', '4', '1', '0836', '1'),
('513326', '道孚县', '513300', '4', '1', '0836', '1'),
('513327', '炉霍县', '513300', '4', '1', '0836', '1'),
('513328', '甘孜县', '513300', '4', '1', '0836', '1'),
('513329', '新龙县', '513300', '4', '1', '0836', '1'),
('513330', '德格县', '513300', '4', '1', '0836', '1'),
('513331', '白玉县', '513300', '4', '1', '0836', '1'),
('513332', '石渠县', '513300', '4', '1', '0836', '1'),
('513333', '色达县', '513300', '4', '1', '0836', '1'),
('513334', '理塘县', '513300', '4', '1', '0836', '1'),
('513335', '巴塘县', '513300', '4', '1', '0836', '1'),
('513336', '乡城县', '513300', '4', '1', '0836', '1'),
('513337', '稻城县', '513300', '4', '1', '0836', '1'),
('513338', '得荣县', '513300', '4', '1', '0836', '1'),
('513400', '凉山彝族自治州', '510000', '3', '1', '0834', '1'),
('513401', '西昌市', '513400', '4', '1', '0834', '1'),
('513422', '木里藏族自治县', '513400', '4', '1', '0834', '1'),
('513423', '盐源县', '513400', '4', '1', '0834', '1'),
('513424', '德昌县', '513400', '4', '1', '0834', '1'),
('513425', '会理县', '513400', '4', '1', '0834', '1'),
('513426', '会东县', '513400', '4', '1', '0834', '1'),
('513427', '宁南县', '513400', '4', '1', '0834', '1'),
('513428', '普格县', '513400', '4', '1', '0834', '1'),
('513429', '布拖县', '513400', '4', '1', '0834', '1'),
('513430', '金阳县', '513400', '4', '1', '0834', '1'),
('513431', '昭觉县', '513400', '4', '1', '0834', '1'),
('513432', '喜德县', '513400', '4', '1', '0834', '1'),
('513433', '冕宁县', '513400', '4', '1', '0834', '1'),
('513434', '越西县', '513400', '4', '1', '0834', '1'),
('513435', '甘洛县', '513400', '4', '1', '0834', '1'),
('513436', '美姑县', '513400', '4', '1', '0834', '1'),
('513437', '雷波县', '513400', '4', '1', '0834', '1'),
('520000', '贵州省', 'CN9999', '2', '1', NULL, '1'),
('520100', '贵阳市', '520000', '3', '1', '0851', '1'),
('520102', '南明区', '520100', '4', '1', '0851', '1'),
('520103', '云岩区', '520100', '4', '1', '0851', '1'),
('520111', '花溪区', '520100', '4', '1', '0851', '1'),
('520112', '乌当区', '520100', '4', '1', '0851', '1'),
('520113', '白云区', '520100', '4', '1', '0851', '1'),
('520114', '小河区', '520100', '4', '1', '0851', '1'),
('520121', '开阳县', '520100', '4', '1', '0851', '1'),
('520122', '息烽县', '520100', '4', '1', '0851', '1'),
('520123', '修文县', '520100', '4', '1', '0851', '1'),
('520181', '清镇市', '520100', '4', '1', '0851', '1'),
('520200', '六盘水市', '520000', '3', '1', '0858', '1'),
('520201', '钟山区', '520200', '4', '1', '0858', '1'),
('520203', '六枝特区', '520200', '4', '1', '0858', '1'),
('520221', '水城县', '520200', '4', '1', '0858', '1'),
('520222', '盘县', '520200', '4', '1', '0858', '1'),
('520300', '遵义市', '520000', '3', '1', '0852', '1'),
('520302', '红花岗区', '520300', '4', '1', '0852', '1'),
('520303', '汇川区', '520300', '4', '1', '0852', '1'),
('520321', '遵义县', '520300', '4', '1', '0852', '1'),
('520322', '桐梓县', '520300', '4', '1', '0852', '1'),
('520323', '绥阳县', '520300', '4', '1', '0852', '1'),
('520324', '正安县', '520300', '4', '1', '0852', '1'),
('520325', '道真仡佬族苗族自治县', '520300', '4', '1', '0852', '1'),
('520326', '务川仡佬族苗族自治县', '520300', '4', '1', '0852', '1'),
('520327', '凤冈县', '520300', '4', '1', '0852', '1'),
('520328', '湄潭县', '520300', '4', '1', '0852', '1'),
('520329', '余庆县', '520300', '4', '1', '0852', '1'),
('520330', '习水县', '520300', '4', '1', '0852', '1'),
('520381', '赤水市', '520300', '4', '1', '0852', '1'),
('520382', '仁怀市', '520300', '4', '1', '0852', '1'),
('520400', '安顺市', '520000', '3', '1', '0853', '1'),
('520402', '西秀区', '520400', '4', '1', '0853', '1'),
('520421', '平坝县', '520400', '4', '1', '0853', '1'),
('520422', '普定县', '520400', '4', '1', '0853', '1'),
('520423', '镇宁布依族苗族自治县', '520400', '4', '1', '0853', '1'),
('520424', '关岭布依族苗族自治县', '520400', '4', '1', '0853', '1'),
('520425', '紫云苗族布依族自治县', '520400', '4', '1', '0853', '1'),
('522200', '铜仁地区', '520000', '3', '1', '0856', '1'),
('522201', '铜仁市', '522200', '4', '1', '0856', '1'),
('522222', '江口县', '522200', '4', '1', '0856', '1'),
('522223', '玉屏侗族自治县', '522200', '4', '1', '0856', '1'),
('522224', '石阡县', '522200', '4', '1', '0856', '1'),
('522225', '思南县', '522200', '4', '1', '0856', '1'),
('522226', '印江土家族苗族自治县', '522200', '4', '1', '0856', '1'),
('522227', '德江县', '522200', '4', '1', '0856', '1'),
('522228', '沿河土家族自治县', '522200', '4', '1', '0856', '1'),
('522229', '松桃苗族自治县', '522200', '4', '1', '0856', '1'),
('522230', '万山特区', '522200', '4', '1', '0856', '1'),
('522300', '黔西南布依族苗族自治州', '520000', '3', '1', '0859', '1'),
('522301', '兴义市', '522300', '4', '1', '0859', '1'),
('522322', '兴仁县', '522300', '4', '1', '0859', '1'),
('522323', '普安县', '522300', '4', '1', '0859', '1'),
('522324', '晴隆县', '522300', '4', '1', '0859', '1'),
('522325', '贞丰县', '522300', '4', '1', '0859', '1'),
('522326', '望谟县', '522300', '4', '1', '0859', '1'),
('522327', '册亨县', '522300', '4', '1', '0859', '1'),
('522328', '安龙县', '522300', '4', '1', '0859', '1'),
('522400', '毕节地区', '520000', '3', '1', '0857', '1'),
('522401', '毕节市', '522400', '4', '1', '0857', '1'),
('522422', '大方县', '522400', '4', '1', '0857', '1'),
('522423', '黔西县', '522400', '4', '1', '0857', '1'),
('522424', '金沙县', '522400', '4', '1', '0857', '1'),
('522425', '织金县', '522400', '4', '1', '0857', '1'),
('522426', '纳雍县', '522400', '4', '1', '0857', '1'),
('522427', '威宁彝族回族苗族自治县', '522400', '4', '1', '0857', '1'),
('522428', '赫章县', '522400', '4', '1', '0857', '1'),
('522600', '黔东南苗族侗族自治州', '520000', '3', '1', '0855', '1'),
('522601', '凯里市', '522600', '4', '1', '0855', '1'),
('522622', '黄平县', '522600', '4', '1', '0855', '1'),
('522623', '施秉县', '522600', '4', '1', '0855', '1'),
('522624', '三穗县', '522600', '4', '1', '0855', '1'),
('522625', '镇远县', '522600', '4', '1', '0855', '1'),
('522626', '岑巩县', '522600', '4', '1', '0855', '1'),
('522627', '天柱县', '522600', '4', '1', '0855', '1'),
('522628', '锦屏县', '522600', '4', '1', '0855', '1'),
('522629', '剑河县', '522600', '4', '1', '0855', '1'),
('522630', '台江县', '522600', '4', '1', '0855', '1'),
('522631', '黎平县', '522600', '4', '1', '0855', '1'),
('522632', '榕江县', '522600', '4', '1', '0855', '1'),
('522633', '从江县', '522600', '4', '1', '0855', '1'),
('522634', '雷山县', '522600', '4', '1', '0855', '1'),
('522635', '麻江县', '522600', '4', '1', '0855', '1'),
('522636', '丹寨县', '522600', '4', '1', '0855', '1'),
('522700', '黔南布依族苗族自治州', '520000', '3', '1', '0854', '1'),
('522701', '都匀市', '522700', '4', '1', '0854', '1'),
('522702', '福泉市', '522700', '4', '1', '0854', '1'),
('522722', '荔波县', '522700', '4', '1', '0854', '1'),
('522723', '贵定县', '522700', '4', '1', '0854', '1'),
('522725', '瓮安县', '522700', '4', '1', '0854', '1'),
('522726', '独山县', '522700', '4', '1', '0854', '1'),
('522727', '平塘县', '522700', '4', '1', '0854', '1'),
('522728', '罗甸县', '522700', '4', '1', '0854', '1'),
('522729', '长顺县', '522700', '4', '1', '0854', '1'),
('522730', '龙里县', '522700', '4', '1', '0854', '1'),
('522731', '惠水县', '522700', '4', '1', '0854', '1'),
('522732', '三都水族自治县', '522700', '4', '1', '0854', '1'),
('530000', '云南省', 'CN9999', '2', '1', NULL, '1'),
('530100', '昆明市', '530000', '3', '1', '0871', '1'),
('530102', '五华区', '530100', '4', '1', '0871', '1'),
('530103', '盘龙区', '530100', '4', '1', '0871', '1'),
('530111', '官渡区', '530100', '4', '1', '0871', '1'),
('530112', '西山区', '530100', '4', '1', '0871', '1'),
('530113', '东川区', '530100', '4', '1', '0871', '1'),
('530121', '呈贡县', '530100', '4', '1', '0871', '1'),
('530122', '晋宁县', '530100', '4', '1', '0871', '1'),
('530124', '富民县', '530100', '4', '1', '0871', '1'),
('530125', '宜良县', '530100', '4', '1', '0871', '1'),
('530126', '石林彝族自治县', '530100', '4', '1', '0871', '1'),
('530127', '嵩明县', '530100', '4', '1', '0871', '1'),
('530128', '禄劝彝族苗族自治县', '530100', '4', '1', '0871', '1'),
('530129', '寻甸回族彝族自治县', '530100', '4', '1', '0871', '1'),
('530181', '安宁市', '530100', '4', '1', '0871', '1'),
('530300', '曲靖市', '530000', '3', '1', '0874', '1'),
('530302', '麒麟区', '530300', '4', '1', '0874', '1'),
('530321', '马龙县', '530300', '4', '1', '0874', '1'),
('530322', '陆良县', '530300', '4', '1', '0874', '1'),
('530323', '师宗县', '530300', '4', '1', '0874', '1'),
('530324', '罗平县', '530300', '4', '1', '0874', '1'),
('530325', '富源县', '530300', '4', '1', '0874', '1'),
('530326', '会泽县', '530300', '4', '1', '0874', '1'),
('530328', '沾益县', '530300', '4', '1', '0874', '1'),
('530381', '宣威市', '530300', '4', '1', '0874', '1'),
('530400', '玉溪市', '530000', '3', '1', '0877', '1'),
('530402', '红塔区', '530400', '4', '1', '0877', '1'),
('530421', '江川县', '530400', '4', '1', '0877', '1'),
('530422', '澄江县', '530400', '4', '1', '0877', '1'),
('530423', '通海县', '530400', '4', '1', '0877', '1'),
('530424', '华宁县', '530400', '4', '1', '0877', '1'),
('530425', '易门县', '530400', '4', '1', '0877', '1'),
('530426', '峨山彝族自治县', '530400', '4', '1', '0877', '1'),
('530427', '新平彝族傣族自治县', '530400', '4', '1', '0877', '1'),
('530428', '元江哈尼族彝族傣族自治县', '530400', '4', '1', '0877', '1'),
('530500', '保山市', '530000', '3', '1', '0875', '1'),
('530502', '隆阳区', '530500', '4', '1', '0875', '1'),
('530521', '施甸县', '530500', '4', '1', '0875', '1'),
('530522', '腾冲县', '530500', '4', '1', '0875', '1'),
('530523', '龙陵县', '530500', '4', '1', '0875', '1'),
('530524', '昌宁县', '530500', '4', '1', '0875', '1'),
('530600', '昭通市', '530000', '3', '1', '0870', '1'),
('530602', '昭阳区', '530600', '4', '1', '0870', '1'),
('530621', '鲁甸县', '530600', '4', '1', '0870', '1'),
('530622', '巧家县', '530600', '4', '1', '0870', '1'),
('530623', '盐津县', '530600', '4', '1', '0870', '1'),
('530624', '大关县', '530600', '4', '1', '0870', '1'),
('530625', '永善县', '530600', '4', '1', '0870', '1'),
('530626', '绥江县', '530600', '4', '1', '0870', '1'),
('530627', '镇雄县', '530600', '4', '1', '0870', '1'),
('530628', '彝良县', '530600', '4', '1', '0870', '1'),
('530629', '威信县', '530600', '4', '1', '0870', '1'),
('530630', '水富县', '530600', '4', '1', '0870', '1'),
('530700', '丽江市', '530000', '3', '1', '0888', '1'),
('530702', '古城区', '530700', '4', '1', '0888', '1'),
('530721', '玉龙纳西族自治县', '530700', '4', '1', '0888', '1'),
('530722', '永胜县', '530700', '4', '1', '0888', '1'),
('530723', '华坪县', '530700', '4', '1', '0888', '1'),
('530724', '宁蒗彝族自治县', '530700', '4', '1', '0888', '1'),
('530800', '普洱市', '530000', '3', '1', NULL, '1'),
('530802', '思茅区', '530800', '4', '1', NULL, '1'),
('530821', '宁洱哈尼族彝族自治县', '530800', '4', '1', NULL, '1'),
('530822', '墨江哈尼族自治县', '530800', '4', '1', NULL, '1'),
('530823', '景东彝族自治县', '530800', '4', '1', NULL, '1'),
('530824', '景谷傣族彝族自治县', '530800', '4', '1', NULL, '1'),
('530825', '镇沅彝族哈尼族拉祜族自治县', '530800', '4', '1', NULL, '1'),
('530826', '江城哈尼族彝族自治县', '530800', '4', '1', NULL, '1'),
('530827', '孟连傣族拉祜族佤族自治县', '530800', '4', '1', NULL, '1'),
('530828', '澜沧拉祜族自治县', '530800', '4', '1', NULL, '1'),
('530829', '西盟佤族自治县', '530800', '4', '1', NULL, '1'),
('530900', '临沧市', '530000', '3', '1', '0883', '1'),
('530902', '临翔区', '530900', '4', '1', '0883', '1'),
('530921', '凤庆县', '530900', '4', '1', '0883', '1'),
('530922', '云县', '530900', '4', '1', '0883', '1'),
('530923', '永德县', '530900', '4', '1', '0883', '1'),
('530924', '镇康县', '530900', '4', '1', '0883', '1'),
('530925', '双江拉祜族佤族布朗族傣族自治县', '530900', '4', '1', '0883', '1'),
('530926', '耿马傣族佤族自治县', '530900', '4', '1', '0883', '1'),
('530927', '沧源佤族自治县', '530900', '4', '1', '0883', '1'),
('532300', '楚雄彝族自治州', '530000', '3', '1', '0878', '1'),
('532301', '楚雄市', '532300', '4', '1', '0878', '1'),
('532322', '双柏县', '532300', '4', '1', '0878', '1'),
('532323', '牟定县', '532300', '4', '1', '0878', '1'),
('532324', '南华县', '532300', '4', '1', '0878', '1'),
('532325', '姚安县', '532300', '4', '1', '0878', '1'),
('532326', '大姚县', '532300', '4', '1', '0878', '1'),
('532327', '永仁县', '532300', '4', '1', '0878', '1'),
('532328', '元谋县', '532300', '4', '1', '0878', '1'),
('532329', '武定县', '532300', '4', '1', '0878', '1'),
('532331', '禄丰县', '532300', '4', '1', '0878', '1'),
('532500', '红河哈尼族彝族自治州', '530000', '3', '1', '087', '1'),
('532501', '个旧市', '532500', '4', '1', '087', '1'),
('532502', '开远市', '532500', '4', '1', '087', '1'),
('532522', '蒙自县', '532500', '4', '1', '087', '1'),
('532523', '屏边苗族自治县', '532500', '4', '1', '087', '1'),
('532524', '建水县', '532500', '4', '1', '087', '1'),
('532525', '石屏县', '532500', '4', '1', '087', '1'),
('532526', '弥勒县', '532500', '4', '1', '087', '1'),
('532527', '泸西县', '532500', '4', '1', '087', '1'),
('532528', '元阳县', '532500', '4', '1', '087', '1'),
('532529', '红河县', '532500', '4', '1', '087', '1'),
('532530', '金平苗族瑶族傣族自治县', '532500', '4', '1', '087', '1'),
('532531', '绿春县', '532500', '4', '1', '087', '1'),
('532532', '河口瑶族自治县', '532500', '4', '1', '087', '1'),
('532600', '文山壮族苗族自治州', '530000', '3', '1', '0876', '1'),
('532621', '文山县', '532600', '4', '1', '0876', '1'),
('532622', '砚山县', '532600', '4', '1', '0876', '1'),
('532623', '西畴县', '532600', '4', '1', '0876', '1'),
('532624', '麻栗坡县', '532600', '4', '1', '0876', '1'),
('532625', '马关县', '532600', '4', '1', '0876', '1'),
('532626', '丘北县', '532600', '4', '1', '0876', '1'),
('532627', '广南县', '532600', '4', '1', '0876', '1'),
('532628', '富宁县', '532600', '4', '1', '0876', '1'),
('532800', '西双版纳傣族自治州', '530000', '3', '1', '0691', '1'),
('532801', '景洪市', '532800', '4', '1', '0691', '1'),
('532822', '勐海县', '532800', '4', '1', '0691', '1'),
('532823', '勐腊县', '532800', '4', '1', '0691', '1'),
('532900', '大理白族自治州', '530000', '3', '1', '0872', '1'),
('532901', '大理市', '532900', '4', '1', '0872', '1'),
('532922', '漾濞彝族自治县', '532900', '4', '1', '0872', '1'),
('532923', '祥云县', '532900', '4', '1', '0872', '1'),
('532924', '宾川县', '532900', '4', '1', '0872', '1'),
('532925', '弥渡县', '532900', '4', '1', '0872', '1'),
('532926', '南涧彝族自治县', '532900', '4', '1', '0872', '1'),
('532927', '巍山彝族回族自治县', '532900', '4', '1', '0872', '1'),
('532928', '永平县', '532900', '4', '1', '0872', '1'),
('532929', '云龙县', '532900', '4', '1', '0872', '1'),
('532930', '洱源县', '532900', '4', '1', '0872', '1'),
('532931', '剑川县', '532900', '4', '1', '0872', '1'),
('532932', '鹤庆县', '532900', '4', '1', '0872', '1'),
('533100', '德宏傣族景颇族自治州', '530000', '3', '1', '0692', '1'),
('533102', '瑞丽市', '533100', '4', '1', '0692', '1'),
('533103', '潞西市', '533100', '4', '1', '0692', '1'),
('533122', '梁河县', '533100', '4', '1', '0692', '1'),
('533123', '盈江县', '533100', '4', '1', '0692', '1'),
('533124', '陇川县', '533100', '4', '1', '0692', '1'),
('533300', '怒江傈僳族自治州', '530000', '3', '1', NULL, '1'),
('533321', '泸水县', '533300', '4', '1', NULL, '1'),
('533323', '福贡县', '533300', '4', '1', NULL, '1'),
('533324', '贡山独龙族怒族自治县', '533300', '4', '1', NULL, '1'),
('533325', '兰坪白族普米族自治县', '533300', '4', '1', NULL, '1'),
('533400', '迪庆藏族自治州', '530000', '3', '1', '0887', '1'),
('533421', '香格里拉县', '533400', '4', '1', '0887', '1'),
('533422', '德钦县', '533400', '4', '1', '0887', '1'),
('533423', '维西傈僳族自治县', '533400', '4', '1', '0887', '1'),
('540000', '西藏自治区', 'CN9999', '2', '1', NULL, '1'),
('540100', '拉萨市', '540000', '3', '1', '0891', '1'),
('540102', '城关区', '540100', '4', '1', '0891', '1'),
('540121', '林周县', '540100', '4', '1', '0891', '1'),
('540122', '当雄县', '540100', '4', '1', '0891', '1'),
('540123', '尼木县', '540100', '4', '1', '0891', '1'),
('540124', '曲水县', '540100', '4', '1', '0891', '1'),
('540125', '堆龙德庆县', '540100', '4', '1', '0891', '1'),
('540126', '达孜县', '540100', '4', '1', '0891', '1'),
('540127', '墨竹工卡县', '540100', '4', '1', '0891', '1'),
('542100', '昌都地区', '540000', '3', '1', '0895', '1'),
('542121', '昌都县', '542100', '4', '1', '0895', '1'),
('542122', '江达县', '542100', '4', '1', '0895', '1'),
('542123', '贡觉县', '542100', '4', '1', '0895', '1'),
('542124', '类乌齐县', '542100', '4', '1', '0895', '1'),
('542125', '丁青县', '542100', '4', '1', '0895', '1'),
('542126', '察雅县', '542100', '4', '1', '0895', '1'),
('542127', '八宿县', '542100', '4', '1', '0895', '1'),
('542128', '左贡县', '542100', '4', '1', '0895', '1'),
('542129', '芒康县', '542100', '4', '1', '0895', '1'),
('542132', '洛隆县', '542100', '4', '1', '0895', '1'),
('542133', '边坝县', '542100', '4', '1', '0895', '1'),
('542200', '山南地区', '540000', '3', '1', '0893', '1'),
('542221', '乃东县', '542200', '4', '1', '0893', '1'),
('542222', '扎囊县', '542200', '4', '1', '0893', '1'),
('542223', '贡嘎县', '542200', '4', '1', '0893', '1'),
('542224', '桑日县', '542200', '4', '1', '0893', '1'),
('542225', '琼结县', '542200', '4', '1', '0893', '1'),
('542226', '曲松县', '542200', '4', '1', '0893', '1'),
('542227', '措美县', '542200', '4', '1', '0893', '1'),
('542228', '洛扎县', '542200', '4', '1', '0893', '1'),
('542229', '加查县', '542200', '4', '1', '0893', '1'),
('542231', '隆子县', '542200', '4', '1', '0893', '1'),
('542232', '错那县', '542200', '4', '1', '0893', '1'),
('542233', '浪卡子县', '542200', '4', '1', '0893', '1'),
('542300', '日喀则地区', '540000', '3', '1', '0892', '1'),
('542301', '日喀则市', '542300', '4', '1', '0892', '1'),
('542322', '南木林县', '542300', '4', '1', '0892', '1'),
('542323', '江孜县', '542300', '4', '1', '0892', '1'),
('542324', '定日县', '542300', '4', '1', '0892', '1'),
('542325', '萨迦县', '542300', '4', '1', '0892', '1'),
('542326', '拉孜县', '542300', '4', '1', '0892', '1'),
('542327', '昂仁县', '542300', '4', '1', '0892', '1'),
('542328', '谢通门县', '542300', '4', '1', '0892', '1'),
('542329', '白朗县', '542300', '4', '1', '0892', '1'),
('542330', '仁布县', '542300', '4', '1', '0892', '1'),
('542331', '康马县', '542300', '4', '1', '0892', '1'),
('542332', '定结县', '542300', '4', '1', '0892', '1'),
('542333', '仲巴县', '542300', '4', '1', '0892', '1'),
('542334', '亚东县', '542300', '4', '1', '0892', '1'),
('542335', '吉隆县', '542300', '4', '1', '0892', '1'),
('542336', '聂拉木县', '542300', '4', '1', '0892', '1'),
('542337', '萨嘎县', '542300', '4', '1', '0892', '1'),
('542338', '岗巴县', '542300', '4', '1', '0892', '1'),
('542400', '那曲地区', '540000', '3', '1', '0896', '1'),
('542421', '那曲县', '542400', '4', '1', '0896', '1'),
('542422', '嘉黎县', '542400', '4', '1', '0896', '1'),
('542423', '比如县', '542400', '4', '1', '0896', '1'),
('542424', '聂荣县', '542400', '4', '1', '0896', '1'),
('542425', '安多县', '542400', '4', '1', '0896', '1'),
('542426', '申扎县', '542400', '4', '1', '0896', '1'),
('542427', '索县', '542400', '4', '1', '0896', '1'),
('542428', '班戈县', '542400', '4', '1', '0896', '1'),
('542429', '巴青县', '542400', '4', '1', '0896', '1'),
('542430', '尼玛县', '542400', '4', '1', '0896', '1'),
('542500', '阿里地区', '540000', '3', '1', '0897', '1'),
('542521', '普兰县', '542500', '4', '1', '0897', '1'),
('542522', '札达县', '542500', '4', '1', '0897', '1'),
('542523', '噶尔县', '542500', '4', '1', '0897', '1'),
('542524', '日土县', '542500', '4', '1', '0897', '1'),
('542525', '革吉县', '542500', '4', '1', '0897', '1'),
('542526', '改则县', '542500', '4', '1', '0897', '1'),
('542527', '措勤县', '542500', '4', '1', '0897', '1'),
('542600', '林芝地区', '540000', '3', '1', '0894', '1'),
('542621', '林芝县', '542600', '4', '1', '0894', '1'),
('542622', '工布江达县', '542600', '4', '1', '0894', '1'),
('542623', '米林县', '542600', '4', '1', '0894', '1'),
('542624', '墨脱县', '542600', '4', '1', '0894', '1'),
('542625', '波密县', '542600', '4', '1', '0894', '1'),
('542626', '察隅县', '542600', '4', '1', '0894', '1'),
('542627', '朗县', '542600', '4', '1', '0894', '1'),
('610000', '陕西省', 'CN9999', '2', '1', NULL, '1'),
('610100', '西安市', '610000', '3', '1', '029', '1'),
('610102', '新城区', '610100', '4', '1', '029', '1'),
('610103', '碑林区', '610100', '4', '1', '029', '1'),
('610104', '莲湖区', '610100', '4', '1', '029', '1'),
('610111', '灞桥区', '610100', '4', '1', '029', '1'),
('610112', '未央区', '610100', '4', '1', '029', '1'),
('610113', '雁塔区', '610100', '4', '1', '029', '1'),
('610114', '阎良区', '610100', '4', '1', '029', '1'),
('610115', '临潼区', '610100', '4', '1', '029', '1'),
('610116', '长安区', '610100', '4', '1', '029', '1'),
('610122', '蓝田县', '610100', '4', '1', '029', '1'),
('610124', '周至县', '610100', '4', '1', '029', '1'),
('610125', '户县', '610100', '4', '1', '029', '1'),
('610126', '高陵县', '610100', '4', '1', '029', '1'),
('610200', '铜川市', '610000', '3', '1', '0919', '1'),
('610202', '王益区', '610200', '4', '1', '0919', '1'),
('610203', '印台区', '610200', '4', '1', '0919', '1'),
('610204', '耀州区', '610200', '4', '1', '0919', '1'),
('610222', '宜君县', '610200', '4', '1', '0919', '1'),
('610300', '宝鸡市', '610000', '3', '1', '0917', '1'),
('610302', '渭滨区', '610300', '4', '1', '0917', '1'),
('610303', '金台区', '610300', '4', '1', '0917', '1'),
('610304', '陈仓区', '610300', '4', '1', '0917', '1'),
('610322', '凤翔县', '610300', '4', '1', '0917', '1'),
('610323', '岐山县', '610300', '4', '1', '0917', '1'),
('610324', '扶风县', '610300', '4', '1', '0917', '1'),
('610326', '眉县', '610300', '4', '1', '0917', '1'),
('610327', '陇县', '610300', '4', '1', '0917', '1'),
('610328', '千阳县', '610300', '4', '1', '0917', '1'),
('610329', '麟游县', '610300', '4', '1', '0917', '1'),
('610330', '凤县', '610300', '4', '1', '0917', '1'),
('610331', '太白县', '610300', '4', '1', '0917', '1'),
('610400', '咸阳市', '610000', '3', '1', '0910', '1'),
('610402', '秦都区', '610400', '4', '1', '0910', '1'),
('610403', '杨凌区', '610400', '4', '1', '0910', '1'),
('610404', '渭城区', '610400', '4', '1', '0910', '1'),
('610422', '三原县', '610400', '4', '1', '0910', '1'),
('610423', '泾阳县', '610400', '4', '1', '0910', '1'),
('610424', '乾县', '610400', '4', '1', '0910', '1'),
('610425', '礼泉县', '610400', '4', '1', '0910', '1'),
('610426', '永寿县', '610400', '4', '1', '0910', '1'),
('610427', '彬县', '610400', '4', '1', '0910', '1'),
('610428', '长武县', '610400', '4', '1', '0910', '1'),
('610429', '旬邑县', '610400', '4', '1', '0910', '1'),
('610430', '淳化县', '610400', '4', '1', '0910', '1'),
('610431', '武功县', '610400', '4', '1', '0910', '1'),
('610481', '兴平市', '610400', '4', '1', '0910', '1'),
('610500', '渭南市', '610000', '3', '1', '0913', '1'),
('610502', '临渭区', '610500', '4', '1', '0913', '1'),
('610521', '华县', '610500', '4', '1', '0913', '1'),
('610522', '潼关县', '610500', '4', '1', '0913', '1'),
('610523', '大荔县', '610500', '4', '1', '0913', '1'),
('610524', '合阳县', '610500', '4', '1', '0913', '1'),
('610525', '澄城县', '610500', '4', '1', '0913', '1'),
('610526', '蒲城县', '610500', '4', '1', '0913', '1'),
('610527', '白水县', '610500', '4', '1', '0913', '1'),
('610528', '富平县', '610500', '4', '1', '0913', '1'),
('610581', '韩城市', '610500', '4', '1', '0913', '1'),
('610582', '华阴市', '610500', '4', '1', '0913', '1'),
('610600', '延安市', '610000', '3', '1', '0911', '1'),
('610602', '宝塔区', '610600', '4', '1', '0911', '1'),
('610621', '延长县', '610600', '4', '1', '0911', '1'),
('610622', '延川县', '610600', '4', '1', '0911', '1'),
('610623', '子长县', '610600', '4', '1', '0911', '1'),
('610624', '安塞县', '610600', '4', '1', '0911', '1'),
('610625', '志丹县', '610600', '4', '1', '0911', '1'),
('610626', '吴起县', '610600', '4', '1', '0911', '1'),
('610627', '甘泉县', '610600', '4', '1', '0911', '1'),
('610628', '富县', '610600', '4', '1', '0911', '1'),
('610629', '洛川县', '610600', '4', '1', '0911', '1'),
('610630', '宜川县', '610600', '4', '1', '0911', '1'),
('610631', '黄龙县', '610600', '4', '1', '0911', '1'),
('610632', '黄陵县', '610600', '4', '1', '0911', '1'),
('610700', '汉中市', '610000', '3', '1', '0916', '1'),
('610702', '汉台区', '610700', '4', '1', '0916', '1'),
('610721', '南郑县', '610700', '4', '1', '0916', '1'),
('610722', '城固县', '610700', '4', '1', '0916', '1'),
('610723', '洋县', '610700', '4', '1', '0916', '1'),
('610724', '西乡县', '610700', '4', '1', '0916', '1'),
('610725', '勉县', '610700', '4', '1', '0916', '1'),
('610726', '宁强县', '610700', '4', '1', '0916', '1'),
('610727', '略阳县', '610700', '4', '1', '0916', '1'),
('610728', '镇巴县', '610700', '4', '1', '0916', '1'),
('610729', '留坝县', '610700', '4', '1', '0916', '1'),
('610730', '佛坪县', '610700', '4', '1', '0916', '1'),
('610800', '榆林市', '610000', '3', '1', '0912', '1'),
('610802', '榆阳区', '610800', '4', '1', '0912', '1'),
('610821', '神木县', '610800', '4', '1', '0912', '1'),
('610822', '府谷县', '610800', '4', '1', '0912', '1'),
('610823', '横山县', '610800', '4', '1', '0912', '1'),
('610824', '靖边县', '610800', '4', '1', '0912', '1'),
('610825', '定边县', '610800', '4', '1', '0912', '1'),
('610826', '绥德县', '610800', '4', '1', '0912', '1'),
('610827', '米脂县', '610800', '4', '1', '0912', '1'),
('610828', '佳县', '610800', '4', '1', '0912', '1'),
('610829', '吴堡县', '610800', '4', '1', '0912', '1'),
('610830', '清涧县', '610800', '4', '1', '0912', '1'),
('610831', '子洲县', '610800', '4', '1', '0912', '1'),
('610900', '安康市', '610000', '3', '1', '0915', '1'),
('610902', '汉滨区', '610900', '4', '1', '0915', '1'),
('610921', '汉阴县', '610900', '4', '1', '0915', '1'),
('610922', '石泉县', '610900', '4', '1', '0915', '1'),
('610923', '宁陕县', '610900', '4', '1', '0915', '1'),
('610924', '紫阳县', '610900', '4', '1', '0915', '1'),
('610925', '岚皋县', '610900', '4', '1', '0915', '1'),
('610926', '平利县', '610900', '4', '1', '0915', '1'),
('610927', '镇坪县', '610900', '4', '1', '0915', '1'),
('610928', '旬阳县', '610900', '4', '1', '0915', '1'),
('610929', '白河县', '610900', '4', '1', '0915', '1'),
('611000', '商洛市', '610000', '3', '1', '0914', '1'),
('611002', '商州区', '611000', '4', '1', '0914', '1'),
('611021', '洛南县', '611000', '4', '1', '0914', '1'),
('611022', '丹凤县', '611000', '4', '1', '0914', '1'),
('611023', '商南县', '611000', '4', '1', '0914', '1'),
('611024', '山阳县', '611000', '4', '1', '0914', '1'),
('611025', '镇安县', '611000', '4', '1', '0914', '1'),
('611026', '柞水县', '611000', '4', '1', '0914', '1'),
('620000', '甘肃省', 'CN9999', '2', '1', NULL, '1'),
('620100', '兰州市', '620000', '3', '1', '0931', '1'),
('620102', '城关区', '620100', '4', '1', '0931', '1'),
('620103', '七里河区', '620100', '4', '1', '0931', '1'),
('620104', '西固区', '620100', '4', '1', '0931', '1'),
('620105', '安宁区', '620100', '4', '1', '0931', '1'),
('620111', '红古区', '620100', '4', '1', '0931', '1'),
('620121', '永登县', '620100', '4', '1', '0931', '1'),
('620122', '皋兰县', '620100', '4', '1', '0931', '1'),
('620123', '榆中县', '620100', '4', '1', '0931', '1'),
('620200', '嘉峪关市', '620000', '3', '1', '0937', '1'),
('620300', '金昌市', '620000', '3', '1', '0935', '1'),
('620302', '金川区', '620300', '4', '1', '0935', '1'),
('620321', '永昌县', '620300', '4', '1', '0935', '1'),
('620400', '白银市', '620000', '3', '1', '0943', '1'),
('620402', '白银区', '620400', '4', '1', '0943', '1'),
('620403', '平川区', '620400', '4', '1', '0943', '1'),
('620421', '靖远县', '620400', '4', '1', '0943', '1'),
('620422', '会宁县', '620400', '4', '1', '0943', '1'),
('620423', '景泰县', '620400', '4', '1', '0943', '1'),
('620500', '天水市', '620000', '3', '1', '0938', '1'),
('620502', '秦州区', '620500', '4', '1', '0938', '1'),
('620503', '麦积区', '620500', '4', '1', '0938', '1'),
('620521', '清水县', '620500', '4', '1', '0938', '1'),
('620522', '秦安县', '620500', '4', '1', '0938', '1'),
('620523', '甘谷县', '620500', '4', '1', '0938', '1'),
('620524', '武山县', '620500', '4', '1', '0938', '1'),
('620525', '张家川回族自治县', '620500', '4', '1', '0938', '1'),
('620600', '武威市', '620000', '3', '1', '0935', '1'),
('620602', '凉州区', '620600', '4', '1', '0935', '1'),
('620621', '民勤县', '620600', '4', '1', '0935', '1'),
('620622', '古浪县', '620600', '4', '1', '0935', '1'),
('620623', '天祝藏族自治县', '620600', '4', '1', '0935', '1'),
('620700', '张掖市', '620000', '3', '1', '0936', '1'),
('620702', '甘州区', '620700', '4', '1', '0936', '1'),
('620721', '肃南裕固族自治县', '620700', '4', '1', '0936', '1'),
('620722', '民乐县', '620700', '4', '1', '0936', '1'),
('620723', '临泽县', '620700', '4', '1', '0936', '1'),
('620724', '高台县', '620700', '4', '1', '0936', '1'),
('620725', '山丹县', '620700', '4', '1', '0936', '1'),
('620800', '平凉市', '620000', '3', '1', '0933', '1');
INSERT INTO `t_pub_area` (`id`, `AREA_NAME`, `PARENT_AREA_ID`, `AREA_LEVEL`, `STATUS`, `AREA_REGION`, `IS_INTERNAL`) VALUES
('620802', '崆峒区', '620800', '4', '1', '0933', '1'),
('620821', '泾川县', '620800', '4', '1', '0933', '1'),
('620822', '灵台县', '620800', '4', '1', '0933', '1'),
('620823', '崇信县', '620800', '4', '1', '0933', '1'),
('620824', '华亭县', '620800', '4', '1', '0933', '1'),
('620825', '庄浪县', '620800', '4', '1', '0933', '1'),
('620826', '静宁县', '620800', '4', '1', '0933', '1'),
('620900', '酒泉市', '620000', '3', '1', '0937', '1'),
('620902', '肃州区', '620900', '4', '1', '0937', '1'),
('620921', '金塔县', '620900', '4', '1', '0937', '1'),
('620922', '瓜州县', '620900', '4', '1', '0937', '1'),
('620923', '肃北蒙古族自治县', '620900', '4', '1', '0937', '1'),
('620924', '阿克塞哈萨克族自治县', '620900', '4', '1', '0937', '1'),
('620981', '玉门市', '620900', '4', '1', '0937', '1'),
('620982', '敦煌市', '620900', '4', '1', '0937', '1'),
('621000', '庆阳市', '620000', '3', '1', NULL, '1'),
('621002', '西峰区', '621000', '4', '1', NULL, '1'),
('621021', '庆城县', '621000', '4', '1', NULL, '1'),
('621022', '环县', '621000', '4', '1', NULL, '1'),
('621023', '华池县', '621000', '4', '1', NULL, '1'),
('621024', '合水县', '621000', '4', '1', NULL, '1'),
('621025', '正宁县', '621000', '4', '1', NULL, '1'),
('621026', '宁县', '621000', '4', '1', NULL, '1'),
('621027', '镇原县', '621000', '4', '1', NULL, '1'),
('621100', '定西市', '620000', '3', '1', '0932', '1'),
('621102', '安定区', '621100', '4', '1', '0932', '1'),
('621121', '通渭县', '621100', '4', '1', '0932', '1'),
('621122', '陇西县', '621100', '4', '1', '0932', '1'),
('621123', '渭源县', '621100', '4', '1', '0932', '1'),
('621124', '临洮县', '621100', '4', '1', '0932', '1'),
('621125', '漳县', '621100', '4', '1', '0932', '1'),
('621126', '岷县', '621100', '4', '1', '0932', '1'),
('621200', '陇南市', '620000', '3', '1', NULL, '1'),
('621202', '武都区', '621200', '4', '1', NULL, '1'),
('621221', '成县', '621200', '4', '1', NULL, '1'),
('621222', '文县', '621200', '4', '1', NULL, '1'),
('621223', '宕昌县', '621200', '4', '1', NULL, '1'),
('621224', '康县', '621200', '4', '1', NULL, '1'),
('621225', '西和县', '621200', '4', '1', NULL, '1'),
('621226', '礼县', '621200', '4', '1', NULL, '1'),
('621227', '徽县', '621200', '4', '1', NULL, '1'),
('621228', '两当县', '621200', '4', '1', NULL, '1'),
('622900', '临夏回族自治州', '620000', '3', '1', '0930', '1'),
('622901', '临夏市', '622900', '4', '1', '0930', '1'),
('622921', '临夏县', '622900', '4', '1', '0930', '1'),
('622922', '康乐县', '622900', '4', '1', '0930', '1'),
('622923', '永靖县', '622900', '4', '1', '0930', '1'),
('622924', '广河县', '622900', '4', '1', '0930', '1'),
('622925', '和政县', '622900', '4', '1', '0930', '1'),
('622926', '东乡族自治县', '622900', '4', '1', '0930', '1'),
('622927', '积石山保安族东乡族撒拉族自治县', '622900', '4', '1', '0930', '1'),
('623000', '甘南藏族自治州', '620000', '3', '1', '0941', '1'),
('623001', '合作市', '623000', '4', '1', '0941', '1'),
('623021', '临潭县', '623000', '4', '1', '0941', '1'),
('623022', '卓尼县', '623000', '4', '1', '0941', '1'),
('623023', '舟曲县', '623000', '4', '1', '0941', '1'),
('623024', '迭部县', '623000', '4', '1', '0941', '1'),
('623025', '玛曲县', '623000', '4', '1', '0941', '1'),
('623026', '碌曲县', '623000', '4', '1', '0941', '1'),
('623027', '夏河县', '623000', '4', '1', '0941', '1'),
('630000', '青海省', 'CN9999', '2', '1', NULL, '1'),
('630100', '西宁市', '630000', '3', '1', '0971', '1'),
('630102', '城东区', '630100', '4', '1', '0971', '1'),
('630103', '城中区', '630100', '4', '1', '0971', '1'),
('630104', '城西区', '630100', '4', '1', '0971', '1'),
('630105', '城北区', '630100', '4', '1', '0971', '1'),
('630121', '大通回族土族自治县', '630100', '4', '1', '0971', '1'),
('630122', '湟中县', '630100', '4', '1', '0971', '1'),
('630123', '湟源县', '630100', '4', '1', '0971', '1'),
('632100', '海东地区', '630000', '3', '1', '0972', '1'),
('632121', '平安县', '632100', '4', '1', '0972', '1'),
('632122', '民和回族土族自治县', '632100', '4', '1', '0972', '1'),
('632123', '乐都县', '632100', '4', '1', '0972', '1'),
('632126', '互助土族自治县', '632100', '4', '1', '0972', '1'),
('632127', '化隆回族自治县', '632100', '4', '1', '0972', '1'),
('632128', '循化撒拉族自治县', '632100', '4', '1', '0972', '1'),
('632200', '海北藏族自治州', '630000', '3', '1', '0970', '1'),
('632221', '门源回族自治县', '632200', '4', '1', '0970', '1'),
('632222', '祁连县', '632200', '4', '1', '0970', '1'),
('632223', '海晏县', '632200', '4', '1', '0970', '1'),
('632224', '刚察县', '632200', '4', '1', '0970', '1'),
('632300', '黄南藏族自治州', '630000', '3', '1', '0973', '1'),
('632321', '同仁县', '632300', '4', '1', '0973', '1'),
('632322', '尖扎县', '632300', '4', '1', '0973', '1'),
('632323', '泽库县', '632300', '4', '1', '0973', '1'),
('632324', '河南蒙古族自治县', '632300', '4', '1', '0973', '1'),
('632500', '海南藏族自治州', '630000', '3', '1', '0974', '1'),
('632521', '共和县', '632500', '4', '1', '0974', '1'),
('632522', '同德县', '632500', '4', '1', '0974', '1'),
('632523', '贵德县', '632500', '4', '1', '0974', '1'),
('632524', '兴海县', '632500', '4', '1', '0974', '1'),
('632525', '贵南县', '632500', '4', '1', '0974', '1'),
('632600', '果洛藏族自治州', '630000', '3', '1', '0975', '1'),
('632621', '玛沁县', '632600', '4', '1', '0975', '1'),
('632622', '班玛县', '632600', '4', '1', '0975', '1'),
('632623', '甘德县', '632600', '4', '1', '0975', '1'),
('632624', '达日县', '632600', '4', '1', '0975', '1'),
('632625', '久治县', '632600', '4', '1', '0975', '1'),
('632626', '玛多县', '632600', '4', '1', '0975', '1'),
('632700', '玉树藏族自治州', '630000', '3', '1', '0976', '1'),
('632721', '玉树县', '632700', '4', '1', '0976', '1'),
('632722', '杂多县', '632700', '4', '1', '0976', '1'),
('632723', '称多县', '632700', '4', '1', '0976', '1'),
('632724', '治多县', '632700', '4', '1', '0976', '1'),
('632725', '囊谦县', '632700', '4', '1', '0976', '1'),
('632726', '曲麻莱县', '632700', '4', '1', '0976', '1'),
('632800', '海西蒙古族藏族自治州', '630000', '3', '1', '0977', '1'),
('632801', '格尔木市', '632800', '4', '1', '0977', '1'),
('632802', '德令哈市', '632800', '4', '1', '0977', '1'),
('632821', '乌兰县', '632800', '4', '1', '0977', '1'),
('632822', '都兰县', '632800', '4', '1', '0977', '1'),
('632823', '天峻县', '632800', '4', '1', '0977', '1'),
('640000', '宁夏回族自治区', 'CN9999', '2', '1', NULL, '1'),
('640100', '银川市', '640000', '3', '1', '0951', '1'),
('640104', '兴庆区', '640100', '4', '1', '0951', '1'),
('640105', '西夏区', '640100', '4', '1', '0951', '1'),
('640106', '金凤区', '640100', '4', '1', '0951', '1'),
('640121', '永宁县', '640100', '4', '1', '0951', '1'),
('640122', '贺兰县', '640100', '4', '1', '0951', '1'),
('640181', '灵武市', '640100', '4', '1', '0951', '1'),
('640200', '石嘴山市', '640000', '3', '1', '0952', '1'),
('640202', '大武口区', '640200', '4', '1', '0952', '1'),
('640205', '惠农区', '640200', '4', '1', '0952', '1'),
('640221', '平罗县', '640200', '4', '1', '0952', '1'),
('640300', '吴忠市', '640000', '3', '1', '0953', '1'),
('640302', '利通区', '640300', '4', '1', '0953', '1'),
('640323', '盐池县', '640300', '4', '1', '0953', '1'),
('640324', '同心县', '640300', '4', '1', '0953', '1'),
('640381', '青铜峡市', '640300', '4', '1', '0953', '1'),
('640400', '固原市', '640000', '3', '1', '0954', '1'),
('640402', '原州区', '640400', '4', '1', '0954', '1'),
('640422', '西吉县', '640400', '4', '1', '0954', '1'),
('640423', '隆德县', '640400', '4', '1', '0954', '1'),
('640424', '泾源县', '640400', '4', '1', '0954', '1'),
('640425', '彭阳县', '640400', '4', '1', '0954', '1'),
('640500', '中卫市', '640000', '3', '1', NULL, '1'),
('640502', '沙坡头区', '640500', '4', '1', NULL, '1'),
('640521', '中宁县', '640500', '4', '1', NULL, '1'),
('640522', '海原县', '640500', '4', '1', NULL, '1'),
('650000', '新疆维吾尔自治区', 'CN9999', '2', '1', NULL, '1'),
('650100', '乌鲁木齐市', '650000', '3', '1', '0991', '1'),
('650102', '天山区', '650100', '4', '1', '0991', '1'),
('650103', '沙依巴克区', '650100', '4', '1', '0991', '1'),
('650104', '新市区', '650100', '4', '1', '0991', '1'),
('650105', '水磨沟区', '650100', '4', '1', '0991', '1'),
('650106', '头屯河区', '650100', '4', '1', '0991', '1'),
('650107', '达坂城区', '650100', '4', '1', '0991', '1'),
('650109', '米东区', '650100', '4', '1', '0991', '1'),
('650121', '乌鲁木齐县', '650100', '4', '1', '0991', '1'),
('650200', '克拉玛依市', '650000', '3', '1', '0990', '1'),
('650202', '独山子区', '650200', '4', '1', '0990', '1'),
('650203', '克拉玛依区', '650200', '4', '1', '0990', '1'),
('650204', '白碱滩区', '650200', '4', '1', '0990', '1'),
('650205', '乌尔禾区', '650200', '4', '1', '0990', '1'),
('652100', '吐鲁番地区', '650000', '3', '1', '0995', '1'),
('652101', '吐鲁番市', '652100', '4', '1', '0995', '1'),
('652122', '鄯善县', '652100', '4', '1', '0995', '1'),
('652123', '托克逊县', '652100', '4', '1', '0995', '1'),
('652200', '哈密地区', '650000', '3', '1', '0902', '1'),
('652201', '哈密市', '652200', '4', '1', '0902', '1'),
('652222', '巴里坤哈萨克自治县', '652200', '4', '1', '0902', '1'),
('652223', '伊吾县', '652200', '4', '1', '0902', '1'),
('652300', '昌吉回族自治州', '650000', '3', '1', '0994', '1'),
('652301', '昌吉市', '652300', '4', '1', '0994', '1'),
('652302', '阜康市', '652300', '4', '1', '0994', '1'),
('652323', '呼图壁县', '652300', '4', '1', '0994', '1'),
('652324', '玛纳斯县', '652300', '4', '1', '0994', '1'),
('652325', '奇台县', '652300', '4', '1', '0994', '1'),
('652327', '吉木萨尔县', '652300', '4', '1', '0994', '1'),
('652328', '木垒哈萨克自治县', '652300', '4', '1', '0994', '1'),
('652700', '博尔塔拉蒙古自治州', '650000', '3', '1', '0909', '1'),
('652701', '博乐市', '652700', '4', '1', '0909', '1'),
('652722', '精河县', '652700', '4', '1', '0909', '1'),
('652723', '温泉县', '652700', '4', '1', '0909', '1'),
('652800', '巴音郭楞蒙古自治州', '650000', '3', '1', '0996', '1'),
('652801', '库尔勒市', '652800', '4', '1', '0996', '1'),
('652822', '轮台县', '652800', '4', '1', '0996', '1'),
('652823', '尉犁县', '652800', '4', '1', '0996', '1'),
('652824', '若羌县', '652800', '4', '1', '0996', '1'),
('652825', '且末县', '652800', '4', '1', '0996', '1'),
('652826', '焉耆回族自治县', '652800', '4', '1', '0996', '1'),
('652827', '和静县', '652800', '4', '1', '0996', '1'),
('652828', '和硕县', '652800', '4', '1', '0996', '1'),
('652829', '博湖县', '652800', '4', '1', '0996', '1'),
('652900', '阿克苏地区', '650000', '3', '1', '0997', '1'),
('652901', '阿克苏市', '652900', '4', '1', '0997', '1'),
('652922', '温宿县', '652900', '4', '1', '0997', '1'),
('652923', '库车县', '652900', '4', '1', '0997', '1'),
('652924', '沙雅县', '652900', '4', '1', '0997', '1'),
('652925', '新和县', '652900', '4', '1', '0997', '1'),
('652926', '拜城县', '652900', '4', '1', '0997', '1'),
('652927', '乌什县', '652900', '4', '1', '0997', '1'),
('652928', '阿瓦提县', '652900', '4', '1', '0997', '1'),
('652929', '柯坪县', '652900', '4', '1', '0997', '1'),
('653000', '克孜勒苏柯尔克孜自治州', '650000', '3', '1', '0908', '1'),
('653001', '阿图什市', '653000', '4', '1', '0908', '1'),
('653022', '阿克陶县', '653000', '4', '1', '0908', '1'),
('653023', '阿合奇县', '653000', '4', '1', '0908', '1'),
('653024', '乌恰县', '653000', '4', '1', '0908', '1'),
('653100', '喀什地区', '650000', '3', '1', '0998', '1'),
('653101', '喀什市', '653100', '4', '1', '0998', '1'),
('653121', '疏附县', '653100', '4', '1', '0998', '1'),
('653122', '疏勒县', '653100', '4', '1', '0998', '1'),
('653123', '英吉沙县', '653100', '4', '1', '0998', '1'),
('653124', '泽普县', '653100', '4', '1', '0998', '1'),
('653125', '莎车县', '653100', '4', '1', '0998', '1'),
('653126', '叶城县', '653100', '4', '1', '0998', '1'),
('653127', '麦盖提县', '653100', '4', '1', '0998', '1'),
('653128', '岳普湖县', '653100', '4', '1', '0998', '1'),
('653129', '伽师县', '653100', '4', '1', '0998', '1'),
('653130', '巴楚县', '653100', '4', '1', '0998', '1'),
('653131', '塔什库尔干塔吉克自治县', '653100', '4', '1', '0998', '1'),
('653200', '和田地区', '650000', '3', '1', '0903', '1'),
('653201', '和田市', '653200', '4', '1', '0903', '1'),
('653221', '和田县', '653200', '4', '1', '0903', '1'),
('653222', '墨玉县', '653200', '4', '1', '0903', '1'),
('653223', '皮山县', '653200', '4', '1', '0903', '1'),
('653224', '洛浦县', '653200', '4', '1', '0903', '1'),
('653225', '策勒县', '653200', '4', '1', '0903', '1'),
('653226', '于田县', '653200', '4', '1', '0903', '1'),
('653227', '民丰县', '653200', '4', '1', '0903', '1'),
('654000', '伊犁哈萨克自治州', '650000', '3', '1', '0999', '1'),
('654002', '伊宁市', '654000', '4', '1', '0999', '1'),
('654003', '奎屯市', '654000', '4', '1', '0999', '1'),
('654021', '伊宁县', '654000', '4', '1', '0999', '1'),
('654022', '察布查尔锡伯自治县', '654000', '4', '1', '0999', '1'),
('654023', '霍城县', '654000', '4', '1', '0999', '1'),
('654024', '巩留县', '654000', '4', '1', '0999', '1'),
('654025', '新源县', '654000', '4', '1', '0999', '1'),
('654026', '昭苏县', '654000', '4', '1', '0999', '1'),
('654027', '特克斯县', '654000', '4', '1', '0999', '1'),
('654028', '尼勒克县', '654000', '4', '1', '0999', '1'),
('654200', '塔城地区', '650000', '3', '1', '0901', '1'),
('654201', '塔城市', '654200', '4', '1', '0901', '1'),
('654202', '乌苏市', '654200', '4', '1', '0901', '1'),
('654221', '额敏县', '654200', '4', '1', '0901', '1'),
('654223', '沙湾县', '654200', '4', '1', '0901', '1'),
('654224', '托里县', '654200', '4', '1', '0901', '1'),
('654225', '裕民县', '654200', '4', '1', '0901', '1'),
('654226', '和布克赛尔蒙古自治县', '654200', '4', '1', '0901', '1'),
('654300', '阿勒泰地区', '650000', '3', '1', '0906', '1'),
('654301', '阿勒泰市', '654300', '4', '1', '0906', '1'),
('654321', '布尔津县', '654300', '4', '1', '0906', '1'),
('654322', '富蕴县', '654300', '4', '1', '0906', '1'),
('654323', '福海县', '654300', '4', '1', '0906', '1'),
('654324', '哈巴河县', '654300', '4', '1', '0906', '1'),
('654325', '青河县', '654300', '4', '1', '0906', '1'),
('654326', '吉木乃县', '654300', '4', '1', '0906', '1'),
('CN9999', '中国', NULL, '1', '1', NULL, '1'),
('SG9999', '新加坡', NULL, '1', '1', NULL, '1');

-- --------------------------------------------------------

--
-- Table structure for table `t_sequence`
--

CREATE TABLE IF NOT EXISTS `t_sequence` (
  `name` varchar(50) NOT NULL,
  `current_value` int(11) NOT NULL,
  `increment` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `t_sequence`
--

INSERT INTO `t_sequence` (`name`, `current_value`, `increment`) VALUES
('channel_id', 76, 1),
('commerce_id', 128, 1),
('n_order_refund_id', 87, 1),
('n_voucher_id', 11, 1),
('order_id', 5141, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jc_address`
--
ALTER TABLE `jc_address`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_jc_address_parent` (`parent_id`);

--
-- Indexes for table `jc_core_admin`
--
ALTER TABLE `jc_core_admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD KEY `fk_jc_admin_user` (`user_id`),
  ADD KEY `fk_jc_admin_website` (`website_id`);

--
-- Indexes for table `jc_core_admin_role`
--
ALTER TABLE `jc_core_admin_role`
  ADD PRIMARY KEY (`role_id`,`admin_id`),
  ADD KEY `fk_jc_core_role_admin` (`role_id`),
  ADD KEY `fk_jc_core_admin_role` (`admin_id`);

--
-- Indexes for table `jc_core_global`
--
ALTER TABLE `jc_core_global`
  ADD PRIMARY KEY (`global_id`);

--
-- Indexes for table `jc_core_log`
--
ALTER TABLE `jc_core_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `fk_jc_log_site` (`website_id`),
  ADD KEY `fk_jc_log_user` (`user_id`);

--
-- Indexes for table `jc_core_member`
--
ALTER TABLE `jc_core_member`
  ADD PRIMARY KEY (`member_id`),
  ADD KEY `fk_jc_member_user` (`user_id`),
  ADD KEY `fk_jc_member_website` (`website_id`);

--
-- Indexes for table `jc_core_message_tpl`
--
ALTER TABLE `jc_core_message_tpl`
  ADD KEY `fk_jc_msgtpl_website` (`website_id`);

--
-- Indexes for table `jc_core_role`
--
ALTER TABLE `jc_core_role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `jc_core_role_permission`
--
ALTER TABLE `jc_core_role_permission`
  ADD KEY `fk_jc_core_permission_role` (`role_id`);

--
-- Indexes for table `jc_core_user`
--
ALTER TABLE `jc_core_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `ak_login_name` (`username`),
  ADD UNIQUE KEY `ak_email` (`email`);

--
-- Indexes for table `jc_core_website`
--
ALTER TABLE `jc_core_website`
  ADD PRIMARY KEY (`website_id`),
  ADD UNIQUE KEY `ak_domain` (`domain`),
  ADD KEY `fk_jc_website_admin` (`admin_id`),
  ADD KEY `fk_jc_website_global` (`global_id`),
  ADD KEY `fk_jc_website_parent` (`parent_id`);

--
-- Indexes for table `jc_data_backup`
--
ALTER TABLE `jc_data_backup`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_online_customerservice`
--
ALTER TABLE `jc_online_customerservice`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_popularity_group`
--
ALTER TABLE `jc_popularity_group`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_popularity_group_product`
--
ALTER TABLE `jc_popularity_group_product`
  ADD PRIMARY KEY (`Id`,`product_id`),
  ADD KEY `fk_jc_popularity_group_product` (`Id`),
  ADD KEY `fk_jc_popularity_product_group` (`product_id`);

--
-- Indexes for table `jc_popularity_item`
--
ALTER TABLE `jc_popularity_item`
  ADD PRIMARY KEY (`popularityitem_id`),
  ADD KEY `fk_jc_shop_popularityitem_cart` (`cart_id`);

--
-- Indexes for table `jc_shop_admin`
--
ALTER TABLE `jc_shop_admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD KEY `fk_jc_shop_admin_website` (`website_id`);

--
-- Indexes for table `jc_shop_advertise`
--
ALTER TABLE `jc_shop_advertise`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `jc_shop_adspace_fk` (`adspace_id`);

--
-- Indexes for table `jc_shop_advertise_attr`
--
ALTER TABLE `jc_shop_advertise_attr`
  ADD KEY `fk_jc_params_advertising` (`Id`);

--
-- Indexes for table `jc_shop_advertise_space`
--
ALTER TABLE `jc_shop_advertise_space`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_article`
--
ALTER TABLE `jc_shop_article`
  ADD PRIMARY KEY (`article_id`),
  ADD KEY `fk_jc_shop_article_channel` (`channel_id`),
  ADD KEY `fk_jc_shop_article_website` (`website_id`);

--
-- Indexes for table `jc_shop_article_content`
--
ALTER TABLE `jc_shop_article_content`
  ADD KEY `fk_jc_shop_content_article` (`article_id`);

--
-- Indexes for table `jc_shop_brand`
--
ALTER TABLE `jc_shop_brand`
  ADD PRIMARY KEY (`brand_id`),
  ADD KEY `fk_jc_shop_brand_website` (`website_id`);

--
-- Indexes for table `jc_shop_brand_text`
--
ALTER TABLE `jc_shop_brand_text`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indexes for table `jc_shop_cardgift`
--
ALTER TABLE `jc_shop_cardgift`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_jc_cardgift_cart` (`cartId`),
  ADD KEY `fk_jc_cardgift_website` (`websiteId`),
  ADD KEY `fk_jc_cardgift_gift` (`giftId`);

--
-- Indexes for table `jc_shop_cart`
--
ALTER TABLE `jc_shop_cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `fk_jc_shop_cart_website` (`website_id`);

--
-- Indexes for table `jc_shop_cart_item`
--
ALTER TABLE `jc_shop_cart_item`
  ADD PRIMARY KEY (`cartitem_id`),
  ADD KEY `fk_jc_shop_cartitem_product` (`product_id`),
  ADD KEY `fk_jc_shop_cartitem_website` (`website_id`),
  ADD KEY `fk_jc_shop_cartitem_cart` (`cart_id`),
  ADD KEY `fk_jc_shop_cartitem_productFash` (`productFash_id`);

--
-- Indexes for table `jc_shop_category`
--
ALTER TABLE `jc_shop_category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `fk_jc_shop_category_parent` (`parent_id`),
  ADD KEY `fk_jc_shop_category_ptype` (`ptype_id`),
  ADD KEY `fk_jc_shop_cateory_website` (`website_id`);

--
-- Indexes for table `jc_shop_category_attr`
--
ALTER TABLE `jc_shop_category_attr`
  ADD KEY `fk_jc_shop_category_attr` (`category_id`);

--
-- Indexes for table `jc_shop_category_brand`
--
ALTER TABLE `jc_shop_category_brand`
  ADD PRIMARY KEY (`brand_id`,`category_id`),
  ADD KEY `fk_jc_shop_category_brand` (`category_id`);

--
-- Indexes for table `jc_shop_category_property`
--
ALTER TABLE `jc_shop_category_property`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_jc_shop_category_property` (`category_id`);

--
-- Indexes for table `jc_shop_category_sdtype`
--
ALTER TABLE `jc_shop_category_sdtype`
  ADD PRIMARY KEY (`category_id`,`standardtype_id`),
  ADD KEY `fk_jc_shop_category_sdtype` (`category_id`),
  ADD KEY `fk_jc_shop_sdtype_category` (`standardtype_id`);

--
-- Indexes for table `jc_shop_channel`
--
ALTER TABLE `jc_shop_channel`
  ADD PRIMARY KEY (`channel_id`),
  ADD KEY `fk_jc_shop_channel_website` (`website_id`),
  ADD KEY `fk_jc_shop_channel_parent` (`parent_id`);

--
-- Indexes for table `jc_shop_channel_content`
--
ALTER TABLE `jc_shop_channel_content`
  ADD KEY `fk_jc_shop_content_channel` (`channel_id`);

--
-- Indexes for table `jc_shop_collect`
--
ALTER TABLE `jc_shop_collect`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_jc_shop_collect_member` (`member_id`),
  ADD KEY `fk_jc_shop_collect_product` (`product_id`),
  ADD KEY `fk_jc_shop_collect_fashion` (`fashion_id`);

--
-- Indexes for table `jc_shop_config`
--
ALTER TABLE `jc_shop_config`
  ADD PRIMARY KEY (`config_id`),
  ADD KEY `fk_jc_shop_config_group` (`register_group_id`);

--
-- Indexes for table `jc_shop_consult`
--
ALTER TABLE `jc_shop_consult`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_product_consult` (`product_id`),
  ADD KEY `fk_member_consult` (`member_id`);

--
-- Indexes for table `jc_shop_coupon`
--
ALTER TABLE `jc_shop_coupon`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `jc_shop_dictionary`
--
ALTER TABLE `jc_shop_dictionary`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_jc_dictionary_type` (`type_id`);

--
-- Indexes for table `jc_shop_dictionary_type`
--
ALTER TABLE `jc_shop_dictionary_type`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_discuss`
--
ALTER TABLE `jc_shop_discuss`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_jc_disucss_member` (`member_id`),
  ADD KEY `fk_jc_disucss_product` (`product_id`);

--
-- Indexes for table `jc_shop_exended`
--
ALTER TABLE `jc_shop_exended`
  ADD PRIMARY KEY (`exended_id`);

--
-- Indexes for table `jc_shop_exended_item`
--
ALTER TABLE `jc_shop_exended_item`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_fashion_standard`
--
ALTER TABLE `jc_shop_fashion_standard`
  ADD PRIMARY KEY (`fashion_id`,`standard_id`),
  ADD KEY `fk_jc_shop_fashion_standard` (`fashion_id`),
  ADD KEY `fk_jc_shop_standard_fashion` (`standard_id`);

--
-- Indexes for table `jc_shop_favorable`
--
ALTER TABLE `jc_shop_favorable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jc_shop_gift`
--
ALTER TABLE `jc_shop_gift`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_gift_exchange`
--
ALTER TABLE `jc_shop_gift_exchange`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_jc_shop_exchange_member` (`member_id`),
  ADD KEY `fk_jc_shop_exchange_gift` (`gift_id`);

--
-- Indexes for table `jc_shop_image`
--
ALTER TABLE `jc_shop_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jc_shop_keyword_q`
--
ALTER TABLE `jc_shop_keyword_q`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_logistics`
--
ALTER TABLE `jc_shop_logistics`
  ADD PRIMARY KEY (`logistics_id`);

--
-- Indexes for table `jc_shop_logistics_text`
--
ALTER TABLE `jc_shop_logistics_text`
  ADD PRIMARY KEY (`logistics_id`);

--
-- Indexes for table `jc_shop_member`
--
ALTER TABLE `jc_shop_member`
  ADD PRIMARY KEY (`member_id`),
  ADD KEY `fk_jc_shop_member_mgroup` (`group_id`),
  ADD KEY `fk_jc_shop_member_website` (`website_id`),
  ADD KEY `fk_jc_shop_dictionary_userdegree` (`userdegree_id`),
  ADD KEY `fk_jc_shop_dictionary_familymembers` (`familymembers_id`),
  ADD KEY `fk_jc_shop_dictionary_incomedesc` (`incomedesc_id`),
  ADD KEY `fk_jc_shop_dictionary_workseniority` (`workseniority_id`),
  ADD KEY `fk_jc_shop_dictionary_degree` (`degree_id`);

--
-- Indexes for table `jc_shop_member_address`
--
ALTER TABLE `jc_shop_member_address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `fk_jc_address_province` (`province_id`),
  ADD KEY `fk_jc_address_city` (`city_id`),
  ADD KEY `fk_jc_address_country` (`country_id`),
  ADD KEY `fk_jc_address_member` (`member_id`);

--
-- Indexes for table `jc_shop_member_coupon`
--
ALTER TABLE `jc_shop_member_coupon`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_member_favorite`
--
ALTER TABLE `jc_shop_member_favorite`
  ADD PRIMARY KEY (`product_id`,`member_id`),
  ADD KEY `fk_jc_shop_favorite_member` (`member_id`),
  ADD KEY `fk_jc_shop_favorite_product` (`product_id`);

--
-- Indexes for table `jc_shop_member_group`
--
ALTER TABLE `jc_shop_member_group`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `fk_jc_shop_mgroup_website` (`website_id`);

--
-- Indexes for table `jc_shop_money`
--
ALTER TABLE `jc_shop_money`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_jc_shop_money_member` (`member_id`);

--
-- Indexes for table `jc_shop_order`
--
ALTER TABLE `jc_shop_order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_jc_shop_order_member` (`member_id`),
  ADD KEY `fk_jc_shop_order_payment` (`payment_id`),
  ADD KEY `fk_jc_shop_order_website` (`website_id`),
  ADD KEY `fk_jc_shop_order_shipping` (`shipping_id`),
  ADD KEY `code` (`code`);

--
-- Indexes for table `jc_shop_order_gathering`
--
ALTER TABLE `jc_shop_order_gathering`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_order_item`
--
ALTER TABLE `jc_shop_order_item`
  ADD PRIMARY KEY (`orderitem_id`),
  ADD KEY `fk_jc_shop_item_order` (`order_id`),
  ADD KEY `fk_jc_shop_orderitem_website` (`website_id`),
  ADD KEY `fk_jc_shop_orderitem_product` (`product_id`),
  ADD KEY `fk_jc_shop_orderitem_productFash` (`productFash_id`);

--
-- Indexes for table `jc_shop_order_return`
--
ALTER TABLE `jc_shop_order_return`
  ADD PRIMARY KEY (`return_id`),
  ADD KEY `fk_jc_shop_order_return` (`order_id`),
  ADD KEY `fk_jc_shop_reason_return` (`reason_id`),
  ADD KEY `fk_jc_shop_paytype_return` (`payType`);

--
-- Indexes for table `jc_shop_order_return_picture`
--
ALTER TABLE `jc_shop_order_return_picture`
  ADD PRIMARY KEY (`return_id`,`priority`),
  ADD KEY `fk_jc_shop_order_return_picture` (`return_id`);

--
-- Indexes for table `jc_shop_order_shipments`
--
ALTER TABLE `jc_shop_order_shipments`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_pay`
--
ALTER TABLE `jc_shop_pay`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_payment`
--
ALTER TABLE `jc_shop_payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_jc_shop_payment_website` (`website_id`);

--
-- Indexes for table `jc_shop_payment_plugins`
--
ALTER TABLE `jc_shop_payment_plugins`
  ADD PRIMARY KEY (`plugins_id`);

--
-- Indexes for table `jc_shop_payment_shipping`
--
ALTER TABLE `jc_shop_payment_shipping`
  ADD PRIMARY KEY (`payment_id`,`shipping_id`);

--
-- Indexes for table `jc_shop_poster`
--
ALTER TABLE `jc_shop_poster`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `jc_shop_product`
--
ALTER TABLE `jc_shop_product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_jc_shop_product_brand` (`brand_id`),
  ADD KEY `fk_jc_shop_product_category` (`category_id`),
  ADD KEY `fk_jc_shop_product_config` (`config_id`),
  ADD KEY `fk_jc_shop_product_ptype` (`ptype_id`),
  ADD KEY `fk_jc_shop_product_website` (`website_id`);

--
-- Indexes for table `jc_shop_product_attr`
--
ALTER TABLE `jc_shop_product_attr`
  ADD KEY `fK_jc_shop_product_attr` (`product_id`);

--
-- Indexes for table `jc_shop_product_exended`
--
ALTER TABLE `jc_shop_product_exended`
  ADD KEY `fk_jc_shop_product_exended` (`product_id`);

--
-- Indexes for table `jc_shop_product_ext`
--
ALTER TABLE `jc_shop_product_ext`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `jc_shop_product_fashion`
--
ALTER TABLE `jc_shop_product_fashion`
  ADD PRIMARY KEY (`fashion_id`),
  ADD KEY `fk_fashion_product` (`product_id`);

--
-- Indexes for table `jc_shop_product_favorable`
--
ALTER TABLE `jc_shop_product_favorable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jc_shop_product_keyword`
--
ALTER TABLE `jc_shop_product_keyword`
  ADD KEY `fk_jc_shop_keyword_product` (`product_id`);

--
-- Indexes for table `jc_shop_product_picture`
--
ALTER TABLE `jc_shop_product_picture`
  ADD PRIMARY KEY (`product_id`,`priority`);

--
-- Indexes for table `jc_shop_product_standard`
--
ALTER TABLE `jc_shop_product_standard`
  ADD PRIMARY KEY (`ps_id`),
  ADD KEY `fk_jc_shop_product_color` (`product_id`);

--
-- Indexes for table `jc_shop_product_tag`
--
ALTER TABLE `jc_shop_product_tag`
  ADD PRIMARY KEY (`stag_id`,`product_id`),
  ADD KEY `fk_jc_shop_tag_product` (`product_id`);

--
-- Indexes for table `jc_shop_product_text`
--
ALTER TABLE `jc_shop_product_text`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `jc_shop_ptype`
--
ALTER TABLE `jc_shop_ptype`
  ADD PRIMARY KEY (`ptype_id`),
  ADD KEY `fk_jc_shop_ptype_website` (`website_id`);

--
-- Indexes for table `jc_shop_ptype_exended`
--
ALTER TABLE `jc_shop_ptype_exended`
  ADD PRIMARY KEY (`exended_id`,`ptype_id`),
  ADD KEY `fk_jc_shop_ptype_exended` (`ptype_id`),
  ADD KEY `fk_jc_shop_exended_ptype` (`exended_id`);

--
-- Indexes for table `jc_shop_ptype_property`
--
ALTER TABLE `jc_shop_ptype_property`
  ADD PRIMARY KEY (`type_property_id`),
  ADD KEY `fk_type_property` (`ptype_id`);

--
-- Indexes for table `jc_shop_score`
--
ALTER TABLE `jc_shop_score`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_jc_shop_score_member` (`member_id`);

--
-- Indexes for table `jc_shop_shipping`
--
ALTER TABLE `jc_shop_shipping`
  ADD PRIMARY KEY (`shipping_id`),
  ADD KEY `fk_jc_shop_shipping_website` (`website_id`);

--
-- Indexes for table `jc_shop_tag`
--
ALTER TABLE `jc_shop_tag`
  ADD PRIMARY KEY (`stag_id`),
  ADD KEY `fk_jc_shop_tag_website` (`website_id`);

--
-- Indexes for table `jc_shop_weixin`
--
ALTER TABLE `jc_shop_weixin`
  ADD PRIMARY KEY (`weixin_id`);

--
-- Indexes for table `jc_shop_weixinmenu`
--
ALTER TABLE `jc_shop_weixinmenu`
  ADD PRIMARY KEY (`weixinmenu_id`);

--
-- Indexes for table `jc_standard`
--
ALTER TABLE `jc_standard`
  ADD PRIMARY KEY (`standard_id`),
  ADD KEY `fc_jc_standard_type` (`type_id`);

--
-- Indexes for table `jc_standard_type`
--
ALTER TABLE `jc_standard_type`
  ADD PRIMARY KEY (`standardtype_id`);

--
-- Indexes for table `n_bank_pay_info`
--
ALTER TABLE `n_bank_pay_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `n_lottery_ticket_item`
--
ALTER TABLE `n_lottery_ticket_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `order_id_2` (`order_id`);

--
-- Indexes for table `n_lottery_ticket_order`
--
ALTER TABLE `n_lottery_ticket_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `n_member_addr`
--
ALTER TABLE `n_member_addr`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `n_member_user`
--
ALTER TABLE `n_member_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `n_order_pay_refund`
--
ALTER TABLE `n_order_pay_refund`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id_pk` (`order_id`);

--
-- Indexes for table `sms_log`
--
ALTER TABLE `sms_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_channel`
--
ALTER TABLE `t_channel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `T_CHANNEL_NAME_INDEX` (`CHANNEL_NAME`),
  ADD KEY `FK_FK_T_CHANNEL_CHANNEL_PARENT_T_CHANNEL_ID` (`CHANNEL_PARENT`),
  ADD KEY `fk_bank_pay_info` (`bank_pay_info_id`),
  ADD KEY `ID` (`id`);

--
-- Indexes for table `t_commerce`
--
ALTER TABLE `t_commerce`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `T_COMMERCE_NAME_INDEX` (`NAME`),
  ADD KEY `AK_UK_T_COMMERCE_NAME` (`NAME`),
  ADD KEY `FK_FK_T_COMMERCE_CHANNEL_ID_T_CHANNEL_ID` (`CHANNEL_ID`);

--
-- Indexes for table `t_n_voucher`
--
ALTER TABLE `t_n_voucher`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `VOUCHER_CODE` (`VOUCHER_CODE`),
  ADD KEY `order_code` (`ORDER_ID`);

--
-- Indexes for table `t_order`
--
ALTER TABLE `t_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_pub_area`
--
ALTER TABLE `t_pub_area`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Fk_area_parent` (`PARENT_AREA_ID`);

--
-- Indexes for table `t_sequence`
--
ALTER TABLE `t_sequence`
  ADD PRIMARY KEY (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jc_address`
--
ALTER TABLE `jc_address`
  MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `jc_core_admin`
--
ALTER TABLE `jc_core_admin`
  MODIFY `admin_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_core_log`
--
ALTER TABLE `jc_core_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `jc_core_member`
--
ALTER TABLE `jc_core_member`
  MODIFY `member_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `jc_core_role`
--
ALTER TABLE `jc_core_role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `jc_core_user`
--
ALTER TABLE `jc_core_user`
  MODIFY `user_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_core_website`
--
ALTER TABLE `jc_core_website`
  MODIFY `website_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_data_backup`
--
ALTER TABLE `jc_data_backup`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_online_customerservice`
--
ALTER TABLE `jc_online_customerservice`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `jc_popularity_group`
--
ALTER TABLE `jc_popularity_group`
  MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `jc_popularity_item`
--
ALTER TABLE `jc_popularity_item`
  MODIFY `popularityitem_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_advertise`
--
ALTER TABLE `jc_shop_advertise`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_shop_advertise_space`
--
ALTER TABLE `jc_shop_advertise_space`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_shop_article`
--
ALTER TABLE `jc_shop_article`
  MODIFY `article_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `jc_shop_brand`
--
ALTER TABLE `jc_shop_brand`
  MODIFY `brand_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `jc_shop_cardgift`
--
ALTER TABLE `jc_shop_cardgift`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_cart_item`
--
ALTER TABLE `jc_shop_cart_item`
  MODIFY `cartitem_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_shop_category`
--
ALTER TABLE `jc_shop_category`
  MODIFY `category_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `jc_shop_category_property`
--
ALTER TABLE `jc_shop_category_property`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_channel`
--
ALTER TABLE `jc_shop_channel`
  MODIFY `channel_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `jc_shop_collect`
--
ALTER TABLE `jc_shop_collect`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `jc_shop_consult`
--
ALTER TABLE `jc_shop_consult`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_coupon`
--
ALTER TABLE `jc_shop_coupon`
  MODIFY `Id` bigint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_shop_dictionary`
--
ALTER TABLE `jc_shop_dictionary`
  MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `jc_shop_dictionary_type`
--
ALTER TABLE `jc_shop_dictionary_type`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `jc_shop_discuss`
--
ALTER TABLE `jc_shop_discuss`
  MODIFY `Id` bigint(22) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_exended`
--
ALTER TABLE `jc_shop_exended`
  MODIFY `exended_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `jc_shop_exended_item`
--
ALTER TABLE `jc_shop_exended_item`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `jc_shop_fashion_standard`
--
ALTER TABLE `jc_shop_fashion_standard`
  MODIFY `fashion_id` bigint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT for table `jc_shop_favorable`
--
ALTER TABLE `jc_shop_favorable`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `jc_shop_gift`
--
ALTER TABLE `jc_shop_gift`
  MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `jc_shop_gift_exchange`
--
ALTER TABLE `jc_shop_gift_exchange`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_keyword_q`
--
ALTER TABLE `jc_shop_keyword_q`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_logistics`
--
ALTER TABLE `jc_shop_logistics`
  MODIFY `logistics_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `jc_shop_member_address`
--
ALTER TABLE `jc_shop_member_address`
  MODIFY `address_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_member_coupon`
--
ALTER TABLE `jc_shop_member_coupon`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_shop_member_group`
--
ALTER TABLE `jc_shop_member_group`
  MODIFY `group_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `jc_shop_money`
--
ALTER TABLE `jc_shop_money`
  MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_order`
--
ALTER TABLE `jc_shop_order`
  MODIFY `order_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_order_gathering`
--
ALTER TABLE `jc_shop_order_gathering`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_order_item`
--
ALTER TABLE `jc_shop_order_item`
  MODIFY `orderitem_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_order_return`
--
ALTER TABLE `jc_shop_order_return`
  MODIFY `return_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_order_shipments`
--
ALTER TABLE `jc_shop_order_shipments`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_pay`
--
ALTER TABLE `jc_shop_pay`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_shop_payment`
--
ALTER TABLE `jc_shop_payment`
  MODIFY `payment_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `jc_shop_payment_plugins`
--
ALTER TABLE `jc_shop_payment_plugins`
  MODIFY `plugins_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `jc_shop_payment_shipping`
--
ALTER TABLE `jc_shop_payment_shipping`
  MODIFY `payment_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `jc_shop_poster`
--
ALTER TABLE `jc_shop_poster`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `jc_shop_product`
--
ALTER TABLE `jc_shop_product`
  MODIFY `product_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `jc_shop_product_fashion`
--
ALTER TABLE `jc_shop_product_fashion`
  MODIFY `fashion_id` bigint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT for table `jc_shop_product_favorable`
--
ALTER TABLE `jc_shop_product_favorable`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_product_standard`
--
ALTER TABLE `jc_shop_product_standard`
  MODIFY `ps_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=236;
--
-- AUTO_INCREMENT for table `jc_shop_ptype`
--
ALTER TABLE `jc_shop_ptype`
  MODIFY `ptype_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `jc_shop_ptype_property`
--
ALTER TABLE `jc_shop_ptype_property`
  MODIFY `type_property_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=950;
--
-- AUTO_INCREMENT for table `jc_shop_score`
--
ALTER TABLE `jc_shop_score`
  MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jc_shop_shipping`
--
ALTER TABLE `jc_shop_shipping`
  MODIFY `shipping_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `jc_shop_tag`
--
ALTER TABLE `jc_shop_tag`
  MODIFY `stag_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `jc_shop_weixin`
--
ALTER TABLE `jc_shop_weixin`
  MODIFY `weixin_id` bigint(1) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `jc_shop_weixinmenu`
--
ALTER TABLE `jc_shop_weixinmenu`
  MODIFY `weixinmenu_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `jc_standard`
--
ALTER TABLE `jc_standard`
  MODIFY `standard_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `jc_standard_type`
--
ALTER TABLE `jc_standard_type`
  MODIFY `standardtype_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `n_member_addr`
--
ALTER TABLE `n_member_addr`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sms_log`
--
ALTER TABLE `sms_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `t_channel`
--
ALTER TABLE `t_channel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `t_commerce`
--
ALTER TABLE `t_commerce`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `t_order`
--
ALTER TABLE `t_order`
  MODIFY `id` int(36) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `jc_address`
--
ALTER TABLE `jc_address`
  ADD CONSTRAINT `fk_jc_address_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_address` (`Id`);

--
-- Constraints for table `jc_core_admin`
--
ALTER TABLE `jc_core_admin`
  ADD CONSTRAINT `fk_jc_admin_user` FOREIGN KEY (`user_id`) REFERENCES `jc_core_user` (`user_id`),
  ADD CONSTRAINT `fk_jc_admin_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_core_admin_role`
--
ALTER TABLE `jc_core_admin_role`
  ADD CONSTRAINT `fk_jc_core_admin_role` FOREIGN KEY (`admin_id`) REFERENCES `jc_core_admin` (`admin_id`),
  ADD CONSTRAINT `fk_jc_core_role_admin` FOREIGN KEY (`role_id`) REFERENCES `jc_core_role` (`role_id`);

--
-- Constraints for table `jc_core_log`
--
ALTER TABLE `jc_core_log`
  ADD CONSTRAINT `fk_jc_log_site` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`),
  ADD CONSTRAINT `fk_jc_log_user` FOREIGN KEY (`user_id`) REFERENCES `jc_core_user` (`user_id`);

--
-- Constraints for table `jc_core_member`
--
ALTER TABLE `jc_core_member`
  ADD CONSTRAINT `fk_jc_member_user` FOREIGN KEY (`user_id`) REFERENCES `jc_core_user` (`user_id`),
  ADD CONSTRAINT `fk_jc_member_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_core_message_tpl`
--
ALTER TABLE `jc_core_message_tpl`
  ADD CONSTRAINT `fk_jc_msgtpl_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_core_role_permission`
--
ALTER TABLE `jc_core_role_permission`
  ADD CONSTRAINT `fk_jc_core_permission_role` FOREIGN KEY (`role_id`) REFERENCES `jc_core_role` (`role_id`);

--
-- Constraints for table `jc_core_website`
--
ALTER TABLE `jc_core_website`
  ADD CONSTRAINT `fk_jc_website_admin` FOREIGN KEY (`admin_id`) REFERENCES `jc_core_admin` (`admin_id`),
  ADD CONSTRAINT `fk_jc_website_global` FOREIGN KEY (`global_id`) REFERENCES `jc_core_global` (`global_id`),
  ADD CONSTRAINT `fk_jc_website_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_popularity_group_product`
--
ALTER TABLE `jc_popularity_group_product`
  ADD CONSTRAINT `fk_jc_popularity_product_group` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`),
  ADD CONSTRAINT `jc_popularity_group_product` FOREIGN KEY (`Id`) REFERENCES `jc_popularity_group` (`Id`);

--
-- Constraints for table `jc_popularity_item`
--
ALTER TABLE `jc_popularity_item`
  ADD CONSTRAINT `fk_jc_shop_popularityitem_cart` FOREIGN KEY (`cart_id`) REFERENCES `jc_shop_cart` (`cart_id`);

--
-- Constraints for table `jc_shop_admin`
--
ALTER TABLE `jc_shop_admin`
  ADD CONSTRAINT `fk_jc_shop_admin_core` FOREIGN KEY (`admin_id`) REFERENCES `jc_core_admin` (`admin_id`),
  ADD CONSTRAINT `fk_jc_shop_admin_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_advertise`
--
ALTER TABLE `jc_shop_advertise`
  ADD CONSTRAINT `jc_shop_adspace_fk` FOREIGN KEY (`adspace_id`) REFERENCES `jc_shop_advertise_space` (`Id`);

--
-- Constraints for table `jc_shop_advertise_attr`
--
ALTER TABLE `jc_shop_advertise_attr`
  ADD CONSTRAINT `jc_shop_advertise_fk` FOREIGN KEY (`Id`) REFERENCES `jc_shop_advertise` (`Id`);

--
-- Constraints for table `jc_shop_article`
--
ALTER TABLE `jc_shop_article`
  ADD CONSTRAINT `fk_jc_shop_article_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_shop_channel` (`channel_id`),
  ADD CONSTRAINT `fk_jc_shop_article_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_article_content`
--
ALTER TABLE `jc_shop_article_content`
  ADD CONSTRAINT `fk_jc_shop_content_article` FOREIGN KEY (`article_id`) REFERENCES `jc_shop_article` (`article_id`);

--
-- Constraints for table `jc_shop_brand`
--
ALTER TABLE `jc_shop_brand`
  ADD CONSTRAINT `fk_jc_shop_brand_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_brand_text`
--
ALTER TABLE `jc_shop_brand_text`
  ADD CONSTRAINT `fk_jc_shop_text_brand` FOREIGN KEY (`brand_id`) REFERENCES `jc_shop_brand` (`brand_id`);

--
-- Constraints for table `jc_shop_cardgift`
--
ALTER TABLE `jc_shop_cardgift`
  ADD CONSTRAINT `fk_jc_cardgift_cart` FOREIGN KEY (`cartId`) REFERENCES `jc_shop_cart` (`cart_id`),
  ADD CONSTRAINT `fk_jc_cardgift_gift` FOREIGN KEY (`giftId`) REFERENCES `jc_shop_gift` (`Id`),
  ADD CONSTRAINT `fk_jc_cardgift_website` FOREIGN KEY (`websiteId`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_cart`
--
ALTER TABLE `jc_shop_cart`
  ADD CONSTRAINT `fk_jc_shop_cart_member` FOREIGN KEY (`cart_id`) REFERENCES `jc_shop_member` (`member_id`),
  ADD CONSTRAINT `fk_jc_shop_cart_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_cart_item`
--
ALTER TABLE `jc_shop_cart_item`
  ADD CONSTRAINT `fk_jc_shop_cartitem_cart` FOREIGN KEY (`cart_id`) REFERENCES `jc_shop_cart` (`cart_id`),
  ADD CONSTRAINT `fk_jc_shop_cartitem_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`),
  ADD CONSTRAINT `fk_jc_shop_cartitem_productFash` FOREIGN KEY (`productFash_id`) REFERENCES `jc_shop_product_fashion` (`fashion_id`),
  ADD CONSTRAINT `fk_jc_shop_cartitem_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_category`
--
ALTER TABLE `jc_shop_category`
  ADD CONSTRAINT `fk_jc_shop_category_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_shop_category` (`category_id`),
  ADD CONSTRAINT `fk_jc_shop_category_ptype` FOREIGN KEY (`ptype_id`) REFERENCES `jc_shop_ptype` (`ptype_id`),
  ADD CONSTRAINT `fk_jc_shop_cateory_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_category_attr`
--
ALTER TABLE `jc_shop_category_attr`
  ADD CONSTRAINT `fK_jc_shop_category_attr` FOREIGN KEY (`category_id`) REFERENCES `jc_shop_category` (`category_id`);

--
-- Constraints for table `jc_shop_category_brand`
--
ALTER TABLE `jc_shop_category_brand`
  ADD CONSTRAINT `fk_jc_shop_brand_category` FOREIGN KEY (`brand_id`) REFERENCES `jc_shop_brand` (`brand_id`),
  ADD CONSTRAINT `fk_jc_shop_category_brand` FOREIGN KEY (`category_id`) REFERENCES `jc_shop_category` (`category_id`);

--
-- Constraints for table `jc_shop_category_property`
--
ALTER TABLE `jc_shop_category_property`
  ADD CONSTRAINT `fk_jc_shop_category_property` FOREIGN KEY (`category_id`) REFERENCES `jc_shop_category` (`category_id`);

--
-- Constraints for table `jc_shop_category_sdtype`
--
ALTER TABLE `jc_shop_category_sdtype`
  ADD CONSTRAINT `fk_jc_shop_category_sdtype` FOREIGN KEY (`category_id`) REFERENCES `jc_shop_category` (`category_id`),
  ADD CONSTRAINT `fk_jc_shop_sdtype_category` FOREIGN KEY (`standardtype_id`) REFERENCES `jc_standard_type` (`standardtype_id`);

--
-- Constraints for table `jc_shop_channel`
--
ALTER TABLE `jc_shop_channel`
  ADD CONSTRAINT `fk_jc_shop_channel_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_shop_channel` (`channel_id`),
  ADD CONSTRAINT `fk_jc_shop_channel_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_channel_content`
--
ALTER TABLE `jc_shop_channel_content`
  ADD CONSTRAINT `fk_jc_shop_content_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_shop_channel` (`channel_id`);

--
-- Constraints for table `jc_shop_collect`
--
ALTER TABLE `jc_shop_collect`
  ADD CONSTRAINT `fk_jc_shop_collect_fashion` FOREIGN KEY (`fashion_id`) REFERENCES `jc_shop_product_fashion` (`fashion_id`),
  ADD CONSTRAINT `fk_jc_shop_collect_member` FOREIGN KEY (`member_id`) REFERENCES `jc_shop_member` (`member_id`),
  ADD CONSTRAINT `fk_jc_shop_collect_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_config`
--
ALTER TABLE `jc_shop_config`
  ADD CONSTRAINT `fk_jc_shop_config_group` FOREIGN KEY (`register_group_id`) REFERENCES `jc_shop_member_group` (`group_id`),
  ADD CONSTRAINT `fk_jc_shop_config_website` FOREIGN KEY (`config_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_consult`
--
ALTER TABLE `jc_shop_consult`
  ADD CONSTRAINT `fk_member_consult` FOREIGN KEY (`member_id`) REFERENCES `jc_shop_member` (`member_id`),
  ADD CONSTRAINT `fk_product_consult` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_coupon`
--
ALTER TABLE `jc_shop_coupon`
  ADD CONSTRAINT `jc_shop_coupon_ibfk_2` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_dictionary`
--
ALTER TABLE `jc_shop_dictionary`
  ADD CONSTRAINT `fk_jc_dictionary_type` FOREIGN KEY (`type_id`) REFERENCES `jc_shop_dictionary_type` (`Id`);

--
-- Constraints for table `jc_shop_discuss`
--
ALTER TABLE `jc_shop_discuss`
  ADD CONSTRAINT `fk_jc_disucss_member` FOREIGN KEY (`member_id`) REFERENCES `jc_shop_member` (`member_id`),
  ADD CONSTRAINT `fk_jc_disucss_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_fashion_standard`
--
ALTER TABLE `jc_shop_fashion_standard`
  ADD CONSTRAINT `fk_jc_shop_fashion_standard` FOREIGN KEY (`fashion_id`) REFERENCES `jc_shop_product_fashion` (`fashion_id`),
  ADD CONSTRAINT `fk_jc_shop_standard_fashion` FOREIGN KEY (`standard_id`) REFERENCES `jc_standard` (`standard_id`);

--
-- Constraints for table `jc_shop_gift_exchange`
--
ALTER TABLE `jc_shop_gift_exchange`
  ADD CONSTRAINT `fk_jc_shop_exchange_gift` FOREIGN KEY (`gift_id`) REFERENCES `jc_shop_gift` (`Id`),
  ADD CONSTRAINT `fk_jc_shop_exchange_member` FOREIGN KEY (`member_id`) REFERENCES `jc_shop_member` (`member_id`);

--
-- Constraints for table `jc_shop_member`
--
ALTER TABLE `jc_shop_member`
  ADD CONSTRAINT `fk_jc_shop_dictionary_familymembers` FOREIGN KEY (`familymembers_id`) REFERENCES `jc_shop_dictionary` (`Id`),
  ADD CONSTRAINT `fk_jc_shop_dictionary_incomedesc` FOREIGN KEY (`incomedesc_id`) REFERENCES `jc_shop_dictionary` (`Id`),
  ADD CONSTRAINT `fk_jc_shop_dictionary_userdegree` FOREIGN KEY (`userdegree_id`) REFERENCES `jc_shop_dictionary` (`Id`),
  ADD CONSTRAINT `fk_jc_shop_dictionary_workseniority` FOREIGN KEY (`workseniority_id`) REFERENCES `jc_shop_dictionary` (`Id`),
  ADD CONSTRAINT `fk_jc_shop_member_mgroup` FOREIGN KEY (`group_id`) REFERENCES `jc_shop_member_group` (`group_id`),
  ADD CONSTRAINT `fk_jc_shop_member_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_member_address`
--
ALTER TABLE `jc_shop_member_address`
  ADD CONSTRAINT `fk_jc_address_city` FOREIGN KEY (`city_id`) REFERENCES `jc_address` (`Id`),
  ADD CONSTRAINT `fk_jc_address_country` FOREIGN KEY (`country_id`) REFERENCES `jc_address` (`Id`),
  ADD CONSTRAINT `fk_jc_address_member` FOREIGN KEY (`member_id`) REFERENCES `jc_shop_member` (`member_id`),
  ADD CONSTRAINT `fk_jc_address_province` FOREIGN KEY (`province_id`) REFERENCES `jc_address` (`Id`);

--
-- Constraints for table `jc_shop_member_favorite`
--
ALTER TABLE `jc_shop_member_favorite`
  ADD CONSTRAINT `fk_jc_shop_favorite_member` FOREIGN KEY (`member_id`) REFERENCES `jc_shop_member` (`member_id`),
  ADD CONSTRAINT `fk_jc_shop_favorite_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_member_group`
--
ALTER TABLE `jc_shop_member_group`
  ADD CONSTRAINT `fk_jc_shop_mgroup_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_money`
--
ALTER TABLE `jc_shop_money`
  ADD CONSTRAINT `fk_jc_shop_money_member` FOREIGN KEY (`member_id`) REFERENCES `jc_shop_member` (`member_id`);

--
-- Constraints for table `jc_shop_order`
--
ALTER TABLE `jc_shop_order`
  ADD CONSTRAINT `fk_jc_shop_order_member` FOREIGN KEY (`member_id`) REFERENCES `jc_shop_member` (`member_id`),
  ADD CONSTRAINT `fk_jc_shop_order_payment` FOREIGN KEY (`payment_id`) REFERENCES `jc_shop_payment` (`payment_id`),
  ADD CONSTRAINT `fk_jc_shop_order_shipping` FOREIGN KEY (`shipping_id`) REFERENCES `jc_shop_shipping` (`shipping_id`),
  ADD CONSTRAINT `fk_jc_shop_order_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_order_item`
--
ALTER TABLE `jc_shop_order_item`
  ADD CONSTRAINT `fk_jc_shop_item_order` FOREIGN KEY (`order_id`) REFERENCES `jc_shop_order` (`order_id`),
  ADD CONSTRAINT `fk_jc_shop_orderitem_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`),
  ADD CONSTRAINT `fk_jc_shop_orderitem_productFash` FOREIGN KEY (`productFash_id`) REFERENCES `jc_shop_product_fashion` (`fashion_id`),
  ADD CONSTRAINT `fk_jc_shop_orderitem_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_order_return_picture`
--
ALTER TABLE `jc_shop_order_return_picture`
  ADD CONSTRAINT `fk_jc_shop_order_return_picture` FOREIGN KEY (`return_id`) REFERENCES `jc_shop_order_return` (`return_id`);

--
-- Constraints for table `jc_shop_payment`
--
ALTER TABLE `jc_shop_payment`
  ADD CONSTRAINT `fk_jc_shop_payment_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_product`
--
ALTER TABLE `jc_shop_product`
  ADD CONSTRAINT `fk_jc_shop_product_brand` FOREIGN KEY (`brand_id`) REFERENCES `jc_shop_brand` (`brand_id`),
  ADD CONSTRAINT `fk_jc_shop_product_category` FOREIGN KEY (`category_id`) REFERENCES `jc_shop_category` (`category_id`),
  ADD CONSTRAINT `fk_jc_shop_product_config` FOREIGN KEY (`config_id`) REFERENCES `jc_shop_config` (`config_id`),
  ADD CONSTRAINT `fk_jc_shop_product_ptype` FOREIGN KEY (`ptype_id`) REFERENCES `jc_shop_ptype` (`ptype_id`),
  ADD CONSTRAINT `fk_jc_shop_product_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_product_attr`
--
ALTER TABLE `jc_shop_product_attr`
  ADD CONSTRAINT `fk_jc_shop_product_attr` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_product_ext`
--
ALTER TABLE `jc_shop_product_ext`
  ADD CONSTRAINT `fk_jc_shop_ext_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_product_fashion`
--
ALTER TABLE `jc_shop_product_fashion`
  ADD CONSTRAINT `fk_fashion_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_product_keyword`
--
ALTER TABLE `jc_shop_product_keyword`
  ADD CONSTRAINT `fk_jc_shop_keyword_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_product_standard`
--
ALTER TABLE `jc_shop_product_standard`
  ADD CONSTRAINT `fk_jc_shop_product_standard` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_product_tag`
--
ALTER TABLE `jc_shop_product_tag`
  ADD CONSTRAINT `fk_jc_shop_product_tag` FOREIGN KEY (`stag_id`) REFERENCES `jc_shop_tag` (`stag_id`),
  ADD CONSTRAINT `fk_jc_shop_tag_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_product_text`
--
ALTER TABLE `jc_shop_product_text`
  ADD CONSTRAINT `fk_jc_shop_text_product` FOREIGN KEY (`product_id`) REFERENCES `jc_shop_product` (`product_id`);

--
-- Constraints for table `jc_shop_ptype`
--
ALTER TABLE `jc_shop_ptype`
  ADD CONSTRAINT `fk_jc_shop_ptype_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_ptype_property`
--
ALTER TABLE `jc_shop_ptype_property`
  ADD CONSTRAINT `fk_type_property` FOREIGN KEY (`ptype_id`) REFERENCES `jc_shop_ptype` (`ptype_id`);

--
-- Constraints for table `jc_shop_score`
--
ALTER TABLE `jc_shop_score`
  ADD CONSTRAINT `fk_jc_shop_score_member` FOREIGN KEY (`member_id`) REFERENCES `jc_shop_member` (`member_id`);

--
-- Constraints for table `jc_shop_shipping`
--
ALTER TABLE `jc_shop_shipping`
  ADD CONSTRAINT `fk_jc_shop_shipping_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_shop_tag`
--
ALTER TABLE `jc_shop_tag`
  ADD CONSTRAINT `fk_jc_shop_tag_website` FOREIGN KEY (`website_id`) REFERENCES `jc_core_website` (`website_id`);

--
-- Constraints for table `jc_standard`
--
ALTER TABLE `jc_standard`
  ADD CONSTRAINT `fc_jc_standard_type` FOREIGN KEY (`type_id`) REFERENCES `jc_standard_type` (`standardtype_id`);

--
-- Constraints for table `n_lottery_ticket_item`
--
ALTER TABLE `n_lottery_ticket_item`
  ADD CONSTRAINT `n_lottery_ticket_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `n_lottery_ticket_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `n_order_pay_refund`
--
ALTER TABLE `n_order_pay_refund`
  ADD CONSTRAINT `order_id_pk` FOREIGN KEY (`order_id`) REFERENCES `jc_shop_order` (`code`);

--
-- Constraints for table `t_channel`
--
ALTER TABLE `t_channel`
  ADD CONSTRAINT `fk_bank_pay_info` FOREIGN KEY (`bank_pay_info_id`) REFERENCES `n_bank_pay_info` (`id`);

--
-- Constraints for table `t_n_voucher`
--
ALTER TABLE `t_n_voucher`
  ADD CONSTRAINT `order_code` FOREIGN KEY (`ORDER_ID`) REFERENCES `jc_shop_order` (`code`);

set foreign_key_checks=1;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
