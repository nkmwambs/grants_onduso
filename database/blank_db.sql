-- Adminer 4.6.3 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `approval`;
CREATE TABLE `approval` (
  `approval_id` int(100) NOT NULL AUTO_INCREMENT,
  `approval_track_number` varchar(50) DEFAULT NULL,
  `fk_approveable_item_id` int(100) DEFAULT NULL,
  `approval_approveable_table_primary_key` varchar(45) DEFAULT NULL COMMENT 'This is a special foreign key in this table but a primary key in either voucher, request, or budget etc',
  `fk_approval_status_id` int(100) DEFAULT NULL,
  `approval_approved_by` varchar(45) DEFAULT NULL,
  `approval_created_date` varchar(45) DEFAULT NULL,
  `approval_created_by` int(100) DEFAULT NULL,
  `approval_last_modified_date` date DEFAULT NULL,
  `approval_last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`approval_id`),
  UNIQUE KEY `track_number_UNIQUE` (`approval_track_number`),
  KEY `fk_approval_approveable_item1_idx` (`fk_approveable_item_id`),
  KEY `fk_approval_approval_status1_idx` (`fk_approval_status_id`),
  CONSTRAINT `fk_approval_approval_status1` FOREIGN KEY (`fk_approval_status_id`) REFERENCES `approval_status` (`approval_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_approval_approveable_item1` FOREIGN KEY (`fk_approveable_item_id`) REFERENCES `approveable_item` (`approveable_item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `approval` (`approval_id`, `approval_track_number`, `fk_approveable_item_id`, `approval_approveable_table_primary_key`, `fk_approval_status_id`, `approval_approved_by`, `approval_created_date`, `approval_created_by`, `approval_last_modified_date`, `approval_last_modified_by`) VALUES
(1,	'APR-7856',	1,	'2',	2,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	'APR-7494',	2,	'1',	1,	NULL,	NULL,	NULL,	NULL,	NULL);

DELIMITER ;;

CREATE TRIGGER `approval_AFTER_UPDATE` AFTER UPDATE ON `approval` FOR EACH ROW
BEGIN

END;;

DELIMITER ;

DROP TABLE IF EXISTS `approval_process_map`;
CREATE TABLE `approval_process_map` (
  `approval_process_map_id` int(100) NOT NULL,
  `approveable_item_id` int(100) DEFAULT NULL,
  `role_id` int(100) DEFAULT NULL,
  `approval_step_depth` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`approval_process_map_id`),
  KEY `fk_approval_process_map_role1_idx` (`role_id`),
  KEY `fk_approval_process_map_approveable_item1_idx` (`approveable_item_id`),
  CONSTRAINT `fk_approval_process_map_approveable_item1` FOREIGN KEY (`approveable_item_id`) REFERENCES `approveable_item` (`approveable_item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_approval_process_map_role1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `approval_status`;
CREATE TABLE `approval_status` (
  `approval_status_id` int(100) NOT NULL AUTO_INCREMENT,
  `approval_status_name` varchar(45) DEFAULT NULL,
  `is_active` int(5) DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `approveable_item_id` int(100) DEFAULT NULL,
  `approval_sequence` int(5) DEFAULT NULL,
  `approver_role_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`approval_status_id`),
  KEY `fk_approval_status_role1_idx` (`approver_role_id`),
  KEY `fk_approval_status_approveable_item1_idx` (`approveable_item_id`),
  CONSTRAINT `fk_approval_status_approveable_item1` FOREIGN KEY (`approveable_item_id`) REFERENCES `approveable_item` (`approveable_item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_approval_status_role1` FOREIGN KEY (`approver_role_id`) REFERENCES `role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `approval_status` (`approval_status_id`, `approval_status_name`, `is_active`, `last_modified_date`, `created_by`, `created_date`, `approveable_item_id`, `approval_sequence`, `approver_role_id`) VALUES
(1,	'New',	1,	NULL,	NULL,	NULL,	1,	1,	1),
(2,	'Submitted',	1,	NULL,	NULL,	NULL,	1,	2,	1),
(3,	'Approved',	1,	NULL,	NULL,	NULL,	1,	3,	1);

DROP TABLE IF EXISTS `approveable_item`;
CREATE TABLE `approveable_item` (
  `approveable_item_id` int(100) NOT NULL AUTO_INCREMENT,
  `approveable_item_name` varchar(45) DEFAULT NULL,
  `is_active` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`approveable_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `approveable_item` (`approveable_item_id`, `approveable_item_name`, `is_active`, `created_by`, `created_date`, `last_modified_date`, `last_modified_by`) VALUES
(1,	'request',	'1',	NULL,	NULL,	NULL,	NULL),
(2,	'voucher',	'1',	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank` (
  `bank_id` int(100) NOT NULL AUTO_INCREMENT,
  `bank_track_number` varchar(100) DEFAULT NULL,
  `bank_name` varchar(45) DEFAULT NULL,
  `bank_swift_code` varchar(45) DEFAULT NULL,
  `bank_is_active` int(5) DEFAULT NULL,
  `bank_created_date` date DEFAULT NULL,
  `bank_created_by` int(100) DEFAULT NULL,
  `bank_last_modified_date` date DEFAULT NULL,
  `bank_last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`bank_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table list all the banks for centers';

INSERT INTO `bank` (`bank_id`, `bank_track_number`, `bank_name`, `bank_swift_code`, `bank_is_active`, `bank_created_date`, `bank_created_by`, `bank_last_modified_date`, `bank_last_modified_by`) VALUES
(1,	'BAK-87365',	'Commercial Bank of Kenya',	'2365',	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `bank_branch`;
CREATE TABLE `bank_branch` (
  `bank_branch_id` int(100) NOT NULL AUTO_INCREMENT,
  `bank_id` int(100) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `is_active` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`bank_branch_id`),
  KEY `fk_bank_branch_bank1_idx` (`bank_id`),
  CONSTRAINT `fk_bank_branch_bank1` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`bank_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table holds branches for banks';


DROP TABLE IF EXISTS `budget`;
CREATE TABLE `budget` (
  `budget_id` int(100) NOT NULL AUTO_INCREMENT,
  `budget_track_number` varchar(45) DEFAULT NULL,
  `fk_center_id` int(100) DEFAULT NULL,
  `budget_year` int(5) DEFAULT NULL,
  `budget_created_by` int(100) DEFAULT NULL,
  `budget_created_date` date DEFAULT NULL,
  `budget_last_modified_by` int(100) DEFAULT NULL,
  `budget_last_modified_date` date DEFAULT NULL,
  PRIMARY KEY (`budget_id`),
  KEY `fk_budget_center1_idx` (`fk_center_id`),
  CONSTRAINT `fk_budget_center1` FOREIGN KEY (`fk_center_id`) REFERENCES `center` (`center_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table holds the budget items by activity';

INSERT INTO `budget` (`budget_id`, `budget_track_number`, `fk_center_id`, `budget_year`, `budget_created_by`, `budget_created_date`, `budget_last_modified_by`, `budget_last_modified_date`) VALUES
(1,	'BGT-74846',	1,	2019,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `budget_detail`;
CREATE TABLE `budget_detail` (
  `budget_detail_id` int(100) NOT NULL,
  `budget_id` int(100) DEFAULT NULL,
  `expense_account_id` int(100) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `approval_status_id` int(100) DEFAULT NULL,
  `center_project_allocation` int(100) DEFAULT NULL,
  `budget_detail_note` longtext,
  PRIMARY KEY (`budget_detail_id`),
  KEY `fk_budget_detail_id_expense_account_id_idx` (`expense_account_id`),
  KEY `fk_budget_detail_budget_id_idx` (`budget_id`),
  KEY `fk_budget_detail_center_project_allocation1_idx` (`center_project_allocation`),
  CONSTRAINT `fk_budget_detail_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `budget` (`budget_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_budget_detail_center_project_allocation1` FOREIGN KEY (`center_project_allocation`) REFERENCES `center_project_allocation` (`center_project_allocation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_budget_detail_id_expense_account_id` FOREIGN KEY (`expense_account_id`) REFERENCES `expense_account` (`expense_account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This hold activties and their budgeted cost';


DROP TABLE IF EXISTS `budget_month_spread`;
CREATE TABLE `budget_month_spread` (
  `budget_month_spread_id` int(100) NOT NULL,
  `budget_detail_id` int(100) DEFAULT NULL,
  `month` varchar(45) DEFAULT NULL,
  `amount` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`budget_month_spread_id`),
  KEY `fk_budget_month_spread_budget_detail1_idx` (`budget_detail_id`),
  CONSTRAINT `fk_budget_month_spread_budget_detail1` FOREIGN KEY (`budget_detail_id`) REFERENCES `budget_detail` (`budget_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table distributes budget allocations by month';


DROP TABLE IF EXISTS `center`;
CREATE TABLE `center` (
  `center_id` int(100) NOT NULL AUTO_INCREMENT,
  `center_track_number` varchar(100) DEFAULT NULL,
  `center_name` varchar(45) NOT NULL,
  `center_code` varchar(10) NOT NULL,
  `center_start_date` date NOT NULL,
  `center_end_date` date NOT NULL,
  `center_is_active` int(5) NOT NULL DEFAULT '0',
  `center_created_by` int(100) NOT NULL,
  `center_created_date` date NOT NULL,
  `center_last_modified_date` date NOT NULL,
  `center_last_modified_by` int(100) NOT NULL,
  PRIMARY KEY (`center_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table list all the remote sites for the organization\n';

INSERT INTO `center` (`center_id`, `center_track_number`, `center_name`, `center_code`, `center_start_date`, `center_end_date`, `center_is_active`, `center_created_by`, `center_created_date`, `center_last_modified_date`, `center_last_modified_by`) VALUES
(1,	'CNT-97356',	'Kiserian CDC',	'KE0240',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(2,	'CNT-65378',	'Machakos CDC',	'KE0765',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(3,	'CNT-75637',	'Kilifi CDC',	'KE0340',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(4,	'CNT-65268',	'Mombasa CDC',	'KE0345',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(5,	'CNT-55473',	'Jinja CDC',	'UG0211',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(6,	'CNT-65370',	'Kampala CDC',	'UG0721',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(7,	'CNT-67653',	'Cape CDC',	'HT0422',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1);

DROP TABLE IF EXISTS `center_bank`;
CREATE TABLE `center_bank` (
  `center_bank_id` int(100) NOT NULL AUTO_INCREMENT,
  `center_id` int(100) DEFAULT NULL,
  `bank_account_number` varchar(50) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  `bank_branch_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`center_bank_id`),
  KEY `fk_center_bank_center1_idx` (`center_id`),
  KEY `fk_center_bank_bank_branch1_idx` (`bank_branch_id`),
  CONSTRAINT `fk_center_bank_bank_branch1` FOREIGN KEY (`bank_branch_id`) REFERENCES `bank_branch` (`bank_branch_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_bank_center1` FOREIGN KEY (`center_id`) REFERENCES `center` (`center_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `center_group`;
CREATE TABLE `center_group` (
  `center_group_id` int(100) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `group_level` int(5) DEFAULT NULL,
  `role_id` int(100) DEFAULT NULL COMMENT 'Manager role id\n',
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  PRIMARY KEY (`center_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `center_group` (`center_group_id`, `name`, `group_level`, `role_id`, `created_date`, `last_modified_date`, `created_by`, `last_modified_by`, `deleted_date`) VALUES
(1,	'Cluster',	1,	1,	'2019-09-27',	'2019-09-27',	1,	1,	NULL),
(2,	'Region',	2,	2,	'2019-09-27',	'2019-09-27',	1,	1,	NULL),
(3,	'Area',	3,	3,	'2019-09-27',	'2019-09-27',	1,	1,	NULL),
(4,	'Global',	4,	4,	'2019-09-27',	'2019-09-27',	1,	1,	NULL);

DROP TABLE IF EXISTS `center_group_link`;
CREATE TABLE `center_group_link` (
  `center_group_link_id` int(11) NOT NULL AUTO_INCREMENT,
  `center_id` int(100) DEFAULT NULL,
  `center_group_id` int(100) DEFAULT NULL,
  `user_id` int(100) DEFAULT NULL COMMENT 'User id of the manager',
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  `center_group_link_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`center_group_link_id`),
  KEY `fk_center_group_link_center1_idx` (`center_id`),
  KEY `fk_center_group_link_center_group1_idx` (`center_group_id`),
  CONSTRAINT `fk_center_group_link_center1` FOREIGN KEY (`center_id`) REFERENCES `center` (`center_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_group_link_center_group1` FOREIGN KEY (`center_group_id`) REFERENCES `center_group` (`center_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `center_group_link` (`center_group_link_id`, `center_id`, `center_group_id`, `user_id`, `created_date`, `last_modified_date`, `deleted_date`, `created_by`, `last_modified_by`, `center_group_link_name`) VALUES
(1,	1,	1,	1,	'2019-09-27',	'2019-09-27',	NULL,	1,	1,	'Central Cluster');

DROP TABLE IF EXISTS `center_project_allocation`;
CREATE TABLE `center_project_allocation` (
  `center_project_allocation_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(100) DEFAULT NULL,
  `amount` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `extended_end_date` date DEFAULT NULL,
  `is_active` varchar(45) DEFAULT NULL,
  `center_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`center_project_allocation_id`),
  KEY `fk_center_project_allocation_project1_idx` (`project_id`),
  KEY `fk_center_project_allocation_center1_idx` (`center_id`),
  CONSTRAINT `fk_center_project_allocation_center1` FOREIGN KEY (`center_id`) REFERENCES `center` (`center_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_project_allocation_project1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table shows how each center has apportioned funds for a give project\n';


DROP TABLE IF EXISTS `chatable_table`;
CREATE TABLE `chatable_table` (
  `chatable_table_id` int(11) NOT NULL,
  `chatable_table_name` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`chatable_table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cheque_book`;
CREATE TABLE `cheque_book` (
  `cheque_book_id` int(11) NOT NULL AUTO_INCREMENT,
  `center_bank_id` int(100) DEFAULT NULL,
  `start_serial_number` varchar(45) DEFAULT NULL,
  `count_of_leaves` varchar(45) DEFAULT NULL,
  `use_start_date` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cheque_book_id`),
  KEY `fk_cheque_book_center_bank1_idx` (`center_bank_id`),
  CONSTRAINT `fk_cheque_book_center_bank1` FOREIGN KEY (`center_bank_id`) REFERENCES `center_bank` (`center_bank_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `customizable_table`;
CREATE TABLE `customizable_table` (
  `customizable_table_id` int(11) NOT NULL,
  `customizable_table_name` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`customizable_table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `custom_field`;
CREATE TABLE `custom_field` (
  `custom_field_id` int(100) NOT NULL,
  `customizable_table_id` int(100) DEFAULT NULL,
  `column_name` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  `custom_field_type_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`custom_field_id`),
  KEY `fk_custom_field_customizable_table1_idx` (`customizable_table_id`),
  KEY `fk_custom_field_custom_field_type1_idx` (`custom_field_type_id`),
  CONSTRAINT `fk_custom_field_custom_field_type1` FOREIGN KEY (`custom_field_type_id`) REFERENCES `custom_field_type` (`custom_field_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_custom_field_customizable_table1` FOREIGN KEY (`customizable_table_id`) REFERENCES `customizable_table` (`customizable_table_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `custom_field_detail`;
CREATE TABLE `custom_field_detail` (
  `custom_field_detail_id` int(100) NOT NULL AUTO_INCREMENT,
  `custom_field_id` int(100) DEFAULT NULL,
  `custom_field_value` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`custom_field_detail_id`),
  KEY `fk_custom_field_detail_custom_field1_idx` (`custom_field_id`),
  CONSTRAINT `fk_custom_field_detail_custom_field1` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_field` (`custom_field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `custom_field_type`;
CREATE TABLE `custom_field_type` (
  `custom_field_type_id` int(100) NOT NULL AUTO_INCREMENT,
  `custom_field_type_name` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`custom_field_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `custom_field_type_option`;
CREATE TABLE `custom_field_type_option` (
  `custom_field_type_option_id` int(100) NOT NULL AUTO_INCREMENT,
  `custom_field_id` int(100) DEFAULT NULL,
  `custom_field_type_option_name` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`custom_field_type_option_id`),
  KEY `fk_custom_field_type_option_custom_field1_idx` (`custom_field_id`),
  CONSTRAINT `fk_custom_field_type_option_custom_field1` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_field` (`custom_field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `expense_account`;
CREATE TABLE `expense_account` (
  `expense_account_id` int(100) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `is_admin` int(5) DEFAULT NULL,
  `is_active` int(5) DEFAULT NULL,
  `is_budgeted` int(5) DEFAULT NULL,
  `income_account_id` int(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`expense_account_id`),
  KEY `fk_expense_account_income_account_idx` (`income_account_id`),
  CONSTRAINT `fk_expense_account_income_account` FOREIGN KEY (`income_account_id`) REFERENCES `income_account` (`income_account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table holds the expense accounts';

INSERT INTO `expense_account` (`expense_account_id`, `description`, `code`, `is_admin`, `is_active`, `is_budgeted`, `income_account_id`, `created_date`, `last_modified_date`, `created_by`, `last_modified_by`) VALUES
(1,	'Expense 1',	'E001',	0,	1,	1,	1,	NULL,	NULL,	NULL,	NULL),
(2,	'Expense 2',	'E002',	0,	1,	1,	1,	NULL,	NULL,	NULL,	NULL),
(3,	'Expense 3',	'E003',	0,	1,	1,	1,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `funder`;
CREATE TABLE `funder` (
  `funder_id` int(100) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  `deleted_date` datetime DEFAULT NULL,
  PRIMARY KEY (`funder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table holds donor (funders) bio-information\n';


DROP TABLE IF EXISTS `funding_status`;
CREATE TABLE `funding_status` (
  `funding_status_id` int(100) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `is_active` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `is_available` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`funding_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `history`;
CREATE TABLE `history` (
  `history_id` int(100) NOT NULL AUTO_INCREMENT,
  `reference_table` varchar(45) DEFAULT NULL,
  `user_id` varchar(45) DEFAULT NULL,
  `table_action` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `income_account`;
CREATE TABLE `income_account` (
  `income_account_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `is_active` int(5) DEFAULT NULL,
  `is_budgeted` int(5) DEFAULT NULL,
  `is_donor_funded` int(5) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`income_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table contains the income accounts. ';

INSERT INTO `income_account` (`income_account_id`, `description`, `code`, `is_active`, `is_budgeted`, `is_donor_funded`, `created_date`, `last_modified_date`, `created_by`, `last_modified_by`) VALUES
(1,	'Project Cost',	'PC',	1,	1,	1,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `language`;
CREATE TABLE `language` (
  `language_id` int(100) NOT NULL AUTO_INCREMENT,
  `language_name` varchar(100) DEFAULT NULL,
  `language_short_name` varchar(10) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `language_phrase`;
CREATE TABLE `language_phrase` (
  `language_phrase_id` int(11) NOT NULL AUTO_INCREMENT,
  `phrase` longtext,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`language_phrase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` int(100) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(100) DEFAULT NULL,
  `menu_derivative_controller` varchar(100) DEFAULT NULL,
  `menu_created_date` date DEFAULT NULL,
  `menu_last_modified_date` date DEFAULT NULL,
  `menu_created_by` int(100) DEFAULT NULL,
  `menu_last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `menu` (`menu_id`, `menu_name`, `menu_derivative_controller`, `menu_created_date`, `menu_last_modified_date`, `menu_created_by`, `menu_last_modified_by`) VALUES
(1,	'Approval',	'Approval',	NULL,	NULL,	NULL,	NULL),
(2,	'Bank',	'Bank',	NULL,	NULL,	NULL,	NULL),
(3,	'Budget',	'Budget',	NULL,	NULL,	NULL,	NULL),
(4,	'Center',	'Center',	NULL,	NULL,	NULL,	NULL),
(5,	'Dashboard',	'Dashboard',	NULL,	NULL,	NULL,	NULL),
(6,	'Field',	'Field',	NULL,	NULL,	NULL,	NULL),
(7,	'Funder',	'Funder',	NULL,	NULL,	NULL,	NULL),
(8,	'Journal',	'Journal',	NULL,	NULL,	NULL,	NULL),
(9,	'Language',	'Language',	NULL,	NULL,	NULL,	NULL),
(10,	'Message',	'Message',	NULL,	NULL,	NULL,	NULL),
(11,	'Request',	'Request',	NULL,	NULL,	NULL,	NULL),
(12,	'User',	'User',	NULL,	NULL,	NULL,	NULL),
(13,	'Voucher',	'Voucher',	NULL,	NULL,	NULL,	NULL),
(14,	'Workplan',	'Workplan',	NULL,	NULL,	NULL,	NULL),
(15,	'Setting',	'Setting',	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `menu_user_order`;
CREATE TABLE `menu_user_order` (
  `menu_user_order_id` int(100) NOT NULL AUTO_INCREMENT,
  `fk_user_id` int(100) DEFAULT NULL,
  `fk_menu_id` int(100) DEFAULT NULL,
  `menu_user_order_is_active` int(5) NOT NULL DEFAULT '1',
  `menu_user_order_level` int(100) DEFAULT NULL,
  `menu_user_order_priority_item` int(5) NOT NULL DEFAULT '1',
  `menu_user_order_created_date` date DEFAULT NULL,
  `menu_user_order_last_modified_date` date DEFAULT NULL,
  `menu_user_order_created_by` int(100) DEFAULT NULL,
  `menu_user_order_last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`menu_user_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `menu_user_order` (`menu_user_order_id`, `fk_user_id`, `fk_menu_id`, `menu_user_order_is_active`, `menu_user_order_level`, `menu_user_order_priority_item`, `menu_user_order_created_date`, `menu_user_order_last_modified_date`, `menu_user_order_created_by`, `menu_user_order_last_modified_by`) VALUES
(16,	1,	1,	1,	5,	1,	NULL,	NULL,	NULL,	NULL),
(17,	1,	2,	1,	2,	0,	NULL,	NULL,	NULL,	NULL),
(18,	1,	3,	1,	3,	1,	NULL,	NULL,	NULL,	NULL),
(19,	1,	4,	1,	4,	0,	NULL,	NULL,	NULL,	NULL),
(20,	1,	5,	1,	1,	1,	NULL,	NULL,	NULL,	NULL),
(21,	1,	6,	1,	6,	0,	NULL,	NULL,	NULL,	NULL),
(22,	1,	7,	1,	7,	1,	NULL,	NULL,	NULL,	NULL),
(23,	1,	8,	1,	8,	1,	NULL,	NULL,	NULL,	NULL),
(24,	1,	9,	1,	9,	0,	NULL,	NULL,	NULL,	NULL),
(25,	1,	10,	1,	10,	1,	NULL,	NULL,	NULL,	NULL),
(26,	1,	11,	1,	11,	1,	NULL,	NULL,	NULL,	NULL),
(27,	1,	12,	1,	12,	0,	NULL,	NULL,	NULL,	NULL),
(28,	1,	13,	1,	13,	1,	NULL,	NULL,	NULL,	NULL),
(29,	1,	14,	1,	14,	1,	NULL,	NULL,	NULL,	NULL),
(30,	1,	15,	1,	15,	0,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `chatable_table_id` int(100) DEFAULT NULL,
  `customizable_table_item_primary_key` int(100) DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `is_thread_open` int(5) DEFAULT '1',
  PRIMARY KEY (`message_id`),
  KEY `fk_message_chatable_table1_idx` (`chatable_table_id`),
  CONSTRAINT `fk_message_chatable_table1` FOREIGN KEY (`chatable_table_id`) REFERENCES `chatable_table` (`chatable_table_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `message_detail`;
CREATE TABLE `message_detail` (
  `message_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_from_user_id` int(100) DEFAULT NULL,
  `message_content` longtext,
  `message_id` int(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  `is_reply` int(5) DEFAULT '0',
  `replied_message_detail_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`message_detail_id`),
  KEY `fk_message_detail_message1_idx` (`message_id`),
  CONSTRAINT `fk_message_detail_message1` FOREIGN KEY (`message_id`) REFERENCES `message` (`message_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `project_id` int(100) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `project_cost` double(10,2) NOT NULL,
  `created_by` int(100) NOT NULL,
  `last_modified_by` int(100) NOT NULL,
  `created_date` date NOT NULL,
  `last_modified_date` date NOT NULL,
  `funder_id` int(100) NOT NULL,
  `code` varchar(10) NOT NULL,
  `funding_status_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `fk_project_id_funder_id_idx` (`funder_id`),
  KEY `fk_project_funding_status1_idx` (`funding_status_id`),
  CONSTRAINT `fk_project_funding_status1` FOREIGN KEY (`funding_status_id`) REFERENCES `funding_status` (`funding_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_id_funder_id` FOREIGN KEY (`funder_id`) REFERENCES `funder` (`funder_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='A project is a single funded proposal that need to be implemented and reported as a unit. It''s related to single funder\n ';


DROP TABLE IF EXISTS `project_cost_proportion`;
CREATE TABLE `project_cost_proportion` (
  `project_cost_proportion_id` int(11) NOT NULL,
  `voucher_detail_id` int(100) DEFAULT NULL,
  `amount` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `center_project_allocation_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`project_cost_proportion_id`),
  KEY `fk_project_cost_proportion_voucher_detail1_idx` (`voucher_detail_id`),
  KEY `fk_project_cost_proportion_center_project_allocation1_idx` (`center_project_allocation_id`),
  CONSTRAINT `fk_project_cost_proportion_center_project_allocation1` FOREIGN KEY (`center_project_allocation_id`) REFERENCES `center_project_allocation` (`center_project_allocation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_cost_proportion_voucher_detail1` FOREIGN KEY (`voucher_detail_id`) REFERENCES `voucher_detail` (`voucher_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reconciliation`;
CREATE TABLE `reconciliation` (
  `reconciliation_id` int(100) NOT NULL AUTO_INCREMENT,
  `reporting_month` varchar(45) DEFAULT NULL,
  `approval_status_id` varchar(45) DEFAULT NULL,
  `statement_amount` varchar(45) DEFAULT NULL,
  `suspense_amount` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `center_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`reconciliation_id`),
  KEY `fk_reconciliation_center1_idx` (`center_id`),
  CONSTRAINT `fk_reconciliation_center1` FOREIGN KEY (`center_id`) REFERENCES `center` (`center_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
  `request_id` int(100) NOT NULL AUTO_INCREMENT,
  `request_date` date DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `request` (`request_id`, `request_date`, `description`, `created_date`, `created_by`, `last_modified_by`, `last_modified_date`, `deleted_at`) VALUES
(1,	'2019-09-29',	'Test request 1',	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	'2019-09-29',	'Test request 2',	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(100) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `role` (`role_id`, `name`, `created_by`, `created_date`, `last_modified_date`, `last_modified_by`, `deleted_at`) VALUES
(1,	'Department Manager',	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `setting` (`setting_id`, `type`, `description`, `created_date`, `last_modified_date`, `deleted_date`, `created_by`, `last_modified_by`) VALUES
(1,	'system_name',	'Grants Management System',	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	'system_title',	'Grants Management System',	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	'address',	'1945 Nairobi',	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	'phone',	'254711808071',	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	'system_email',	'support@compassionkenya.com',	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	'language',	'english',	NULL,	NULL,	NULL,	NULL,	NULL),
(10,	'text_align',	'left-to-right',	NULL,	NULL,	NULL,	NULL,	NULL),
(14,	'skin_colour',	'blue',	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `translation`;
CREATE TABLE `translation` (
  `translation_id` int(100) NOT NULL AUTO_INCREMENT,
  `language_phrase_id` int(100) DEFAULT NULL,
  `language_id` int(100) DEFAULT NULL,
  `translate` longtext,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`translation_id`),
  KEY `fk_translation_language1_idx` (`language_id`),
  KEY `fk_translation_language_phrase1_idx` (`language_phrase_id`),
  CONSTRAINT `fk_translation_language1` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_translation_language_phrase1` FOREIGN KEY (`language_phrase_id`) REFERENCES `language_phrase` (`language_phrase_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(100) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `center_group_link_id` int(100) DEFAULT NULL,
  `is_center_group_manager` int(5) DEFAULT NULL,
  `language_id` int(100) DEFAULT NULL COMMENT 'User''s default language',
  `is_active` int(5) DEFAULT '1',
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_user_center_group_link1_idx` (`center_group_link_id`),
  KEY `fk_user_language1_idx` (`language_id`),
  CONSTRAINT `fk_user_center_group_link1` FOREIGN KEY (`center_group_link_id`) REFERENCES `center_group_link` (`center_group_link_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_language1` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `user` (`user_id`, `first_name`, `last_name`, `email`, `center_group_link_id`, `is_center_group_manager`, `language_id`, `is_active`, `password`) VALUES
(1,	'Nicodemus',	'Karisa',	'nkmwambs@gmail.com',	NULL,	NULL,	NULL,	1,	'fbdf9989ea636d6b339fd6b85f63e06e');

DROP TABLE IF EXISTS `user_access_level`;
CREATE TABLE `user_access_level` (
  `user_access_level_id` int(11) NOT NULL AUTO_INCREMENT,
  `controller_method` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`user_access_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `user_access_level` (`user_access_level_id`, `controller_method`, `created_date`, `created_by`, `deleted_at`, `last_modified_date`, `last_modified_by`) VALUES
(1,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(133,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(134,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(135,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(136,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(137,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(138,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(139,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(140,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(141,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(142,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(143,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(144,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(145,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(146,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(147,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(148,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(149,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(150,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(151,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(152,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(153,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(154,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(155,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(156,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(157,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(158,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(159,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(160,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(161,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(162,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(163,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL),
(164,	'dashboard::index',	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `user_priviledge`;
CREATE TABLE `user_priviledge` (
  `user_priviledge_id` int(100) NOT NULL AUTO_INCREMENT,
  `user_access_level_id` int(100) DEFAULT NULL,
  `user_id` int(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`user_priviledge_id`),
  KEY `fk_user_priviledge_user_access_level1_idx` (`user_access_level_id`),
  CONSTRAINT `fk_user_priviledge_user_access_level1` FOREIGN KEY (`user_access_level_id`) REFERENCES `user_access_level` (`user_access_level_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `user_priviledge` (`user_priviledge_id`, `user_access_level_id`, `user_id`, `created_date`, `created_by`, `deleted_at`, `last_modified_date`, `last_modified_by`) VALUES
(1,	1,	1,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `variance_note`;
CREATE TABLE `variance_note` (
  `variance_note_id` int(100) NOT NULL AUTO_INCREMENT,
  `reconciliation_id` int(100) DEFAULT NULL,
  `expense_account_id` int(100) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `variance_note_detail` longtext,
  PRIMARY KEY (`variance_note_id`),
  KEY `fk_variance_comment_reconciliation1_idx` (`reconciliation_id`),
  KEY `fk_variance_comment_expense_account1_idx` (`expense_account_id`),
  CONSTRAINT `fk_variance_comment_expense_account1` FOREIGN KEY (`expense_account_id`) REFERENCES `expense_account` (`expense_account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_variance_comment_reconciliation1` FOREIGN KEY (`reconciliation_id`) REFERENCES `reconciliation` (`reconciliation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `voucher`;
CREATE TABLE `voucher` (
  `voucher_id` int(100) NOT NULL,
  `center_id` int(100) DEFAULT NULL,
  `voucher_date` varchar(45) DEFAULT NULL,
  `voucher_type_id` int(100) DEFAULT NULL,
  `cheque_number` varchar(45) DEFAULT NULL,
  `transaction_cleared_date` varchar(45) DEFAULT NULL,
  `transaction_cleared_month` varchar(45) DEFAULT NULL,
  `vendor` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `allow_edit` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`voucher_id`),
  KEY `fk_voucher_center1_idx` (`center_id`),
  KEY `fk_voucher_voucher_type1_idx` (`voucher_type_id`),
  CONSTRAINT `fk_voucher_center1` FOREIGN KEY (`center_id`) REFERENCES `center` (`center_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_voucher_voucher_type1` FOREIGN KEY (`voucher_type_id`) REFERENCES `voucher_type` (`voucher_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This holds transactions \n';


DROP TABLE IF EXISTS `voucher_detail`;
CREATE TABLE `voucher_detail` (
  `voucher_detail_id` int(100) NOT NULL,
  `voucher_id` int(100) DEFAULT NULL,
  `income_expense_account_id` int(100) DEFAULT NULL COMMENT 'Can be income_account_id or expense_account_id depending on the selected voucher type',
  `quantity` varchar(45) DEFAULT NULL,
  `unit_cost` varchar(45) DEFAULT NULL,
  `total_cost` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `request_detail_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`voucher_detail_id`),
  KEY `fk_voucher_detail_voucher1_idx` (`voucher_id`),
  KEY `fk_voucher_detail_request_detail1_idx` (`request_detail_id`),
  CONSTRAINT `fk_voucher_detail_request_detail1` FOREIGN KEY (`request_detail_id`) REFERENCES `request_detail` (`request_detail_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_voucher_detail_voucher1` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`voucher_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `voucher_type`;
CREATE TABLE `voucher_type` (
  `voucher_type_id` int(100) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `is_active` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `voucher_type_cash_account` varchar(20) DEFAULT NULL COMMENT 'Can either be bank or cash',
  `voucher_type_transaction_effect_id` int(100) DEFAULT NULL COMMENT 'Can be payment or revenue',
  PRIMARY KEY (`voucher_type_id`),
  KEY `fk_voucher_type_voucher_type_transaction_effect1_idx` (`voucher_type_transaction_effect_id`),
  CONSTRAINT `fk_voucher_type_voucher_type_transaction_effect1` FOREIGN KEY (`voucher_type_transaction_effect_id`) REFERENCES `voucher_type_transaction_effect` (`voucher_type_transaction_effect_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `voucher_type_transaction_effect`;
CREATE TABLE `voucher_type_transaction_effect` (
  `voucher_type_transaction_effect_id` int(100) NOT NULL,
  `voucher_type_transaction_effect_name` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `last_modified_date` date DEFAULT NULL,
  `deleted_date` date DEFAULT NULL,
  `created_by` int(100) DEFAULT NULL,
  `last_modified_by` int(100) DEFAULT NULL,
  PRIMARY KEY (`voucher_type_transaction_effect_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- 2019-10-06 20:07:54
