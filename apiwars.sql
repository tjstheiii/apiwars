/*
SQLyog Community v11.32 (32 bit)
MySQL - 5.6.17-log : Database - apiwars
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`apiwars` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `apiwars`;

/*Table structure for table `Accounts` */

DROP TABLE IF EXISTS `Accounts`;

CREATE TABLE `Accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_address` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `currency_gold` int(10) unsigned NOT NULL,
  `currency_energy` int(10) unsigned NOT NULL,
  `currency_actionpts` int(10) unsigned NOT NULL,
  `currency_gems` int(10) unsigned NOT NULL,
  `stats_apicalls` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Accounts` */

/*Table structure for table `Characters` */

DROP TABLE IF EXISTS `Characters`;

CREATE TABLE `Characters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accountid` int(10) unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  `typeid` int(10) unsigned NOT NULL,
  `tier` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `experience_max` int(10) unsigned NOT NULL,
  `experience` int(10) unsigned NOT NULL,
  `stats_hp_max` int(10) unsigned NOT NULL,
  `stats_hp` int(10) unsigned NOT NULL,
  `stats_atk` int(10) unsigned NOT NULL,
  `stats_def` int(10) unsigned NOT NULL,
  `stats_crit` int(11) unsigned NOT NULL,
  `equip_head` int(11) unsigned DEFAULT NULL,
  `equip_chest` int(11) unsigned DEFAULT NULL,
  `equip_boots` int(11) unsigned DEFAULT NULL,
  `equip_weap` int(11) unsigned DEFAULT NULL,
  `equip_belt` int(11) unsigned DEFAULT NULL,
  `equip_accessory` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `char_to_account` (`accountid`),
  KEY `char_to_type` (`typeid`),
  KEY `char_to_equip_head` (`equip_head`),
  KEY `char_to_equip_chest` (`equip_chest`),
  KEY `char_to_equip_boots` (`equip_boots`),
  KEY `char_to_equip_weap` (`equip_weap`),
  KEY `char_to_equip_belt` (`equip_belt`),
  KEY `char_to_equip_accessory` (`equip_accessory`),
  CONSTRAINT `char_to_account` FOREIGN KEY (`accountid`) REFERENCES `Accounts` (`id`),
  CONSTRAINT `char_to_type` FOREIGN KEY (`typeid`) REFERENCES `Characters_Type_DM` (`typeid`),
  CONSTRAINT `char_to_equip_head` FOREIGN KEY (`equip_head`) REFERENCES `Equipment` (`id`),
  CONSTRAINT `char_to_equip_chest` FOREIGN KEY (`equip_chest`) REFERENCES `Equipment` (`id`),
  CONSTRAINT `char_to_equip_boots` FOREIGN KEY (`equip_boots`) REFERENCES `Equipment` (`id`),
  CONSTRAINT `char_to_equip_weap` FOREIGN KEY (`equip_weap`) REFERENCES `Equipment` (`id`),
  CONSTRAINT `char_to_equip_belt` FOREIGN KEY (`equip_belt`) REFERENCES `Equipment` (`id`),
  CONSTRAINT `char_to_equip_accessory` FOREIGN KEY (`equip_accessory`) REFERENCES `Equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Characters` */

/*Table structure for table `Characters_Type_DM` */

DROP TABLE IF EXISTS `Characters_Type_DM`;

CREATE TABLE `Characters_Type_DM` (
  `typeid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Characters_Type_DM` */

/*Table structure for table `Enemies` */

DROP TABLE IF EXISTS `Enemies`;

CREATE TABLE `Enemies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accountid` int(10) unsigned NOT NULL,
  `typeid` int(10) unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  `tier` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `stats_hp_max` int(10) unsigned NOT NULL,
  `stats_hp` int(10) unsigned NOT NULL,
  `stats_atk` int(10) unsigned NOT NULL,
  `stats_def` int(10) unsigned NOT NULL,
  `stats_crit` int(10) unsigned NOT NULL,
  `stats_armor` int(10) unsigned NOT NULL,
  `closes` timestamp NOT NULL,
  `statusid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enemies_to_account` (`accountid`),
  KEY `enemies_to_type` (`typeid`),
  KEY `enemies_to_status` (`statusid`),
  CONSTRAINT `enemies_to_account` FOREIGN KEY (`accountid`) REFERENCES `Accounts` (`id`),
  CONSTRAINT `enemies_to_type` FOREIGN KEY (`typeid`) REFERENCES `Enemies_Type_DM` (`typeid`),
  CONSTRAINT `enemies_to_status` FOREIGN KEY (`statusid`) REFERENCES `Enemies_Status_DM` (`statusid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Enemies` */

/*Table structure for table `Enemies_Status_DM` */

DROP TABLE IF EXISTS `Enemies_Status_DM`;

CREATE TABLE `Enemies_Status_DM` (
  `statusid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`statusid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Enemies_Status_DM` */

/*Table structure for table `Enemies_Type_DM` */

DROP TABLE IF EXISTS `Enemies_Type_DM`;

CREATE TABLE `Enemies_Type_DM` (
  `typeid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Enemies_Type_DM` */

/*Table structure for table `Equipment` */

DROP TABLE IF EXISTS `Equipment`;

CREATE TABLE `Equipment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accountid` int(10) unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  `typeid` int(10) unsigned NOT NULL,
  `tier` int(10) unsigned NOT NULL,
  `stats_atk` int(11) NOT NULL,
  `stats_def` int(11) NOT NULL,
  `stats_crit` int(11) NOT NULL,
  `stats_hp` int(11) NOT NULL,
  `stats_armor` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `equip_to_account` (`accountid`),
  KEY `equip_to_type` (`typeid`),
  CONSTRAINT `equip_to_account` FOREIGN KEY (`accountid`) REFERENCES `Accounts` (`id`),
  CONSTRAINT `equip_to_type` FOREIGN KEY (`typeid`) REFERENCES `Equipment_Type_DM` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Equipment` */

/*Table structure for table `Equipment_Type_DM` */

DROP TABLE IF EXISTS `Equipment_Type_DM`;

CREATE TABLE `Equipment_Type_DM` (
  `typeid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Equipment_Type_DM` */

/*Table structure for table `Explorations` */

DROP TABLE IF EXISTS `Explorations`;

CREATE TABLE `Explorations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accountid` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL,
  `zoneid` int(10) unsigned NOT NULL,
  `partyid` int(10) unsigned NOT NULL,
  `found_zoneid` int(10) unsigned DEFAULT NULL,
  `found_itemid` int(10) unsigned DEFAULT NULL,
  `found_enemyid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `explor_to_account` (`accountid`),
  KEY `explor_to_zone` (`zoneid`),
  KEY `explor_to_party` (`partyid`),
  KEY `explor_to_foundzone` (`found_zoneid`),
  KEY `explor_to_founditem` (`found_itemid`),
  KEY `explor_to_foundenemy` (`found_enemyid`),
  CONSTRAINT `explor_to_account` FOREIGN KEY (`accountid`) REFERENCES `Accounts` (`id`),
  CONSTRAINT `explor_to_zone` FOREIGN KEY (`zoneid`) REFERENCES `Zones` (`id`),
  CONSTRAINT `explor_to_party` FOREIGN KEY (`partyid`) REFERENCES `Parties` (`id`),
  CONSTRAINT `explor_to_foundzone` FOREIGN KEY (`found_zoneid`) REFERENCES `Zones` (`id`),
  CONSTRAINT `explor_to_founditem` FOREIGN KEY (`found_itemid`) REFERENCES `Items` (`id`),
  CONSTRAINT `explor_to_foundenemy` FOREIGN KEY (`found_enemyid`) REFERENCES `Enemies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Explorations` */

/*Table structure for table `Fights` */

DROP TABLE IF EXISTS `Fights`;

CREATE TABLE `Fights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accountid` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL,
  `enemyid` int(10) unsigned NOT NULL,
  `partyid` int(10) unsigned NOT NULL,
  `resultid` int(10) unsigned NOT NULL,
  `gained_gold` int(11) DEFAULT NULL,
  `gained_experience` int(11) DEFAULT NULL,
  `gained_itemid` int(10) unsigned DEFAULT NULL,
  `gained_equipmentid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fights_to_result` (`resultid`),
  KEY `fights_to_gained_item` (`gained_itemid`),
  KEY `fights_to_gained_equipment` (`gained_equipmentid`),
  KEY `fights_to_account` (`accountid`),
  KEY `fights_to_enemy` (`enemyid`),
  KEY `fights_to_party` (`partyid`),
  CONSTRAINT `fights_to_result` FOREIGN KEY (`resultid`) REFERENCES `Fights_Result_DM` (`resultid`),
  CONSTRAINT `fights_to_gained_item` FOREIGN KEY (`gained_itemid`) REFERENCES `Items` (`id`),
  CONSTRAINT `fights_to_gained_equipment` FOREIGN KEY (`gained_equipmentid`) REFERENCES `Equipment` (`id`),
  CONSTRAINT `fights_to_account` FOREIGN KEY (`accountid`) REFERENCES `Accounts` (`id`),
  CONSTRAINT `fights_to_enemy` FOREIGN KEY (`enemyid`) REFERENCES `Enemies` (`id`),
  CONSTRAINT `fights_to_party` FOREIGN KEY (`partyid`) REFERENCES `Items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Fights` */

/*Table structure for table `Fights_Result_DM` */

DROP TABLE IF EXISTS `Fights_Result_DM`;

CREATE TABLE `Fights_Result_DM` (
  `resultid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`resultid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Fights_Result_DM` */

/*Table structure for table `Items` */

DROP TABLE IF EXISTS `Items`;

CREATE TABLE `Items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `typeid` int(10) unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  `cost` int(10) unsigned DEFAULT NULL,
  `level` int(10) unsigned NOT NULL,
  `tier` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `items_to_type` (`typeid`),
  CONSTRAINT `items_to_type` FOREIGN KEY (`typeid`) REFERENCES `Items_Type_DM` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Items` */

/*Table structure for table `Items_Accounts_Assoc` */

DROP TABLE IF EXISTS `Items_Accounts_Assoc`;

CREATE TABLE `Items_Accounts_Assoc` (
  `itemid` int(10) unsigned NOT NULL,
  `accountid` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`itemid`,`accountid`),
  KEY `itemaccount_to_account` (`accountid`),
  CONSTRAINT `itemaccount_to_item` FOREIGN KEY (`itemid`) REFERENCES `Items` (`id`),
  CONSTRAINT `itemaccount_to_account` FOREIGN KEY (`accountid`) REFERENCES `Accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Items_Accounts_Assoc` */

/*Table structure for table `Items_Type_DM` */

DROP TABLE IF EXISTS `Items_Type_DM`;

CREATE TABLE `Items_Type_DM` (
  `typeid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Items_Type_DM` */

/*Table structure for table `Parties` */

DROP TABLE IF EXISTS `Parties`;

CREATE TABLE `Parties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accountid` int(10) unsigned NOT NULL,
  `statusid` int(10) unsigned NOT NULL,
  `member1id` int(10) unsigned DEFAULT NULL,
  `member2id` int(10) unsigned DEFAULT NULL,
  `member3id` int(10) unsigned DEFAULT NULL,
  `member4id` int(10) unsigned DEFAULT NULL,
  `member5id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parties_to_account` (`accountid`),
  KEY `parties_to_member1` (`member1id`),
  KEY `parties_to_member2` (`member2id`),
  KEY `parties_to_member3` (`member3id`),
  KEY `parties_to_member4` (`member4id`),
  KEY `parties_to_member5` (`member5id`),
  KEY `parties_to_status` (`statusid`),
  CONSTRAINT `parties_to_account` FOREIGN KEY (`accountid`) REFERENCES `Accounts` (`id`),
  CONSTRAINT `parties_to_member1` FOREIGN KEY (`member1id`) REFERENCES `Characters` (`id`),
  CONSTRAINT `parties_to_member2` FOREIGN KEY (`member2id`) REFERENCES `Characters` (`id`),
  CONSTRAINT `parties_to_member3` FOREIGN KEY (`member3id`) REFERENCES `Characters` (`id`),
  CONSTRAINT `parties_to_member4` FOREIGN KEY (`member4id`) REFERENCES `Characters` (`id`),
  CONSTRAINT `parties_to_member5` FOREIGN KEY (`member5id`) REFERENCES `Characters` (`id`),
  CONSTRAINT `parties_to_status` FOREIGN KEY (`statusid`) REFERENCES `Parties_Status_DM` (`statusid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Parties` */

/*Table structure for table `Parties_Status_DM` */

DROP TABLE IF EXISTS `Parties_Status_DM`;

CREATE TABLE `Parties_Status_DM` (
  `statusid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`statusid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Parties_Status_DM` */

/*Table structure for table `Zones` */

DROP TABLE IF EXISTS `Zones`;

CREATE TABLE `Zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `typeid` int(10) unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  `tier` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zones_to_type` (`typeid`),
  CONSTRAINT `zones_to_type` FOREIGN KEY (`typeid`) REFERENCES `Zones_Type_DM` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Zones` */

/*Table structure for table `Zones_Accounts_Assoc` */

DROP TABLE IF EXISTS `Zones_Accounts_Assoc`;

CREATE TABLE `Zones_Accounts_Assoc` (
  `zoneid` int(10) unsigned NOT NULL,
  `accountid` int(10) unsigned NOT NULL,
  `closes` timestamp NOT NULL,
  PRIMARY KEY (`zoneid`,`accountid`),
  KEY `zoneaccount_to_account` (`accountid`),
  CONSTRAINT `zoneaccount_to_zone` FOREIGN KEY (`zoneid`) REFERENCES `Zones` (`id`),
  CONSTRAINT `zoneaccount_to_account` FOREIGN KEY (`accountid`) REFERENCES `Accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Zones_Accounts_Assoc` */

/*Table structure for table `Zones_Type_DM` */

DROP TABLE IF EXISTS `Zones_Type_DM`;

CREATE TABLE `Zones_Type_DM` (
  `typeid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Zones_Type_DM` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
