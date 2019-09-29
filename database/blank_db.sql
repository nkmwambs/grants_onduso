-- Adminer 4.6.3 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

CREATE TABLE `approval` (
  `approval_id` int(100) NOT NULL AUTO_INCREMENT,
  `approveable_item_id` int(100) DEFAULT NULL,
  `approveable_table_primary_key` varchar(45) DEFAULT NULL COMMENT 'This is a special foreign key in this table but a primary key in either voucher, request, or budget etc',
  `approval_status_id` int(100) DEFAULT NULL,
  `approved_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`approval_id`),
  KEY `fk_approval_approveable_item1_idx` (`approveable_item_id`),
  KEY `fk_approval_approval_status1_idx` (`approval_status_id`),
  CONSTRAINT `fk_approval_approval_status1` FOREIGN KEY (`approval_status_id`) REFERENCES `approval_status` (`approval_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_approval_approveable_item1` FOREIGN KEY (`approveable_item_id`) REFERENCES `approveable_item` (`approveable_item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DELIMITER ;;

CREATE TRIGGER `approval_AFTER_UPDATE` AFTER UPDATE ON `approval` FOR EACH ROW
BEGIN

END;;

DELIMITER ;

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


CREATE TABLE `approval_status` (
  `approval_status_id` int(100) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
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


CREATE TABLE `approveable_item` (
  `approveable_item_id` int(11) NOT NULL,
  `table_name` varchar(45) DEFAULT NULL,
  `is_active` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`approveable_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `bank` (
  `bank_id` int(100) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `swift_code` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `is_active` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`bank_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table list all the banks for centers';


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


CREATE TABLE `budget` (
  `budget_id` int(100) NOT NULL,
  `center_id` int(100) DEFAULT NULL,
  `budget_year` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`budget_id`),
  KEY `fk_budget_center1_idx` (`center_id`),
  CONSTRAINT `fk_budget_center1` FOREIGN KEY (`center_id`) REFERENCES `center` (`center_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table holds the budget items by activity';


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


CREATE TABLE `center` (
  `center_id` int(100) NOT NULL AUTO_INCREMENT,
  `center_name` varchar(45) NOT NULL,
  `code` varchar(10) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` int(5) NOT NULL DEFAULT '0',
  `created_by` int(100) NOT NULL,
  `created_date` date NOT NULL,
  `last_modified_date` date NOT NULL,
  `last_modified_by` int(100) NOT NULL,
  PRIMARY KEY (`center_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table list all the remote sites for the organization\n';

INSERT INTO `center` (`center_id`, `center_name`, `code`, `start_date`, `end_date`, `is_active`, `created_by`, `created_date`, `last_modified_date`, `last_modified_by`) VALUES
(1,	'Kiserian CDC',	'KE0240',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(2,	'Machakos CDC',	'KE0765',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(3,	'Kilifi CDC',	'KE0340',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(4,	'Mombasa CDC',	'KE0345',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(5,	'Jinja CDC',	'UG0211',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(6,	'Kampala CDC',	'UG0721',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1),
(7,	'Cape CDC',	'HT0422',	'2019-09-27',	'2019-09-27',	1,	1,	'2019-09-27',	'2019-09-27',	1);

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


CREATE TABLE `expense_account` (
  `expense_account_id` int(100) NOT NULL,
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


CREATE TABLE `history` (
  `history_id` int(100) NOT NULL AUTO_INCREMENT,
  `reference_table` varchar(45) DEFAULT NULL,
  `user_id` varchar(45) DEFAULT NULL,
  `table_action` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


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


CREATE TABLE `request` (
  `request_id` int(11) NOT NULL,
  `request_date` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `approval_status_id` int(100) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `role` (
  `role_id` int(100) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_date` varchar(45) DEFAULT NULL,
  `last_modified_date` varchar(45) DEFAULT NULL,
  `last_modified_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `setting` (
  `setting_id` int(11) NOT NULL,
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
(1,	'system_name',	'Staff Recognition System',	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	'system_title',	'Staff Recognition',	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	'address',	'1945 Nairobi',	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	'phone',	'254711808071',	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	'system_email',	'support@compassionkenya.com',	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	'language',	'english',	NULL,	NULL,	NULL,	NULL,	NULL),
(10,	'text_align',	'left-to-right',	NULL,	NULL,	NULL,	NULL,	NULL),
(14,	'skin_colour',	'blue',	NULL,	NULL,	NULL,	NULL,	NULL);

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


CREATE TABLE `user` (
  `user_id` int(100) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `center_group_link_id` int(100) DEFAULT NULL,
  `is_center_group_manager` int(5) DEFAULT NULL,
  `language_id` int(100) DEFAULT NULL COMMENT 'User''s default language',
  PRIMARY KEY (`user_id`),
  KEY `fk_user_center_group_link1_idx` (`center_group_link_id`),
  KEY `fk_user_language1_idx` (`language_id`),
  CONSTRAINT `fk_user_center_group_link1` FOREIGN KEY (`center_group_link_id`) REFERENCES `center_group_link` (`center_group_link_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_language1` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


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


-- 2019-09-29 12:11:09
