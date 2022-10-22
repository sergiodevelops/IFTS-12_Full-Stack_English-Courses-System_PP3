-- Adminer 4.8.1 MySQL 8.0.30 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `grafana`;
CREATE DATABASE `grafana` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `grafana`;

CREATE TABLE `alert` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version` bigint NOT NULL,
  `dashboard_id` bigint NOT NULL,
  `panel_id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` mediumtext COLLATE utf8mb4_unicode_ci,
  `frequency` bigint NOT NULL,
  `handler` bigint NOT NULL,
  `severity` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `silenced` tinyint(1) NOT NULL,
  `execution_error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `eval_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `eval_date` datetime DEFAULT NULL,
  `new_state_date` datetime NOT NULL,
  `state_changes` int NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `for` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_alert_org_id_id` (`org_id`,`id`),
  KEY `IDX_alert_state` (`state`),
  KEY `IDX_alert_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `alert_configuration` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `alertmanager_configuration` mediumtext COLLATE utf8mb4_unicode_ci,
  `configuration_version` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `org_id` bigint NOT NULL DEFAULT '0',
  `configuration_hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not-yet-calculated',
  PRIMARY KEY (`id`),
  KEY `IDX_alert_configuration_org_id` (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `alert_configuration` (`id`, `alertmanager_configuration`, `configuration_version`, `created_at`, `default`, `org_id`, `configuration_hash`) VALUES
(1,	'{\n	\"alertmanager_config\": {\n		\"route\": {\n			\"receiver\": \"grafana-default-email\",\n			\"group_by\": [\"grafana_folder\", \"alertname\"]\n		},\n		\"receivers\": [{\n			\"name\": \"grafana-default-email\",\n			\"grafana_managed_receiver_configs\": [{\n				\"uid\": \"\",\n				\"name\": \"email receiver\",\n				\"type\": \"email\",\n				\"isDefault\": true,\n				\"settings\": {\n					\"addresses\": \"<example@email.com>\"\n				}\n			}]\n		}]\n	}\n}\n',	'v1',	1664531698,	1,	1,	'e0528a75784033ae7b15c40851d89484');

CREATE TABLE `alert_image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_image_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `alert_instance` (
  `rule_org_id` bigint NOT NULL,
  `rule_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `labels` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `labels_hash` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_state` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_state_since` bigint NOT NULL,
  `last_eval_time` bigint NOT NULL,
  `current_state_end` bigint NOT NULL DEFAULT '0',
  `current_reason` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rule_org_id`,`rule_uid`,`labels_hash`),
  KEY `IDX_alert_instance_rule_org_id_rule_uid_current_state` (`rule_org_id`,`rule_uid`,`current_state`),
  KEY `IDX_alert_instance_rule_org_id_current_state` (`rule_org_id`,`current_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `alert_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `frequency` bigint DEFAULT NULL,
  `send_reminder` tinyint(1) DEFAULT '0',
  `disable_resolve_message` tinyint(1) NOT NULL DEFAULT '0',
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secure_settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_notification_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `alert_notification_state` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `alert_id` bigint NOT NULL,
  `notifier_id` bigint NOT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` bigint NOT NULL,
  `updated_at` bigint NOT NULL,
  `alert_rule_state_updated_version` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_notification_state_org_id_alert_id_notifier_id` (`org_id`,`alert_id`,`notifier_id`),
  KEY `IDX_alert_notification_state_alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `alert_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  `updated` datetime NOT NULL,
  `interval_seconds` bigint NOT NULL DEFAULT '60',
  `version` int NOT NULL DEFAULT '0',
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `namespace_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_data_state` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NoData',
  `exec_err_state` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Alerting',
  `for` bigint NOT NULL DEFAULT '0',
  `annotations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `labels` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `dashboard_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `panel_id` bigint DEFAULT NULL,
  `rule_group_idx` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_rule_org_id_uid` (`org_id`,`uid`),
  UNIQUE KEY `UQE_alert_rule_org_id_namespace_uid_title` (`org_id`,`namespace_uid`,`title`),
  KEY `IDX_alert_rule_org_id_namespace_uid_rule_group` (`org_id`,`namespace_uid`,`rule_group`),
  KEY `IDX_alert_rule_org_id_dashboard_uid_panel_id` (`org_id`,`dashboard_uid`,`panel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `alert_rule_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `alert_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_rule_tag_alert_id_tag_id` (`alert_id`,`tag_id`),
  KEY `IDX_alert_rule_tag_alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `alert_rule_version` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rule_org_id` bigint NOT NULL,
  `rule_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `rule_namespace_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_version` int NOT NULL,
  `restored_from` int NOT NULL,
  `version` int NOT NULL,
  `created` datetime NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  `interval_seconds` bigint NOT NULL,
  `no_data_state` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NoData',
  `exec_err_state` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Alerting',
  `for` bigint NOT NULL DEFAULT '0',
  `annotations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `labels` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `rule_group_idx` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_rule_version_rule_org_id_rule_uid_version` (`rule_org_id`,`rule_uid`,`version`),
  KEY `IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group` (`rule_org_id`,`rule_namespace_uid`,`rule_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `annotation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `alert_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `dashboard_id` bigint DEFAULT NULL,
  `panel_id` bigint DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `type` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `metric` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prev_state` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_state` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `epoch` bigint NOT NULL,
  `region_id` bigint DEFAULT '0',
  `tags` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` bigint DEFAULT '0',
  `updated` bigint DEFAULT '0',
  `epoch_end` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_annotation_org_id_alert_id` (`org_id`,`alert_id`),
  KEY `IDX_annotation_org_id_type` (`org_id`,`type`),
  KEY `IDX_annotation_org_id_created` (`org_id`,`created`),
  KEY `IDX_annotation_org_id_updated` (`org_id`,`updated`),
  KEY `IDX_annotation_org_id_dashboard_id_epoch_end_epoch` (`org_id`,`dashboard_id`,`epoch_end`,`epoch`),
  KEY `IDX_annotation_org_id_epoch_end_epoch` (`org_id`,`epoch_end`,`epoch`),
  KEY `IDX_annotation_alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `annotation_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `annotation_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_annotation_tag_annotation_id_tag_id` (`annotation_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `api_key` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `expires` bigint DEFAULT NULL,
  `service_account_id` bigint DEFAULT NULL,
  `last_used_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_api_key_key` (`key`),
  UNIQUE KEY `UQE_api_key_org_id_name` (`org_id`,`name`),
  KEY `IDX_api_key_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `builtin_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `org_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_builtin_role_org_id_role_id_role` (`org_id`,`role_id`,`role`),
  KEY `IDX_builtin_role_role_id` (`role_id`),
  KEY `IDX_builtin_role_role` (`role`),
  KEY `IDX_builtin_role_org_id` (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `builtin_role` (`id`, `role`, `role_id`, `created`, `updated`, `org_id`) VALUES
(1,	'Editor',	2,	'2022-09-30 19:26:37',	'2022-09-30 19:26:37',	1),
(2,	'Viewer',	3,	'2022-09-30 19:26:37',	'2022-09-30 19:26:37',	1);

CREATE TABLE `cache_data` (
  `cache_key` varchar(168) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` blob NOT NULL,
  `expires` int NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`cache_key`),
  UNIQUE KEY `UQE_cache_data_cache_key` (`cache_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `correlation` (
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`uid`,`source_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `dashboard` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL,
  `slug` varchar(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `gnet_id` bigint DEFAULT NULL,
  `plugin_id` varchar(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_id` bigint NOT NULL DEFAULT '0',
  `is_folder` tinyint(1) NOT NULL DEFAULT '0',
  `has_acl` tinyint(1) NOT NULL DEFAULT '0',
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_org_id_folder_id_title` (`org_id`,`folder_id`,`title`),
  UNIQUE KEY `UQE_dashboard_org_id_uid` (`org_id`,`uid`),
  KEY `IDX_dashboard_org_id` (`org_id`),
  KEY `IDX_dashboard_gnet_id` (`gnet_id`),
  KEY `IDX_dashboard_org_id_plugin_id` (`org_id`,`plugin_id`),
  KEY `IDX_dashboard_title` (`title`),
  KEY `IDX_dashboard_is_folder` (`is_folder`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `dashboard` (`id`, `version`, `slug`, `title`, `data`, `org_id`, `created`, `updated`, `updated_by`, `created_by`, `gnet_id`, `plugin_id`, `folder_id`, `is_folder`, `has_acl`, `uid`, `is_public`) VALUES
(1,	4,	'test1',	'Test1',	'{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"id\":1,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"description\":\"\",\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"axisCenteredZero\":false,\"axisColorMode\":\"series\",\"axisPlacement\":\"auto\",\"fillOpacity\":60,\"gradientMode\":\"opacity\",\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false},\"lineWidth\":2,\"scaleDistribution\":{\"log\":2,\"type\":\"log\"}},\"decimals\":0,\"mappings\":[{\"options\":{\"2022\":{\"color\":\"orange\",\"index\":0}},\"type\":\"value\"}],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"purple\",\"value\":null}]},\"unit\":\"none\"},\"overrides\":[{\"matcher\":{\"id\":\"byName\",\"options\":\"metric\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"yellow\",\"mode\":\"palette-classic\"}}]},{\"matcher\":{\"id\":\"byName\",\"options\":\"Año\"},\"properties\":[{\"id\":\"custom.axisLabel\",\"value\":\"Año\"}]},{\"matcher\":{\"id\":\"byName\",\"options\":\"metric\"},\"properties\":[{\"id\":\"custom.axisPlacement\",\"value\":\"hidden\"}]}]},\"gridPos\":{\"h\":8,\"w\":12,\"x\":0,\"y\":0},\"id\":4,\"options\":{\"barRadius\":0,\"barWidth\":0.97,\"colorByField\":\"Año\",\"groupWidth\":0.7,\"legend\":{\"calcs\":[],\"displayMode\":\"list\",\"placement\":\"right\",\"showLegend\":false},\"orientation\":\"auto\",\"showValue\":\"auto\",\"stacking\":\"none\",\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"},\"xField\":\"Año\",\"xTickLabelRotation\":0,\"xTickLabelSpacing\":0},\"targets\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"table\",\"group\":[],\"metricColumn\":\"fecha\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  YEAR(fecha) AS Año,\\n  count(1) AS metric\\nFROM Matricula\\nGROUP BY YEAR(fecha)\\nORDER BY metric\",\"refId\":\"A\",\"select\":[[{\"params\":[\"id\"],\"type\":\"column\"}]],\"table\":\"Matricula\",\"timeColumn\":\"fecha_alta\",\"timeColumnType\":\"timestamp\",\"where\":[]}],\"title\":\"Inscriptos por Año\",\"type\":\"barchart\"},{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"description\":\"\",\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false}},\"mappings\":[],\"unit\":\"none\"},\"overrides\":[{\"matcher\":{\"id\":\"byName\",\"options\":\"Administrativo\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#bf696e\",\"mode\":\"fixed\"}}]},{\"matcher\":{\"id\":\"byName\",\"options\":\"Alumno\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#d52727\",\"mode\":\"fixed\"}}]}]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":8},\"id\":2,\"options\":{\"displayLabels\":[\"percent\"],\"legend\":{\"displayMode\":\"list\",\"placement\":\"right\",\"showLegend\":true,\"values\":[]},\"pieType\":\"pie\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":true},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"pluginVersion\":\"9.1.6\",\"targets\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"table\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  --NOW() as time_sec,\\n  case \\n    when es_admin = 1 then \'Administrativo\'\\n    when es_admin = 2 then \'Docente\'\\n    when es_admin = 3 then \'Alumno\'\\n  END metric,\\n  count(1) as value\\nFROM Usuario\\nGROUP BY es_admin\\nORDER BY count(1)\",\"refId\":\"A\",\"select\":[[{\"params\":[\"es_admin\"],\"type\":\"column\"}]],\"table\":\"Usuario\",\"timeColumn\":\"IdUsuario\",\"timeColumnType\":\"int\",\"where\":[{\"name\":\"$__unixEpochFilter\",\"params\":[],\"type\":\"macro\"}]}],\"title\":\"Usuarios Registrados\",\"type\":\"piechart\"}],\"schemaVersion\":37,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Test1\",\"uid\":\"CPMWPd44z\",\"version\":4,\"weekStart\":\"\"}',	1,	'2022-09-30 19:26:37',	'2022-10-01 01:20:49',	1,	1,	0,	'',	0,	0,	0,	'CPMWPd44z',	0);

CREATE TABLE `dashboard_acl` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `dashboard_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `team_id` bigint DEFAULT NULL,
  `permission` smallint NOT NULL DEFAULT '4',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_acl_dashboard_id_user_id` (`dashboard_id`,`user_id`),
  UNIQUE KEY `UQE_dashboard_acl_dashboard_id_team_id` (`dashboard_id`,`team_id`),
  KEY `IDX_dashboard_acl_dashboard_id` (`dashboard_id`),
  KEY `IDX_dashboard_acl_user_id` (`user_id`),
  KEY `IDX_dashboard_acl_team_id` (`team_id`),
  KEY `IDX_dashboard_acl_org_id_role` (`org_id`,`role`),
  KEY `IDX_dashboard_acl_permission` (`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `dashboard_acl` (`id`, `org_id`, `dashboard_id`, `user_id`, `team_id`, `permission`, `role`, `created`, `updated`) VALUES
(1,	-1,	-1,	NULL,	NULL,	1,	'Viewer',	'2017-06-20 00:00:00',	'2017-06-20 00:00:00'),
(2,	-1,	-1,	NULL,	NULL,	2,	'Editor',	'2017-06-20 00:00:00',	'2017-06-20 00:00:00');

CREATE TABLE `dashboard_provisioning` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint DEFAULT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `external_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` int NOT NULL DEFAULT '0',
  `check_sum` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_dashboard_provisioning_dashboard_id` (`dashboard_id`),
  KEY `IDX_dashboard_provisioning_dashboard_id_name` (`dashboard_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `dashboard_public` (
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dashboard_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `time_settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `template_variables` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `access_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  `updated_by` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `UQE_dashboard_public_config_uid` (`uid`),
  UNIQUE KEY `UQE_dashboard_public_config_access_token` (`access_token`),
  KEY `IDX_dashboard_public_config_org_id_dashboard_uid` (`org_id`,`dashboard_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `dashboard_snapshot` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `delete_key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `external` tinyint(1) NOT NULL,
  `external_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dashboard` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `external_delete_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboard_encrypted` mediumblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_snapshot_key` (`key`),
  UNIQUE KEY `UQE_dashboard_snapshot_delete_key` (`delete_key`),
  KEY `IDX_dashboard_snapshot_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `dashboard_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint NOT NULL,
  `term` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_dashboard_tag_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `dashboard_version` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint NOT NULL,
  `parent_version` int NOT NULL,
  `restored_from` int NOT NULL,
  `version` int NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_version_dashboard_id_version` (`dashboard_id`,`version`),
  KEY `IDX_dashboard_version_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `dashboard_version` (`id`, `dashboard_id`, `parent_version`, `restored_from`, `version`, `created`, `created_by`, `message`, `data`) VALUES
(1,	1,	0,	0,	1,	'2022-09-30 19:26:37',	1,	'',	'{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"id\":null,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false}},\"mappings\":[],\"unit\":\"none\"},\"overrides\":[{\"matcher\":{\"id\":\"byName\",\"options\":\"Administrativo\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#bf696e\",\"mode\":\"fixed\"}}]},{\"matcher\":{\"id\":\"byName\",\"options\":\"Alumno\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#d52727\",\"mode\":\"fixed\"}}]}]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"id\":2,\"options\":{\"displayLabels\":[\"percent\"],\"legend\":{\"displayMode\":\"list\",\"placement\":\"right\",\"showLegend\":true,\"values\":[]},\"pieType\":\"pie\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":true},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"pluginVersion\":\"9.1.6\",\"targets\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"table\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  --NOW() as time_sec,\\n  case \\n    when es_admin = 1 then \'Administrativo\'\\n    when es_admin = 2 then \'Docente\'\\n    when es_admin = 3 then \'Alumno\'\\n  END metric,\\n  count(1) as value\\nFROM Usuario\\nGROUP BY es_admin\\nORDER BY count(1)\",\"refId\":\"A\",\"select\":[[{\"params\":[\"es_admin\"],\"type\":\"column\"}]],\"table\":\"Usuario\",\"timeColumn\":\"IdUsuario\",\"timeColumnType\":\"int\",\"where\":[{\"name\":\"$__unixEpochFilter\",\"params\":[],\"type\":\"macro\"}]}],\"title\":\"Panel Title\",\"type\":\"piechart\"}],\"schemaVersion\":37,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Test1\",\"uid\":\"CPMWPd44z\",\"version\":1,\"weekStart\":\"\"}'),
(2,	1,	1,	0,	2,	'2022-10-01 00:58:14',	1,	'',	'{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"id\":1,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"description\":\"\",\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"continuous-GrYlRd\"},\"custom\":{\"axisCenteredZero\":false,\"axisColorMode\":\"series\",\"axisLabel\":\"\",\"axisPlacement\":\"auto\",\"fillOpacity\":80,\"gradientMode\":\"none\",\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false},\"lineWidth\":1,\"scaleDistribution\":{\"type\":\"linear\"}},\"mappings\":[{\"options\":{\"2022\":{\"color\":\"orange\",\"index\":0}},\"type\":\"value\"}],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"yellow\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[{\"matcher\":{\"id\":\"byName\",\"options\":\"metric\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"yellow\",\"mode\":\"fixed\"}}]}]},\"gridPos\":{\"h\":8,\"w\":12,\"x\":0,\"y\":0},\"id\":4,\"options\":{\"barRadius\":0,\"barWidth\":0.97,\"colorByField\":\"value\",\"groupWidth\":0.7,\"legend\":{\"calcs\":[],\"displayMode\":\"list\",\"placement\":\"right\",\"showLegend\":true},\"orientation\":\"auto\",\"showValue\":\"auto\",\"stacking\":\"none\",\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"},\"xField\":\"value\",\"xTickLabelRotation\":0,\"xTickLabelSpacing\":0},\"targets\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"table\",\"group\":[],\"metricColumn\":\"fecha\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  YEAR(fecha) AS value,\\n  count(1) AS metric\\nFROM Matricula\\nGROUP BY YEAR(fecha)\\nORDER BY metric\",\"refId\":\"A\",\"select\":[[{\"params\":[\"id\"],\"type\":\"column\"}]],\"table\":\"Matricula\",\"timeColumn\":\"fecha_alta\",\"timeColumnType\":\"timestamp\",\"where\":[]}],\"title\":\"Inscriptos por Año\",\"type\":\"barchart\"},{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false}},\"mappings\":[],\"unit\":\"none\"},\"overrides\":[{\"matcher\":{\"id\":\"byName\",\"options\":\"Administrativo\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#bf696e\",\"mode\":\"fixed\"}}]},{\"matcher\":{\"id\":\"byName\",\"options\":\"Alumno\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#d52727\",\"mode\":\"fixed\"}}]}]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":8},\"id\":2,\"options\":{\"displayLabels\":[\"percent\"],\"legend\":{\"displayMode\":\"list\",\"placement\":\"right\",\"showLegend\":true,\"values\":[]},\"pieType\":\"pie\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":true},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"pluginVersion\":\"9.1.6\",\"targets\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"table\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  --NOW() as time_sec,\\n  case \\n    when es_admin = 1 then \'Administrativo\'\\n    when es_admin = 2 then \'Docente\'\\n    when es_admin = 3 then \'Alumno\'\\n  END metric,\\n  count(1) as value\\nFROM Usuario\\nGROUP BY es_admin\\nORDER BY count(1)\",\"refId\":\"A\",\"select\":[[{\"params\":[\"es_admin\"],\"type\":\"column\"}]],\"table\":\"Usuario\",\"timeColumn\":\"IdUsuario\",\"timeColumnType\":\"int\",\"where\":[{\"name\":\"$__unixEpochFilter\",\"params\":[],\"type\":\"macro\"}]}],\"title\":\"Panel Title\",\"type\":\"piechart\"}],\"schemaVersion\":37,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Test1\",\"uid\":\"CPMWPd44z\",\"version\":2,\"weekStart\":\"\"}'),
(3,	1,	2,	0,	3,	'2022-10-01 01:00:30',	1,	'',	'{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"id\":1,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"description\":\"\",\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"continuous-GrYlRd\"},\"custom\":{\"axisCenteredZero\":false,\"axisColorMode\":\"series\",\"axisLabel\":\"\",\"axisPlacement\":\"auto\",\"fillOpacity\":80,\"gradientMode\":\"none\",\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false},\"lineWidth\":1,\"scaleDistribution\":{\"type\":\"linear\"}},\"mappings\":[{\"options\":{\"2022\":{\"color\":\"orange\",\"index\":0}},\"type\":\"value\"}],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"yellow\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[{\"matcher\":{\"id\":\"byName\",\"options\":\"metric\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"yellow\",\"mode\":\"fixed\"}}]}]},\"gridPos\":{\"h\":8,\"w\":12,\"x\":0,\"y\":0},\"id\":4,\"options\":{\"barRadius\":0,\"barWidth\":0.97,\"colorByField\":\"value\",\"groupWidth\":0.7,\"legend\":{\"calcs\":[],\"displayMode\":\"list\",\"placement\":\"right\",\"showLegend\":true},\"orientation\":\"auto\",\"showValue\":\"auto\",\"stacking\":\"none\",\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"},\"xField\":\"value\",\"xTickLabelRotation\":0,\"xTickLabelSpacing\":0},\"targets\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"table\",\"group\":[],\"metricColumn\":\"fecha\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  YEAR(fecha) AS value,\\n  count(1) AS metric\\nFROM Matricula\\nGROUP BY YEAR(fecha)\\nORDER BY metric\",\"refId\":\"A\",\"select\":[[{\"params\":[\"id\"],\"type\":\"column\"}]],\"table\":\"Matricula\",\"timeColumn\":\"fecha_alta\",\"timeColumnType\":\"timestamp\",\"where\":[]}],\"title\":\"Inscriptos por Año\",\"type\":\"barchart\"},{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"description\":\"\",\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false}},\"mappings\":[],\"unit\":\"none\"},\"overrides\":[{\"matcher\":{\"id\":\"byName\",\"options\":\"Administrativo\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#bf696e\",\"mode\":\"fixed\"}}]},{\"matcher\":{\"id\":\"byName\",\"options\":\"Alumno\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#d52727\",\"mode\":\"fixed\"}}]}]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":8},\"id\":2,\"options\":{\"displayLabels\":[\"percent\"],\"legend\":{\"displayMode\":\"list\",\"placement\":\"right\",\"showLegend\":true,\"values\":[]},\"pieType\":\"pie\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":true},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"pluginVersion\":\"9.1.6\",\"targets\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"table\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  --NOW() as time_sec,\\n  case \\n    when es_admin = 1 then \'Administrativo\'\\n    when es_admin = 2 then \'Docente\'\\n    when es_admin = 3 then \'Alumno\'\\n  END metric,\\n  count(1) as value\\nFROM Usuario\\nGROUP BY es_admin\\nORDER BY count(1)\",\"refId\":\"A\",\"select\":[[{\"params\":[\"es_admin\"],\"type\":\"column\"}]],\"table\":\"Usuario\",\"timeColumn\":\"IdUsuario\",\"timeColumnType\":\"int\",\"where\":[{\"name\":\"$__unixEpochFilter\",\"params\":[],\"type\":\"macro\"}]}],\"title\":\"Usuarios Registrados\",\"type\":\"piechart\"}],\"schemaVersion\":37,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Test1\",\"uid\":\"CPMWPd44z\",\"version\":3,\"weekStart\":\"\"}'),
(4,	1,	3,	0,	4,	'2022-10-01 01:20:49',	1,	'',	'{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"id\":1,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"description\":\"\",\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"axisCenteredZero\":false,\"axisColorMode\":\"series\",\"axisPlacement\":\"auto\",\"fillOpacity\":60,\"gradientMode\":\"opacity\",\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false},\"lineWidth\":2,\"scaleDistribution\":{\"log\":2,\"type\":\"log\"}},\"decimals\":0,\"mappings\":[{\"options\":{\"2022\":{\"color\":\"orange\",\"index\":0}},\"type\":\"value\"}],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"purple\",\"value\":null}]},\"unit\":\"none\"},\"overrides\":[{\"matcher\":{\"id\":\"byName\",\"options\":\"metric\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"yellow\",\"mode\":\"palette-classic\"}}]},{\"matcher\":{\"id\":\"byName\",\"options\":\"Año\"},\"properties\":[{\"id\":\"custom.axisLabel\",\"value\":\"Año\"}]},{\"matcher\":{\"id\":\"byName\",\"options\":\"metric\"},\"properties\":[{\"id\":\"custom.axisPlacement\",\"value\":\"hidden\"}]}]},\"gridPos\":{\"h\":8,\"w\":12,\"x\":0,\"y\":0},\"id\":4,\"options\":{\"barRadius\":0,\"barWidth\":0.97,\"colorByField\":\"Año\",\"groupWidth\":0.7,\"legend\":{\"calcs\":[],\"displayMode\":\"list\",\"placement\":\"right\",\"showLegend\":false},\"orientation\":\"auto\",\"showValue\":\"auto\",\"stacking\":\"none\",\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"},\"xField\":\"Año\",\"xTickLabelRotation\":0,\"xTickLabelSpacing\":0},\"targets\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"table\",\"group\":[],\"metricColumn\":\"fecha\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  YEAR(fecha) AS Año,\\n  count(1) AS metric\\nFROM Matricula\\nGROUP BY YEAR(fecha)\\nORDER BY metric\",\"refId\":\"A\",\"select\":[[{\"params\":[\"id\"],\"type\":\"column\"}]],\"table\":\"Matricula\",\"timeColumn\":\"fecha_alta\",\"timeColumnType\":\"timestamp\",\"where\":[]}],\"title\":\"Inscriptos por Año\",\"type\":\"barchart\"},{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"description\":\"\",\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false}},\"mappings\":[],\"unit\":\"none\"},\"overrides\":[{\"matcher\":{\"id\":\"byName\",\"options\":\"Administrativo\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#bf696e\",\"mode\":\"fixed\"}}]},{\"matcher\":{\"id\":\"byName\",\"options\":\"Alumno\"},\"properties\":[{\"id\":\"color\",\"value\":{\"fixedColor\":\"#d52727\",\"mode\":\"fixed\"}}]}]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":8},\"id\":2,\"options\":{\"displayLabels\":[\"percent\"],\"legend\":{\"displayMode\":\"list\",\"placement\":\"right\",\"showLegend\":true,\"values\":[]},\"pieType\":\"pie\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":true},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"pluginVersion\":\"9.1.6\",\"targets\":[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"table\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  --NOW() as time_sec,\\n  case \\n    when es_admin = 1 then \'Administrativo\'\\n    when es_admin = 2 then \'Docente\'\\n    when es_admin = 3 then \'Alumno\'\\n  END metric,\\n  count(1) as value\\nFROM Usuario\\nGROUP BY es_admin\\nORDER BY count(1)\",\"refId\":\"A\",\"select\":[[{\"params\":[\"es_admin\"],\"type\":\"column\"}]],\"table\":\"Usuario\",\"timeColumn\":\"IdUsuario\",\"timeColumnType\":\"int\",\"where\":[{\"name\":\"$__unixEpochFilter\",\"params\":[],\"type\":\"macro\"}]}],\"title\":\"Usuarios Registrados\",\"type\":\"piechart\"}],\"schemaVersion\":37,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Test1\",\"uid\":\"CPMWPd44z\",\"version\":4,\"weekStart\":\"\"}');

CREATE TABLE `data_keys` (
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `scope` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `encrypted_data` blob NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `data_keys` (`name`, `active`, `scope`, `provider`, `encrypted_data`, `created`, `updated`, `label`) VALUES
('e8w0kdVVz',	1,	'root',	'secretKey.v1',	'lEgKLXnyl�>���{7Q�d��\0\Ziy�FD+n�}q��\'d',	'2022-09-30 13:27:04',	'2022-09-30 13:27:04',	'2022-09-30/root@secretKey.v1');

CREATE TABLE `data_source` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `version` int NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `database` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_auth` tinyint(1) NOT NULL,
  `basic_auth_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_auth_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL,
  `json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `with_credentials` tinyint(1) NOT NULL DEFAULT '0',
  `secure_json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `read_only` tinyint(1) DEFAULT NULL,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_data_source_org_id_name` (`org_id`,`name`),
  UNIQUE KEY `UQE_data_source_org_id_uid` (`org_id`,`uid`),
  KEY `IDX_data_source_org_id` (`org_id`),
  KEY `IDX_data_source_org_id_is_default` (`org_id`,`is_default`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `data_source` (`id`, `org_id`, `version`, `type`, `name`, `access`, `url`, `password`, `user`, `database`, `basic_auth`, `basic_auth_user`, `basic_auth_password`, `is_default`, `json_data`, `created`, `updated`, `with_credentials`, `secure_json_data`, `read_only`, `uid`) VALUES
(1,	1,	4,	'mysql',	'Institutoidiomas',	'proxy',	'mysql_service_main:3306',	'',	'root',	'InstitutoIdiomas',	0,	'',	'',	1,	'{\"maxOpenConns\":10,\"timezone\":\"America/Argentina/Buenos_Aires\"}',	'2022-09-30 13:27:04',	'2022-09-30 13:35:05',	0,	'{\"password\":\"I1pUaDNNR3RrVmxaNiNzYW5jQ3kxQp/zFYm/SMp/BeqciN3p/cp/rTjB\"}',	0,	'7UwAkOVVk');

CREATE TABLE `entity_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `file` (
  `path` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_folder_path_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contents` blob NOT NULL,
  `etag` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cache_control` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_disposition` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  `size` bigint NOT NULL,
  `mime_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `UQE_file_path_hash` (`path_hash`),
  KEY `IDX_file_parent_folder_path_hash` (`parent_folder_path_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `file_meta` (
  `path_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `UQE_file_meta_path_hash_key` (`path_hash`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `kv_store` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `namespace` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_kv_store_org_id_namespace_key` (`org_id`,`namespace`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `kv_store` (`id`, `org_id`, `namespace`, `key`, `value`, `created`, `updated`) VALUES
(1,	0,	'datasource',	'secretMigrationStatus',	'compatible',	'2022-09-30 09:54:59',	'2022-09-30 09:54:59'),
(2,	1,	'alertmanager',	'notifications',	'',	'2022-09-30 10:09:58',	'2022-09-30 10:09:58'),
(3,	1,	'alertmanager',	'silences',	'',	'2022-09-30 10:09:58',	'2022-09-30 10:09:58');

CREATE TABLE `library_element` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `folder_id` bigint NOT NULL,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kind` bigint NOT NULL,
  `type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` bigint NOT NULL,
  `version` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_library_element_org_id_folder_id_name_kind` (`org_id`,`folder_id`,`name`,`kind`),
  UNIQUE KEY `UQE_library_element_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `library_element_connection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `element_id` bigint NOT NULL,
  `kind` bigint NOT NULL,
  `connection_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_library_element_connection_element_id_kind_connection_id` (`element_id`,`kind`,`connection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `login_attempt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_login_attempt_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `migration_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `migration_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sql` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `success` tinyint(1) NOT NULL,
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=451 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES
(1,	'create migration_log table',	'CREATE TABLE IF NOT EXISTS `migration_log` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `migration_id` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `sql` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `success` TINYINT(1) NOT NULL\n, `error` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `timestamp` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:39:19'),
(2,	'create user table',	'CREATE TABLE IF NOT EXISTS `user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `login` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `salt` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `rands` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `company` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `account_id` BIGINT(20) NOT NULL\n, `is_admin` TINYINT(1) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:39:29'),
(3,	'add unique index user.login',	'CREATE UNIQUE INDEX `UQE_user_login` ON `user` (`login`);',	1,	'',	'2022-09-30 09:39:33'),
(4,	'add unique index user.email',	'CREATE UNIQUE INDEX `UQE_user_email` ON `user` (`email`);',	1,	'',	'2022-09-30 09:39:34'),
(5,	'drop index UQE_user_login - v1',	'DROP INDEX `UQE_user_login` ON `user`',	1,	'',	'2022-09-30 09:39:37'),
(6,	'drop index UQE_user_email - v1',	'DROP INDEX `UQE_user_email` ON `user`',	1,	'',	'2022-09-30 09:39:39'),
(7,	'Rename table user to user_v1 - v1',	'ALTER TABLE `user` RENAME TO `user_v1`',	1,	'',	'2022-09-30 09:39:43'),
(8,	'create user table v2',	'CREATE TABLE IF NOT EXISTS `user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `login` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `salt` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `rands` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `company` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `org_id` BIGINT(20) NOT NULL\n, `is_admin` TINYINT(1) NOT NULL\n, `email_verified` TINYINT(1) NULL\n, `theme` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:39:45'),
(9,	'create index UQE_user_login - v2',	'CREATE UNIQUE INDEX `UQE_user_login` ON `user` (`login`);',	1,	'',	'2022-09-30 09:39:49'),
(10,	'create index UQE_user_email - v2',	'CREATE UNIQUE INDEX `UQE_user_email` ON `user` (`email`);',	1,	'',	'2022-09-30 09:39:52'),
(11,	'copy data_source v1 to v2',	'INSERT INTO `user` (`version`\n, `name`\n, `salt`\n, `org_id`\n, `updated`\n, `created`\n, `id`\n, `login`\n, `email`\n, `password`\n, `rands`\n, `company`\n, `is_admin`) SELECT `version`\n, `name`\n, `salt`\n, `account_id`\n, `updated`\n, `created`\n, `id`\n, `login`\n, `email`\n, `password`\n, `rands`\n, `company`\n, `is_admin` FROM `user_v1`',	1,	'',	'2022-09-30 09:39:55'),
(12,	'Drop old table user_v1',	'DROP TABLE IF EXISTS `user_v1`',	1,	'',	'2022-09-30 09:39:56'),
(13,	'Add column help_flags1 to user table',	'alter table `user` ADD COLUMN `help_flags1` BIGINT(20) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:39:58'),
(14,	'Update user table charset',	'ALTER TABLE `user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `login` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `salt` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `rands` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `company` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `theme` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',	1,	'',	'2022-09-30 09:40:00'),
(15,	'Add last_seen_at column to user',	'alter table `user` ADD COLUMN `last_seen_at` DATETIME NULL ',	1,	'',	'2022-09-30 09:40:00'),
(16,	'Add missing user data',	'code migration',	1,	'',	'2022-09-30 09:40:02'),
(17,	'Add is_disabled column to user',	'alter table `user` ADD COLUMN `is_disabled` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:40:02'),
(18,	'Add index user.login/user.email',	'CREATE INDEX `IDX_user_login_email` ON `user` (`login`,`email`);',	1,	'',	'2022-09-30 09:40:04'),
(19,	'Add is_service_account column to user',	'alter table `user` ADD COLUMN `is_service_account` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:40:05'),
(20,	'Update is_service_account column to nullable',	'ALTER TABLE user MODIFY is_service_account BOOLEAN DEFAULT 0;',	1,	'',	'2022-09-30 09:40:08'),
(21,	'create temp user table v1-7',	'CREATE TABLE IF NOT EXISTS `temp_user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `code` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `status` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `invited_by_user_id` BIGINT(20) NULL\n, `email_sent` TINYINT(1) NOT NULL\n, `email_sent_on` DATETIME NULL\n, `remote_addr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:40:12'),
(22,	'create index IDX_temp_user_email - v1-7',	'CREATE INDEX `IDX_temp_user_email` ON `temp_user` (`email`);',	1,	'',	'2022-09-30 09:40:18'),
(23,	'create index IDX_temp_user_org_id - v1-7',	'CREATE INDEX `IDX_temp_user_org_id` ON `temp_user` (`org_id`);',	1,	'',	'2022-09-30 09:40:21'),
(24,	'create index IDX_temp_user_code - v1-7',	'CREATE INDEX `IDX_temp_user_code` ON `temp_user` (`code`);',	1,	'',	'2022-09-30 09:40:24'),
(25,	'create index IDX_temp_user_status - v1-7',	'CREATE INDEX `IDX_temp_user_status` ON `temp_user` (`status`);',	1,	'',	'2022-09-30 09:40:27'),
(26,	'Update temp_user table charset',	'ALTER TABLE `temp_user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `code` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `status` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `remote_addr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',	1,	'',	'2022-09-30 09:40:31'),
(27,	'drop index IDX_temp_user_email - v1',	'DROP INDEX `IDX_temp_user_email` ON `temp_user`',	1,	'',	'2022-09-30 09:40:33'),
(28,	'drop index IDX_temp_user_org_id - v1',	'DROP INDEX `IDX_temp_user_org_id` ON `temp_user`',	1,	'',	'2022-09-30 09:40:36'),
(29,	'drop index IDX_temp_user_code - v1',	'DROP INDEX `IDX_temp_user_code` ON `temp_user`',	1,	'',	'2022-09-30 09:40:37'),
(30,	'drop index IDX_temp_user_status - v1',	'DROP INDEX `IDX_temp_user_status` ON `temp_user`',	1,	'',	'2022-09-30 09:40:39'),
(31,	'Rename table temp_user to temp_user_tmp_qwerty - v1',	'ALTER TABLE `temp_user` RENAME TO `temp_user_tmp_qwerty`',	1,	'',	'2022-09-30 09:40:42'),
(32,	'create temp_user v2',	'CREATE TABLE IF NOT EXISTS `temp_user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `code` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `status` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `invited_by_user_id` BIGINT(20) NULL\n, `email_sent` TINYINT(1) NOT NULL\n, `email_sent_on` DATETIME NULL\n, `remote_addr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` INT NOT NULL DEFAULT 0\n, `updated` INT NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:40:46'),
(33,	'create index IDX_temp_user_email - v2',	'CREATE INDEX `IDX_temp_user_email` ON `temp_user` (`email`);',	1,	'',	'2022-09-30 09:40:51'),
(34,	'create index IDX_temp_user_org_id - v2',	'CREATE INDEX `IDX_temp_user_org_id` ON `temp_user` (`org_id`);',	1,	'',	'2022-09-30 09:40:54'),
(35,	'create index IDX_temp_user_code - v2',	'CREATE INDEX `IDX_temp_user_code` ON `temp_user` (`code`);',	1,	'',	'2022-09-30 09:40:56'),
(36,	'create index IDX_temp_user_status - v2',	'CREATE INDEX `IDX_temp_user_status` ON `temp_user` (`status`);',	1,	'',	'2022-09-30 09:40:57'),
(37,	'copy temp_user v1 to v2',	'INSERT INTO `temp_user` (`role`\n, `invited_by_user_id`\n, `id`\n, `name`\n, `email`\n, `code`\n, `status`\n, `email_sent`\n, `email_sent_on`\n, `remote_addr`\n, `org_id`\n, `version`) SELECT `role`\n, `invited_by_user_id`\n, `id`\n, `name`\n, `email`\n, `code`\n, `status`\n, `email_sent`\n, `email_sent_on`\n, `remote_addr`\n, `org_id`\n, `version` FROM `temp_user_tmp_qwerty`',	1,	'',	'2022-09-30 09:41:02'),
(38,	'drop temp_user_tmp_qwerty',	'DROP TABLE IF EXISTS `temp_user_tmp_qwerty`',	1,	'',	'2022-09-30 09:41:02'),
(39,	'Set created for temp users that will otherwise prematurely expire',	'code migration',	1,	'',	'2022-09-30 09:41:04'),
(40,	'create star table',	'CREATE TABLE IF NOT EXISTS `star` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:41:04'),
(41,	'add unique index star.user_id_dashboard_id',	'CREATE UNIQUE INDEX `UQE_star_user_id_dashboard_id` ON `star` (`user_id`,`dashboard_id`);',	1,	'',	'2022-09-30 09:41:07'),
(42,	'create org table v1',	'CREATE TABLE IF NOT EXISTS `org` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `address1` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `address2` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `city` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `state` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `zip_code` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `country` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `billing_email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:41:09'),
(43,	'create index UQE_org_name - v1',	'CREATE UNIQUE INDEX `UQE_org_name` ON `org` (`name`);',	1,	'',	'2022-09-30 09:41:14'),
(44,	'create org_user table v1',	'CREATE TABLE IF NOT EXISTS `org_user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:41:19'),
(45,	'create index IDX_org_user_org_id - v1',	'CREATE INDEX `IDX_org_user_org_id` ON `org_user` (`org_id`);',	1,	'',	'2022-09-30 09:41:25'),
(46,	'create index UQE_org_user_org_id_user_id - v1',	'CREATE UNIQUE INDEX `UQE_org_user_org_id_user_id` ON `org_user` (`org_id`,`user_id`);',	1,	'',	'2022-09-30 09:41:28'),
(47,	'create index IDX_org_user_user_id - v1',	'CREATE INDEX `IDX_org_user_user_id` ON `org_user` (`user_id`);',	1,	'',	'2022-09-30 09:41:32'),
(48,	'Update org table charset',	'ALTER TABLE `org` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `address1` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `address2` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `city` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `state` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `zip_code` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `country` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `billing_email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',	1,	'',	'2022-09-30 09:41:38'),
(49,	'Update org_user table charset',	'ALTER TABLE `org_user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:41:43'),
(50,	'Migrate all Read Only Viewers to Viewers',	'UPDATE org_user SET role = \'Viewer\' WHERE role = \'Read Only Editor\'',	1,	'',	'2022-09-30 09:41:45'),
(51,	'create dashboard table',	'CREATE TABLE IF NOT EXISTS `dashboard` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `slug` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `account_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:41:45'),
(52,	'add index dashboard.account_id',	'CREATE INDEX `IDX_dashboard_account_id` ON `dashboard` (`account_id`);',	1,	'',	'2022-09-30 09:41:49'),
(53,	'add unique index dashboard_account_id_slug',	'CREATE UNIQUE INDEX `UQE_dashboard_account_id_slug` ON `dashboard` (`account_id`,`slug`);',	1,	'',	'2022-09-30 09:41:51'),
(54,	'create dashboard_tag table',	'CREATE TABLE IF NOT EXISTS `dashboard_tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `term` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:41:54'),
(55,	'add unique index dashboard_tag.dasboard_id_term',	'CREATE UNIQUE INDEX `UQE_dashboard_tag_dashboard_id_term` ON `dashboard_tag` (`dashboard_id`,`term`);',	1,	'',	'2022-09-30 09:41:59'),
(56,	'drop index UQE_dashboard_tag_dashboard_id_term - v1',	'DROP INDEX `UQE_dashboard_tag_dashboard_id_term` ON `dashboard_tag`',	1,	'',	'2022-09-30 09:42:05'),
(57,	'Rename table dashboard to dashboard_v1 - v1',	'ALTER TABLE `dashboard` RENAME TO `dashboard_v1`',	1,	'',	'2022-09-30 09:42:07'),
(58,	'create dashboard v2',	'CREATE TABLE IF NOT EXISTS `dashboard` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `slug` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:42:11'),
(59,	'create index IDX_dashboard_org_id - v2',	'CREATE INDEX `IDX_dashboard_org_id` ON `dashboard` (`org_id`);',	1,	'',	'2022-09-30 09:42:18'),
(60,	'create index UQE_dashboard_org_id_slug - v2',	'CREATE UNIQUE INDEX `UQE_dashboard_org_id_slug` ON `dashboard` (`org_id`,`slug`);',	1,	'',	'2022-09-30 09:42:21'),
(61,	'copy dashboard v1 to v2',	'INSERT INTO `dashboard` (`updated`\n, `id`\n, `version`\n, `slug`\n, `title`\n, `data`\n, `org_id`\n, `created`) SELECT `updated`\n, `id`\n, `version`\n, `slug`\n, `title`\n, `data`\n, `account_id`\n, `created` FROM `dashboard_v1`',	1,	'',	'2022-09-30 09:42:24'),
(62,	'drop table dashboard_v1',	'DROP TABLE IF EXISTS `dashboard_v1`',	1,	'',	'2022-09-30 09:42:24'),
(63,	'alter dashboard.data to mediumtext v1',	'ALTER TABLE dashboard MODIFY data MEDIUMTEXT;',	1,	'',	'2022-09-30 09:42:27'),
(64,	'Add column updated_by in dashboard - v2',	'alter table `dashboard` ADD COLUMN `updated_by` INT NULL ',	1,	'',	'2022-09-30 09:42:36'),
(65,	'Add column created_by in dashboard - v2',	'alter table `dashboard` ADD COLUMN `created_by` INT NULL ',	1,	'',	'2022-09-30 09:42:39'),
(66,	'Add column gnetId in dashboard',	'alter table `dashboard` ADD COLUMN `gnet_id` BIGINT(20) NULL ',	1,	'',	'2022-09-30 09:42:42'),
(67,	'Add index for gnetId in dashboard',	'CREATE INDEX `IDX_dashboard_gnet_id` ON `dashboard` (`gnet_id`);',	1,	'',	'2022-09-30 09:42:45'),
(68,	'Add column plugin_id in dashboard',	'alter table `dashboard` ADD COLUMN `plugin_id` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:42:47'),
(69,	'Add index for plugin_id in dashboard',	'CREATE INDEX `IDX_dashboard_org_id_plugin_id` ON `dashboard` (`org_id`,`plugin_id`);',	1,	'',	'2022-09-30 09:42:50'),
(70,	'Add index for dashboard_id in dashboard_tag',	'CREATE INDEX `IDX_dashboard_tag_dashboard_id` ON `dashboard_tag` (`dashboard_id`);',	1,	'',	'2022-09-30 09:42:52'),
(71,	'Update dashboard table charset',	'ALTER TABLE `dashboard` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `slug` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `plugin_id` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `data` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:42:54'),
(72,	'Update dashboard_tag table charset',	'ALTER TABLE `dashboard_tag` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `term` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:43:02'),
(73,	'Add column folder_id in dashboard',	'alter table `dashboard` ADD COLUMN `folder_id` BIGINT(20) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:43:03'),
(74,	'Add column isFolder in dashboard',	'alter table `dashboard` ADD COLUMN `is_folder` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:43:06'),
(75,	'Add column has_acl in dashboard',	'alter table `dashboard` ADD COLUMN `has_acl` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:43:09'),
(76,	'Add column uid in dashboard',	'alter table `dashboard` ADD COLUMN `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:43:12'),
(77,	'Update uid column values in dashboard',	'UPDATE dashboard SET uid=lpad(id,9,\'0\') WHERE uid IS NULL;',	1,	'',	'2022-09-30 09:43:15'),
(78,	'Add unique index dashboard_org_id_uid',	'CREATE UNIQUE INDEX `UQE_dashboard_org_id_uid` ON `dashboard` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:43:16'),
(79,	'Remove unique index org_id_slug',	'DROP INDEX `UQE_dashboard_org_id_slug` ON `dashboard`',	1,	'',	'2022-09-30 09:43:18'),
(80,	'Update dashboard title length',	'ALTER TABLE `dashboard` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `title` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:43:20'),
(81,	'Add unique index for dashboard_org_id_title_folder_id',	'CREATE UNIQUE INDEX `UQE_dashboard_org_id_folder_id_title` ON `dashboard` (`org_id`,`folder_id`,`title`);',	1,	'',	'2022-09-30 09:43:30'),
(82,	'create dashboard_provisioning',	'CREATE TABLE IF NOT EXISTS `dashboard_provisioning` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NULL\n, `name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `external_id` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:43:32'),
(83,	'Rename table dashboard_provisioning to dashboard_provisioning_tmp_qwerty - v1',	'ALTER TABLE `dashboard_provisioning` RENAME TO `dashboard_provisioning_tmp_qwerty`',	1,	'',	'2022-09-30 09:43:37'),
(84,	'create dashboard_provisioning v2',	'CREATE TABLE IF NOT EXISTS `dashboard_provisioning` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NULL\n, `name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `external_id` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` INT NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:43:41'),
(85,	'create index IDX_dashboard_provisioning_dashboard_id - v2',	'CREATE INDEX `IDX_dashboard_provisioning_dashboard_id` ON `dashboard_provisioning` (`dashboard_id`);',	1,	'',	'2022-09-30 09:43:49'),
(86,	'create index IDX_dashboard_provisioning_dashboard_id_name - v2',	'CREATE INDEX `IDX_dashboard_provisioning_dashboard_id_name` ON `dashboard_provisioning` (`dashboard_id`,`name`);',	1,	'',	'2022-09-30 09:43:53'),
(87,	'copy dashboard_provisioning v1 to v2',	'INSERT INTO `dashboard_provisioning` (`id`\n, `dashboard_id`\n, `name`\n, `external_id`) SELECT `id`\n, `dashboard_id`\n, `name`\n, `external_id` FROM `dashboard_provisioning_tmp_qwerty`',	1,	'',	'2022-09-30 09:43:57'),
(88,	'drop dashboard_provisioning_tmp_qwerty',	'DROP TABLE IF EXISTS `dashboard_provisioning_tmp_qwerty`',	1,	'',	'2022-09-30 09:43:57'),
(89,	'Add check_sum column',	'alter table `dashboard_provisioning` ADD COLUMN `check_sum` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:44:01'),
(90,	'Add index for dashboard_title',	'CREATE INDEX `IDX_dashboard_title` ON `dashboard` (`title`);',	1,	'',	'2022-09-30 09:44:03'),
(91,	'delete tags for deleted dashboards',	'DELETE FROM dashboard_tag WHERE dashboard_id NOT IN (SELECT id FROM dashboard)',	1,	'',	'2022-09-30 09:44:06'),
(92,	'delete stars for deleted dashboards',	'DELETE FROM star WHERE dashboard_id NOT IN (SELECT id FROM dashboard)',	1,	'',	'2022-09-30 09:44:06'),
(93,	'Add index for dashboard_is_folder',	'CREATE INDEX `IDX_dashboard_is_folder` ON `dashboard` (`is_folder`);',	1,	'',	'2022-09-30 09:44:07'),
(94,	'Add isPublic for dashboard',	'alter table `dashboard` ADD COLUMN `is_public` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:44:10'),
(95,	'create data_source table',	'CREATE TABLE IF NOT EXISTS `data_source` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `account_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `access` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `database` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth` TINYINT(1) NOT NULL\n, `basic_auth_user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth_password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `is_default` TINYINT(1) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:44:12'),
(96,	'add index data_source.account_id',	'CREATE INDEX `IDX_data_source_account_id` ON `data_source` (`account_id`);',	1,	'',	'2022-09-30 09:44:15'),
(97,	'add unique index data_source.account_id_name',	'CREATE UNIQUE INDEX `UQE_data_source_account_id_name` ON `data_source` (`account_id`,`name`);',	1,	'',	'2022-09-30 09:44:17'),
(98,	'drop index IDX_data_source_account_id - v1',	'DROP INDEX `IDX_data_source_account_id` ON `data_source`',	1,	'',	'2022-09-30 09:44:20'),
(99,	'drop index UQE_data_source_account_id_name - v1',	'DROP INDEX `UQE_data_source_account_id_name` ON `data_source`',	1,	'',	'2022-09-30 09:44:23'),
(100,	'Rename table data_source to data_source_v1 - v1',	'ALTER TABLE `data_source` RENAME TO `data_source_v1`',	1,	'',	'2022-09-30 09:44:25'),
(101,	'create data_source table v2',	'CREATE TABLE IF NOT EXISTS `data_source` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `access` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `database` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth` TINYINT(1) NOT NULL\n, `basic_auth_user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth_password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `is_default` TINYINT(1) NOT NULL\n, `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:44:26'),
(102,	'create index IDX_data_source_org_id - v2',	'CREATE INDEX `IDX_data_source_org_id` ON `data_source` (`org_id`);',	1,	'',	'2022-09-30 09:44:29'),
(103,	'create index UQE_data_source_org_id_name - v2',	'CREATE UNIQUE INDEX `UQE_data_source_org_id_name` ON `data_source` (`org_id`,`name`);',	1,	'',	'2022-09-30 09:44:34'),
(104,	'Drop old table data_source_v1 #2',	'DROP TABLE IF EXISTS `data_source_v1`',	1,	'',	'2022-09-30 09:44:36'),
(105,	'Add column with_credentials',	'alter table `data_source` ADD COLUMN `with_credentials` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:44:38'),
(106,	'Add secure json data column',	'alter table `data_source` ADD COLUMN `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:44:39'),
(107,	'Update data_source table charset',	'ALTER TABLE `data_source` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `access` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `database` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `basic_auth_user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `basic_auth_password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',	1,	'',	'2022-09-30 09:44:41'),
(108,	'Update initial version to 1',	'UPDATE data_source SET version = 1 WHERE version = 0',	1,	'',	'2022-09-30 09:44:44'),
(109,	'Add read_only data column',	'alter table `data_source` ADD COLUMN `read_only` TINYINT(1) NULL ',	1,	'',	'2022-09-30 09:44:44'),
(110,	'Migrate logging ds to loki ds',	'UPDATE data_source SET type = \'loki\' WHERE type = \'logging\'',	1,	'',	'2022-09-30 09:44:46'),
(111,	'Update json_data with nulls',	'UPDATE data_source SET json_data = \'{}\' WHERE json_data is null',	1,	'',	'2022-09-30 09:44:47'),
(112,	'Add uid column',	'alter table `data_source` ADD COLUMN `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:44:48'),
(113,	'Update uid value',	'UPDATE data_source SET uid=lpad(id,9,\'0\');',	1,	'',	'2022-09-30 09:44:51'),
(114,	'Add unique index datasource_org_id_uid',	'CREATE UNIQUE INDEX `UQE_data_source_org_id_uid` ON `data_source` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:44:52'),
(115,	'add unique index datasource_org_id_is_default',	'CREATE INDEX `IDX_data_source_org_id_is_default` ON `data_source` (`org_id`,`is_default`);',	1,	'',	'2022-09-30 09:44:54'),
(116,	'create api_key table',	'CREATE TABLE IF NOT EXISTS `api_key` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `account_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:44:56'),
(117,	'add index api_key.account_id',	'CREATE INDEX `IDX_api_key_account_id` ON `api_key` (`account_id`);',	1,	'',	'2022-09-30 09:45:01'),
(118,	'add index api_key.key',	'CREATE UNIQUE INDEX `UQE_api_key_key` ON `api_key` (`key`);',	1,	'',	'2022-09-30 09:45:04'),
(119,	'add index api_key.account_id_name',	'CREATE UNIQUE INDEX `UQE_api_key_account_id_name` ON `api_key` (`account_id`,`name`);',	1,	'',	'2022-09-30 09:45:06'),
(120,	'drop index IDX_api_key_account_id - v1',	'DROP INDEX `IDX_api_key_account_id` ON `api_key`',	1,	'',	'2022-09-30 09:45:08'),
(121,	'drop index UQE_api_key_key - v1',	'DROP INDEX `UQE_api_key_key` ON `api_key`',	1,	'',	'2022-09-30 09:45:09'),
(122,	'drop index UQE_api_key_account_id_name - v1',	'DROP INDEX `UQE_api_key_account_id_name` ON `api_key`',	1,	'',	'2022-09-30 09:45:10'),
(123,	'Rename table api_key to api_key_v1 - v1',	'ALTER TABLE `api_key` RENAME TO `api_key_v1`',	1,	'',	'2022-09-30 09:45:12'),
(124,	'create api_key table v2',	'CREATE TABLE IF NOT EXISTS `api_key` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:45:14'),
(125,	'create index IDX_api_key_org_id - v2',	'CREATE INDEX `IDX_api_key_org_id` ON `api_key` (`org_id`);',	1,	'',	'2022-09-30 09:45:17'),
(126,	'create index UQE_api_key_key - v2',	'CREATE UNIQUE INDEX `UQE_api_key_key` ON `api_key` (`key`);',	1,	'',	'2022-09-30 09:45:19'),
(127,	'create index UQE_api_key_org_id_name - v2',	'CREATE UNIQUE INDEX `UQE_api_key_org_id_name` ON `api_key` (`org_id`,`name`);',	1,	'',	'2022-09-30 09:45:23'),
(128,	'copy api_key v1 to v2',	'INSERT INTO `api_key` (`id`\n, `org_id`\n, `name`\n, `key`\n, `role`\n, `created`\n, `updated`) SELECT `id`\n, `account_id`\n, `name`\n, `key`\n, `role`\n, `created`\n, `updated` FROM `api_key_v1`',	1,	'',	'2022-09-30 09:45:25'),
(129,	'Drop old table api_key_v1',	'DROP TABLE IF EXISTS `api_key_v1`',	1,	'',	'2022-09-30 09:45:25'),
(130,	'Update api_key table charset',	'ALTER TABLE `api_key` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:45:28'),
(131,	'Add expires to api_key table',	'alter table `api_key` ADD COLUMN `expires` BIGINT(20) NULL ',	1,	'',	'2022-09-30 09:45:29'),
(132,	'Add service account foreign key',	'alter table `api_key` ADD COLUMN `service_account_id` BIGINT(20) NULL ',	1,	'',	'2022-09-30 09:45:30'),
(133,	'set service account foreign key to nil if 0',	'UPDATE api_key SET service_account_id = NULL WHERE service_account_id = 0;',	1,	'',	'2022-09-30 09:45:33'),
(134,	'Add last_used_at to api_key table',	'alter table `api_key` ADD COLUMN `last_used_at` DATETIME NULL ',	1,	'',	'2022-09-30 09:45:33'),
(135,	'create dashboard_snapshot table v4',	'CREATE TABLE IF NOT EXISTS `dashboard_snapshot` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `dashboard` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `expires` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:45:36'),
(136,	'drop table dashboard_snapshot_v4 #1',	'DROP TABLE IF EXISTS `dashboard_snapshot`',	1,	'',	'2022-09-30 09:45:40'),
(137,	'create dashboard_snapshot table v5 #2',	'CREATE TABLE IF NOT EXISTS `dashboard_snapshot` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `delete_key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `external` TINYINT(1) NOT NULL\n, `external_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `dashboard` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `expires` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:45:42'),
(138,	'create index UQE_dashboard_snapshot_key - v5',	'CREATE UNIQUE INDEX `UQE_dashboard_snapshot_key` ON `dashboard_snapshot` (`key`);',	1,	'',	'2022-09-30 09:45:44'),
(139,	'create index UQE_dashboard_snapshot_delete_key - v5',	'CREATE UNIQUE INDEX `UQE_dashboard_snapshot_delete_key` ON `dashboard_snapshot` (`delete_key`);',	1,	'',	'2022-09-30 09:45:47'),
(140,	'create index IDX_dashboard_snapshot_user_id - v5',	'CREATE INDEX `IDX_dashboard_snapshot_user_id` ON `dashboard_snapshot` (`user_id`);',	1,	'',	'2022-09-30 09:45:49'),
(141,	'alter dashboard_snapshot to mediumtext v2',	'ALTER TABLE dashboard_snapshot MODIFY dashboard MEDIUMTEXT;',	1,	'',	'2022-09-30 09:45:52'),
(142,	'Update dashboard_snapshot table charset',	'ALTER TABLE `dashboard_snapshot` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `delete_key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `external_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `dashboard` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:46:00'),
(143,	'Add column external_delete_url to dashboard_snapshots table',	'alter table `dashboard_snapshot` ADD COLUMN `external_delete_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:46:06'),
(144,	'Add encrypted dashboard json column',	'alter table `dashboard_snapshot` ADD COLUMN `dashboard_encrypted` BLOB NULL ',	1,	'',	'2022-09-30 09:46:08'),
(145,	'Change dashboard_encrypted column to MEDIUMBLOB',	'ALTER TABLE dashboard_snapshot MODIFY dashboard_encrypted MEDIUMBLOB;',	1,	'',	'2022-09-30 09:46:10'),
(146,	'create quota table v1',	'CREATE TABLE IF NOT EXISTS `quota` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NULL\n, `user_id` BIGINT(20) NULL\n, `target` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `limit` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:46:19'),
(147,	'create index UQE_quota_org_id_user_id_target - v1',	'CREATE UNIQUE INDEX `UQE_quota_org_id_user_id_target` ON `quota` (`org_id`,`user_id`,`target`);',	1,	'',	'2022-09-30 09:46:22'),
(148,	'Update quota table charset',	'ALTER TABLE `quota` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `target` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:46:24'),
(149,	'create plugin_setting table',	'CREATE TABLE IF NOT EXISTS `plugin_setting` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NULL\n, `plugin_id` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `enabled` TINYINT(1) NOT NULL\n, `pinned` TINYINT(1) NOT NULL\n, `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:46:25'),
(150,	'create index UQE_plugin_setting_org_id_plugin_id - v1',	'CREATE UNIQUE INDEX `UQE_plugin_setting_org_id_plugin_id` ON `plugin_setting` (`org_id`,`plugin_id`);',	1,	'',	'2022-09-30 09:46:29'),
(151,	'Add column plugin_version to plugin_settings',	'alter table `plugin_setting` ADD COLUMN `plugin_version` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:46:31'),
(152,	'Update plugin_setting table charset',	'ALTER TABLE `plugin_setting` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `plugin_id` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `plugin_version` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',	1,	'',	'2022-09-30 09:46:33'),
(153,	'create session table',	'CREATE TABLE IF NOT EXISTS `session` (\n`key` CHAR(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `data` BLOB NOT NULL\n, `expiry` INTEGER(255) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:46:34'),
(154,	'Drop old table playlist table',	'DROP TABLE IF EXISTS `playlist`',	1,	'',	'2022-09-30 09:46:36'),
(155,	'Drop old table playlist_item table',	'DROP TABLE IF EXISTS `playlist_item`',	1,	'',	'2022-09-30 09:46:37'),
(156,	'create playlist table v2',	'CREATE TABLE IF NOT EXISTS `playlist` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `interval` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:46:38'),
(157,	'create playlist item table v2',	'CREATE TABLE IF NOT EXISTS `playlist_item` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `playlist_id` BIGINT(20) NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `order` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:46:42'),
(158,	'Update playlist table charset',	'ALTER TABLE `playlist` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `interval` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:46:45'),
(159,	'Update playlist_item table charset',	'ALTER TABLE `playlist_item` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:46:46'),
(160,	'drop preferences table v2',	'DROP TABLE IF EXISTS `preferences`',	1,	'',	'2022-09-30 09:46:47'),
(161,	'drop preferences table v3',	'DROP TABLE IF EXISTS `preferences`',	1,	'',	'2022-09-30 09:46:47'),
(162,	'create preferences table v3',	'CREATE TABLE IF NOT EXISTS `preferences` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `home_dashboard_id` BIGINT(20) NOT NULL\n, `timezone` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `theme` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:46:48'),
(163,	'Update preferences table charset',	'ALTER TABLE `preferences` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `timezone` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `theme` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:46:52'),
(164,	'Add column team_id in preferences',	'alter table `preferences` ADD COLUMN `team_id` BIGINT(20) NULL ',	1,	'',	'2022-09-30 09:46:53'),
(165,	'Update team_id column values in preferences',	'UPDATE preferences SET team_id=0 WHERE team_id IS NULL;',	1,	'',	'2022-09-30 09:46:57'),
(166,	'Add column week_start in preferences',	'alter table `preferences` ADD COLUMN `week_start` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:46:59'),
(167,	'Add column preferences.json_data',	'alter table `preferences` ADD COLUMN `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:47:02'),
(168,	'alter preferences.json_data to mediumtext v1',	'ALTER TABLE preferences MODIFY json_data MEDIUMTEXT;',	1,	'',	'2022-09-30 09:47:04'),
(169,	'create alert table v1',	'CREATE TABLE IF NOT EXISTS `alert` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `panel_id` BIGINT(20) NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `state` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `frequency` BIGINT(20) NOT NULL\n, `handler` BIGINT(20) NOT NULL\n, `severity` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `silenced` TINYINT(1) NOT NULL\n, `execution_error` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `eval_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `eval_date` DATETIME NULL\n, `new_state_date` DATETIME NOT NULL\n, `state_changes` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:47:10'),
(170,	'add index alert org_id & id ',	'CREATE INDEX `IDX_alert_org_id_id` ON `alert` (`org_id`,`id`);',	1,	'',	'2022-09-30 09:47:14'),
(171,	'add index alert state',	'CREATE INDEX `IDX_alert_state` ON `alert` (`state`);',	1,	'',	'2022-09-30 09:47:16'),
(172,	'add index alert dashboard_id',	'CREATE INDEX `IDX_alert_dashboard_id` ON `alert` (`dashboard_id`);',	1,	'',	'2022-09-30 09:47:18'),
(173,	'Create alert_rule_tag table v1',	'CREATE TABLE IF NOT EXISTS `alert_rule_tag` (\n`alert_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:47:19'),
(174,	'Add unique index alert_rule_tag.alert_id_tag_id',	'CREATE UNIQUE INDEX `UQE_alert_rule_tag_alert_id_tag_id` ON `alert_rule_tag` (`alert_id`,`tag_id`);',	1,	'',	'2022-09-30 09:47:22'),
(175,	'drop index UQE_alert_rule_tag_alert_id_tag_id - v1',	'DROP INDEX `UQE_alert_rule_tag_alert_id_tag_id` ON `alert_rule_tag`',	1,	'',	'2022-09-30 09:47:26'),
(176,	'Rename table alert_rule_tag to alert_rule_tag_v1 - v1',	'ALTER TABLE `alert_rule_tag` RENAME TO `alert_rule_tag_v1`',	1,	'',	'2022-09-30 09:47:30'),
(177,	'Create alert_rule_tag table v2',	'CREATE TABLE IF NOT EXISTS `alert_rule_tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `alert_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:47:32'),
(178,	'create index UQE_alert_rule_tag_alert_id_tag_id - Add unique index alert_rule_tag.alert_id_tag_id V2',	'CREATE UNIQUE INDEX `UQE_alert_rule_tag_alert_id_tag_id` ON `alert_rule_tag` (`alert_id`,`tag_id`);',	1,	'',	'2022-09-30 09:47:36'),
(179,	'copy alert_rule_tag v1 to v2',	'INSERT INTO `alert_rule_tag` (`alert_id`\n, `tag_id`) SELECT `alert_id`\n, `tag_id` FROM `alert_rule_tag_v1`',	1,	'',	'2022-09-30 09:47:38'),
(180,	'drop table alert_rule_tag_v1',	'DROP TABLE IF EXISTS `alert_rule_tag_v1`',	1,	'',	'2022-09-30 09:47:38'),
(181,	'create alert_notification table v1',	'CREATE TABLE IF NOT EXISTS `alert_notification` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:47:39'),
(182,	'Add column is_default',	'alter table `alert_notification` ADD COLUMN `is_default` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:47:42'),
(183,	'Add column frequency',	'alter table `alert_notification` ADD COLUMN `frequency` BIGINT(20) NULL ',	1,	'',	'2022-09-30 09:47:43'),
(184,	'Add column send_reminder',	'alter table `alert_notification` ADD COLUMN `send_reminder` TINYINT(1) NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:47:46'),
(185,	'Add column disable_resolve_message',	'alter table `alert_notification` ADD COLUMN `disable_resolve_message` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:47:49'),
(186,	'add index alert_notification org_id & name',	'CREATE UNIQUE INDEX `UQE_alert_notification_org_id_name` ON `alert_notification` (`org_id`,`name`);',	1,	'',	'2022-09-30 09:47:51'),
(187,	'Update alert table charset',	'ALTER TABLE `alert` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `state` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `severity` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `execution_error` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `eval_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',	1,	'',	'2022-09-30 09:47:53'),
(188,	'Update alert_notification table charset',	'ALTER TABLE `alert_notification` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:47:54'),
(189,	'create notification_journal table v1',	'CREATE TABLE IF NOT EXISTS `alert_notification_journal` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alert_id` BIGINT(20) NOT NULL\n, `notifier_id` BIGINT(20) NOT NULL\n, `sent_at` BIGINT(20) NOT NULL\n, `success` TINYINT(1) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:47:55'),
(190,	'add index notification_journal org_id & alert_id & notifier_id',	'CREATE INDEX `IDX_alert_notification_journal_org_id_alert_id_notifier_id` ON `alert_notification_journal` (`org_id`,`alert_id`,`notifier_id`);',	1,	'',	'2022-09-30 09:47:59'),
(191,	'drop alert_notification_journal',	'DROP TABLE IF EXISTS `alert_notification_journal`',	1,	'',	'2022-09-30 09:48:01'),
(192,	'create alert_notification_state table v1',	'CREATE TABLE IF NOT EXISTS `alert_notification_state` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alert_id` BIGINT(20) NOT NULL\n, `notifier_id` BIGINT(20) NOT NULL\n, `state` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `version` BIGINT(20) NOT NULL\n, `updated_at` BIGINT(20) NOT NULL\n, `alert_rule_state_updated_version` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:48:04'),
(193,	'add index alert_notification_state org_id & alert_id & notifier_id',	'CREATE UNIQUE INDEX `UQE_alert_notification_state_org_id_alert_id_notifier_id` ON `alert_notification_state` (`org_id`,`alert_id`,`notifier_id`);',	1,	'',	'2022-09-30 09:48:09'),
(194,	'Add for to alert table',	'alter table `alert` ADD COLUMN `for` BIGINT(20) NULL ',	1,	'',	'2022-09-30 09:48:11'),
(195,	'Add column uid in alert_notification',	'alter table `alert_notification` ADD COLUMN `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:48:12'),
(196,	'Update uid column values in alert_notification',	'UPDATE alert_notification SET uid=lpad(id,9,\'0\') WHERE uid IS NULL;',	1,	'',	'2022-09-30 09:48:14'),
(197,	'Add unique index alert_notification_org_id_uid',	'CREATE UNIQUE INDEX `UQE_alert_notification_org_id_uid` ON `alert_notification` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:48:15'),
(198,	'Remove unique index org_id_name',	'DROP INDEX `UQE_alert_notification_org_id_name` ON `alert_notification`',	1,	'',	'2022-09-30 09:48:17'),
(199,	'Add column secure_settings in alert_notification',	'alter table `alert_notification` ADD COLUMN `secure_settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:48:19'),
(200,	'alter alert.settings to mediumtext',	'ALTER TABLE alert MODIFY settings MEDIUMTEXT;',	1,	'',	'2022-09-30 09:48:21'),
(201,	'Add non-unique index alert_notification_state_alert_id',	'CREATE INDEX `IDX_alert_notification_state_alert_id` ON `alert_notification_state` (`alert_id`);',	1,	'',	'2022-09-30 09:48:32'),
(202,	'Add non-unique index alert_rule_tag_alert_id',	'CREATE INDEX `IDX_alert_rule_tag_alert_id` ON `alert_rule_tag` (`alert_id`);',	1,	'',	'2022-09-30 09:48:38'),
(203,	'Drop old annotation table v4',	'DROP TABLE IF EXISTS `annotation`',	1,	'',	'2022-09-30 09:48:42'),
(204,	'create annotation table v5',	'CREATE TABLE IF NOT EXISTS `annotation` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alert_id` BIGINT(20) NULL\n, `user_id` BIGINT(20) NULL\n, `dashboard_id` BIGINT(20) NULL\n, `panel_id` BIGINT(20) NULL\n, `category_id` BIGINT(20) NULL\n, `type` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `text` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `metric` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `prev_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `new_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `epoch` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:48:43'),
(205,	'add index annotation 0 v3',	'CREATE INDEX `IDX_annotation_org_id_alert_id` ON `annotation` (`org_id`,`alert_id`);',	1,	'',	'2022-09-30 09:48:47'),
(206,	'add index annotation 1 v3',	'CREATE INDEX `IDX_annotation_org_id_type` ON `annotation` (`org_id`,`type`);',	1,	'',	'2022-09-30 09:48:51'),
(207,	'add index annotation 2 v3',	'CREATE INDEX `IDX_annotation_org_id_category_id` ON `annotation` (`org_id`,`category_id`);',	1,	'',	'2022-09-30 09:48:55'),
(208,	'add index annotation 3 v3',	'CREATE INDEX `IDX_annotation_org_id_dashboard_id_panel_id_epoch` ON `annotation` (`org_id`,`dashboard_id`,`panel_id`,`epoch`);',	1,	'',	'2022-09-30 09:48:58'),
(209,	'add index annotation 4 v3',	'CREATE INDEX `IDX_annotation_org_id_epoch` ON `annotation` (`org_id`,`epoch`);',	1,	'',	'2022-09-30 09:49:00'),
(210,	'Update annotation table charset',	'ALTER TABLE `annotation` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `type` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `text` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `metric` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `prev_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `new_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:49:04'),
(211,	'Add column region_id to annotation table',	'alter table `annotation` ADD COLUMN `region_id` BIGINT(20) NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:49:05'),
(212,	'Drop category_id index',	'DROP INDEX `IDX_annotation_org_id_category_id` ON `annotation`',	1,	'',	'2022-09-30 09:49:08'),
(213,	'Add column tags to annotation table',	'alter table `annotation` ADD COLUMN `tags` VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:49:11'),
(214,	'Create annotation_tag table v2',	'CREATE TABLE IF NOT EXISTS `annotation_tag` (\n`annotation_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:49:13'),
(215,	'Add unique index annotation_tag.annotation_id_tag_id',	'CREATE UNIQUE INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag` (`annotation_id`,`tag_id`);',	1,	'',	'2022-09-30 09:49:15'),
(216,	'drop index UQE_annotation_tag_annotation_id_tag_id - v2',	'DROP INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag`',	1,	'',	'2022-09-30 09:49:19'),
(217,	'Rename table annotation_tag to annotation_tag_v2 - v2',	'ALTER TABLE `annotation_tag` RENAME TO `annotation_tag_v2`',	1,	'',	'2022-09-30 09:49:26'),
(218,	'Create annotation_tag table v3',	'CREATE TABLE IF NOT EXISTS `annotation_tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `annotation_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:49:28'),
(219,	'create index UQE_annotation_tag_annotation_id_tag_id - Add unique index annotation_tag.annotation_id_tag_id V3',	'CREATE UNIQUE INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag` (`annotation_id`,`tag_id`);',	1,	'',	'2022-09-30 09:49:30'),
(220,	'copy annotation_tag v2 to v3',	'INSERT INTO `annotation_tag` (`annotation_id`\n, `tag_id`) SELECT `annotation_id`\n, `tag_id` FROM `annotation_tag_v2`',	1,	'',	'2022-09-30 09:49:32'),
(221,	'drop table annotation_tag_v2',	'DROP TABLE IF EXISTS `annotation_tag_v2`',	1,	'',	'2022-09-30 09:49:32'),
(222,	'Update alert annotations and set TEXT to empty',	'UPDATE annotation SET TEXT = \'\' WHERE alert_id > 0',	1,	'',	'2022-09-30 09:49:34'),
(223,	'Add created time to annotation table',	'alter table `annotation` ADD COLUMN `created` BIGINT(20) NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:49:34'),
(224,	'Add updated time to annotation table',	'alter table `annotation` ADD COLUMN `updated` BIGINT(20) NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:49:36'),
(225,	'Add index for created in annotation table',	'CREATE INDEX `IDX_annotation_org_id_created` ON `annotation` (`org_id`,`created`);',	1,	'',	'2022-09-30 09:49:38'),
(226,	'Add index for updated in annotation table',	'CREATE INDEX `IDX_annotation_org_id_updated` ON `annotation` (`org_id`,`updated`);',	1,	'',	'2022-09-30 09:49:39'),
(227,	'Convert existing annotations from seconds to milliseconds',	'UPDATE annotation SET epoch = (epoch*1000) where epoch < 9999999999',	1,	'',	'2022-09-30 09:49:40'),
(228,	'Add epoch_end column',	'alter table `annotation` ADD COLUMN `epoch_end` BIGINT(20) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:49:40'),
(229,	'Add index for epoch_end',	'CREATE INDEX `IDX_annotation_org_id_epoch_epoch_end` ON `annotation` (`org_id`,`epoch`,`epoch_end`);',	1,	'',	'2022-09-30 09:49:41'),
(230,	'Make epoch_end the same as epoch',	'UPDATE annotation SET epoch_end = epoch',	1,	'',	'2022-09-30 09:49:42'),
(231,	'Move region to single row',	'code migration',	1,	'',	'2022-09-30 09:49:42'),
(232,	'Remove index org_id_epoch from annotation table',	'DROP INDEX `IDX_annotation_org_id_epoch` ON `annotation`',	1,	'',	'2022-09-30 09:49:43'),
(233,	'Remove index org_id_dashboard_id_panel_id_epoch from annotation table',	'DROP INDEX `IDX_annotation_org_id_dashboard_id_panel_id_epoch` ON `annotation`',	1,	'',	'2022-09-30 09:49:45'),
(234,	'Add index for org_id_dashboard_id_epoch_end_epoch on annotation table',	'CREATE INDEX `IDX_annotation_org_id_dashboard_id_epoch_end_epoch` ON `annotation` (`org_id`,`dashboard_id`,`epoch_end`,`epoch`);',	1,	'',	'2022-09-30 09:49:47'),
(235,	'Add index for org_id_epoch_end_epoch on annotation table',	'CREATE INDEX `IDX_annotation_org_id_epoch_end_epoch` ON `annotation` (`org_id`,`epoch_end`,`epoch`);',	1,	'',	'2022-09-30 09:49:48'),
(236,	'Remove index org_id_epoch_epoch_end from annotation table',	'DROP INDEX `IDX_annotation_org_id_epoch_epoch_end` ON `annotation`',	1,	'',	'2022-09-30 09:49:49'),
(237,	'Add index for alert_id on annotation table',	'CREATE INDEX `IDX_annotation_alert_id` ON `annotation` (`alert_id`);',	1,	'',	'2022-09-30 09:49:51'),
(238,	'create test_data table',	'CREATE TABLE IF NOT EXISTS `test_data` (\n`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `metric1` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `metric2` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `value_big_int` BIGINT(20) NULL\n, `value_double` DOUBLE NULL\n, `value_float` FLOAT NULL\n, `value_int` INT NULL\n, `time_epoch` BIGINT(20) NOT NULL\n, `time_date_time` DATETIME NOT NULL\n, `time_time_stamp` TIMESTAMP NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:49:52'),
(239,	'create dashboard_version table v1',	'CREATE TABLE IF NOT EXISTS `dashboard_version` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `parent_version` INT NOT NULL\n, `restored_from` INT NOT NULL\n, `version` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` BIGINT(20) NOT NULL\n, `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:49:54'),
(240,	'add index dashboard_version.dashboard_id',	'CREATE INDEX `IDX_dashboard_version_dashboard_id` ON `dashboard_version` (`dashboard_id`);',	1,	'',	'2022-09-30 09:49:56'),
(241,	'add unique index dashboard_version.dashboard_id and dashboard_version.version',	'CREATE UNIQUE INDEX `UQE_dashboard_version_dashboard_id_version` ON `dashboard_version` (`dashboard_id`,`version`);',	1,	'',	'2022-09-30 09:49:57'),
(242,	'Set dashboard version to 1 where 0',	'UPDATE dashboard SET version = 1 WHERE version = 0',	1,	'',	'2022-09-30 09:49:58'),
(243,	'save existing dashboard data in dashboard_version table v1',	'INSERT INTO dashboard_version\n(\n	dashboard_id,\n	version,\n	parent_version,\n	restored_from,\n	created,\n	created_by,\n	message,\n	data\n)\nSELECT\n	dashboard.id,\n	dashboard.version,\n	dashboard.version,\n	dashboard.version,\n	dashboard.updated,\n	COALESCE(dashboard.updated_by, -1),\n	\'\',\n	dashboard.data\nFROM dashboard;',	1,	'',	'2022-09-30 09:49:58'),
(244,	'alter dashboard_version.data to mediumtext v1',	'ALTER TABLE dashboard_version MODIFY data MEDIUMTEXT;',	1,	'',	'2022-09-30 09:49:58'),
(245,	'create team table',	'CREATE TABLE IF NOT EXISTS `team` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:50:05'),
(246,	'add index team.org_id',	'CREATE INDEX `IDX_team_org_id` ON `team` (`org_id`);',	1,	'',	'2022-09-30 09:50:07'),
(247,	'add unique index team_org_id_name',	'CREATE UNIQUE INDEX `UQE_team_org_id_name` ON `team` (`org_id`,`name`);',	1,	'',	'2022-09-30 09:50:08'),
(248,	'create team member table',	'CREATE TABLE IF NOT EXISTS `team_member` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `team_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:50:09'),
(249,	'add index team_member.org_id',	'CREATE INDEX `IDX_team_member_org_id` ON `team_member` (`org_id`);',	1,	'',	'2022-09-30 09:50:10'),
(250,	'add unique index team_member_org_id_team_id_user_id',	'CREATE UNIQUE INDEX `UQE_team_member_org_id_team_id_user_id` ON `team_member` (`org_id`,`team_id`,`user_id`);',	1,	'',	'2022-09-30 09:50:11'),
(251,	'add index team_member.team_id',	'CREATE INDEX `IDX_team_member_team_id` ON `team_member` (`team_id`);',	1,	'',	'2022-09-30 09:50:14'),
(252,	'Add column email to team table',	'alter table `team` ADD COLUMN `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:50:16'),
(253,	'Add column external to team_member table',	'alter table `team_member` ADD COLUMN `external` TINYINT(1) NULL ',	1,	'',	'2022-09-30 09:50:17'),
(254,	'Add column permission to team_member table',	'alter table `team_member` ADD COLUMN `permission` SMALLINT NULL ',	1,	'',	'2022-09-30 09:50:18'),
(255,	'create dashboard acl table',	'CREATE TABLE IF NOT EXISTS `dashboard_acl` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NULL\n, `team_id` BIGINT(20) NULL\n, `permission` SMALLINT NOT NULL DEFAULT 4\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:50:19'),
(256,	'add index dashboard_acl_dashboard_id',	'CREATE INDEX `IDX_dashboard_acl_dashboard_id` ON `dashboard_acl` (`dashboard_id`);',	1,	'',	'2022-09-30 09:50:23'),
(257,	'add unique index dashboard_acl_dashboard_id_user_id',	'CREATE UNIQUE INDEX `UQE_dashboard_acl_dashboard_id_user_id` ON `dashboard_acl` (`dashboard_id`,`user_id`);',	1,	'',	'2022-09-30 09:50:25'),
(258,	'add unique index dashboard_acl_dashboard_id_team_id',	'CREATE UNIQUE INDEX `UQE_dashboard_acl_dashboard_id_team_id` ON `dashboard_acl` (`dashboard_id`,`team_id`);',	1,	'',	'2022-09-30 09:50:28'),
(259,	'add index dashboard_acl_user_id',	'CREATE INDEX `IDX_dashboard_acl_user_id` ON `dashboard_acl` (`user_id`);',	1,	'',	'2022-09-30 09:50:29'),
(260,	'add index dashboard_acl_team_id',	'CREATE INDEX `IDX_dashboard_acl_team_id` ON `dashboard_acl` (`team_id`);',	1,	'',	'2022-09-30 09:50:29'),
(261,	'add index dashboard_acl_org_id_role',	'CREATE INDEX `IDX_dashboard_acl_org_id_role` ON `dashboard_acl` (`org_id`,`role`);',	1,	'',	'2022-09-30 09:50:30'),
(262,	'add index dashboard_permission',	'CREATE INDEX `IDX_dashboard_acl_permission` ON `dashboard_acl` (`permission`);',	1,	'',	'2022-09-30 09:50:32'),
(263,	'save default acl rules in dashboard_acl table',	'\nINSERT INTO dashboard_acl\n	(\n		org_id,\n		dashboard_id,\n		permission,\n		role,\n		created,\n		updated\n	)\n	VALUES\n		(-1,-1, 1,\'Viewer\',\'2017-06-20\',\'2017-06-20\'),\n		(-1,-1, 2,\'Editor\',\'2017-06-20\',\'2017-06-20\')\n	',	1,	'',	'2022-09-30 09:50:34'),
(264,	'delete acl rules for deleted dashboards and folders',	'DELETE FROM dashboard_acl WHERE dashboard_id NOT IN (SELECT id FROM dashboard) AND dashboard_id != -1',	1,	'',	'2022-09-30 09:50:35'),
(265,	'create tag table',	'CREATE TABLE IF NOT EXISTS `tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `key` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:50:36'),
(266,	'add index tag.key_value',	'CREATE UNIQUE INDEX `UQE_tag_key_value` ON `tag` (`key`,`value`);',	1,	'',	'2022-09-30 09:50:39'),
(267,	'create login attempt table',	'CREATE TABLE IF NOT EXISTS `login_attempt` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `username` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `ip_address` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:50:41'),
(268,	'add index login_attempt.username',	'CREATE INDEX `IDX_login_attempt_username` ON `login_attempt` (`username`);',	1,	'',	'2022-09-30 09:50:42'),
(269,	'drop index IDX_login_attempt_username - v1',	'DROP INDEX `IDX_login_attempt_username` ON `login_attempt`',	1,	'',	'2022-09-30 09:50:43'),
(270,	'Rename table login_attempt to login_attempt_tmp_qwerty - v1',	'ALTER TABLE `login_attempt` RENAME TO `login_attempt_tmp_qwerty`',	1,	'',	'2022-09-30 09:50:43'),
(271,	'create login_attempt v2',	'CREATE TABLE IF NOT EXISTS `login_attempt` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `username` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `ip_address` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` INT NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:50:45'),
(272,	'create index IDX_login_attempt_username - v2',	'CREATE INDEX `IDX_login_attempt_username` ON `login_attempt` (`username`);',	1,	'',	'2022-09-30 09:50:46'),
(273,	'copy login_attempt v1 to v2',	'INSERT INTO `login_attempt` (`id`\n, `username`\n, `ip_address`) SELECT `id`\n, `username`\n, `ip_address` FROM `login_attempt_tmp_qwerty`',	1,	'',	'2022-09-30 09:50:47'),
(274,	'drop login_attempt_tmp_qwerty',	'DROP TABLE IF EXISTS `login_attempt_tmp_qwerty`',	1,	'',	'2022-09-30 09:50:47'),
(275,	'create user auth table',	'CREATE TABLE IF NOT EXISTS `user_auth` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `auth_module` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `auth_id` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:50:49'),
(276,	'create index IDX_user_auth_auth_module_auth_id - v1',	'CREATE INDEX `IDX_user_auth_auth_module_auth_id` ON `user_auth` (`auth_module`,`auth_id`);',	1,	'',	'2022-09-30 09:50:50'),
(277,	'alter user_auth.auth_id to length 190',	'ALTER TABLE user_auth MODIFY auth_id VARCHAR(190);',	1,	'',	'2022-09-30 09:50:51'),
(278,	'Add OAuth access token to user_auth',	'alter table `user_auth` ADD COLUMN `o_auth_access_token` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:50:54'),
(279,	'Add OAuth refresh token to user_auth',	'alter table `user_auth` ADD COLUMN `o_auth_refresh_token` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:50:55'),
(280,	'Add OAuth token type to user_auth',	'alter table `user_auth` ADD COLUMN `o_auth_token_type` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:50:56'),
(281,	'Add OAuth expiry to user_auth',	'alter table `user_auth` ADD COLUMN `o_auth_expiry` DATETIME NULL ',	1,	'',	'2022-09-30 09:51:00'),
(282,	'Add index to user_id column in user_auth',	'CREATE INDEX `IDX_user_auth_user_id` ON `user_auth` (`user_id`);',	1,	'',	'2022-09-30 09:51:01'),
(283,	'Add OAuth ID token to user_auth',	'alter table `user_auth` ADD COLUMN `o_auth_id_token` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:51:03'),
(284,	'create server_lock table',	'CREATE TABLE IF NOT EXISTS `server_lock` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `operation_uid` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `version` BIGINT(20) NOT NULL\n, `last_execution` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:51:04'),
(285,	'add index server_lock.operation_uid',	'CREATE UNIQUE INDEX `UQE_server_lock_operation_uid` ON `server_lock` (`operation_uid`);',	1,	'',	'2022-09-30 09:51:06'),
(286,	'create user auth token table',	'CREATE TABLE IF NOT EXISTS `user_auth_token` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `auth_token` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `prev_auth_token` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `user_agent` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `client_ip` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `auth_token_seen` TINYINT(1) NOT NULL\n, `seen_at` INT NULL\n, `rotated_at` INT NOT NULL\n, `created_at` INT NOT NULL\n, `updated_at` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:51:07'),
(287,	'add unique index user_auth_token.auth_token',	'CREATE UNIQUE INDEX `UQE_user_auth_token_auth_token` ON `user_auth_token` (`auth_token`);',	1,	'',	'2022-09-30 09:51:08'),
(288,	'add unique index user_auth_token.prev_auth_token',	'CREATE UNIQUE INDEX `UQE_user_auth_token_prev_auth_token` ON `user_auth_token` (`prev_auth_token`);',	1,	'',	'2022-09-30 09:51:09'),
(289,	'add index user_auth_token.user_id',	'CREATE INDEX `IDX_user_auth_token_user_id` ON `user_auth_token` (`user_id`);',	1,	'',	'2022-09-30 09:51:11'),
(290,	'Add revoked_at to the user auth token',	'alter table `user_auth_token` ADD COLUMN `revoked_at` INT NULL ',	1,	'',	'2022-09-30 09:51:12'),
(291,	'create cache_data table',	'CREATE TABLE IF NOT EXISTS `cache_data` (\n`cache_key` VARCHAR(168) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `data` BLOB NOT NULL\n, `expires` INTEGER(255) NOT NULL\n, `created_at` INTEGER(255) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:51:13'),
(292,	'add unique index cache_data.cache_key',	'CREATE UNIQUE INDEX `UQE_cache_data_cache_key` ON `cache_data` (`cache_key`);',	1,	'',	'2022-09-30 09:51:15'),
(293,	'create short_url table v1',	'CREATE TABLE IF NOT EXISTS `short_url` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `path` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_by` INT NOT NULL\n, `created_at` INT NOT NULL\n, `last_seen_at` INT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:51:16'),
(294,	'add index short_url.org_id-uid',	'CREATE UNIQUE INDEX `UQE_short_url_org_id_uid` ON `short_url` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:51:17'),
(295,	'alter table short_url alter column created_by type to bigint',	'ALTER TABLE short_url MODIFY created_by BIGINT;',	1,	'',	'2022-09-30 09:51:20'),
(296,	'delete alert_definition table',	'DROP TABLE IF EXISTS `alert_definition`',	1,	'',	'2022-09-30 09:51:23'),
(297,	'recreate alert_definition table',	'CREATE TABLE IF NOT EXISTS `alert_definition` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL DEFAULT 60\n, `version` INT NOT NULL DEFAULT 0\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:51:23'),
(298,	'add index in alert_definition on org_id and title columns',	'CREATE INDEX `IDX_alert_definition_org_id_title` ON `alert_definition` (`org_id`,`title`);',	1,	'',	'2022-09-30 09:51:24'),
(299,	'add index in alert_definition on org_id and uid columns',	'CREATE INDEX `IDX_alert_definition_org_id_uid` ON `alert_definition` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:51:25'),
(300,	'alter alert_definition table data column to mediumtext in mysql',	'ALTER TABLE alert_definition MODIFY data MEDIUMTEXT;',	1,	'',	'2022-09-30 09:51:27'),
(301,	'drop index in alert_definition on org_id and title columns',	'DROP INDEX `IDX_alert_definition_org_id_title` ON `alert_definition`',	1,	'',	'2022-09-30 09:51:32'),
(302,	'drop index in alert_definition on org_id and uid columns',	'DROP INDEX `IDX_alert_definition_org_id_uid` ON `alert_definition`',	1,	'',	'2022-09-30 09:51:33'),
(303,	'add unique index in alert_definition on org_id and title columns',	'CREATE UNIQUE INDEX `UQE_alert_definition_org_id_title` ON `alert_definition` (`org_id`,`title`);',	1,	'',	'2022-09-30 09:51:34'),
(304,	'add unique index in alert_definition on org_id and uid columns',	'CREATE UNIQUE INDEX `UQE_alert_definition_org_id_uid` ON `alert_definition` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:51:35'),
(305,	'Add column paused in alert_definition',	'alter table `alert_definition` ADD COLUMN `paused` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:51:38'),
(306,	'drop alert_definition table',	'DROP TABLE IF EXISTS `alert_definition`',	1,	'',	'2022-09-30 09:51:38'),
(307,	'delete alert_definition_version table',	'DROP TABLE IF EXISTS `alert_definition_version`',	1,	'',	'2022-09-30 09:51:39'),
(308,	'recreate alert_definition_version table',	'CREATE TABLE IF NOT EXISTS `alert_definition_version` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `alert_definition_id` BIGINT(20) NOT NULL\n, `alert_definition_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `parent_version` INT NOT NULL\n, `restored_from` INT NOT NULL\n, `version` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:51:39'),
(309,	'add index in alert_definition_version table on alert_definition_id and version columns',	'CREATE UNIQUE INDEX `UQE_alert_definition_version_alert_definition_id_version` ON `alert_definition_version` (`alert_definition_id`,`version`);',	1,	'',	'2022-09-30 09:51:41'),
(310,	'add index in alert_definition_version table on alert_definition_uid and version columns',	'CREATE UNIQUE INDEX `UQE_alert_definition_version_alert_definition_uid_version` ON `alert_definition_version` (`alert_definition_uid`,`version`);',	1,	'',	'2022-09-30 09:51:42'),
(311,	'alter alert_definition_version table data column to mediumtext in mysql',	'ALTER TABLE alert_definition_version MODIFY data MEDIUMTEXT;',	1,	'',	'2022-09-30 09:51:43'),
(312,	'drop alert_definition_version table',	'DROP TABLE IF EXISTS `alert_definition_version`',	1,	'',	'2022-09-30 09:51:47'),
(313,	'create alert_instance table',	'CREATE TABLE IF NOT EXISTS `alert_instance` (\n`def_org_id` BIGINT(20) NOT NULL\n, `def_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `labels` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `labels_hash` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `current_state` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `current_state_since` BIGINT(20) NOT NULL\n, `last_eval_time` BIGINT(20) NOT NULL\n, PRIMARY KEY ( `def_org_id`,`def_uid`,`labels_hash` )) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:51:48'),
(314,	'add index in alert_instance table on def_org_id, def_uid and current_state columns',	'CREATE INDEX `IDX_alert_instance_def_org_id_def_uid_current_state` ON `alert_instance` (`def_org_id`,`def_uid`,`current_state`);',	1,	'',	'2022-09-30 09:51:49'),
(315,	'add index in alert_instance table on def_org_id, current_state columns',	'CREATE INDEX `IDX_alert_instance_def_org_id_current_state` ON `alert_instance` (`def_org_id`,`current_state`);',	1,	'',	'2022-09-30 09:51:51'),
(316,	'add column current_state_end to alert_instance',	'alter table `alert_instance` ADD COLUMN `current_state_end` BIGINT(20) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:51:52'),
(317,	'remove index def_org_id, def_uid, current_state on alert_instance',	'DROP INDEX `IDX_alert_instance_def_org_id_def_uid_current_state` ON `alert_instance`',	1,	'',	'2022-09-30 09:51:53'),
(318,	'remove index def_org_id, current_state on alert_instance',	'DROP INDEX `IDX_alert_instance_def_org_id_current_state` ON `alert_instance`',	1,	'',	'2022-09-30 09:51:55'),
(319,	'rename def_org_id to rule_org_id in alert_instance',	'ALTER TABLE alert_instance CHANGE def_org_id rule_org_id BIGINT;',	1,	'',	'2022-09-30 09:51:55'),
(320,	'rename def_uid to rule_uid in alert_instance',	'ALTER TABLE alert_instance CHANGE def_uid rule_uid VARCHAR(40);',	1,	'',	'2022-09-30 09:51:56'),
(321,	'add index rule_org_id, rule_uid, current_state on alert_instance',	'CREATE INDEX `IDX_alert_instance_rule_org_id_rule_uid_current_state` ON `alert_instance` (`rule_org_id`,`rule_uid`,`current_state`);',	1,	'',	'2022-09-30 09:51:57'),
(322,	'add index rule_org_id, current_state on alert_instance',	'CREATE INDEX `IDX_alert_instance_rule_org_id_current_state` ON `alert_instance` (`rule_org_id`,`current_state`);',	1,	'',	'2022-09-30 09:51:57'),
(323,	'add current_reason column related to current_state',	'alter table `alert_instance` ADD COLUMN `current_reason` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:51:58'),
(324,	'create alert_rule table',	'CREATE TABLE IF NOT EXISTS `alert_rule` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL DEFAULT 60\n, `version` INT NOT NULL DEFAULT 0\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `namespace_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `rule_group` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `no_data_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'NoData\'\n, `exec_err_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'Alerting\'\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:52:00'),
(325,	'add index in alert_rule on org_id and title columns',	'CREATE UNIQUE INDEX `UQE_alert_rule_org_id_title` ON `alert_rule` (`org_id`,`title`);',	1,	'',	'2022-09-30 09:52:02'),
(326,	'add index in alert_rule on org_id and uid columns',	'CREATE UNIQUE INDEX `UQE_alert_rule_org_id_uid` ON `alert_rule` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:52:02'),
(327,	'add index in alert_rule on org_id, namespace_uid, group_uid columns',	'CREATE INDEX `IDX_alert_rule_org_id_namespace_uid_rule_group` ON `alert_rule` (`org_id`,`namespace_uid`,`rule_group`);',	1,	'',	'2022-09-30 09:52:03'),
(328,	'alter alert_rule table data column to mediumtext in mysql',	'ALTER TABLE alert_rule MODIFY data MEDIUMTEXT;',	1,	'',	'2022-09-30 09:52:04'),
(329,	'add column for to alert_rule',	'alter table `alert_rule` ADD COLUMN `for` BIGINT(20) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:52:09'),
(330,	'add column annotations to alert_rule',	'alter table `alert_rule` ADD COLUMN `annotations` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:52:11'),
(331,	'add column labels to alert_rule',	'alter table `alert_rule` ADD COLUMN `labels` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:52:12'),
(332,	'remove unique index from alert_rule on org_id, title columns',	'DROP INDEX `UQE_alert_rule_org_id_title` ON `alert_rule`',	1,	'',	'2022-09-30 09:52:13'),
(333,	'add index in alert_rule on org_id, namespase_uid and title columns',	'CREATE UNIQUE INDEX `UQE_alert_rule_org_id_namespace_uid_title` ON `alert_rule` (`org_id`,`namespace_uid`,`title`);',	1,	'',	'2022-09-30 09:52:14'),
(334,	'add dashboard_uid column to alert_rule',	'alter table `alert_rule` ADD COLUMN `dashboard_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:52:15'),
(335,	'add panel_id column to alert_rule',	'alter table `alert_rule` ADD COLUMN `panel_id` BIGINT(20) NULL ',	1,	'',	'2022-09-30 09:52:17'),
(336,	'add index in alert_rule on org_id, dashboard_uid and panel_id columns',	'CREATE INDEX `IDX_alert_rule_org_id_dashboard_uid_panel_id` ON `alert_rule` (`org_id`,`dashboard_uid`,`panel_id`);',	1,	'',	'2022-09-30 09:52:18'),
(337,	'add rule_group_idx column to alert_rule',	'alter table `alert_rule` ADD COLUMN `rule_group_idx` INT NOT NULL DEFAULT 1 ',	1,	'',	'2022-09-30 09:52:19'),
(338,	'create alert_rule_version table',	'CREATE TABLE IF NOT EXISTS `alert_rule_version` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `rule_org_id` BIGINT(20) NOT NULL\n, `rule_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `rule_namespace_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `rule_group` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `parent_version` INT NOT NULL\n, `restored_from` INT NOT NULL\n, `version` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL\n, `no_data_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'NoData\'\n, `exec_err_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'Alerting\'\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:52:20'),
(339,	'add index in alert_rule_version table on rule_org_id, rule_uid and version columns',	'CREATE UNIQUE INDEX `UQE_alert_rule_version_rule_org_id_rule_uid_version` ON `alert_rule_version` (`rule_org_id`,`rule_uid`,`version`);',	1,	'',	'2022-09-30 09:52:22'),
(340,	'add index in alert_rule_version table on rule_org_id, rule_namespace_uid and rule_group columns',	'CREATE INDEX `IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group` ON `alert_rule_version` (`rule_org_id`,`rule_namespace_uid`,`rule_group`);',	1,	'',	'2022-09-30 09:52:23'),
(341,	'alter alert_rule_version table data column to mediumtext in mysql',	'ALTER TABLE alert_rule_version MODIFY data MEDIUMTEXT;',	1,	'',	'2022-09-30 09:52:23'),
(342,	'add column for to alert_rule_version',	'alter table `alert_rule_version` ADD COLUMN `for` BIGINT(20) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:52:28'),
(343,	'add column annotations to alert_rule_version',	'alter table `alert_rule_version` ADD COLUMN `annotations` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:52:30'),
(344,	'add column labels to alert_rule_version',	'alter table `alert_rule_version` ADD COLUMN `labels` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:52:32'),
(345,	'add rule_group_idx column to alert_rule_version',	'alter table `alert_rule_version` ADD COLUMN `rule_group_idx` INT NOT NULL DEFAULT 1 ',	1,	'',	'2022-09-30 09:52:34'),
(346,	'create_alert_configuration_table',	'CREATE TABLE IF NOT EXISTS `alert_configuration` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `alertmanager_configuration` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `configuration_version` VARCHAR(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_at` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:52:36'),
(347,	'Add column default in alert_configuration',	'alter table `alert_configuration` ADD COLUMN `default` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:52:37'),
(348,	'alert alert_configuration alertmanager_configuration column from TEXT to MEDIUMTEXT if mysql',	'ALTER TABLE alert_configuration MODIFY alertmanager_configuration MEDIUMTEXT;',	1,	'',	'2022-09-30 09:52:38'),
(349,	'add column org_id in alert_configuration',	'alter table `alert_configuration` ADD COLUMN `org_id` BIGINT(20) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:52:41'),
(350,	'add index in alert_configuration table on org_id column',	'CREATE INDEX `IDX_alert_configuration_org_id` ON `alert_configuration` (`org_id`);',	1,	'',	'2022-09-30 09:52:43'),
(351,	'add configuration_hash column to alert_configuration',	'alter table `alert_configuration` ADD COLUMN `configuration_hash` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'not-yet-calculated\' ',	1,	'',	'2022-09-30 09:52:44'),
(352,	'create_ngalert_configuration_table',	'CREATE TABLE IF NOT EXISTS `ngalert_configuration` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alertmanagers` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created_at` INT NOT NULL\n, `updated_at` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:52:45'),
(353,	'add index in ngalert_configuration on org_id column',	'CREATE UNIQUE INDEX `UQE_ngalert_configuration_org_id` ON `ngalert_configuration` (`org_id`);',	1,	'',	'2022-09-30 09:52:46'),
(354,	'add column send_alerts_to in ngalert_configuration',	'alter table `ngalert_configuration` ADD COLUMN `send_alerts_to` SMALLINT NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:52:47'),
(355,	'create provenance_type table',	'CREATE TABLE IF NOT EXISTS `provenance_type` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `record_key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `record_type` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `provenance` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:52:48'),
(356,	'add index to uniquify (record_key, record_type, org_id) columns',	'CREATE UNIQUE INDEX `UQE_provenance_type_record_type_record_key_org_id` ON `provenance_type` (`record_type`,`record_key`,`org_id`);',	1,	'',	'2022-09-30 09:52:51'),
(357,	'create alert_image table',	'CREATE TABLE IF NOT EXISTS `alert_image` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `token` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `path` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `url` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_at` DATETIME NOT NULL\n, `expires_at` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:52:52'),
(358,	'add unique index on token to alert_image table',	'CREATE UNIQUE INDEX `UQE_alert_image_token` ON `alert_image` (`token`);',	1,	'',	'2022-09-30 09:52:54'),
(359,	'support longer URLs in alert_image table',	'ALTER TABLE alert_image MODIFY url VARCHAR(2048) NOT NULL;',	1,	'',	'2022-09-30 09:52:55'),
(360,	'move dashboard alerts to unified alerting',	'code migration',	1,	'',	'2022-09-30 09:52:55'),
(361,	'create library_element table v1',	'CREATE TABLE IF NOT EXISTS `library_element` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `folder_id` BIGINT(20) NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `kind` BIGINT(20) NOT NULL\n, `type` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `description` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `model` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` BIGINT(20) NOT NULL\n, `updated` DATETIME NOT NULL\n, `updated_by` BIGINT(20) NOT NULL\n, `version` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:52:55'),
(362,	'add index library_element org_id-folder_id-name-kind',	'CREATE UNIQUE INDEX `UQE_library_element_org_id_folder_id_name_kind` ON `library_element` (`org_id`,`folder_id`,`name`,`kind`);',	1,	'',	'2022-09-30 09:52:57'),
(363,	'create library_element_connection table v1',	'CREATE TABLE IF NOT EXISTS `library_element_connection` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `element_id` BIGINT(20) NOT NULL\n, `kind` BIGINT(20) NOT NULL\n, `connection_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:52:57'),
(364,	'add index library_element_connection element_id-kind-connection_id',	'CREATE UNIQUE INDEX `UQE_library_element_connection_element_id_kind_connection_id` ON `library_element_connection` (`element_id`,`kind`,`connection_id`);',	1,	'',	'2022-09-30 09:52:59'),
(365,	'add unique index library_element org_id_uid',	'CREATE UNIQUE INDEX `UQE_library_element_org_id_uid` ON `library_element` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:53:00'),
(366,	'increase max description length to 2048',	'ALTER TABLE `library_element` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `description` VARCHAR(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',	1,	'',	'2022-09-30 09:53:02'),
(367,	'clone move dashboard alerts to unified alerting',	'code migration',	1,	'',	'2022-09-30 09:53:04'),
(368,	'create data_keys table',	'CREATE TABLE IF NOT EXISTS `data_keys` (\n`name` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `active` TINYINT(1) NOT NULL\n, `scope` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `provider` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `encrypted_data` BLOB NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:04'),
(369,	'create secrets table',	'CREATE TABLE IF NOT EXISTS `secrets` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `namespace` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:06'),
(370,	'rename data_keys name column to id',	'ALTER TABLE `data_keys` CHANGE `name` `id` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci',	1,	'',	'2022-09-30 09:53:07'),
(371,	'add name column into data_keys',	'alter table `data_keys` ADD COLUMN `name` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'\' ',	1,	'',	'2022-09-30 09:53:09'),
(372,	'copy data_keys id column values into name',	'UPDATE data_keys SET name = id',	1,	'',	'2022-09-30 09:53:10'),
(373,	'rename data_keys name column to label',	'ALTER TABLE `data_keys` CHANGE `name` `label` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci',	1,	'',	'2022-09-30 09:53:10'),
(374,	'rename data_keys id column back to name',	'ALTER TABLE `data_keys` CHANGE `id` `name` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci',	1,	'',	'2022-09-30 09:53:13'),
(375,	'create kv_store table v1',	'CREATE TABLE IF NOT EXISTS `kv_store` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `namespace` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:13'),
(376,	'add index kv_store.org_id-namespace-key',	'CREATE UNIQUE INDEX `UQE_kv_store_org_id_namespace_key` ON `kv_store` (`org_id`,`namespace`,`key`);',	1,	'',	'2022-09-30 09:53:15'),
(377,	'update dashboard_uid and panel_id from existing annotations',	'set dashboard_uid and panel_id migration',	1,	'',	'2022-09-30 09:53:17'),
(378,	'create permission table',	'CREATE TABLE IF NOT EXISTS `permission` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `action` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `scope` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:17'),
(379,	'add unique index permission.role_id',	'CREATE INDEX `IDX_permission_role_id` ON `permission` (`role_id`);',	1,	'',	'2022-09-30 09:53:18'),
(380,	'add unique index role_id_action_scope',	'CREATE UNIQUE INDEX `UQE_permission_role_id_action_scope` ON `permission` (`role_id`,`action`,`scope`);',	1,	'',	'2022-09-30 09:53:19'),
(381,	'create role table',	'CREATE TABLE IF NOT EXISTS `role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `description` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `version` BIGINT(20) NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:20'),
(382,	'add column display_name',	'alter table `role` ADD COLUMN `display_name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:53:22'),
(383,	'add column group_name',	'alter table `role` ADD COLUMN `group_name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',	1,	'',	'2022-09-30 09:53:23'),
(384,	'add index role.org_id',	'CREATE INDEX `IDX_role_org_id` ON `role` (`org_id`);',	1,	'',	'2022-09-30 09:53:25'),
(385,	'add unique index role_org_id_name',	'CREATE UNIQUE INDEX `UQE_role_org_id_name` ON `role` (`org_id`,`name`);',	1,	'',	'2022-09-30 09:53:25'),
(386,	'add index role_org_id_uid',	'CREATE UNIQUE INDEX `UQE_role_org_id_uid` ON `role` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:53:26'),
(387,	'create team role table',	'CREATE TABLE IF NOT EXISTS `team_role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `team_id` BIGINT(20) NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:27'),
(388,	'add index team_role.org_id',	'CREATE INDEX `IDX_team_role_org_id` ON `team_role` (`org_id`);',	1,	'',	'2022-09-30 09:53:28'),
(389,	'add unique index team_role_org_id_team_id_role_id',	'CREATE UNIQUE INDEX `UQE_team_role_org_id_team_id_role_id` ON `team_role` (`org_id`,`team_id`,`role_id`);',	1,	'',	'2022-09-30 09:53:29'),
(390,	'add index team_role.team_id',	'CREATE INDEX `IDX_team_role_team_id` ON `team_role` (`team_id`);',	1,	'',	'2022-09-30 09:53:31'),
(391,	'create user role table',	'CREATE TABLE IF NOT EXISTS `user_role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:33'),
(392,	'add index user_role.org_id',	'CREATE INDEX `IDX_user_role_org_id` ON `user_role` (`org_id`);',	1,	'',	'2022-09-30 09:53:34'),
(393,	'add unique index user_role_org_id_user_id_role_id',	'CREATE UNIQUE INDEX `UQE_user_role_org_id_user_id_role_id` ON `user_role` (`org_id`,`user_id`,`role_id`);',	1,	'',	'2022-09-30 09:53:35'),
(394,	'add index user_role.user_id',	'CREATE INDEX `IDX_user_role_user_id` ON `user_role` (`user_id`);',	1,	'',	'2022-09-30 09:53:36'),
(395,	'create builtin role table',	'CREATE TABLE IF NOT EXISTS `builtin_role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `role` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:37'),
(396,	'add index builtin_role.role_id',	'CREATE INDEX `IDX_builtin_role_role_id` ON `builtin_role` (`role_id`);',	1,	'',	'2022-09-30 09:53:39'),
(397,	'add index builtin_role.name',	'CREATE INDEX `IDX_builtin_role_role` ON `builtin_role` (`role`);',	1,	'',	'2022-09-30 09:53:41'),
(398,	'Add column org_id to builtin_role table',	'alter table `builtin_role` ADD COLUMN `org_id` BIGINT(20) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:53:42'),
(399,	'add index builtin_role.org_id',	'CREATE INDEX `IDX_builtin_role_org_id` ON `builtin_role` (`org_id`);',	1,	'',	'2022-09-30 09:53:43'),
(400,	'add unique index builtin_role_org_id_role_id_role',	'CREATE UNIQUE INDEX `UQE_builtin_role_org_id_role_id_role` ON `builtin_role` (`org_id`,`role_id`,`role`);',	1,	'',	'2022-09-30 09:53:44'),
(401,	'Remove unique index role_org_id_uid',	'DROP INDEX `UQE_role_org_id_uid` ON `role`',	1,	'',	'2022-09-30 09:53:45'),
(402,	'add unique index role.uid',	'CREATE UNIQUE INDEX `UQE_role_uid` ON `role` (`uid`);',	1,	'',	'2022-09-30 09:53:46'),
(403,	'create seed assignment table',	'CREATE TABLE IF NOT EXISTS `seed_assignment` (\n`builtin_role` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role_name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:47'),
(404,	'add unique index builtin_role_role_name',	'CREATE UNIQUE INDEX `UQE_seed_assignment_builtin_role_role_name` ON `seed_assignment` (`builtin_role`,`role_name`);',	1,	'',	'2022-09-30 09:53:49'),
(405,	'add column hidden to role table',	'alter table `role` ADD COLUMN `hidden` TINYINT(1) NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:53:52'),
(406,	'create query_history table v1',	'CREATE TABLE IF NOT EXISTS `query_history` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `datasource_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_by` INT NOT NULL\n, `created_at` INT NOT NULL\n, `comment` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `queries` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:53:53'),
(407,	'add index query_history.org_id-created_by-datasource_uid',	'CREATE INDEX `IDX_query_history_org_id_created_by_datasource_uid` ON `query_history` (`org_id`,`created_by`,`datasource_uid`);',	1,	'',	'2022-09-30 09:53:54'),
(408,	'alter table query_history alter column created_by type to bigint',	'ALTER TABLE query_history MODIFY created_by BIGINT;',	1,	'',	'2022-09-30 09:53:57'),
(409,	'teams permissions migration',	'code migration',	1,	'',	'2022-09-30 09:54:03'),
(410,	'dashboard permissions',	'code migration',	1,	'',	'2022-09-30 09:54:04'),
(411,	'dashboard permissions uid scopes',	'code migration',	1,	'',	'2022-09-30 09:54:05'),
(412,	'drop managed folder create actions',	'code migration',	1,	'',	'2022-09-30 09:54:05'),
(413,	'alerting notification permissions',	'code migration',	1,	'',	'2022-09-30 09:54:05'),
(414,	'create query_history_star table v1',	'CREATE TABLE IF NOT EXISTS `query_history_star` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `query_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `user_id` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:54:06'),
(415,	'add index query_history.user_id-query_uid',	'CREATE UNIQUE INDEX `UQE_query_history_star_user_id_query_uid` ON `query_history_star` (`user_id`,`query_uid`);',	1,	'',	'2022-09-30 09:54:08'),
(416,	'add column org_id in query_history_star',	'alter table `query_history_star` ADD COLUMN `org_id` BIGINT(20) NOT NULL DEFAULT 1 ',	1,	'',	'2022-09-30 09:54:11'),
(417,	'alter table query_history_star_mig column user_id type to bigint',	'ALTER TABLE query_history_star MODIFY user_id BIGINT;',	1,	'',	'2022-09-30 09:54:12'),
(418,	'create correlation table v1',	'CREATE TABLE IF NOT EXISTS `correlation` (\n`uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `source_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `target_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `label` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `description` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, PRIMARY KEY ( `uid`,`source_uid` )) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:54:14'),
(419,	'create entity_events table',	'CREATE TABLE IF NOT EXISTS `entity_event` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `entity_id` VARCHAR(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `event_type` VARCHAR(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:54:16'),
(420,	'create dashboard public config v1',	'CREATE TABLE IF NOT EXISTS `dashboard_public_config` (\n`uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `dashboard_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `time_settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `refresh_rate` INT NOT NULL DEFAULT 30\n, `template_variables` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:54:17'),
(421,	'drop index UQE_dashboard_public_config_uid - v1',	'DROP INDEX `UQE_dashboard_public_config_uid` ON `dashboard_public_config`',	1,	'',	'2022-09-30 09:54:21'),
(422,	'drop index IDX_dashboard_public_config_org_id_dashboard_uid - v1',	'DROP INDEX `IDX_dashboard_public_config_org_id_dashboard_uid` ON `dashboard_public_config`',	1,	'',	'2022-09-30 09:54:21'),
(423,	'Drop old dashboard public config table',	'DROP TABLE IF EXISTS `dashboard_public_config`',	1,	'',	'2022-09-30 09:54:21'),
(424,	'recreate dashboard public config v1',	'CREATE TABLE IF NOT EXISTS `dashboard_public_config` (\n`uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `dashboard_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `time_settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `refresh_rate` INT NOT NULL DEFAULT 30\n, `template_variables` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:54:22'),
(425,	'create index UQE_dashboard_public_config_uid - v1',	'CREATE UNIQUE INDEX `UQE_dashboard_public_config_uid` ON `dashboard_public_config` (`uid`);',	1,	'',	'2022-09-30 09:54:23'),
(426,	'create index IDX_dashboard_public_config_org_id_dashboard_uid - v1',	'CREATE INDEX `IDX_dashboard_public_config_org_id_dashboard_uid` ON `dashboard_public_config` (`org_id`,`dashboard_uid`);',	1,	'',	'2022-09-30 09:54:24'),
(427,	'drop index UQE_dashboard_public_config_uid - v2',	'DROP INDEX `UQE_dashboard_public_config_uid` ON `dashboard_public_config`',	1,	'',	'2022-09-30 09:54:25'),
(428,	'drop index IDX_dashboard_public_config_org_id_dashboard_uid - v2',	'DROP INDEX `IDX_dashboard_public_config_org_id_dashboard_uid` ON `dashboard_public_config`',	1,	'',	'2022-09-30 09:54:26'),
(429,	'Drop public config table',	'DROP TABLE IF EXISTS `dashboard_public_config`',	1,	'',	'2022-09-30 09:54:27'),
(430,	'Recreate dashboard public config v2',	'CREATE TABLE IF NOT EXISTS `dashboard_public_config` (\n`uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `dashboard_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `time_settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `template_variables` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `access_token` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_by` INT NOT NULL\n, `updated_by` INT NULL\n, `created_at` DATETIME NOT NULL\n, `updated_at` DATETIME NULL\n, `is_enabled` TINYINT(1) NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:54:29'),
(431,	'create index UQE_dashboard_public_config_uid - v2',	'CREATE UNIQUE INDEX `UQE_dashboard_public_config_uid` ON `dashboard_public_config` (`uid`);',	1,	'',	'2022-09-30 09:54:30'),
(432,	'create index IDX_dashboard_public_config_org_id_dashboard_uid - v2',	'CREATE INDEX `IDX_dashboard_public_config_org_id_dashboard_uid` ON `dashboard_public_config` (`org_id`,`dashboard_uid`);',	1,	'',	'2022-09-30 09:54:31'),
(433,	'create index UQE_dashboard_public_config_access_token - v2',	'CREATE UNIQUE INDEX `UQE_dashboard_public_config_access_token` ON `dashboard_public_config` (`access_token`);',	1,	'',	'2022-09-30 09:54:32'),
(434,	'Rename table dashboard_public_config to dashboard_public - v2',	'ALTER TABLE `dashboard_public_config` RENAME TO `dashboard_public`',	1,	'',	'2022-09-30 09:54:32'),
(435,	'create default alerting folders',	'code migration',	1,	'',	'2022-09-30 09:54:34'),
(436,	'create file table',	'CREATE TABLE IF NOT EXISTS `file` (\n`path` VARCHAR(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `path_hash` VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `parent_folder_path_hash` VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `contents` BLOB NOT NULL\n, `etag` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `cache_control` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `content_disposition` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `size` BIGINT(20) NOT NULL\n, `mime_type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:54:35'),
(437,	'file table idx: path natural pk',	'CREATE UNIQUE INDEX `UQE_file_path_hash` ON `file` (`path_hash`);',	1,	'',	'2022-09-30 09:54:37'),
(438,	'file table idx: parent_folder_path_hash fast folder retrieval',	'CREATE INDEX `IDX_file_parent_folder_path_hash` ON `file` (`parent_folder_path_hash`);',	1,	'',	'2022-09-30 09:54:39'),
(439,	'create file_meta table',	'CREATE TABLE IF NOT EXISTS `file_meta` (\n`path_hash` VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` VARCHAR(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',	1,	'',	'2022-09-30 09:54:40'),
(440,	'file table idx: path key',	'CREATE UNIQUE INDEX `UQE_file_meta_path_hash_key` ON `file_meta` (`path_hash`,`key`);',	1,	'',	'2022-09-30 09:54:42'),
(441,	'set path collation in file table',	'SELECT 0;',	1,	'',	'2022-09-30 09:54:45'),
(442,	'managed permissions migration',	'code migration',	1,	'',	'2022-09-30 09:54:45'),
(443,	'managed folder permissions alert actions migration',	'code migration',	1,	'',	'2022-09-30 09:54:46'),
(444,	'RBAC action name migrator',	'code migration',	1,	'',	'2022-09-30 09:54:46'),
(445,	'Add UID column to playlist',	'alter table `playlist` ADD COLUMN `uid` VARCHAR(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0 ',	1,	'',	'2022-09-30 09:54:46'),
(446,	'Update uid column values in playlist',	'UPDATE playlist SET uid=id;',	1,	'',	'2022-09-30 09:54:47'),
(447,	'Add index for uid in playlist',	'CREATE UNIQUE INDEX `UQE_playlist_org_id_uid` ON `playlist` (`org_id`,`uid`);',	1,	'',	'2022-09-30 09:54:47'),
(448,	'update group index for alert rules',	'code migration',	1,	'',	'2022-09-30 09:54:49'),
(449,	'managed folder permissions alert actions repeated migration',	'code migration',	1,	'',	'2022-09-30 09:54:49'),
(450,	'admin only folder/dashboard permission',	'code migration',	1,	'',	'2022-09-30 09:54:49');

CREATE TABLE `ngalert_configuration` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `alertmanagers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int NOT NULL,
  `updated_at` int NOT NULL,
  `send_alerts_to` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_ngalert_configuration_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `org` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_org_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `org` (`id`, `version`, `name`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`, `billing_email`, `created`, `updated`) VALUES
(1,	0,	'Main Org.',	'',	'',	'',	'',	'',	'',	NULL,	'2022-09-30 09:54:57',	'2022-09-30 09:54:57');

CREATE TABLE `org_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_org_user_org_id_user_id` (`org_id`,`user_id`),
  KEY `IDX_org_user_org_id` (`org_id`),
  KEY `IDX_org_user_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `org_user` (`id`, `org_id`, `user_id`, `role`, `created`, `updated`) VALUES
(1,	1,	1,	'Admin',	'2022-09-30 09:54:57',	'2022-09-30 09:54:57');

CREATE TABLE `permission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL,
  `action` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_permission_role_id_action_scope` (`role_id`,`action`,`scope`),
  KEY `IDX_permission_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `permission` (`id`, `role_id`, `action`, `scope`, `created`, `updated`) VALUES
(1,	1,	'dashboards:read',	'dashboards:uid:CPMWPd44z',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37'),
(2,	1,	'dashboards:write',	'dashboards:uid:CPMWPd44z',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37'),
(3,	1,	'dashboards:delete',	'dashboards:uid:CPMWPd44z',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37'),
(4,	1,	'dashboards.permissions:read',	'dashboards:uid:CPMWPd44z',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37'),
(5,	1,	'dashboards.permissions:write',	'dashboards:uid:CPMWPd44z',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37'),
(6,	2,	'dashboards:read',	'dashboards:uid:CPMWPd44z',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37'),
(7,	2,	'dashboards:write',	'dashboards:uid:CPMWPd44z',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37'),
(8,	2,	'dashboards:delete',	'dashboards:uid:CPMWPd44z',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37'),
(9,	3,	'dashboards:read',	'dashboards:uid:CPMWPd44z',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37');

CREATE TABLE `playlist` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `uid` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_playlist_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `playlist_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `playlist_id` bigint NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `plugin_setting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint DEFAULT NULL,
  `plugin_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `pinned` tinyint(1) NOT NULL,
  `json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `secure_json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `plugin_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_plugin_setting_org_id_plugin_id` (`org_id`,`plugin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `preferences` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `version` int NOT NULL,
  `home_dashboard_id` bigint NOT NULL,
  `timezone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `team_id` bigint DEFAULT NULL,
  `week_start` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `json_data` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `provenance_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `record_key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `record_type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provenance` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_provenance_type_record_type_record_key_org_id` (`record_type`,`record_key`,`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `query_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `datasource_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint DEFAULT NULL,
  `created_at` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queries` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_query_history_org_id_created_by_datasource_uid` (`org_id`,`created_by`,`datasource_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `query_history` (`id`, `uid`, `org_id`, `datasource_uid`, `created_by`, `created_at`, `comment`, `queries`) VALUES
(1,	'lqLezdVVz',	1,	'7UwAkOVVk',	1,	1664544912,	'',	'[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"time_series\",\"group\":[],\"key\":\"Q-8edd0116-3a0b-48f6-b678-537730b4e3ec-0\",\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  fecha_alta AS \\\"time\\\",\\n  id\\nFROM Anuncio\\nWHERE\\n  $__timeFilter(fecha_alta)\\nORDER BY fecha_alta\",\"refId\":\"A\",\"select\":[[{\"params\":[\"id\"],\"type\":\"column\"}]],\"table\":\"Anuncio\",\"timeColumn\":\"fecha_alta\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"}]}]'),
(2,	'GSpgidVVz',	1,	'7UwAkOVVk',	1,	1664544936,	'',	'[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"time_series\",\"group\":[],\"key\":\"Q-8edd0116-3a0b-48f6-b678-537730b4e3ec-0\",\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  fecha_alta AS \\\"time\\\",\\n  id\\nFROM Usuario\\nORDER BY fecha_alta\",\"refId\":\"A\",\"select\":[[{\"params\":[\"id\"],\"type\":\"column\"}]],\"table\":\"Usuario\",\"timeColumn\":\"fecha_alta\",\"timeColumnType\":\"timestamp\",\"where\":[]}]'),
(3,	'TrzmmOV4z',	1,	'7UwAkOVVk',	1,	1664544990,	'',	'[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"time_series\",\"group\":[],\"key\":\"Q-8edd0116-3a0b-48f6-b678-537730b4e3ec-0\",\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  fecha_alta AS \\\"time\\\",\\n  id\\nFROM Alumno\\nORDER BY fecha_alta\",\"refId\":\"A\",\"select\":[[{\"params\":[\"id\"],\"type\":\"column\"}]],\"table\":\"Alumno\",\"timeColumn\":\"fecha_alta\",\"timeColumnType\":\"timestamp\",\"where\":[]}]'),
(4,	'Itdmmd4Vk',	1,	'7UwAkOVVk',	1,	1664544998,	'',	'[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"time_series\",\"group\":[],\"key\":\"Q-8edd0116-3a0b-48f6-b678-537730b4e3ec-0\",\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  fecha_alta AS \\\"time\\\",\\n  id\\nFROM Usuario\\nORDER BY fecha_alta\",\"refId\":\"A\",\"select\":[[{\"params\":[\"id\"],\"type\":\"column\"}]],\"table\":\"Usuario\",\"timeColumn\":\"fecha_alta\",\"timeColumnType\":\"timestamp\",\"where\":[]}]'),
(5,	'vBkMLKVVz',	1,	'7UwAkOVVk',	1,	1664598532,	'',	'[{\"datasource\":{\"type\":\"mysql\",\"uid\":\"7UwAkOVVk\"},\"format\":\"time_series\",\"group\":[],\"key\":\"Q-edf016a2-4ef8-4128-a348-8b7435712af0-0\",\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  fecha_alta AS \\\"time\\\",\\n  id\\nFROM Anuncio\\nWHERE\\n  $__timeFilter(fecha_alta)\\nORDER BY fecha_alta\",\"refId\":\"A\",\"select\":[[{\"params\":[\"id\"],\"type\":\"column\"}]],\"table\":\"Anuncio\",\"timeColumn\":\"fecha_alta\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"}]}]');

CREATE TABLE `query_history_star` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `query_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `org_id` bigint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_query_history_star_user_id_query_uid` (`user_id`,`query_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `quota` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `target` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `limit` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_quota_org_id_user_id_target` (`org_id`,`user_id`,`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `version` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `display_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_role_org_id_name` (`org_id`,`name`),
  UNIQUE KEY `UQE_role_uid` (`uid`),
  KEY `IDX_role_org_id` (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `role` (`id`, `name`, `description`, `version`, `org_id`, `uid`, `created`, `updated`, `display_name`, `group_name`, `hidden`) VALUES
(1,	'managed:users:1:permissions',	'',	0,	1,	's9MZEdVVk',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37',	'',	'',	0),
(2,	'managed:builtins:editor:permissions',	'',	0,	1,	'BCGZPd4Vk',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37',	'',	'',	0),
(3,	'managed:builtins:viewer:permissions',	'',	0,	1,	'p3MZEO44k',	'2022-09-30 19:26:37',	'2022-09-30 19:26:37',	'',	'',	0);

CREATE TABLE `secrets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `namespace` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `secrets` (`id`, `org_id`, `namespace`, `type`, `value`, `created`, `updated`) VALUES
(1,	1,	'Institutoidiomas',	'datasource',	'I1pUaDNNR3RrVmxaNiNrSDYzcjJzYzxnFDGfKgmIYpGZtkrE6o61BMUs6tHKYk+ceT/P+8qkAsS0',	'2022-09-30 13:27:04',	'2022-09-30 13:35:05');

CREATE TABLE `seed_assignment` (
  `builtin_role` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `UQE_seed_assignment_builtin_role_role_name` (`builtin_role`,`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `server_lock` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `operation_uid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` bigint NOT NULL,
  `last_execution` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_server_lock_operation_uid` (`operation_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `server_lock` (`id`, `operation_uid`, `version`, `last_execution`) VALUES
(1,	'migrate secrets to unified secrets',	2,	1664594082),
(2,	'cleanup expired auth tokens',	2,	1664575259),
(3,	'delete old login attempts',	81,	1664598892);

CREATE TABLE `session` (
  `key` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` blob NOT NULL,
  `expiry` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `short_url` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint DEFAULT NULL,
  `created_at` int NOT NULL,
  `last_seen_at` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_short_url_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `star` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `dashboard_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_star_user_id_dashboard_id` (`user_id`,`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_tag_key_value` (`key`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `team` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_org_id_name` (`org_id`,`name`),
  KEY `IDX_team_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `team_member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `team_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `external` tinyint(1) DEFAULT NULL,
  `permission` smallint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_member_org_id_team_id_user_id` (`org_id`,`team_id`,`user_id`),
  KEY `IDX_team_member_org_id` (`org_id`),
  KEY `IDX_team_member_team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `team_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `team_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_role_org_id_team_id_role_id` (`org_id`,`team_id`,`role_id`),
  KEY `IDX_team_role_org_id` (`org_id`),
  KEY `IDX_team_role_team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `temp_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `version` int NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `invited_by_user_id` bigint DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL,
  `email_sent_on` datetime DEFAULT NULL,
  `remote_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` int NOT NULL DEFAULT '0',
  `updated` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_temp_user_email` (`email`),
  KEY `IDX_temp_user_org_id` (`org_id`),
  KEY `IDX_temp_user_code` (`code`),
  KEY `IDX_temp_user_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `test_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `metric1` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metric2` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_big_int` bigint DEFAULT NULL,
  `value_double` double DEFAULT NULL,
  `value_float` float DEFAULT NULL,
  `value_int` int DEFAULT NULL,
  `time_epoch` bigint NOT NULL,
  `time_date_time` datetime NOT NULL,
  `time_time_stamp` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version` int NOT NULL,
  `login` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rands` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `org_id` bigint NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `theme` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `help_flags1` bigint NOT NULL DEFAULT '0',
  `last_seen_at` datetime DEFAULT NULL,
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_service_account` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_login` (`login`),
  UNIQUE KEY `UQE_user_email` (`email`),
  KEY `IDX_user_login_email` (`login`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `user` (`id`, `version`, `login`, `email`, `name`, `password`, `salt`, `rands`, `company`, `org_id`, `is_admin`, `email_verified`, `theme`, `created`, `updated`, `help_flags1`, `last_seen_at`, `is_disabled`, `is_service_account`) VALUES
(1,	0,	'admin',	'admin@localhost',	'',	'0d191750dfe93d5bbe5260215e4209e299bfcb3f124ef87991e1578d19c5e651ef1755386fbf95af6dfdf905dcd409a1017e',	'QdiKLRuLbI',	'Tsv0qq4xf4',	'',	1,	1,	0,	'',	'2022-09-30 09:54:57',	'2022-09-30 09:54:57',	0,	'2022-10-01 04:39:09',	0,	0);

CREATE TABLE `user_auth` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `auth_module` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth_id` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `o_auth_access_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `o_auth_refresh_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `o_auth_token_type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `o_auth_expiry` datetime DEFAULT NULL,
  `o_auth_id_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_user_auth_auth_module_auth_id` (`auth_module`,`auth_id`),
  KEY `IDX_user_auth_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `user_auth_token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `auth_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prev_auth_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth_token_seen` tinyint(1) NOT NULL,
  `seen_at` int DEFAULT NULL,
  `rotated_at` int NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NOT NULL,
  `revoked_at` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_auth_token_auth_token` (`auth_token`),
  UNIQUE KEY `UQE_user_auth_token_prev_auth_token` (`prev_auth_token`),
  KEY `IDX_user_auth_token_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `user_auth_token` (`id`, `user_id`, `auth_token`, `prev_auth_token`, `user_agent`, `client_ip`, `auth_token_seen`, `seen_at`, `rotated_at`, `created_at`, `updated_at`, `revoked_at`) VALUES
(1,	1,	'25e9c21962de2fdd925079ab9c6e2883a033c41acfccf9ba9479e7919e3ee9fc',	'e6c2962d79f81c54da7a73282a011f1b409906232f0a4b2dea7651d65365928f',	'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36',	'172.21.0.1',	1,	1664598168,	1664598167,	1664544092,	1664544092,	0);

CREATE TABLE `user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_role_org_id_user_id_role_id` (`org_id`,`user_id`,`role_id`),
  KEY `IDX_user_role_org_id` (`org_id`),
  KEY `IDX_user_role_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `user_role` (`id`, `org_id`, `user_id`, `role_id`, `created`) VALUES
(1,	1,	1,	1,	'2022-09-30 19:26:37');

-- 2022-10-01 04:42:38

SET FOREIGN_KEY_CHECKS = 1;
