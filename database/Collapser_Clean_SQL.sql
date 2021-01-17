-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: Mar 18, 2017 as 08:46 
-- Versão do Servidor: 5.1.41
-- Versão do PHP: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `styller`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL,
  `salt` varchar(40) NOT NULL DEFAULT '',
  `premdays` int(11) NOT NULL DEFAULT '0',
  `lastday` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `key` varchar(32) NOT NULL DEFAULT '0',
  `blocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'internal usage',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '1',
  `page_lastday` int(11) NOT NULL,
  `email_new` varchar(255) NOT NULL,
  `email_new_time` int(15) NOT NULL,
  `created` int(11) NOT NULL DEFAULT '0',
  `rlname` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `page_access` int(11) NOT NULL DEFAULT '0',
  `email_code` varchar(255) NOT NULL DEFAULT '0',
  `next_email` int(11) NOT NULL DEFAULT '0',
  `premium_points` int(11) NOT NULL DEFAULT '0',
  `vote` int(11) NOT NULL,
  `last_post` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(255) NOT NULL,
  `vip_time` int(11) NOT NULL DEFAULT '0',
  `guild_points` int(11) NOT NULL DEFAULT '0',
  `guild_points_stats` int(11) NOT NULL DEFAULT '0',
  `loot_time` int(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `salt`, `premdays`, `lastday`, `email`, `key`, `blocked`, `warnings`, `group_id`, `page_lastday`, `email_new`, `email_new_time`, `created`, `rlname`, `location`, `page_access`, `email_code`, `next_email`, `premium_points`, `vote`, `last_post`, `flag`, `vip_time`, `guild_points`, `guild_points_stats`, `loot_time`) VALUES
(1, '0', 'b6589fc6ab0dc82cf12099d1c2d40ab994e8410c', '', 65535, 0, '', '0', 0, 0, 1, 1489877020, '', 0, 1374647117, '', '', 999999, '0', 0, 0, 0, 0, '', 0, 0, 0, 0),
(2, '1', '356a192b7913b04c54574d18c28d46e6395428ab', '', 65535, 0, '', '0', 0, 0, 1, 1489877020, '', 0, 1374647117, '', '', 999999, '0', 0, 0, 0, 0, '', 0, 0, 0, 0),
(3, 'sample', '52527d68407a977702f53b16c82fedb988db6999', '', 2, 0, 'vitorsubhi@gmail.com', '0', 0, 0, 1, 0, '', 0, 1489880646, '', '', 0, '0', 0, 0, 0, 0, '', 0, 0, 0, 0);

--
-- Gatilhos `accounts`
--
DROP TRIGGER IF EXISTS `ondelete_accounts`;
DELIMITER //
CREATE TRIGGER `ondelete_accounts` BEFORE DELETE ON `accounts`
 FOR EACH ROW BEGIN
	DELETE FROM `bans` WHERE `type` IN (3, 4) AND `value` = OLD.`id`;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_storage`
--

CREATE TABLE IF NOT EXISTS `account_storage` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_id_2` (`account_id`,`key`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `account_storage`
--

INSERT INTO `account_storage` (`account_id`, `key`, `value`) VALUES
(8459649, 93871, '2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_viplist`
--

CREATE TABLE IF NOT EXISTS `account_viplist` (
  `account_id` int(11) NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `description` varchar(128) NOT NULL,
  `icon` int(11) unsigned NOT NULL,
  `notify` tinyint(1) NOT NULL,
  UNIQUE KEY `account_id_2` (`account_id`,`player_id`),
  KEY `account_id` (`account_id`),
  KEY `player_id` (`player_id`),
  KEY `world_id` (`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `account_viplist`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `announcements`
--

CREATE TABLE IF NOT EXISTS `announcements` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `text` varchar(255) NOT NULL,
  `date` varchar(20) NOT NULL,
  `author` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `announcements`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '1 - ip, 2 - player, 3 - account, 4 - notation',
  `value` int(10) unsigned NOT NULL COMMENT 'ip - ip address, player - player_id, account - account_id, notation - account_id',
  `param` int(10) unsigned NOT NULL COMMENT 'ip - mask, player - type (1 - report, 2 - lock, 3 - ban), account - player, notation - player',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `expires` int(11) NOT NULL DEFAULT '-1',
  `added` int(10) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `reason` int(10) unsigned NOT NULL DEFAULT '0',
  `action` int(10) unsigned NOT NULL DEFAULT '0',
  `statement` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`value`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `bans`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `ban_table`
--

CREATE TABLE IF NOT EXISTS `ban_table` (
  `id` int(11) NOT NULL,
  `account` int(11) NOT NULL,
  `added` int(11) NOT NULL,
  `expires` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `ban_table`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `death_list`
--

CREATE TABLE IF NOT EXISTS `death_list` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `killer_name` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `death_list`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `environment_killers`
--

CREATE TABLE IF NOT EXISTS `environment_killers` (
  `kill_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  KEY `kill_id` (`kill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `environment_killers`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `global_storage`
--

CREATE TABLE IF NOT EXISTS `global_storage` (
  `key` varchar(32) NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  UNIQUE KEY `key` (`key`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `global_storage`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `guilds`
--

CREATE TABLE IF NOT EXISTS `guilds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `checkdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL,
  `balance` bigint(20) unsigned NOT NULL,
  `description` text NOT NULL,
  `logo_gfx_name` varchar(255) NOT NULL DEFAULT '',
  `last_execute_points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `guilds`
--


--
-- Gatilhos `guilds`
--
DROP TRIGGER IF EXISTS `oncreate_guilds`;
DELIMITER //
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds`
 FOR EACH ROW BEGIN
	INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Leader', 3, NEW.`id`);
	INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Vice-Leader', 2, NEW.`id`);
	INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Member', 1, NEW.`id`);
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `ondelete_guilds`;
DELIMITER //
CREATE TRIGGER `ondelete_guilds` BEFORE DELETE ON `guilds`
 FOR EACH ROW BEGIN
	UPDATE `players` SET `guildnick` = '', `rank_id` = 0 WHERE `rank_id` IN (SELECT `id` FROM `guild_ranks` WHERE `guild_id` = OLD.`id`);
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_invites`
--

CREATE TABLE IF NOT EXISTS `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `player_id` (`player_id`,`guild_id`),
  KEY `guild_id` (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `guild_invites`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_kills`
--

CREATE TABLE IF NOT EXISTS `guild_kills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `war_id` int(11) NOT NULL,
  `death_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `guild_id` (`guild_id`),
  KEY `war_id` (`war_id`),
  KEY `death_id` (`death_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `guild_kills`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_ranks`
--

CREATE TABLE IF NOT EXISTS `guild_ranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `level` int(11) NOT NULL COMMENT '1 - leader, 2 - vice leader, 3 - member',
  PRIMARY KEY (`id`),
  KEY `guild_id` (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `guild_ranks`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_wars`
--

CREATE TABLE IF NOT EXISTS `guild_wars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `enemy_id` int(11) NOT NULL,
  `begin` bigint(20) NOT NULL DEFAULT '0',
  `end` bigint(20) NOT NULL DEFAULT '0',
  `frags` int(10) unsigned NOT NULL DEFAULT '0',
  `payment` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guild_kills` int(10) unsigned NOT NULL DEFAULT '0',
  `enemy_kills` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `guild_id` (`guild_id`),
  KEY `enemy_id` (`enemy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `guild_wars`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `houses`
--

CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL,
  `paid` int(10) unsigned NOT NULL DEFAULT '0',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `lastwarning` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `town` int(10) unsigned NOT NULL DEFAULT '0',
  `size` int(10) unsigned NOT NULL DEFAULT '0',
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `rent` int(10) unsigned NOT NULL DEFAULT '0',
  `doors` int(10) unsigned NOT NULL DEFAULT '0',
  `beds` int(10) unsigned NOT NULL DEFAULT '0',
  `tiles` int(10) unsigned NOT NULL DEFAULT '0',
  `guild` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `clear` tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `houses`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `house_auctions`
--

CREATE TABLE IF NOT EXISTS `house_auctions` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `bid` int(10) unsigned NOT NULL DEFAULT '0',
  `limit` int(10) unsigned NOT NULL DEFAULT '0',
  `endtime` bigint(20) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `house_id` (`house_id`,`world_id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `house_auctions`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `house_data`
--

CREATE TABLE IF NOT EXISTS `house_data` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `data` longblob NOT NULL,
  UNIQUE KEY `house_id` (`house_id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `house_data`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `house_lists`
--

CREATE TABLE IF NOT EXISTS `house_lists` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `listid` int(11) NOT NULL,
  `list` text NOT NULL,
  UNIQUE KEY `house_id` (`house_id`,`world_id`,`listid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `house_lists`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `killers`
--

CREATE TABLE IF NOT EXISTS `killers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `death_id` int(11) NOT NULL,
  `final_hit` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `unjustified` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `war` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `death_id` (`death_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `killers`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `login_history`
--

CREATE TABLE IF NOT EXISTS `login_history` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `login` tinyint(1) NOT NULL DEFAULT '0',
  `ip` int(11) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL DEFAULT '0',
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `login_history`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `lottery`
--

CREATE TABLE IF NOT EXISTS `lottery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `item_name` varchar(255) NOT NULL,
  `date` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `lottery`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `market_history`
--

CREATE TABLE IF NOT EXISTS `market_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `expires_at` bigint(20) unsigned NOT NULL,
  `inserted` bigint(20) unsigned NOT NULL,
  `state` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`,`sale`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `market_history`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `market_offers`
--

CREATE TABLE IF NOT EXISTS `market_offers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `created` bigint(20) unsigned NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT '0',
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sale` (`sale`,`itemtype`),
  KEY `created` (`created`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `market_offers`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `marriage_system`
--

CREATE TABLE IF NOT EXISTS `marriage_system` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `partner` varchar(255) NOT NULL,
  `marriage_date` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `marriage_system`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `pagsegurotransacoes`
--

CREATE TABLE IF NOT EXISTS `pagsegurotransacoes` (
  `TransacaoID` varchar(36) NOT NULL,
  `VendedorEmail` varchar(200) NOT NULL,
  `Referencia` varchar(200) DEFAULT NULL,
  `TipoFrete` char(2) DEFAULT NULL,
  `ValorFrete` decimal(10,2) DEFAULT NULL,
  `Extras` decimal(10,2) DEFAULT NULL,
  `Anotacao` text,
  `TipoPagamento` varchar(50) NOT NULL,
  `StatusTransacao` varchar(50) NOT NULL,
  `CliNome` varchar(200) NOT NULL,
  `CliEmail` varchar(200) NOT NULL,
  `CliEndereco` varchar(200) NOT NULL,
  `CliNumero` varchar(10) DEFAULT NULL,
  `CliComplemento` varchar(100) DEFAULT NULL,
  `CliBairro` varchar(100) NOT NULL,
  `CliCidade` varchar(100) NOT NULL,
  `CliEstado` char(2) NOT NULL,
  `CliCEP` varchar(9) NOT NULL,
  `CliTelefone` varchar(14) DEFAULT NULL,
  `NumItens` int(11) NOT NULL,
  `Data` datetime NOT NULL,
  `ProdQuantidade_x` int(5) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `TransacaoID` (`TransacaoID`,`StatusTransacao`),
  KEY `Referencia` (`Referencia`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `pagsegurotransacoes`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `lookmount` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `soul` int(10) unsigned NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT '0',
  `sex` int(11) NOT NULL DEFAULT '0',
  `lastlogin` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lastip` int(10) unsigned NOT NULL DEFAULT '0',
  `save` tinyint(1) NOT NULL DEFAULT '1',
  `skull` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `skulltime` int(11) NOT NULL DEFAULT '0',
  `rank_id` int(11) NOT NULL DEFAULT '0',
  `guildnick` varchar(255) NOT NULL DEFAULT '',
  `lastlogout` bigint(20) unsigned NOT NULL DEFAULT '0',
  `blessings` tinyint(2) NOT NULL DEFAULT '0',
  `pvp_blessing` tinyint(1) NOT NULL DEFAULT '0',
  `balance` bigint(20) unsigned NOT NULL DEFAULT '0',
  `stamina` bigint(20) unsigned NOT NULL DEFAULT '151200000' COMMENT 'stored in miliseconds',
  `direction` int(11) NOT NULL DEFAULT '2',
  `loss_experience` int(11) NOT NULL DEFAULT '100',
  `loss_mana` int(11) NOT NULL DEFAULT '100',
  `loss_skills` int(11) NOT NULL DEFAULT '100',
  `loss_containers` int(11) NOT NULL DEFAULT '100',
  `loss_items` int(11) NOT NULL DEFAULT '100',
  `premend` int(11) NOT NULL DEFAULT '0' COMMENT 'NOT IN USE BY THE SERVER',
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `marriage` int(10) unsigned NOT NULL DEFAULT '0',
  `promotion` int(11) NOT NULL DEFAULT '0',
  `deleted` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `offlinetraining_time` smallint(5) unsigned NOT NULL DEFAULT '43200',
  `offlinetraining_skill` int(11) NOT NULL DEFAULT '-1',
  `created` int(11) NOT NULL DEFAULT '0',
  `nick_verify` int(11) NOT NULL DEFAULT '0',
  `old_name` varchar(255) NOT NULL DEFAULT '',
  `hide_char` int(11) NOT NULL DEFAULT '0',
  `worldtransfer` int(11) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `show_outfit` tinyint(4) NOT NULL DEFAULT '1',
  `show_eq` tinyint(4) NOT NULL DEFAULT '1',
  `show_bars` tinyint(4) NOT NULL DEFAULT '1',
  `show_skills` tinyint(4) NOT NULL DEFAULT '1',
  `show_quests` tinyint(4) NOT NULL DEFAULT '1',
  `stars` int(10) NOT NULL DEFAULT '0',
  `ip` varchar(17) NOT NULL DEFAULT '0',
  `cast` tinyint(4) NOT NULL DEFAULT '0',
  `castViewers` int(11) NOT NULL DEFAULT '0',
  `castDescription` varchar(255) NOT NULL,
  `broadcasting` tinyint(4) DEFAULT '0',
  `viewers` int(1) DEFAULT '0',
  `frags` int(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`deleted`),
  KEY `account_id` (`account_id`),
  KEY `group_id` (`group_id`),
  KEY `online` (`online`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Extraindo dados da tabela `players`
--

INSERT INTO `players` (`id`, `name`, `world_id`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `lookmount`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `rank_id`, `guildnick`, `lastlogout`, `blessings`, `pvp_blessing`, `balance`, `stamina`, `direction`, `loss_experience`, `loss_mana`, `loss_skills`, `loss_containers`, `loss_items`, `premend`, `online`, `marriage`, `promotion`, `deleted`, `description`, `offlinetraining_time`, `offlinetraining_skill`, `created`, `nick_verify`, `old_name`, `hide_char`, `worldtransfer`, `comment`, `show_outfit`, `show_eq`, `show_bars`, `show_skills`, `show_quests`, `stars`, `ip`, `cast`, `castViewers`, `castDescription`, `broadcasting`, `viewers`, `frags`) VALUES
(1, 'Account Manager', 0, 1, 2, 1, 0, 150, 150, 0, 30, 50, 20, 40, 225, 0, 0, 0, 0, 0, 0, 0, 0, 160, 51, 7, '', 400, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(2, 'Rook Sample', 0, 1, 3, 1, 0, 185, 185, 0, 0, 0, 0, 0, 110, 0, 0, 0, 0, 0, 0, 0, 0, 50, 50, 7, '', 400, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(3, 'Sorcerer Sample', 0, 1, 3, 8, 1, 185, 185, 4200, 68, 114, 78, 58, 128, 0, 0, 0, 35, 35, 0, 0, 2, 32369, 32241, 7, '', 400, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(4, 'Druid Sample', 0, 1, 3, 8, 2, 185, 185, 4200, 68, 114, 78, 58, 128, 0, 0, 0, 35, 35, 0, 0, 2, 32369, 32241, 7, '', 400, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(5, 'Paladin Sample', 0, 1, 3, 8, 3, 185, 185, 4200, 68, 114, 78, 58, 128, 0, 0, 0, 35, 35, 0, 0, 2, 32369, 32241, 7, '', 500, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(6, 'Knight Sample', 0, 1, 3, 8, 4, 185, 185, 4200, 68, 114, 78, 58, 128, 0, 0, 0, 35, 35, 0, 0, 2, 160, 51, 7, '', 550, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0);

--
-- Gatilhos `players`
--
DROP TRIGGER IF EXISTS `oncreate_players`;
DELIMITER //
CREATE TRIGGER `oncreate_players` AFTER INSERT ON `players`
 FOR EACH ROW BEGIN
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 0, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 1, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 2, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 3, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 4, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 5, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 6, 10);
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `ondelete_players`;
DELIMITER //
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players`
 FOR EACH ROW BEGIN
	DELETE FROM `bans` WHERE `type` IN (2, 5) AND `value` = OLD.`id`;
	UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_deaths`
--

CREATE TABLE IF NOT EXISTS `player_deaths` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `date` bigint(20) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `player_deaths`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_depotitems`
--

CREATE TABLE IF NOT EXISTS `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range, eg. 0-100 is reserved for depot lockers and all above 100 will be normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  `m_uid` int(11) NOT NULL DEFAULT '0',
  `serial` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_depotitems`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_inboxitems`
--

CREATE TABLE IF NOT EXISTS `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  `serial` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_inboxitems`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_items`
--

CREATE TABLE IF NOT EXISTS `player_items` (
  `player_id` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  `m_uid` int(11) NOT NULL DEFAULT '0',
  `serial` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_items`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_killers`
--

CREATE TABLE IF NOT EXISTS `player_killers` (
  `kill_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  KEY `kill_id` (`kill_id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_killers`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_namelocks`
--

CREATE TABLE IF NOT EXISTS `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `new_name` varchar(255) NOT NULL,
  `date` bigint(20) NOT NULL DEFAULT '0',
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_namelocks`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_skills`
--

CREATE TABLE IF NOT EXISTS `player_skills` (
  `player_id` int(11) NOT NULL,
  `skillid` tinyint(2) NOT NULL DEFAULT '0',
  `value` int(10) unsigned NOT NULL DEFAULT '0',
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `player_id_2` (`player_id`,`skillid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_skills`
--

INSERT INTO `player_skills` (`player_id`, `skillid`, `value`, `count`) VALUES
(2, 0, 10, 0),
(2, 1, 10, 0),
(2, 2, 10, 0),
(2, 3, 10, 0),
(2, 4, 10, 0),
(2, 5, 10, 0),
(2, 6, 10, 0),
(3, 0, 10, 0),
(3, 1, 10, 0),
(3, 2, 10, 0),
(3, 3, 10, 0),
(3, 4, 10, 0),
(3, 5, 10, 0),
(3, 6, 10, 0),
(4, 0, 10, 0),
(4, 1, 10, 0),
(4, 2, 10, 0),
(4, 3, 10, 0),
(4, 4, 10, 0),
(4, 5, 10, 0),
(4, 6, 10, 0),
(5, 0, 10, 0),
(5, 1, 10, 0),
(5, 2, 10, 0),
(5, 3, 10, 0),
(5, 4, 10, 0),
(5, 5, 10, 0),
(5, 6, 10, 0),
(6, 0, 10, 0),
(6, 1, 10, 0),
(6, 2, 10, 0),
(6, 3, 10, 0),
(6, 4, 10, 0),
(6, 5, 10, 0),
(6, 6, 10, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_spells`
--

CREATE TABLE IF NOT EXISTS `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`name`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_spells`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_statements`
--

CREATE TABLE IF NOT EXISTS `player_statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL DEFAULT '0',
  `text` varchar(255) NOT NULL,
  `date` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `player_statements`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_storage`
--

CREATE TABLE IF NOT EXISTS `player_storage` (
  `player_id` int(11) NOT NULL,
  `key` varchar(32) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`key`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_storage`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_viplist`
--

CREATE TABLE IF NOT EXISTS `player_viplist` (
  `player_id` int(11) NOT NULL,
  `vip_id` int(11) NOT NULL,
  `description` varchar(128) NOT NULL,
  `icon` int(11) unsigned NOT NULL,
  `notify` tinyint(1) NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`vip_id`),
  KEY `player_id` (`player_id`),
  KEY `vip_id` (`vip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_viplist`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `server_config`
--

CREATE TABLE IF NOT EXISTS `server_config` (
  `config` varchar(35) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `config` (`config`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('db_version', '41'),
('encryption', '2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_motd`
--

CREATE TABLE IF NOT EXISTS `server_motd` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  UNIQUE KEY `id` (`id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `server_motd`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_record`
--

CREATE TABLE IF NOT EXISTS `server_record` (
  `record` int(11) NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL,
  UNIQUE KEY `record` (`record`,`world_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `server_record`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_reports`
--

CREATE TABLE IF NOT EXISTS `server_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '1',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL DEFAULT '0',
  `report` text NOT NULL,
  `reads` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `world_id` (`world_id`),
  KEY `reads` (`reads`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `server_reports`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `shop_npc`
--

CREATE TABLE IF NOT EXISTS `shop_npc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `price` int(11) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `shop_npc`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `thanks`
--

CREATE TABLE IF NOT EXISTS `thanks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(30) NOT NULL,
  `forum_id` text NOT NULL,
  `player_name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `thanks`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `tiles`
--

CREATE TABLE IF NOT EXISTS `tiles` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `house_id` int(10) unsigned NOT NULL,
  `x` int(5) unsigned NOT NULL,
  `y` int(5) unsigned NOT NULL,
  `z` tinyint(2) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`,`world_id`),
  KEY `x` (`x`,`y`,`z`),
  KEY `house_id` (`house_id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tiles`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `tile_items`
--

CREATE TABLE IF NOT EXISTS `tile_items` (
  `tile_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  `serial` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `tile_id` (`tile_id`,`world_id`,`sid`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tile_items`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `tile_store`
--

CREATE TABLE IF NOT EXISTS `tile_store` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `data` longblob NOT NULL,
  KEY `house_id` (`house_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tile_store`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `videos`
--

CREATE TABLE IF NOT EXISTS `videos` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(20) NOT NULL,
  `url` varchar(50) NOT NULL,
  `autor` varchar(20) NOT NULL,
  `data` varchar(50) NOT NULL,
  `tag` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `videos`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `woe`
--

CREATE TABLE IF NOT EXISTS `woe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `started` int(11) NOT NULL,
  `guild` int(11) NOT NULL,
  `breaker` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `woe`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_bug_logs`
--

CREATE TABLE IF NOT EXISTS `z_bug_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_bug_logs`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_forum`
--

CREATE TABLE IF NOT EXISTS `z_forum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `first_post` int(11) NOT NULL DEFAULT '0',
  `last_post` int(11) NOT NULL DEFAULT '0',
  `section` int(3) NOT NULL DEFAULT '0',
  `icon_id` int(3) NOT NULL DEFAULT '1',
  `replies` int(20) NOT NULL DEFAULT '0',
  `views` int(20) NOT NULL DEFAULT '0',
  `author_aid` int(20) NOT NULL DEFAULT '0',
  `author_guid` int(20) NOT NULL DEFAULT '0',
  `post_text` text NOT NULL,
  `post_topic` varchar(255) NOT NULL,
  `post_smile` tinyint(1) NOT NULL DEFAULT '0',
  `post_date` int(20) NOT NULL DEFAULT '0',
  `last_edit_aid` int(20) NOT NULL DEFAULT '0',
  `edit_date` int(20) NOT NULL DEFAULT '0',
  `post_ip` varchar(32) NOT NULL DEFAULT '0.0.0.0',
  PRIMARY KEY (`id`),
  KEY `section` (`section`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_forum`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_helpdesk`
--

CREATE TABLE IF NOT EXISTS `z_helpdesk` (
  `account` varchar(255) NOT NULL,
  `type` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `text` text NOT NULL,
  `id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  `reply` int(11) NOT NULL,
  `who` int(11) NOT NULL,
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `tag` int(11) NOT NULL,
  `registered` int(11) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_helpdesk`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_monsters`
--

CREATE TABLE IF NOT EXISTS `z_monsters` (
  `hide_creature` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `mana` int(11) NOT NULL,
  `exp` int(11) NOT NULL,
  `health` int(11) NOT NULL,
  `speed_lvl` int(11) NOT NULL DEFAULT '1',
  `use_haste` tinyint(1) NOT NULL,
  `voices` text NOT NULL,
  `immunities` varchar(255) NOT NULL,
  `summonable` tinyint(1) NOT NULL,
  `convinceable` tinyint(1) NOT NULL,
  `race` varchar(255) NOT NULL,
  `loot` text NOT NULL,
  `gfx_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_monsters`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_news_tickers`
--

CREATE TABLE IF NOT EXISTS `z_news_tickers` (
  `date` int(11) NOT NULL DEFAULT '1',
  `author` int(11) NOT NULL,
  `image_id` int(3) NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `hide_ticker` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_news_tickers`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_ots_comunication`
--

CREATE TABLE IF NOT EXISTS `z_ots_comunication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `param1` varchar(255) NOT NULL,
  `param2` varchar(255) NOT NULL,
  `param3` varchar(255) NOT NULL,
  `param4` varchar(255) NOT NULL,
  `param5` varchar(255) NOT NULL,
  `param6` varchar(255) NOT NULL,
  `param7` varchar(255) NOT NULL,
  `delete_it` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Extraindo dados da tabela `z_ots_comunication`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_polls`
--

CREATE TABLE IF NOT EXISTS `z_polls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL,
  `end` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `answers` int(11) NOT NULL,
  `votes_all` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_polls`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_polls_answers`
--

CREATE TABLE IF NOT EXISTS `z_polls_answers` (
  `poll_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `votes` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_polls_answers`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shopguild_history_item`
--

CREATE TABLE IF NOT EXISTS `z_shopguild_history_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `offer_id` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shopguild_history_item`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shopguild_history_pacc`
--

CREATE TABLE IF NOT EXISTS `z_shopguild_history_pacc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `pacc_days` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shopguild_history_pacc`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shopguild_offer`
--

CREATE TABLE IF NOT EXISTS `z_shopguild_offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `points` int(11) NOT NULL DEFAULT '0',
  `itemid1` int(11) NOT NULL DEFAULT '0',
  `count1` int(11) NOT NULL DEFAULT '0',
  `itemid2` int(11) NOT NULL DEFAULT '0',
  `count2` int(11) NOT NULL DEFAULT '0',
  `offer_type` varchar(255) DEFAULT NULL,
  `offer_description` text NOT NULL,
  `offer_name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shopguild_offer`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shop_history_item`
--

CREATE TABLE IF NOT EXISTS `z_shop_history_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `offer_id` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shop_history_item`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shop_history_pacc`
--

CREATE TABLE IF NOT EXISTS `z_shop_history_pacc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `pacc_days` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shop_history_pacc`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shop_offer`
--

CREATE TABLE IF NOT EXISTS `z_shop_offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `points` int(11) NOT NULL DEFAULT '0',
  `itemid1` int(11) NOT NULL DEFAULT '0',
  `count1` int(11) NOT NULL DEFAULT '0',
  `itemid2` int(11) NOT NULL DEFAULT '0',
  `count2` int(11) NOT NULL DEFAULT '0',
  `offer_type` varchar(255) DEFAULT NULL,
  `offer_description` text NOT NULL,
  `offer_name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shop_offer`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_spells`
--

CREATE TABLE IF NOT EXISTS `z_spells` (
  `name` varchar(255) NOT NULL,
  `spell` varchar(255) NOT NULL,
  `spell_type` varchar(255) NOT NULL,
  `mana` int(11) NOT NULL DEFAULT '0',
  `lvl` int(11) NOT NULL DEFAULT '0',
  `mlvl` int(11) NOT NULL DEFAULT '0',
  `soul` int(11) NOT NULL DEFAULT '0',
  `pacc` varchar(255) NOT NULL,
  `vocations` varchar(255) NOT NULL,
  `conj_count` int(11) NOT NULL DEFAULT '0',
  `hide_spell` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_spells`
--

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `environment_killers`
--
ALTER TABLE `environment_killers`
  ADD CONSTRAINT `environment_killers_ibfk_1` FOREIGN KEY (`kill_id`) REFERENCES `killers` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `guild_kills`
--
ALTER TABLE `guild_kills`
  ADD CONSTRAINT `guild_kills_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_kills_ibfk_2` FOREIGN KEY (`war_id`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_kills_ibfk_3` FOREIGN KEY (`death_id`) REFERENCES `player_deaths` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD CONSTRAINT `guild_wars_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_wars_ibfk_2` FOREIGN KEY (`enemy_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `house_auctions`
--
ALTER TABLE `house_auctions`
  ADD CONSTRAINT `house_auctions_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `house_auctions_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `house_data`
--
ALTER TABLE `house_data`
  ADD CONSTRAINT `house_data_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `killers`
--
ALTER TABLE `killers`
  ADD CONSTRAINT `killers_ibfk_1` FOREIGN KEY (`death_id`) REFERENCES `player_deaths` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `login_history`
--
ALTER TABLE `login_history`
  ADD CONSTRAINT `login_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`);

--
-- Restrições para a tabela `market_history`
--
ALTER TABLE `market_history`
  ADD CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `market_offers`
--
ALTER TABLE `market_offers`
  ADD CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD CONSTRAINT `player_inboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_killers`
--
ALTER TABLE `player_killers`
  ADD CONSTRAINT `player_killers_ibfk_1` FOREIGN KEY (`kill_id`) REFERENCES `killers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `player_killers_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_skills`
--
ALTER TABLE `player_skills`
  ADD CONSTRAINT `player_skills_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_statements`
--
ALTER TABLE `player_statements`
  ADD CONSTRAINT `player_statements_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_viplist`
--
ALTER TABLE `player_viplist`
  ADD CONSTRAINT `player_viplist_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `player_viplist_ibfk_2` FOREIGN KEY (`vip_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `server_reports`
--
ALTER TABLE `server_reports`
  ADD CONSTRAINT `server_reports_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `tiles`
--
ALTER TABLE `tiles`
  ADD CONSTRAINT `tiles_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `tile_items`
--
ALTER TABLE `tile_items`
  ADD CONSTRAINT `tile_items_ibfk_1` FOREIGN KEY (`tile_id`) REFERENCES `tiles` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
