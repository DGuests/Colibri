-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22/02/2022 às 13:31
-- Versão do servidor: 10.4.18-MariaDB
-- Versão do PHP: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `addlist`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_base_paginas`
--

CREATE TABLE `tb_base_paginas` (
  `p_pag_id` int(11) NOT NULL,
  `s_pag_nome` varchar(100) DEFAULT NULL,
  `i_pag_entradas` int(11) DEFAULT NULL,
  `i_pag_click_especial` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_bnf_beneficio`
--

CREATE TABLE `tb_bnf_beneficio` (
  `p_bnf_id` int(11) NOT NULL,
  `s_bnf_nome` varchar(45) NOT NULL,
  `n_bnf_vip_m` int(11) DEFAULT NULL COMMENT 'Armazena a qtd de Vips Masculinos',
  `n_bnf_vip_f` int(11) DEFAULT NULL COMMENT 'Armazena a qtd de Vips Femininos',
  `n_bnf_diamantes` int(11) DEFAULT NULL,
  `f_bnf_usuario` int(11) DEFAULT NULL,
  `t_bnf_data_cadastro` datetime DEFAULT NULL,
  `b_bnf_principal` tinyint(1) NOT NULL DEFAULT 0,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_bnf_beneficio`
--

INSERT INTO `tb_bnf_beneficio` (`p_bnf_id`, `s_bnf_nome`, `n_bnf_vip_m`, `n_bnf_vip_f`, `n_bnf_diamantes`, `f_bnf_usuario`, `t_bnf_data_cadastro`, `b_bnf_principal`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(82, 'Benefício OC', NULL, NULL, NULL, 3078, '2021-07-19 18:02:47', 0, '2021-07-19 18:02:47', '2021-07-19 18:02:47', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_bnf_condicional`
--

CREATE TABLE `tb_bnf_condicional` (
  `p_cnd_id` int(11) NOT NULL,
  `f_bnf_id` int(11) NOT NULL,
  `n_cnd_de` int(11) DEFAULT NULL COMMENT 'Armazena a quantidade minima para entregar o benefício',
  `s_cnd_beneficio` text DEFAULT NULL COMMENT 'Armazena a descrição do benefício.',
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_bnf_condicional`
--

INSERT INTO `tb_bnf_condicional` (`p_cnd_id`, `f_bnf_id`, `n_cnd_de`, `s_cnd_beneficio`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(64, 82, 10, '1 Espumante', '2021-07-19 18:02:47', '2021-07-19 18:02:47', NULL),
(65, 82, 20, '1 combo Absolut + Red Bull', '2021-07-19 18:02:47', '2021-07-19 18:02:47', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_bnf_garantido`
--

CREATE TABLE `tb_bnf_garantido` (
  `p_grt_id` int(11) NOT NULL,
  `f_bnf_id` int(11) NOT NULL,
  `s_grt_beneficio` text DEFAULT NULL COMMENT 'Armazena o benefício garantido.',
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_bnf_garantido`
--

INSERT INTO `tb_bnf_garantido` (`p_grt_id`, `f_bnf_id`, `s_grt_beneficio`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(95, 82, '6 Cervejas', '2021-07-19 18:02:47', '2021-07-19 18:02:47', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_cid_cidade`
--

CREATE TABLE `tb_cid_cidade` (
  `p_cid_id` int(11) UNSIGNED NOT NULL,
  `s_cid_nome` varchar(50) NOT NULL DEFAULT '',
  `s_cid_nome_abreviado` varchar(11) NOT NULL DEFAULT '',
  `f_cid_uf` int(11) DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `f_cid_pais` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_cid_cidade_regiao`
--

CREATE TABLE `tb_cid_cidade_regiao` (
  `p_reg_regiao` int(11) UNSIGNED NOT NULL,
  `s_reg_nome` varchar(50) NOT NULL DEFAULT '',
  `f_reg_cidade` int(11) NOT NULL,
  `s_latitude_min` varchar(25) DEFAULT NULL,
  `s_longitude_min` varchar(25) DEFAULT NULL,
  `s_latitude_max` varchar(25) DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_cid_cidade_regiao`
--

INSERT INTO `tb_cid_cidade_regiao` (`p_reg_regiao`, `s_reg_nome`, `f_reg_cidade`, `s_latitude_min`, `s_longitude_min`, `s_latitude_max`, `updatedAt`, `createdAt`) VALUES
(1, 'Zona Sul', 1, NULL, NULL, NULL, '2021-07-19 18:09:15', '2021-07-19 18:09:15');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_data_cardapio`
--

CREATE TABLE `tb_data_cardapio` (
  `p_car_id` int(11) UNSIGNED NOT NULL,
  `n_car_entradas` int(11) NOT NULL DEFAULT 0,
  `f_car_estabelecimento` int(11) NOT NULL,
  `t_car_data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_data_cardapio`
--

INSERT INTO `tb_data_cardapio` (`p_car_id`, `n_car_entradas`, `f_car_estabelecimento`, `t_car_data`) VALUES
(32315, 4, 3078, '2021-08-02'),
(32316, 5, 3078, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_data_link_bio`
--

CREATE TABLE `tb_data_link_bio` (
  `p_link_id` int(11) UNSIGNED NOT NULL,
  `n_link_entradas` int(11) NOT NULL DEFAULT 0,
  `f_link_estabelecimento` int(11) NOT NULL,
  `t_link_data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_categoria`
--

CREATE TABLE `tb_est_fin_categoria` (
  `p_cat_id` int(11) UNSIGNED NOT NULL,
  `s_cat_titulo` varchar(255) NOT NULL DEFAULT '',
  `s_cat_titulo_ingles` varchar(255) DEFAULT NULL,
  `s_cat_titulo_espanhol` varchar(255) DEFAULT NULL,
  `s_cat_cor` varchar(15) DEFAULT NULL,
  `f_cat_usuario` int(11) NOT NULL,
  `s_cat_icone` varchar(35) DEFAULT NULL,
  `b_cat_visivel` tinyint(1) NOT NULL DEFAULT 1,
  `n_cat_ordem` int(11) DEFAULT NULL,
  `s_cat_tipo_cardapio` varchar(1) NOT NULL DEFAULT 'a',
  `s_cat_observacao` text DEFAULT NULL,
  `n_cat_preco` decimal(10,0) DEFAULT NULL,
  `f_cat_cozinha` int(11) DEFAULT NULL,
  `f_cat_meio_meio` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_est_fin_categoria`
--

INSERT INTO `tb_est_fin_categoria` (`p_cat_id`, `s_cat_titulo`, `s_cat_titulo_ingles`, `s_cat_titulo_espanhol`, `s_cat_cor`, `f_cat_usuario`, `s_cat_icone`, `b_cat_visivel`, `n_cat_ordem`, `s_cat_tipo_cardapio`, `s_cat_observacao`, `n_cat_preco`, `f_cat_cozinha`, `f_cat_meio_meio`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(8035, 'Monte sua Pipoca', NULL, NULL, NULL, 3078, NULL, 0, 3, 'a', '', NULL, 5, NULL, '2021-08-16 12:00:36', '2021-08-16 12:00:36', NULL),
(8036, 'Cerveja', NULL, NULL, NULL, 3078, NULL, 0, 4, 'a', NULL, NULL, NULL, NULL, '2021-08-16 12:00:36', '2021-08-16 12:00:36', NULL),
(8037, 'Chás', NULL, NULL, NULL, 3078, NULL, 0, 2, 'a', NULL, NULL, NULL, NULL, '2021-08-16 12:00:36', '2021-08-16 12:00:36', NULL),
(8038, 'Cerveja2', NULL, NULL, NULL, 3078, NULL, 0, 5, 'a', NULL, NULL, NULL, NULL, '2021-08-16 12:00:36', '2021-08-16 12:00:36', NULL),
(8039, 'Dica 430', NULL, NULL, NULL, 3078, NULL, 1, NULL, 'a', NULL, NULL, NULL, NULL, '2021-08-23 14:15:47', '2021-08-23 14:15:47', '2021-08-23 19:13:16'),
(8040, 'Combos', NULL, NULL, NULL, 3078, NULL, 1, NULL, 'a', NULL, NULL, NULL, NULL, '2021-08-23 14:15:47', '2021-08-23 14:15:47', '2021-08-23 19:13:16'),
(8041, 'Mais Vendidos', NULL, NULL, NULL, 3078, NULL, 1, NULL, 'a', NULL, NULL, NULL, NULL, '2021-08-23 14:15:47', '2021-08-23 14:15:47', '2021-08-23 19:13:16'),
(8042, 'Entradas', NULL, NULL, NULL, 3078, NULL, 1, NULL, 'a', NULL, NULL, NULL, NULL, '2021-08-23 14:15:47', '2021-08-23 14:15:47', '2021-08-23 19:13:16'),
(8043, 'Pizzas Napoletanas Individuais', NULL, NULL, NULL, 3078, NULL, 1, NULL, 'a', NULL, NULL, NULL, NULL, '2021-08-23 14:15:47', '2021-08-23 14:15:47', '2021-08-23 19:13:16'),
(8044, 'Sobremesas', NULL, NULL, NULL, 3078, NULL, 1, NULL, 'a', NULL, NULL, NULL, NULL, '2021-08-23 14:15:47', '2021-08-23 14:15:47', '2021-08-23 19:13:16'),
(8045, 'Vai uma cervejinha?', NULL, NULL, NULL, 3078, NULL, 0, NULL, 'a', NULL, NULL, NULL, NULL, '2021-08-23 14:15:47', '2021-08-23 14:15:47', '2021-08-23 19:13:16'),
(8046, 'Um vinho para harmonizar?', NULL, NULL, NULL, 3078, NULL, 0, NULL, 'a', NULL, NULL, NULL, NULL, '2021-08-23 14:15:47', '2021-08-23 14:15:47', '2021-08-23 19:13:16'),
(8047, 'Você ja tem bebida em casa?', NULL, NULL, NULL, 3078, NULL, 0, NULL, 'a', NULL, NULL, NULL, NULL, '2021-08-23 14:15:47', '2021-08-23 14:15:47', '2021-08-23 19:13:16');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_categoria_grupos`
--

CREATE TABLE `tb_est_fin_categoria_grupos` (
  `p_grp_id` int(11) UNSIGNED NOT NULL,
  `f_grp_categoria` int(11) NOT NULL,
  `s_grp_titulo` varchar(55) NOT NULL DEFAULT '',
  `s_grp_titulo_ingles` varchar(55) DEFAULT NULL,
  `s_grp_titulo_espanhol` varchar(55) DEFAULT NULL,
  `n_grp_ordem` int(11) DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_categoria_horarios`
--

CREATE TABLE `tb_est_fin_categoria_horarios` (
  `p_hora_id` int(11) UNSIGNED NOT NULL,
  `f_hora_categoria` int(11) NOT NULL,
  `t_hora_inicio_seg` time DEFAULT NULL,
  `t_hora_fim_seg` time DEFAULT NULL,
  `t_hora_inicio_ter` time DEFAULT NULL,
  `t_hora_fim_ter` time DEFAULT NULL,
  `t_hora_inicio_qua` time DEFAULT NULL,
  `t_hora_fim_qua` time DEFAULT NULL,
  `t_hora_inicio_qui` time DEFAULT NULL,
  `t_hora_fim_qui` time DEFAULT NULL,
  `t_hora_inicio_sex` time DEFAULT NULL,
  `t_hora_fim_sex` time DEFAULT NULL,
  `t_hora_inicio_sab` time DEFAULT NULL,
  `t_hora_fim_sab` time DEFAULT NULL,
  `t_hora_inicio_dom` time DEFAULT NULL,
  `t_hora_fim_dom` time DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_complementos`
--

CREATE TABLE `tb_est_fin_complementos` (
  `p_comp_id` int(9) NOT NULL,
  `f_prod_id` int(9) DEFAULT NULL,
  `s_comp_nome` varchar(80) DEFAULT NULL,
  `e_comp_obrigatoriedade` enum('OPCIONAL','OBRIGATORIO') DEFAULT NULL,
  `n_comp_qtd_minima` int(3) DEFAULT NULL,
  `n_comp_qtd_maxima` int(3) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `tb_est_fin_complementos`
--

INSERT INTO `tb_est_fin_complementos` (`p_comp_id`, `f_prod_id`, `s_comp_nome`, `e_comp_obrigatoriedade`, `n_comp_qtd_minima`, `n_comp_qtd_maxima`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(13, 56250, 'Tipo Pipoca', 'OBRIGATORIO', 1, 1, '2021-08-13 15:38:30', '2021-08-13 15:38:30', NULL),
(14, 56250, 'Adicionais', 'OPCIONAL', 0, 6, '2021-08-13 15:38:30', '2021-08-13 15:38:30', NULL),
(15, 56253, 'Para mergulhar a borda da sua Pizza!', 'OPCIONAL', NULL, 2, '2021-08-23 14:36:54', '2021-08-23 14:36:54', '2021-08-23 19:34:21'),
(16, 56253, 'Sobremesas', 'OPCIONAL', NULL, 2, '2021-08-23 14:36:54', '2021-08-23 14:36:54', '2021-08-23 19:34:21'),
(17, 56253, 'Cerveja', 'OPCIONAL', NULL, 1, '2021-08-23 14:36:54', '2021-08-23 14:36:54', '2021-08-23 19:34:21'),
(18, 56259, 'Bravo, bravo, calabresa', 'OBRIGATORIO', 1, 1, '2021-08-23 14:37:47', '2021-08-23 14:37:47', '2021-08-23 19:37:07'),
(19, 56259, 'Coca Cola Lata', 'OBRIGATORIO', 1, 1, '2021-08-23 14:37:47', '2021-08-23 14:37:47', '2021-08-23 19:37:07'),
(20, 56260, 'Pizza Promo', 'OBRIGATORIO', 1, 1, '2021-08-23 14:39:38', '2021-08-23 14:39:38', '2021-08-23 19:37:52'),
(21, 56260, 'Escolha 2 Pizzas!', 'OBRIGATORIO', 2, 2, '2021-08-23 14:39:38', '2021-08-23 14:39:38', '2021-08-23 19:37:52'),
(22, 56260, 'Para mergulhar a borda da sua Pizza!', 'OPCIONAL', NULL, 6, '2021-08-23 14:39:38', '2021-08-23 14:39:38', '2021-08-23 19:37:52'),
(23, 56260, 'Sobremesas', 'OPCIONAL', NULL, 2, '2021-08-23 14:39:38', '2021-08-23 14:39:38', '2021-08-23 19:37:52'),
(24, 56261, 'Pizza Promo!', 'OBRIGATORIO', 1, 1, '2021-08-23 14:41:43', '2021-08-23 14:41:43', '2021-08-23 19:40:16'),
(25, 56261, 'Escolha 3 Pizzas!', 'OBRIGATORIO', 3, 3, '2021-08-23 14:41:43', '2021-08-23 14:41:43', '2021-08-23 19:40:16'),
(26, 56261, 'Para mergulhar a borda da sua Pizza!', 'OPCIONAL', NULL, 6, '2021-08-23 14:41:43', '2021-08-23 14:41:43', '2021-08-23 19:40:16'),
(27, 56261, 'Sobremesas', 'OPCIONAL', NULL, 8, '2021-08-23 14:41:43', '2021-08-23 14:41:43', '2021-08-23 19:40:16'),
(28, 56262, 'Escolha 1 Pizza!', 'OBRIGATORIO', 1, 1, '2021-08-23 14:44:20', '2021-08-23 14:44:20', '2021-08-23 19:43:11'),
(29, 56262, 'Refrigerante lata', 'OBRIGATORIO', 1, 1, '2021-08-23 14:44:20', '2021-08-23 14:44:20', '2021-08-23 19:43:11'),
(30, 56262, 'Para mergulhar a borda da sua Pizza!', 'OPCIONAL', NULL, 6, '2021-08-23 14:44:20', '2021-08-23 14:44:20', '2021-08-23 19:43:11'),
(31, 56262, 'Sobremesas', 'OPCIONAL', NULL, 6, '2021-08-23 14:44:20', '2021-08-23 14:44:20', '2021-08-23 19:43:11'),
(32, 56263, 'Pizza napolitana individual', 'OBRIGATORIO', 1, 1, '2021-08-23 14:45:45', '2021-08-23 14:45:45', '2021-08-23 19:45:09'),
(33, 56263, 'Refrigerante lata', 'OBRIGATORIO', 1, 1, '2021-08-23 14:45:45', '2021-08-23 14:45:45', '2021-08-23 19:45:09'),
(34, 56264, 'Pizzas individuais', 'OBRIGATORIO', 2, 2, '2021-08-23 14:47:15', '2021-08-23 14:47:15', '2021-08-23 19:46:08'),
(35, 56264, 'Vinhos (375ml)', 'OBRIGATORIO', 1, 1, '2021-08-23 14:47:15', '2021-08-23 14:47:15', '2021-08-23 19:46:08'),
(36, 56264, 'Sobremesa', 'OBRIGATORIO', 1, 1, '2021-08-23 14:47:15', '2021-08-23 14:47:15', '2021-08-23 19:46:08'),
(37, 56265, 'Queen Margherita', 'OBRIGATORIO', 1, 1, '2021-08-23 14:48:46', '2021-08-23 14:48:46', '2021-08-23 19:48:08'),
(38, 56265, 'Coca Cola Lata', 'OBRIGATORIO', 1, 1, '2021-08-23 14:48:46', '2021-08-23 14:48:46', '2021-08-23 19:48:08'),
(39, 56266, 'Sobremesas', 'OBRIGATORIO', 1, 1, '2021-08-23 14:50:40', '2021-08-23 14:50:40', '2021-08-23 19:48:50'),
(40, 56266, 'Escolha 2 Pizzas!', 'OBRIGATORIO', 2, 2, '2021-08-23 14:50:40', '2021-08-23 14:50:40', '2021-08-23 19:48:50'),
(41, 56266, 'Para mergulhar a borda da sua Pizza!', 'OPCIONAL', NULL, 6, '2021-08-23 14:50:40', '2021-08-23 14:50:40', '2021-08-23 19:48:50'),
(42, 56266, 'Cerveja', 'OPCIONAL', NULL, 1, '2021-08-23 14:50:40', '2021-08-23 14:50:40', '2021-08-23 19:48:50'),
(43, 56266, 'Vinho', 'OPCIONAL', NULL, 1, '2021-08-23 14:50:40', '2021-08-23 14:50:40', '2021-08-23 19:48:50');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_complementos_itens`
--

CREATE TABLE `tb_est_fin_complementos_itens` (
  `p_comp_item_id` int(9) NOT NULL,
  `f_comp_id` int(9) DEFAULT NULL,
  `s_comp_item_nome` varchar(80) DEFAULT NULL,
  `s_comp_item_descricao` varchar(250) DEFAULT NULL,
  `n_comp_item_preco` float DEFAULT NULL,
  `s_comp_item_foto` varchar(25) DEFAULT NULL,
  `e_comp_item_status` enum('ATIVADO','PAUSADO') DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `tb_est_fin_complementos_itens`
--

INSERT INTO `tb_est_fin_complementos_itens` (`p_comp_item_id`, `f_comp_id`, `s_comp_item_nome`, `s_comp_item_descricao`, `n_comp_item_preco`, `s_comp_item_foto`, `e_comp_item_status`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(26, 13, 'Salgada', 'Pipoca levemente salgada', 7.9, NULL, 'ATIVADO', '2021-08-13 15:40:11', '2021-08-13 15:40:11', NULL),
(27, 13, 'Doce', 'Pipoca com açúcar derretido', NULL, NULL, 'ATIVADO', '2021-08-13 15:40:11', '2021-08-13 15:40:11', NULL),
(28, 14, 'Manteiga', 'Descrição teste', 7.9, NULL, 'ATIVADO', '2021-08-13 15:41:12', '2021-08-13 15:41:12', NULL),
(29, 14, 'Leite Ninho', NULL, 9.9, NULL, 'ATIVADO', '2021-08-13 15:41:12', '2021-08-13 15:41:12', NULL),
(30, 14, 'Confete', NULL, 5.4, NULL, 'ATIVADO', '2021-08-13 15:41:12', '2021-08-13 15:41:12', NULL),
(31, 18, 'Bravo, Bravo, Calabresa', 'Molho de tomate italiano, muçarela fresca, calabresa levemente picante com erva doce, orégano fresco e cebola roxa', NULL, NULL, 'ATIVADO', '2021-08-23 14:54:53', '2021-08-23 14:54:53', '2021-08-23 19:53:21'),
(32, 19, 'Coca Cola Lata', NULL, NULL, NULL, 'ATIVADO', '2021-08-23 14:55:14', '2021-08-23 14:55:14', '2021-08-23 19:54:55'),
(33, 20, 'Queen Margherita', 'Nossa rainha, molho de tomate italiano, muçarela fresca fior de latte, parmesão, azeite italiano extra virgem e manjericão.', NULL, NULL, 'ATIVADO', '2021-08-23 14:56:30', '2021-08-23 14:56:30', '2021-08-23 19:55:23'),
(34, 21, 'Baggio', 'Molho de tomate italiano, muçarela fresca fior de latte, abobrinha marinada no alho e alecrim, parmesão e burrata com raspas de limão', 44, NULL, 'ATIVADO', '2021-08-23 14:58:44', '2021-08-23 14:58:44', '2021-08-23 19:56:39'),
(35, 21, 'Bravo, Bravo, Calabresa', 'Molho de tomate italiano, muçarela fresca e fior de latte, calabresa artesanal com erva doce, orégano fresco e cebola roxa.', 37, NULL, 'ATIVADO', '2021-08-23 14:58:44', '2021-08-23 14:58:44', '2021-08-23 19:56:39'),
(36, 21, 'Queen Margherita', 'Nossa Rainha, molho de tomate italiano, muçarela fresca fior de latte, parmesào, azeite italiano extra virgem e manjericão.', 37, NULL, 'ATIVADO', '2021-08-23 15:00:40', '2021-08-23 15:00:40', '2021-08-23 19:58:55'),
(37, 21, 'Porco Belly', 'Molho de tomate italiano, muçarela fresca fior de latte, pancetta artesanal marinada no limão siciliano, finalizada com Stracciatella (recheio de burrata) e salsinha.', 41, NULL, 'ATIVADO', '2021-08-23 15:00:40', '2021-08-23 15:00:40', '2021-08-23 19:58:55'),
(38, 22, 'Molho de Tomate Italiano', 'Molho de tomate italiano importado, o mesmo que utilizamos em nossas pizzas, fica delicioso para molhar a borda da sua Pizza!', 4, NULL, 'ATIVADO', '2021-08-23 15:02:28', '2021-08-23 15:02:28', '2021-08-23 20:00:46'),
(39, 22, 'Molho de Pesto de Manjericão', 'Molho de tomate com manjericão fresco, azeite italiano extra virgem, parmesão, pecorino romano e castanha do pará. Fica delicioso para molhar a borda da sua pizza!', 6, NULL, 'ATIVADO', '2021-08-23 15:02:28', '2021-08-23 15:02:28', '2021-08-23 20:00:46'),
(40, 23, 'Cannoli', 'Dois cannolis recheados de ricota com toque cítrico, gotas de chocolate e pistache', 24, NULL, 'ATIVADO', '2021-08-23 15:03:48', '2021-08-23 15:03:48', '2021-08-23 20:02:31'),
(41, 23, 'Calzone de Nutella', 'Massa de pizza individual fechada com recheio de nutella. Tudo isso em uma massa leve de longa fermentação feita com farinha importada da Itália, montada artesanalmente.', 26, NULL, 'ATIVADO', '2021-08-23 15:03:48', '2021-08-23 15:03:48', '2021-08-23 20:02:31'),
(42, 24, 'Queen Margherita', NULL, 19.5, NULL, 'ATIVADO', '2021-08-23 15:06:23', '2021-08-23 15:06:23', '2021-08-23 20:05:19'),
(43, 24, 'Cruella', NULL, 21, NULL, 'ATIVADO', '2021-08-23 15:06:23', '2021-08-23 15:06:23', '2021-08-23 20:05:19'),
(44, 24, 'Bravo, Bravo, Calabresa', NULL, 19.5, NULL, 'ATIVADO', '2021-08-23 15:06:23', '2021-08-23 15:06:23', '2021-08-23 20:05:19'),
(45, 24, 'Caprichosa Veggie', NULL, 21.5, NULL, 'ATIVADO', '2021-08-23 15:06:23', '2021-08-23 15:06:23', '2021-08-23 20:05:19'),
(46, 25, 'Baggio', 'Molho de tomate italiano, muçarela fresca fior de latte, abobrinha marinada no alho e alecrim, parmesão e burrata com raspas de limão', 44, NULL, 'ATIVADO', '2021-08-23 15:09:23', '2021-08-23 15:09:23', '2021-08-23 20:06:57'),
(47, 25, 'Bravo, Bravo, Calabresa', 'Molho de tomate italiano, muçarela fresca e fior de latte, calabresa artesanal com erva doce, orégano fresco e cebola roxa.', 37, NULL, 'ATIVADO', '2021-08-23 15:09:23', '2021-08-23 15:09:23', '2021-08-23 20:06:57'),
(48, 25, 'Queen Margherita', 'Nossa Rainha, molho de tomate italiano, muçarela fresca fior de latte, parmesào, azeite italiano extra virgem e manjericão.', 37, NULL, 'ATIVADO', '2021-08-23 15:09:23', '2021-08-23 15:09:23', '2021-08-23 20:06:57'),
(49, 25, 'Porco Belly', 'Molho de tomate italiano, muçarela fresca fior de latte, pancetta artesanal marinada no limão siciliano, finalizada com Stracciatella (recheio de burrata) e salsinha.', 44, NULL, 'ATIVADO', '2021-08-23 15:09:23', '2021-08-23 15:09:23', '2021-08-23 20:06:57'),
(50, 26, 'Molho de Tomate Italiano', 'Molho de tomate italiano importado, o mesmo que utilizamos em nossas pizzas, fica delicioso para molhar a borda da sua Pizza!', 4, NULL, 'ATIVADO', '2021-08-23 15:10:26', '2021-08-23 15:10:26', '2021-08-23 20:09:33'),
(51, 26, 'Molho de Pesto de Manjericão', 'Molho de tomate com manjericão fresco, azeite italiano extra virgem, parmesão, pecorino romano e castanha do pará. Fica delicioso para molhar a borda da sua pizza!', 6, NULL, 'ATIVADO', '2021-08-23 15:10:26', '2021-08-23 15:10:26', '2021-08-23 20:09:33'),
(52, 27, 'Cannoli', 'Dois cannolis recheados de ricota com toque cítrico, gotas de chocolate e pistache', 24, NULL, 'ATIVADO', '2021-08-23 15:11:13', '2021-08-23 15:11:13', '2021-08-23 20:10:29'),
(53, 27, 'Calzone de Nutella', 'Massa de pizza individual fechada com recheio de nutella. Tudo isso em uma massa leve de longa fermentação feita com farinha importada da Itália, montada artesanalmente.', 26, NULL, 'ATIVADO', '2021-08-23 15:11:13', '2021-08-23 15:11:13', '2021-08-23 20:10:29'),
(54, 28, 'Cruella', NULL, 34.9, NULL, 'ATIVADO', '2021-08-23 15:15:45', '2021-08-23 15:15:45', '2021-08-23 20:13:55'),
(55, 28, 'Queen Margherita', NULL, 34.9, NULL, 'ATIVADO', '2021-08-23 15:15:45', '2021-08-23 15:15:45', '2021-08-23 20:13:55'),
(56, 28, 'Bravo, Bravo, Calabresa', NULL, 34.9, NULL, 'ATIVADO', '2021-08-23 15:15:45', '2021-08-23 15:15:45', '2021-08-23 20:13:55'),
(57, 29, 'Coca Cola Lata', NULL, 7, NULL, 'ATIVADO', '2021-08-23 15:16:31', '2021-08-23 15:16:31', '2021-08-23 20:15:55'),
(58, 29, 'Coca Cola Zero Lata', NULL, 7, NULL, 'ATIVADO', '2021-08-23 15:16:31', '2021-08-23 15:16:31', '2021-08-23 20:15:55'),
(59, 30, 'Molho de Tomate Italiano', 'Molho de tomate italiano importado, o mesmo que utilizamos em nossas pizzas, fica delicioso para molhar a borda da sua Pizza!', 4, NULL, 'ATIVADO', '2021-08-23 15:17:45', '2021-08-23 15:17:45', '2021-08-23 20:16:35'),
(60, NULL, 'Molho de Pesto de Manjericão', 'Molho de tomate com manjericão fresco, azeite italiano extra virgem, parmesão, pecorino romano e castanha do pará. Fica delicioso para molhar a borda da sua pizza!', 6, NULL, 'ATIVADO', '2021-08-23 15:17:45', '2021-08-23 15:17:45', '2021-08-23 20:16:35'),
(61, 31, 'Cannoli', 'Dois cannolis recheados de ricota com toque cítrico, gotas de chocolate e pistache', 24, NULL, NULL, '2021-08-23 15:18:49', '2021-08-23 15:18:49', '2021-08-23 20:17:49'),
(62, 31, 'Calzone de Nutella', 'Massa de pizza individual fechada com recheio de nutella. Tudo isso em uma massa leve de longa fermentação feita com farinha importada da Itália, montada artesanalmente.', 26, NULL, 'ATIVADO', '2021-08-23 15:18:49', '2021-08-23 15:18:49', '2021-08-23 20:17:49'),
(63, 32, 'Cruella', 'Moolho de tomate, muçarela fresca, salame apimentado e melado de cana', 34.9, NULL, 'ATIVADO', '2021-08-23 15:20:41', '2021-08-23 15:20:41', '2021-08-23 20:19:04'),
(64, 33, 'Coca Cola Lata', 'Coca Cola Lata 350ml', 7, NULL, 'ATIVADO', '2021-08-23 15:20:41', '2021-08-23 15:20:41', '2021-08-23 20:19:04'),
(65, 33, 'Coca Cola Zero Lata', 'Coca Cola Zero Lata 350ml', 7, NULL, 'ATIVADO', '2021-08-23 15:20:41', '2021-08-23 15:20:41', '2021-08-23 20:19:04'),
(66, 34, 'Queen Margherita', 'Molho de tomate italiano, muçarela fresca, parmesão, azeite e manjericão', NULL, NULL, 'ATIVADO', '2021-08-23 15:23:52', '2021-08-23 15:23:52', '2021-08-23 20:20:59'),
(67, 34, 'Bravo, Bravo, Calabresa', 'Molho de tomate italiano, muçarela fresca, calabresa levemente picante com erva doce, orégano fresco e cebola roxa', NULL, NULL, 'ATIVADO', '2021-08-23 15:23:52', '2021-08-23 15:23:52', '2021-08-23 20:20:59'),
(68, 34, 'Cruella', 'Molho de tomate, muçarela fresca, salame apimentado e melado de cana', NULL, NULL, 'ATIVADO', '2021-08-23 15:23:52', '2021-08-23 15:23:52', '2021-08-23 20:20:59'),
(69, 35, 'Santa Helena Carménère (375ml)', NULL, NULL, NULL, 'ATIVADO', '2021-08-23 15:25:23', '2021-08-23 15:25:23', '2021-08-23 20:24:20'),
(70, 35, 'Trapiche Malbec (375ml)', NULL, NULL, NULL, 'ATIVADO', '2021-08-23 15:25:23', '2021-08-23 15:25:23', '2021-08-23 20:24:20'),
(71, 36, 'Cannoli', NULL, NULL, NULL, 'ATIVADO', '2021-08-23 15:25:53', '2021-08-23 15:25:53', '2021-08-23 20:25:27'),
(72, 37, 'Queen Margherita', 'Molho de tomate italiano, muçarela fresca, parmesão, azeite e manjericão.', 34.9, NULL, 'ATIVADO', '2021-08-23 15:27:11', '2021-08-23 15:27:11', '2021-08-23 20:26:24'),
(73, 38, 'Coca Cola Lata', NULL, 7, NULL, 'ATIVADO', '2021-08-23 15:27:11', '2021-08-23 15:27:11', '2021-08-23 20:26:24'),
(74, 39, 'Cannoli', 'Dois cannolis recheados de ricota com toque cítrico, gotas de chocolate e pistache', 11, NULL, 'ATIVADO', '2021-08-23 15:28:36', '2021-08-23 15:28:36', '2021-08-23 20:27:32'),
(75, 39, 'Calzone de Nutella', 'Massa de pizza individual fechada com recheio de nutella. Tudo isso em uma massa leve de longa fermentação feita com farinha importada da Itália, montada artesanalmente.', NULL, NULL, 'ATIVADO', '2021-08-23 15:28:36', '2021-08-23 15:28:36', '2021-08-23 20:27:32'),
(76, 40, 'Baggio', 'Molho de tomate italiano, muçarela fresca fior de latte, abobrinha marinada no alho e alecrim, parmesão e burrata com raspas de limão', 44, NULL, 'ATIVADO', '2021-08-23 15:31:03', '2021-08-23 15:31:03', '2021-08-23 20:28:48'),
(77, 40, 'Bravo, Bravo, Calabresa', 'Molho de tomate italiano, muçarela fresca e fior de latte, calabresa artesanal com erva doce, orégano fresco e cebola roxa.', 37, NULL, 'ATIVADO', '2021-08-23 15:31:03', '2021-08-23 15:31:03', '2021-08-23 20:28:48'),
(78, 40, 'Queen Margherita', 'Nossa Rainha, molho de tomate italiano, muçarela fresca fior de latte, parmesào, azeite italiano extra virgem e manjericão.', 37, NULL, 'ATIVADO', '2021-08-23 15:31:03', '2021-08-23 15:31:03', '2021-08-23 20:28:48'),
(79, 40, 'Porco Belly', 'Molho de tomate italiano, muçarela fresca fior de latte, pancetta artesanal marinada no limão siciliano, finalizada com Stracciatella (recheio de burrata) e salsinha.', 41, NULL, 'ATIVADO', '2021-08-23 15:31:03', '2021-08-23 15:31:03', '2021-08-23 20:28:48'),
(80, 41, 'Molho de Tomate Italiano', 'Molho de tomate italiano importado, o mesmo que utilizamos em nossas pizzas, fica delicioso para molhar a borda da sua Pizza!', 4, NULL, 'ATIVADO', '2021-08-23 15:33:10', '2021-08-23 15:33:10', '2021-08-23 20:31:20'),
(81, 41, 'Molho de Pesto de Manjericão', 'Molho de tomate com manjericão fresco, azeite italiano extra virgem, parmesão, pecorino romano e castanha do pará. Fica delicioso para molhar a borda da sua pizza!', 6, NULL, 'ATIVADO', '2021-08-23 15:33:10', '2021-08-23 15:33:10', '2021-08-23 20:31:20'),
(82, 42, 'Stella Artois (275ml)', NULL, 9, NULL, 'ATIVADO', '2021-08-23 15:33:10', '2021-08-23 15:33:10', '2021-08-23 20:31:20'),
(83, 43, 'Santa Helena Carménère', NULL, 37, NULL, 'ATIVADO', '2021-08-23 15:33:10', '2021-08-23 15:33:10', '2021-08-23 20:31:20');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_configuracao`
--

CREATE TABLE `tb_est_fin_configuracao` (
  `p_conf_id` int(11) UNSIGNED NOT NULL,
  `f_conf_usuario` int(11) NOT NULL,
  `b_conf_exigir_dados` tinyint(1) NOT NULL DEFAULT 1,
  `n_conf_taxa_servico` float DEFAULT NULL,
  `b_conf_exigir_token` tinyint(1) NOT NULL DEFAULT 1,
  `b_conf_valores_pedido` tinyint(1) NOT NULL DEFAULT 1,
  `n_conf_couvert` float DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_cozinhas`
--

CREATE TABLE `tb_est_fin_cozinhas` (
  `p_coz_id` int(11) NOT NULL,
  `f_coz_estabelecimento` int(11) NOT NULL,
  `s_coz_nome` varchar(55) NOT NULL,
  `b_coz_ativo` tinyint(1) NOT NULL DEFAULT 1,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_est_fin_cozinhas`
--

INSERT INTO `tb_est_fin_cozinhas` (`p_coz_id`, `f_coz_estabelecimento`, `s_coz_nome`, `b_coz_ativo`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(5, 3078, 'Bar', 0, '2021-05-19 23:21:09', '2021-05-19 23:21:09', NULL),
(6, 3078, 'Cozinha', 0, '2021-05-19 23:21:13', '2021-05-19 23:21:13', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_delivery_pedido`
--

CREATE TABLE `tb_est_fin_delivery_pedido` (
  `p_del_id` int(11) NOT NULL,
  `f_del_usuario` int(11) NOT NULL,
  `f_del_cliente` int(11) NOT NULL,
  `n_del_valor` float DEFAULT NULL,
  `n_del_valor_entrega` float DEFAULT NULL,
  `s_del_status` varchar(55) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_mesas`
--

CREATE TABLE `tb_est_fin_mesas` (
  `p_mesa_id` int(11) UNSIGNED NOT NULL,
  `f_usu_id` int(11) NOT NULL,
  `s_mesa_numero` varchar(50) NOT NULL DEFAULT '',
  `s_mesa_hash` varchar(255) NOT NULL DEFAULT '',
  `s_mesa_status` enum('active','deleted') NOT NULL DEFAULT 'active',
  `e_mesa_tipo` enum('mesa','quarto') DEFAULT NULL,
  `s_mesa_numero2` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updateAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_est_fin_mesas`
--

INSERT INTO `tb_est_fin_mesas` (`p_mesa_id`, `f_usu_id`, `s_mesa_numero`, `s_mesa_hash`, `s_mesa_status`, `e_mesa_tipo`, `s_mesa_numero2`, `createdAt`, `updateAt`, `deletedAt`) VALUES
(17, 1, '1', '', 'active', NULL, NULL, '2021-06-03 15:05:03', '2021-06-03 15:05:03', NULL),
(18, 2, '11', '', 'active', NULL, NULL, '2021-06-03 15:05:03', '2021-06-03 15:05:03', NULL),
(19, 2, '2', '', 'active', NULL, NULL, '2021-06-03 15:05:26', '2021-06-03 15:05:26', NULL),
(20, 3078, '1', '8G1Z', 'active', NULL, NULL, '2021-07-21 14:29:00', '2021-07-21 14:29:00', NULL),
(21, 3078, '2', 'X9H6', 'active', NULL, NULL, '2021-07-21 14:29:00', '2021-07-21 14:29:00', NULL),
(22, 3078, '3', '3M71', 'active', NULL, NULL, '2021-07-21 14:29:00', '2021-07-21 14:29:00', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_mesas_historico`
--

CREATE TABLE `tb_est_fin_mesas_historico` (
  `p_mesa_id` int(11) UNSIGNED NOT NULL,
  `f_usu_id` int(11) NOT NULL,
  `s_mesa_numero` varchar(50) NOT NULL DEFAULT '',
  `s_mesa_hash` varchar(255) NOT NULL DEFAULT '',
  `s_mesa_status` enum('active','deleted','closed') NOT NULL DEFAULT 'closed',
  `d_mesa_data_abertura` datetime DEFAULT NULL,
  `d_mesa_data_fechamento` datetime DEFAULT NULL,
  `s_mesa_token` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updateAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_mesas_pedido`
--

CREATE TABLE `tb_est_fin_mesas_pedido` (
  `p_mesa_ped_id` int(11) UNSIGNED NOT NULL,
  `f_mesa_id` int(11) NOT NULL,
  `f_usu_id` int(11) NOT NULL,
  `s_mesa_numero` varchar(50) NOT NULL DEFAULT '',
  `s_mesa_hash` varchar(255) NOT NULL DEFAULT '',
  `n_mesa_qde_pessoas` int(11) DEFAULT NULL,
  `n_mesa_nota` float DEFAULT NULL,
  `s_mesa_status` enum('closed','active') NOT NULL DEFAULT 'active',
  `d_mesa_data_abertura` datetime DEFAULT NULL,
  `d_mesa_data_fechamento` datetime DEFAULT NULL,
  `s_mesa_token` varchar(255) DEFAULT NULL,
  `n_mesa_valor` float DEFAULT NULL,
  `n_mesa_valor_servico` float DEFAULT NULL,
  `n_mesa_valor_couvert` float DEFAULT NULL,
  `n_mesa_valor_total` float DEFAULT NULL,
  `s_mesa_forma` varchar(50) DEFAULT NULL,
  `s_mesa_situacao` varchar(50) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_est_fin_mesas_pedido`
--

INSERT INTO `tb_est_fin_mesas_pedido` (`p_mesa_ped_id`, `f_mesa_id`, `f_usu_id`, `s_mesa_numero`, `s_mesa_hash`, `n_mesa_qde_pessoas`, `n_mesa_nota`, `s_mesa_status`, `d_mesa_data_abertura`, `d_mesa_data_fechamento`, `s_mesa_token`, `n_mesa_valor`, `n_mesa_valor_servico`, `n_mesa_valor_couvert`, `n_mesa_valor_total`, `s_mesa_forma`, `s_mesa_situacao`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(22, 20, 3078, '1', '8G1Z', NULL, NULL, 'active', '2021-07-21 14:29:47', NULL, '6RZ0', 19.8, 0, 0, 19.8, NULL, 'EM ABERTO', '2021-07-21 14:29:47', '2021-07-21 14:29:47', NULL),
(23, 21, 3078, '2', 'X9H6', NULL, NULL, 'active', '2021-08-02 14:56:27', NULL, 'XAJU', 139.8, 0, 0, 139.8, NULL, 'EM ABERTO', '2021-08-02 14:56:27', '2021-08-02 14:56:27', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_notificacoes`
--

CREATE TABLE `tb_est_fin_notificacoes` (
  `p_not_id` int(11) NOT NULL,
  `f_usu_id` int(11) NOT NULL,
  `s_mesa_numero` varchar(50) DEFAULT NULL,
  `s_not_mensagem` text DEFAULT NULL,
  `s_not_enviado_em` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updateAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_pedidos`
--

CREATE TABLE `tb_est_fin_pedidos` (
  `p_ped_id` int(11) UNSIGNED NOT NULL,
  `f_ped_cliente` int(11) NOT NULL,
  `f_ped_produto` int(11) NOT NULL,
  `s_ped_observacao` varchar(500) DEFAULT NULL,
  `s_ped_status` varchar(1) NOT NULL DEFAULT 'a',
  `f_ped_mesa` int(11) DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_pedidos_impressao`
--

CREATE TABLE `tb_est_fin_pedidos_impressao` (
  `p_imp_id` int(11) NOT NULL,
  `f_imp_usuario` int(11) NOT NULL,
  `f_imp_pedido` int(11) NOT NULL,
  `s_imp_texto` text NOT NULL,
  `b_imp_impresso` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_est_fin_pedidos_impressao`
--

INSERT INTO `tb_est_fin_pedidos_impressao` (`p_imp_id`, `f_imp_usuario`, `f_imp_pedido`, `s_imp_texto`, `b_imp_impresso`, `createdAt`, `updatedAt`) VALUES
(1, 3078, 23, 'Pedido: 23%0aMesa: 2%0a%0aMonte sua Pipoca: 9.9 x 1 = 9.9%0a', 0, '2021-08-02 17:05:51', '2021-08-02 17:05:51'),
(2, 3078, 23, 'Pedido: 23%0aMesa: 2%0a%0aAçaí Bull: 0 x 1 = 12.9%0a', 0, '2021-08-02 17:06:11', '2021-08-02 17:06:11'),
(3, 3078, 23, 'Pedido: 23%0aMesa: 2%0a%0aAçaí Bull: 0,00 x 1 = 12,90%0a', 0, '2021-08-02 17:08:36', '2021-08-02 17:08:36'),
(4, 3078, 23, 'Pedido: 23%0aMesa: 2%0a%0aMonte sua Pipoca: 9,90 x 1 = 9,90%0a', 0, '2021-08-02 17:09:29', '2021-08-02 17:09:29');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_pedidos_produtos`
--

CREATE TABLE `tb_est_fin_pedidos_produtos` (
  `p_ped_id` int(11) UNSIGNED NOT NULL,
  `f_ped_cliente` int(11) NOT NULL,
  `f_ped_id` int(11) DEFAULT NULL COMMENT 'Inclusão de complementos',
  `f_ped_produto` int(11) NOT NULL,
  `s_ped_observacao` varchar(500) DEFAULT NULL,
  `s_ped_status` varchar(15) NOT NULL DEFAULT 'NOVO',
  `f_ped_mesa` int(11) DEFAULT NULL,
  `n_ped_qde` int(11) DEFAULT NULL,
  `n_ped_valor_unitario` float DEFAULT NULL,
  `n_ped_valor_total` float DEFAULT NULL,
  `s_ped_produto_nome_original` varchar(255) DEFAULT NULL,
  `b_ped_visivel` tinyint(1) NOT NULL DEFAULT 1,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_est_fin_pedidos_produtos`
--

INSERT INTO `tb_est_fin_pedidos_produtos` (`p_ped_id`, `f_ped_cliente`, `f_ped_id`, `f_ped_produto`, `s_ped_observacao`, `s_ped_status`, `f_ped_mesa`, `n_ped_qde`, `n_ped_valor_unitario`, `n_ped_valor_total`, `s_ped_produto_nome_original`, `b_ped_visivel`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(51, 3, NULL, 56250, NULL, 'NOVO', NULL, 1, 9.9, 9.9, 'Monte sua Pipoca', 1, '2021-06-16 18:56:24', '2021-06-16 18:56:24', NULL),
(52, 3, NULL, 56251, NULL, 'NOVO', NULL, 1, 12, 12, 'Açaí Bull', 1, '2021-06-16 18:56:24', '2021-06-16 18:56:24', NULL),
(53, 1, NULL, 56250, '', 'NOVO', 22, 2, 9.9, 19.8, 'Monte sua Pipoca', 1, '2021-07-21 14:33:27', '2021-07-21 14:33:27', NULL),
(54, 1, NULL, 56250, '', 'NOVO', 23, 1, 9.9, 9.9, 'Monte sua Pipoca', 1, '2021-08-02 14:58:43', '2021-08-02 14:58:43', NULL),
(55, 1, NULL, 56252, '', 'NOVO', 23, 1, 12, 12, 'Teste', 1, '2021-08-02 17:00:26', '2021-08-02 17:00:26', NULL),
(56, 1, NULL, 56250, '', 'NOVO', 23, 2, 9.9, 19.8, 'Monte sua Pipoca', 1, '2021-08-02 17:00:57', '2021-08-02 17:00:57', NULL),
(57, 1, NULL, 56251, '', 'NOVO', 23, 1, 0, 9.9, 'Açaí Bull', 1, '2021-08-02 17:02:55', '2021-08-02 17:02:55', NULL),
(58, 1, NULL, 56251, '', 'NOVO', 23, 1, 0, 12.9, 'Açaí Bull', 1, '2021-08-02 17:03:44', '2021-08-02 17:03:44', NULL),
(59, 1, NULL, 56250, '', 'NOVO', 23, 2, 9.9, 19.8, 'Monte sua Pipoca', 1, '2021-08-02 17:04:07', '2021-08-02 17:04:07', NULL),
(60, 1, NULL, 56250, '', 'NOVO', 23, 1, 9.9, 9.9, 'Monte sua Pipoca', 1, '2021-08-02 17:05:12', '2021-08-02 17:05:12', NULL),
(61, 1, NULL, 56250, '', 'NOVO', 23, 1, 9.9, 9.9, 'Monte sua Pipoca', 1, '2021-08-02 17:05:51', '2021-08-02 17:05:51', NULL),
(62, 1, NULL, 56251, '', 'NOVO', 23, 1, 0, 12.9, 'Açaí Bull', 1, '2021-08-02 17:06:11', '2021-08-02 17:06:11', NULL),
(63, 1, NULL, 56251, '', 'NOVO', 23, 1, 0, 12.9, 'Açaí Bull', 1, '2021-08-02 17:08:36', '2021-08-02 17:08:36', NULL),
(64, 1, NULL, 56250, '', 'NOVO', 23, 1, 9.9, 9.9, 'Monte sua Pipoca', 1, '2021-08-02 17:09:29', '2021-08-02 17:09:29', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_pedidos_simples`
--

CREATE TABLE `tb_est_fin_pedidos_simples` (
  `p_ped_id` int(11) UNSIGNED NOT NULL,
  `f_ped_estabelecimento` int(11) NOT NULL,
  `s_ped_nome` varchar(255) NOT NULL DEFAULT '',
  `s_ped_fone` varchar(25) NOT NULL DEFAULT '',
  `s_ped_email` varchar(120) NOT NULL DEFAULT '',
  `n_ped_pager` int(11) NOT NULL,
  `s_ped_status` varchar(1) NOT NULL DEFAULT 'a',
  `s_ped_observacao` varchar(35) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_pedidos_subitens`
--

CREATE TABLE `tb_est_fin_pedidos_subitens` (
  `p_ped_sub_id` int(11) UNSIGNED NOT NULL,
  `f_ped_sub_pedido` int(11) NOT NULL,
  `f_ped_sub_subitem` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_produtos`
--

CREATE TABLE `tb_est_fin_produtos` (
  `p_prd_id` int(11) UNSIGNED NOT NULL,
  `s_prd_titulo` varchar(120) NOT NULL DEFAULT '',
  `s_prd_titulo_ingles` varchar(255) DEFAULT NULL,
  `s_prd_titulo_espanhol` varchar(255) DEFAULT NULL,
  `s_prd_detalhe` text DEFAULT NULL,
  `s_prd_detalhe_ingles` text DEFAULT NULL,
  `s_prd_detalhe_espanhol` text DEFAULT NULL,
  `s_prd_cor` varchar(15) DEFAULT NULL,
  `f_prd_categoria` int(11) NOT NULL,
  `n_prd_preco` float NOT NULL,
  `n_prd_preco_promo` float DEFAULT NULL,
  `s_prd_tipo` varchar(15) DEFAULT NULL,
  `s_prd_foto` varchar(25) DEFAULT NULL,
  `b_prd_visivel` tinyint(1) NOT NULL DEFAULT 1,
  `n_prd_ordem` int(11) DEFAULT NULL,
  `n_prd_qtd_subitens` int(11) DEFAULT NULL,
  `b_prd_subitens_extra` tinyint(1) NOT NULL DEFAULT 0,
  `f_prd_grupo` int(11) DEFAULT NULL,
  `b_prd_vegetariano` tinyint(1) NOT NULL DEFAULT 0,
  `b_prd_vegano` tinyint(1) NOT NULL DEFAULT 0,
  `b_prd_gluten` tinyint(1) NOT NULL DEFAULT 0,
  `b_prd_lactose` tinyint(1) NOT NULL DEFAULT 0,
  `b_prd_alcool` tinyint(1) NOT NULL DEFAULT 0,
  `n_prd_qtd_pessoas` int(11) DEFAULT NULL,
  `s_prd_tipo_cardapio` varchar(1) DEFAULT 'a',
  `b_prd_ocultar_preco` tinyint(1) NOT NULL DEFAULT 0,
  `b_prd_destaque` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_est_fin_produtos`
--

INSERT INTO `tb_est_fin_produtos` (`p_prd_id`, `s_prd_titulo`, `s_prd_titulo_ingles`, `s_prd_titulo_espanhol`, `s_prd_detalhe`, `s_prd_detalhe_ingles`, `s_prd_detalhe_espanhol`, `s_prd_cor`, `f_prd_categoria`, `n_prd_preco`, `n_prd_preco_promo`, `s_prd_tipo`, `s_prd_foto`, `b_prd_visivel`, `n_prd_ordem`, `n_prd_qtd_subitens`, `b_prd_subitens_extra`, `f_prd_grupo`, `b_prd_vegetariano`, `b_prd_vegano`, `b_prd_gluten`, `b_prd_lactose`, `b_prd_alcool`, `n_prd_qtd_pessoas`, `s_prd_tipo_cardapio`, `b_prd_ocultar_preco`, `b_prd_destaque`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(56250, 'Monte sua Pipoca', NULL, NULL, 'Monte sua Pipoca', NULL, NULL, NULL, 8035, 9.9, NULL, NULL, '16980.png', 1, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 'a', 0, 0, '2021-04-19 17:23:02', '2021-04-19 17:23:02', NULL),
(56251, 'Açaí Bull', NULL, NULL, 'tteste', NULL, NULL, NULL, 8035, 0, NULL, NULL, '16939.png', 1, 1, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 'a', 0, 0, '2021-04-24 19:31:29', '2021-04-24 19:31:29', NULL),
(56252, 'Teste', NULL, NULL, 'teste', NULL, NULL, NULL, 8038, 12, NULL, NULL, NULL, 1, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 'a', 0, 0, '2021-07-04 19:08:51', '2021-07-04 19:08:51', NULL),
(56253, 'Novidade! Portuguesa', NULL, NULL, NULL, NULL, NULL, NULL, 3078, 39.9, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:19:45', '2021-08-23 14:19:45', '2021-08-23 19:17:11'),
(56254, 'Caprichosa Veggie', NULL, NULL, NULL, NULL, NULL, NULL, 3078, 41, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:19:45', '2021-08-23 14:19:45', '2021-08-23 19:17:11'),
(56255, 'Novidade! Corn Bacon', NULL, NULL, NULL, NULL, NULL, NULL, 3078, 39.9, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:19:45', '2021-08-23 14:19:45', '2021-08-23 19:17:11'),
(56256, 'Porco Belly', NULL, NULL, NULL, NULL, NULL, NULL, 3078, 41, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:19:45', '2021-08-23 14:19:45', '2021-08-23 19:17:11'),
(56257, 'Formágica (Pizza Branca)', NULL, NULL, '', NULL, NULL, NULL, 3078, 41, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:19:45', '2021-08-23 14:19:45', '2021-08-23 19:17:11'),
(56258, 'Novidade! Pepperoni', NULL, NULL, NULL, NULL, NULL, NULL, 3078, 39, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:19:45', '2021-08-23 14:19:45', '2021-08-23 19:17:11'),
(56259, 'Bravo, bravo, calabresa + Coca-Cola lata por R$41,90', NULL, NULL, NULL, NULL, NULL, NULL, 8040, 41.9, NULL, NULL, NULL, 1, 0, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:26:40', '2021-08-23 14:26:40', '2021-08-23 19:19:56'),
(56260, 'Combo 3 Amici - 3 Pizzas, Ganhe 50% de desconto na Queen!', NULL, NULL, NULL, NULL, NULL, NULL, 8040, 66.5, NULL, NULL, NULL, 1, 1, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:26:40', '2021-08-23 14:26:40', '2021-08-23 19:19:56'),
(56261, 'Combo Famiglia - 4 pizzas, Ganhe 50% de desconto na 4a Pizza!', NULL, NULL, NULL, NULL, NULL, NULL, 8040, 107, NULL, NULL, NULL, 1, 2, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:26:40', '2021-08-23 14:26:40', '2021-08-23 19:19:56'),
(56262, 'Combo Personale - Pizza Individual + Refri Lata', NULL, NULL, NULL, NULL, NULL, NULL, 8040, 41.9, NULL, NULL, NULL, 1, 3, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:26:40', '2021-08-23 14:26:40', '2021-08-23 19:19:56'),
(56263, 'Cruella + Coca-Cola por R$41,90!', NULL, NULL, NULL, NULL, NULL, NULL, 8040, 41.9, NULL, NULL, NULL, 1, 4, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:27:50', '2021-08-23 14:27:50', '2021-08-23 19:27:05'),
(56264, 'Jantar Romântico - 2 Pizzas + 1 Vinho + Cannoli', NULL, NULL, NULL, NULL, NULL, NULL, 8040, 126, NULL, NULL, NULL, 1, 5, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:27:50', '2021-08-23 14:27:50', '2021-08-23 19:27:05'),
(56265, 'Queen Margherita + Coca-Cola lata por R$41,90!', NULL, NULL, NULL, NULL, NULL, NULL, 8040, 41.9, NULL, NULL, NULL, 1, 6, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:28:40', '2021-08-23 14:28:40', '2021-08-23 19:27:53'),
(56266, 'Combo Due - Sobremesa 50% Off + 2 Pizzas!', NULL, NULL, NULL, NULL, NULL, NULL, 8040, 48, NULL, NULL, NULL, 1, 7, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:28:40', '2021-08-23 14:28:40', '2021-08-23 19:27:53'),
(56270, 'Queen Margherita', NULL, NULL, NULL, NULL, NULL, NULL, 8041, 37, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:30:10', '2021-08-23 14:30:10', '2021-08-23 19:29:03'),
(56271, 'Bravo, bravo, calabresa', NULL, NULL, NULL, NULL, NULL, '', 8041, 39, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:30:10', '2021-08-23 14:30:10', '2021-08-23 19:29:03'),
(56272, 'Cruella', NULL, NULL, NULL, NULL, NULL, '', 8041, 40, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:30:10', '2021-08-23 14:30:10', '2021-08-23 19:29:03'),
(56273, 'Crostata', NULL, NULL, NULL, NULL, NULL, NULL, 8042, 23, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:30:46', '2021-08-23 14:30:46', '2021-08-23 19:30:14'),
(56274, 'Crostata recheada', NULL, NULL, NULL, NULL, NULL, NULL, 8042, 27, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:30:46', '2021-08-23 14:30:46', '2021-08-23 19:30:14'),
(56275, 'Calzone de Nutella', NULL, NULL, NULL, NULL, NULL, NULL, 8044, 26, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:32:13', '2021-08-23 14:32:13', '2021-08-23 19:31:52'),
(56276, 'Cannoli', NULL, NULL, NULL, NULL, NULL, NULL, 8044, 24, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:32:13', '2021-08-23 14:32:13', '2021-08-23 19:31:52'),
(56277, 'Baggio', NULL, NULL, NULL, NULL, NULL, NULL, 8043, 44, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:33:18', '2021-08-23 14:33:18', '2021-08-23 19:32:46'),
(56278, 'Dona Gema (Pizza Branca)', NULL, NULL, NULL, NULL, NULL, NULL, 8043, 41, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, NULL, 'a', 0, 0, '2021-08-23 14:33:18', '2021-08-23 14:33:18', '2021-08-23 19:32:46');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_produto_grupos`
--

CREATE TABLE `tb_est_fin_produto_grupos` (
  `p_prd_grp_id` int(11) NOT NULL,
  `f_prd_grp_produto` int(11) NOT NULL,
  `s_prd_grp_titulo` varchar(100) NOT NULL,
  `b_prd_grp_obrigatorio` tinyint(1) NOT NULL,
  `b_prd_grp_obrigatorio_qtd` int(11) NOT NULL,
  `n_prd_grp_ordem` int(11) NOT NULL,
  `n_prd_grp_qtd_subitens_gratis` int(11) NOT NULL,
  `b_prd_grp_add_extra` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_est_fin_produto_grupos`
--

INSERT INTO `tb_est_fin_produto_grupos` (`p_prd_grp_id`, `f_prd_grp_produto`, `s_prd_grp_titulo`, `b_prd_grp_obrigatorio`, `b_prd_grp_obrigatorio_qtd`, `n_prd_grp_ordem`, `n_prd_grp_qtd_subitens_gratis`, `b_prd_grp_add_extra`, `createdAt`, `updatedAt`) VALUES
(1, 56250, 'BASE', 1, 0, 1, 1, 0, '2021-08-16 10:14:45', '2021-08-16 10:14:45'),
(2, 56250, 'TAMANHO DO BALDE', 1, 0, 2, 1, 0, '2021-08-16 10:14:45', '2021-08-16 10:14:45'),
(3, 56250, 'TEMPEROS', 1, 0, 3, 1, 1, '2021-08-16 10:14:45', '2021-08-16 10:14:45');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_produto_precos`
--

CREATE TABLE `tb_est_fin_produto_precos` (
  `p_pre_id` int(11) UNSIGNED NOT NULL,
  `f_pre_produto` int(11) NOT NULL,
  `s_pre_nome` varchar(20) NOT NULL DEFAULT '',
  `s_pre_nome_ingles` varchar(120) DEFAULT NULL,
  `s_pre_nome_espanhol` varchar(120) DEFAULT NULL,
  `n_pre_preco` float NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_est_fin_produto_precos`
--

INSERT INTO `tb_est_fin_produto_precos` (`p_pre_id`, `f_pre_produto`, `s_pre_nome`, `s_pre_nome_ingles`, `s_pre_nome_espanhol`, `n_pre_preco`, `createdAt`, `updatedAt`) VALUES
(25255, 56251, '300ml', NULL, NULL, 9.9, '2021-08-16 10:07:41', '2021-08-16 10:07:41'),
(25256, 56251, '500ml', NULL, NULL, 12.9, '2021-08-16 10:07:41', '2021-08-16 10:07:41');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_produto_subitens`
--

CREATE TABLE `tb_est_fin_produto_subitens` (
  `p_prd_sub_id` int(11) UNSIGNED NOT NULL,
  `f_prd_sub_produto` int(11) NOT NULL,
  `f_prd_sub_subitem` int(11) NOT NULL,
  `n_prd_sub_ordem` int(11) DEFAULT NULL,
  `f_prd_sub_grupo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_est_fin_subitens`
--

CREATE TABLE `tb_est_fin_subitens` (
  `p_sub_id` int(11) UNSIGNED NOT NULL,
  `f_sub_usuario` int(11) NOT NULL,
  `s_sub_titulo` varchar(35) NOT NULL DEFAULT '',
  `s_sub_detalhe` text DEFAULT NULL,
  `n_sub_preco` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_aniversarios`
--

CREATE TABLE `tb_eve_aniversarios` (
  `p_ani_id` int(11) NOT NULL,
  `f_ani_evento` int(11) DEFAULT NULL,
  `f_ani_colaborador` int(11) DEFAULT NULL,
  `s_ani_nome` varchar(45) DEFAULT NULL,
  `s_ani_username` varchar(45) DEFAULT NULL,
  `s_ani_descricao` varchar(500) DEFAULT NULL,
  `n_ani_qtd` int(11) DEFAULT NULL,
  `s_ani_foto` varchar(45) DEFAULT NULL,
  `f_ani_aniversariante` int(11) DEFAULT NULL,
  `n_ani_vip` int(11) DEFAULT NULL,
  `n_ani_acom_vip` int(11) DEFAULT NULL,
  `n_ani_vip_uni` int(11) DEFAULT NULL,
  `s_ani_flyer` longtext DEFAULT NULL,
  `f_ani_bnf_cond` int(11) DEFAULT NULL,
  `t_ani_data_cadastro` datetime DEFAULT NULL,
  `s_ani_flyer_titulo` varchar(155) DEFAULT NULL,
  `s_ani_flyer_subtitulo` varchar(155) DEFAULT NULL,
  `s_ani_flyer_horario` varchar(15) DEFAULT NULL,
  `f_ani_flyer_template` int(11) DEFAULT NULL,
  `f_ani_tipo` int(11) NOT NULL DEFAULT 1,
  `b_ani_oc` tinyint(1) NOT NULL DEFAULT 0,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_eve_aniversarios`
--

INSERT INTO `tb_eve_aniversarios` (`p_ani_id`, `f_ani_evento`, `f_ani_colaborador`, `s_ani_nome`, `s_ani_username`, `s_ani_descricao`, `n_ani_qtd`, `s_ani_foto`, `f_ani_aniversariante`, `n_ani_vip`, `n_ani_acom_vip`, `n_ani_vip_uni`, `s_ani_flyer`, `f_ani_bnf_cond`, `t_ani_data_cadastro`, `s_ani_flyer_titulo`, `s_ani_flyer_subtitulo`, `s_ani_flyer_horario`, `f_ani_flyer_template`, `f_ani_tipo`, `b_ani_oc`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(6033, 2165, 3078, 'Teste', 'teste', 'Teste', 3, NULL, 3078, NULL, NULL, NULL, NULL, NULL, '2021-06-28 23:46:48', NULL, NULL, NULL, NULL, 1, 0, '2021-06-28 18:47:27', '2021-06-28 18:47:27', NULL),
(6034, 2165, 3078, 'Teste 2', NULL, 'teste 2', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2021-07-04 15:09:17', NULL, NULL, '16h00', NULL, 1, 0, '2021-07-04 15:09:17', '2021-07-04 15:09:17', NULL),
(6035, 2163, 3078, 'Venha comemorar meus 3.0', NULL, 'Meu aniversário vai ser foda', NULL, NULL, 3082, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '16h08', NULL, 1, 1, '2021-07-19 21:12:43', '2021-07-19 21:12:43', NULL),
(6036, 2174, 3078, 'Reserva Lucas Silva de Matos', NULL, 'Reserva de mesa', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2021-10-14 11:29:34', NULL, NULL, NULL, NULL, 5, 0, '2021-10-14 11:29:34', '2021-10-14 11:29:34', NULL),
(6037, 2163, 3078, 'Lucas', NULL, 'Teste', NULL, NULL, 3082, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '16h08', NULL, 1, 1, '2022-02-18 21:35:20', '2022-02-18 21:35:20', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_aniversario_form`
--

CREATE TABLE `tb_eve_aniversario_form` (
  `p_ani_form_id` int(11) NOT NULL,
  `s_ani_form_nome` varchar(100) DEFAULT NULL,
  `t_ani_form_data` date DEFAULT NULL,
  `s_ani_form_celular` varchar(20) DEFAULT NULL,
  `f_ani_form_casa` int(11) DEFAULT NULL,
  `t_ani_form_data_cadastro` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_colaborador`
--

CREATE TABLE `tb_eve_colaborador` (
  `p_col_eve_id` int(11) NOT NULL COMMENT 'Armazena a chave primária.',
  `f_col_id` int(11) NOT NULL COMMENT 'Armazena o ID do colaborador.',
  `f_eve_id` int(11) NOT NULL COMMENT 'Armazena o ID do evento.',
  `f_bnf_id` int(11) DEFAULT NULL,
  `e_col_eve_fixo` enum('n','s') NOT NULL COMMENT 'Armazena se o colaborador foi inserido porque ele era fixo.',
  `f_col_eve_funcao` int(11) NOT NULL COMMENT 'Armazena a função do colaborador para o evento.',
  `e_col_eve_status` enum('p','a','r','d') NOT NULL DEFAULT 'a',
  `t_col_eve_data_cadastro` datetime NOT NULL,
  `n_col_eve_vip_m` int(11) DEFAULT NULL,
  `n_col_eve_vip_f` int(11) DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_colaborador_lista`
--

CREATE TABLE `tb_eve_colaborador_lista` (
  `p_col_lis_id` int(11) UNSIGNED NOT NULL,
  `f_col_lis_colaborador` int(11) NOT NULL,
  `f_col_lis_lista` int(11) NOT NULL,
  `f_col_lis_evento` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_comanda`
--

CREATE TABLE `tb_eve_comanda` (
  `p_comanda_id` int(11) NOT NULL,
  `n_comanda` varchar(45) DEFAULT NULL,
  `s_nome_convidado` varchar(45) DEFAULT NULL,
  `n_nome_convidado_id` int(11) DEFAULT NULL,
  `s_telefone` varchar(45) DEFAULT NULL,
  `s_nome_promoter` varchar(45) DEFAULT NULL,
  `n_nome_promoter_id` int(11) DEFAULT NULL,
  `b_active` tinyint(4) DEFAULT 0,
  `n_consumo` float DEFAULT NULL,
  `s_tipo_lista` varchar(255) DEFAULT NULL,
  `s_cpf` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_espera_setores`
--

CREATE TABLE `tb_eve_espera_setores` (
  `p_set_id` int(11) NOT NULL,
  `f_set_evento` int(11) NOT NULL,
  `s_set_titulo` varchar(55) NOT NULL,
  `b_set_ativo` tinyint(1) NOT NULL DEFAULT 1,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_eve_espera_setores`
--

INSERT INTO `tb_eve_espera_setores` (`p_set_id`, `f_set_evento`, `s_set_titulo`, `b_set_ativo`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(1, 2163, 'Rooftop', 1, '2021-08-13 20:34:57', '2021-08-13 20:34:57', NULL),
(2, 2163, 'Varanda', 1, '2021-08-13 20:34:57', '2021-08-13 20:34:57', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_evento`
--

CREATE TABLE `tb_eve_evento` (
  `p_eve_id` int(11) NOT NULL COMMENT 'Armazena a chave primária.',
  `f_eve_usuario` int(11) NOT NULL COMMENT 'Chave estrangeira do usuário.',
  `s_eve_titulo` varchar(255) DEFAULT NULL,
  `s_eve_descricao` text DEFAULT NULL,
  `e_eve_visibilidade` enum('n','s') NOT NULL DEFAULT 's',
  `t_eve_data_evento` datetime NOT NULL COMMENT 'Armazena a data do evento.',
  `t_eve_data_fim_evento` datetime DEFAULT NULL,
  `t_eve_data_fechamento` datetime DEFAULT NULL COMMENT 'Armazena a data de fechamento do evento.',
  `t_eve_data_fechamento_checkin` datetime DEFAULT NULL COMMENT 'Armazena a data de fechamento do checkin.',
  `t_eve_data_cadastro` datetime NOT NULL COMMENT 'Armazena a data de cadastro.',
  `f_eve_fb_masc` varchar(50) DEFAULT NULL,
  `f_eve_fb_fem` varchar(50) DEFAULT NULL,
  `f_eve_oc_beneficio` varchar(50) DEFAULT NULL,
  `s_eve_flyer` varchar(50) DEFAULT NULL,
  `f_eve_ani_masc` int(11) DEFAULT NULL,
  `f_eve_ani_fem` int(11) DEFAULT NULL,
  `n_eve_vip_masc` varchar(50) DEFAULT NULL,
  `f_eve_bnf_colab` int(11) DEFAULT NULL,
  `n_eve_vip_fem` varchar(45) DEFAULT NULL,
  `n_eve_ani_vip` int(11) DEFAULT NULL,
  `n_eve_acom_vip` int(11) DEFAULT NULL,
  `f_eve_cenario_mesas` int(11) DEFAULT NULL,
  `b_eve_estrela` tinyint(4) NOT NULL DEFAULT 0,
  `b_eve_somente_link` tinyint(4) NOT NULL DEFAULT 0,
  `n_eve_limite_aniversarios` int(11) DEFAULT NULL,
  `b_eve_oc` tinyint(1) NOT NULL DEFAULT 0,
  `b_eve_espera_online` tinyint(1) NOT NULL DEFAULT 0,
  `n_eve_espera_tolerancia` int(11) DEFAULT 5,
  `b_eve_reserva_online` tinyint(1) NOT NULL DEFAULT 1,
  `t_eve_reserva_online_limite` varchar(5) DEFAULT NULL,
  `b_eve_horarios_ativo` tinyint(1) NOT NULL DEFAULT 1,
  `n_eve_promover_padrao` int(11) DEFAULT NULL,
  `b_eve_comemorar` tinyint(1) NOT NULL DEFAULT 0,
  `e_eve_reserva_pagamento` varchar(1) DEFAULT NULL,
  `n_eve_reserva_pagamento_pessoa` float DEFAULT NULL,
  `b_eve_entrada_pagamento` tinyint(1) NOT NULL DEFAULT 0,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_eve_evento`
--

INSERT INTO `tb_eve_evento` (`p_eve_id`, `f_eve_usuario`, `s_eve_titulo`, `s_eve_descricao`, `e_eve_visibilidade`, `t_eve_data_evento`, `t_eve_data_fim_evento`, `t_eve_data_fechamento`, `t_eve_data_fechamento_checkin`, `t_eve_data_cadastro`, `f_eve_fb_masc`, `f_eve_fb_fem`, `f_eve_oc_beneficio`, `s_eve_flyer`, `f_eve_ani_masc`, `f_eve_ani_fem`, `n_eve_vip_masc`, `f_eve_bnf_colab`, `n_eve_vip_fem`, `n_eve_ani_vip`, `n_eve_acom_vip`, `f_eve_cenario_mesas`, `b_eve_estrela`, `b_eve_somente_link`, `n_eve_limite_aniversarios`, `b_eve_oc`, `b_eve_espera_online`, `n_eve_espera_tolerancia`, `b_eve_reserva_online`, `t_eve_reserva_online_limite`, `b_eve_horarios_ativo`, `n_eve_promover_padrao`, `b_eve_comemorar`, `e_eve_reserva_pagamento`, `n_eve_reserva_pagamento_pessoa`, `b_eve_entrada_pagamento`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(2163, 3078, 'Happy Hour', 'Teste<br />dad', 's', '2022-02-25 16:08:00', '2022-02-25 22:08:00', '2021-04-30 16:08:00', NULL, '2021-03-28 21:08:00', 'Homem 30', 'Mulher 10', '82', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 117, 0, 0, NULL, 0, 1, 2, 1, NULL, 1, NULL, 0, 'm', NULL, 1, '2021-03-28 16:10:17', '2021-03-28 16:10:17', NULL),
(2164, 3078, '-', '-', 's', '2021-05-30 16:00:00', '2021-05-30 20:00:00', NULL, NULL, '2021-05-28 16:32:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 117, 0, 0, NULL, 0, 0, NULL, 0, NULL, 1, NULL, 0, '0', NULL, 0, '2021-05-28 16:32:24', '2021-05-28 16:32:24', NULL),
(2165, 3078, 'Teste', 'teste', 's', '2021-07-04 16:00:00', '2021-07-04 20:00:00', NULL, NULL, '2021-07-03 20:25:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 117, 0, 0, NULL, 0, 0, 5, 0, '1', 1, NULL, 0, NULL, NULL, 0, '2021-07-03 20:25:40', '2021-07-03 20:25:40', NULL),
(2166, 3078, 'Teste', 'Teste', 's', '2021-07-19 16:00:00', '2021-07-19 19:00:00', NULL, NULL, '2021-07-05 16:02:22', 'Homem 30', 'Mulher 10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 117, 0, 0, NULL, 0, 0, NULL, 0, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-07-05 16:02:22', '2021-07-05 16:02:22', NULL),
(2167, 3078, '-', 'Teste', 's', '2021-10-18 16:00:00', '2021-10-18 19:00:00', NULL, NULL, '2021-09-09 15:46:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 117, 0, 0, NULL, 0, 0, NULL, 0, '', 1, NULL, 0, NULL, NULL, 0, '2021-09-09 15:46:49', '2021-09-09 15:46:49', NULL),
(2168, 3078, '-', 'Testte', 's', '2021-10-22 16:00:00', '2021-10-22 18:00:00', NULL, NULL, '2021-10-11 17:51:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-10-11 17:51:06', '2021-10-11 17:51:06', NULL),
(2169, 3078, '-', 'Teste', 's', '2021-10-17 16:00:00', '2021-10-17 19:00:00', NULL, NULL, '2021-10-11 18:03:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-10-11 18:03:45', '2021-10-11 18:03:45', NULL),
(2170, 3078, '-', 'Teste', 's', '2021-10-19 16:00:00', '2021-10-19 18:00:00', NULL, NULL, '2021-10-11 18:05:13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-10-11 18:05:13', '2021-10-11 18:05:13', NULL),
(2171, 3078, '-', 'Teste', 's', '2021-10-20 16:00:00', '2021-10-20 18:00:00', NULL, NULL, '2021-10-11 18:07:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 117, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-10-11 18:07:22', '2021-10-11 18:07:22', NULL),
(2172, 3078, '-', 'Teste', 's', '2021-10-21 16:00:00', '2021-10-21 18:00:00', NULL, NULL, '2021-10-11 18:12:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-10-11 18:12:48', '2021-10-11 18:12:48', NULL),
(2173, 3078, '-', 'Teste', 's', '2021-10-16 16:00:00', '2021-10-16 18:00:00', NULL, NULL, '2021-10-11 18:21:28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-10-11 18:21:28', '2021-10-11 18:21:28', NULL),
(2174, 3078, '-', 'Teste', 's', '2021-10-15 16:00:00', '2021-10-15 18:00:00', NULL, NULL, '2021-10-11 18:24:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-10-11 18:24:14', '2021-10-11 18:24:14', NULL),
(2175, 3078, '-', '', 's', '2021-11-20 16:00:00', '2021-11-20 19:00:00', NULL, NULL, '2021-11-03 18:49:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 117, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-11-03 18:49:08', '2021-11-03 18:49:08', NULL),
(2176, 3078, '-', '', 's', '2021-11-21 16:00:00', '2021-11-21 19:00:00', NULL, NULL, '2021-11-04 14:53:51', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 117, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-11-04 14:53:51', '2021-11-04 14:53:51', NULL),
(2177, 3078, '-', '', 's', '2021-11-22 16:00:00', '2021-11-22 19:00:00', NULL, NULL, '2021-11-04 14:58:31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-11-04 14:58:31', '2021-11-04 14:58:31', NULL),
(2178, 3078, '-', '', 's', '2021-11-23 16:00:00', '2021-11-23 19:00:00', NULL, NULL, '2021-11-04 15:00:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-11-04 15:00:11', '2021-11-04 15:00:11', NULL),
(2179, 3078, '-', '', 's', '2021-12-24 16:00:00', '2021-12-24 17:00:00', NULL, NULL, '2021-11-04 15:01:56', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 0, 5, 1, NULL, 1, NULL, 0, NULL, NULL, 0, '2021-11-04 15:01:56', '2021-11-04 15:01:56', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_funcao`
--

CREATE TABLE `tb_eve_funcao` (
  `p_func_id` int(11) NOT NULL COMMENT 'Armazena o ID da função do usuário.',
  `s_func_nome` varchar(45) NOT NULL COMMENT 'Armazena a função do usuário.',
  `t_func_data_cadastro` datetime NOT NULL COMMENT 'Armazena a data de cadastro.',
  `s_func_cor` varchar(45) DEFAULT NULL COMMENT 'Armazena a cor da função',
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_funcao_acessos`
--

CREATE TABLE `tb_eve_funcao_acessos` (
  `p_aces_id` int(11) UNSIGNED NOT NULL,
  `f_aces_funcao` int(11) NOT NULL,
  `b_aces_acesso_convidados` tinyint(11) NOT NULL DEFAULT 1,
  `b_aces_acesso_criar_evento` tinyint(11) NOT NULL DEFAULT 1,
  `b_aces_acesso_checkin` tinyint(11) NOT NULL DEFAULT 1,
  `b_aces_acesso_colaboradores` tinyint(11) NOT NULL DEFAULT 1,
  `b_aces_acesso_resultados` tinyint(11) NOT NULL DEFAULT 1,
  `b_aces_acesso_listas` tinyint(11) NOT NULL DEFAULT 1,
  `b_aces_acesso_configuracoes` tinyint(11) NOT NULL DEFAULT 1,
  `b_aces_acesso_pos_venda` tinyint(11) NOT NULL DEFAULT 1,
  `b_aces_acesso_reserva_mesa` tinyint(11) NOT NULL DEFAULT 1,
  `f_aces_usuario` int(11) NOT NULL DEFAULT 1,
  `updatedAt` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_giro_mesa`
--

CREATE TABLE `tb_eve_giro_mesa` (
  `p_gir_id` int(11) UNSIGNED NOT NULL,
  `f_gir_evento` int(11) NOT NULL,
  `s_gir_hora_inicio` time DEFAULT NULL,
  `s_gir_hora_fim` time DEFAULT NULL,
  `b_gir_ativo` tinyint(1) NOT NULL DEFAULT 1,
  `n_gir_limite_reservas` int(11) DEFAULT NULL,
  `n_gir_limite_pessoas` int(11) DEFAULT NULL,
  `n_gir_limite_pessoas_reserva` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_eve_giro_mesa`
--

INSERT INTO `tb_eve_giro_mesa` (`p_gir_id`, `f_gir_evento`, `s_gir_hora_inicio`, `s_gir_hora_fim`, `b_gir_ativo`, `n_gir_limite_reservas`, `n_gir_limite_pessoas`, `n_gir_limite_pessoas_reserva`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1765, 2163, '16:00:00', '16:00:00', 1, NULL, NULL, NULL, '2021-03-28 16:25:03', '2021-03-28 16:25:03', NULL),
(1766, 2166, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-07-05 16:02:22', '2021-07-05 16:02:22', NULL),
(1767, 2168, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-10-11 17:51:06', '2021-10-11 17:51:06', NULL),
(1768, 2168, '20:00:00', '21:00:00', 1, NULL, NULL, NULL, '2021-10-11 17:51:06', '2021-10-11 17:51:06', NULL),
(1769, 2169, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-10-11 18:03:45', '2021-10-11 18:03:45', NULL),
(1770, 2170, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-10-11 18:05:13', '2021-10-11 18:05:13', NULL),
(1771, 2171, '16:00:00', '18:00:00', 0, NULL, NULL, NULL, '2021-10-11 18:07:22', '2021-10-11 18:07:22', NULL),
(1772, 2172, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-10-11 18:12:48', '2021-10-11 18:12:48', NULL),
(1773, 2173, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-10-11 18:21:28', '2021-10-11 18:21:28', NULL),
(1774, 2174, '16:00:00', '18:00:00', 0, NULL, NULL, NULL, '2021-10-11 18:24:14', '2021-10-11 18:24:14', NULL),
(1775, 2174, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-10-13 13:37:43', '2021-10-13 13:37:43', NULL),
(1776, 2171, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-10-20 18:19:11', '2021-10-20 18:19:11', NULL),
(1777, 2175, '16:00:00', '17:00:00', 1, NULL, NULL, NULL, '2021-11-03 18:49:08', '2021-11-03 18:49:08', NULL),
(1778, 2176, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-11-04 14:53:51', '2021-11-04 14:53:51', NULL),
(1779, 2177, '16:00:00', '18:00:00', 1, NULL, NULL, NULL, '2021-11-04 14:58:31', '2021-11-04 14:58:31', NULL),
(1780, 2178, '16:00:00', '17:00:00', 1, NULL, NULL, NULL, '2021-11-04 15:00:11', '2021-11-04 15:00:11', NULL),
(1781, 2179, '16:00:00', '17:00:00', 1, NULL, NULL, NULL, '2021-11-04 15:01:56', '2021-11-04 15:01:56', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_link_promover`
--

CREATE TABLE `tb_eve_link_promover` (
  `p_lnk_id` int(11) NOT NULL,
  `s_lnk_fb_masc` varchar(255) NOT NULL,
  `n_lnk_limite_masc` int(11) DEFAULT NULL,
  `s_lnk_fb_fem` varchar(255) NOT NULL,
  `n_lnk_limite_fem` int(11) DEFAULT NULL,
  `f_lnk_usuario` int(11) NOT NULL,
  `f_lnk_evento` int(11) NOT NULL,
  `f_lnk_aniversario` int(11) DEFAULT NULL,
  `f_lnk_aniversariante` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_eve_link_promover`
--

INSERT INTO `tb_eve_link_promover` (`p_lnk_id`, `s_lnk_fb_masc`, `n_lnk_limite_masc`, `s_lnk_fb_fem`, `n_lnk_limite_fem`, `f_lnk_usuario`, `f_lnk_evento`, `f_lnk_aniversario`, `f_lnk_aniversariante`, `createdAt`, `updatedAt`) VALUES
(2036, 'Homem', NULL, 'Mulher', NULL, 3078, 2163, NULL, NULL, '2021-08-13 11:27:21', '2021-08-13 11:27:21'),
(2037, 'Homem', NULL, 'Mulher', NULL, 3078, 2163, NULL, NULL, '2021-08-13 11:27:21', '2021-08-13 11:27:21'),
(2038, 'Homem', NULL, 'Mulher', NULL, 3078, 2163, NULL, NULL, '2021-08-13 11:27:21', '2021-08-13 11:27:21'),
(2039, 'Homem', NULL, 'Mulher', NULL, 3078, 2163, NULL, NULL, '2021-08-13 11:27:21', '2021-08-13 11:27:21'),
(2040, 'Homem', NULL, 'Mulher', NULL, 3078, 2166, NULL, NULL, '2021-08-13 11:27:21', '2021-08-13 11:27:21');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_lista`
--

CREATE TABLE `tb_eve_lista` (
  `p_lst_id` int(11) NOT NULL COMMENT 'Armazena o ID da lista.',
  `f_lst_evento` int(11) NOT NULL COMMENT 'Amazena o id do evento.',
  `f_lst_participante` int(11) DEFAULT NULL COMMENT 'Armazena o ID do participante.',
  `s_lst_nome` varchar(255) NOT NULL COMMENT 'Armazena o Nome do participante',
  `s_lst_email` varchar(255) DEFAULT NULL,
  `s_lst_telefone` varchar(50) DEFAULT NULL,
  `e_lst_sexo` enum('m','f') DEFAULT NULL,
  `t_lst_nasc` date DEFAULT NULL COMMENT 'Armazena a data de nascimento.',
  `s_lst_documento` varchar(55) DEFAULT NULL,
  `s_lst_status` varchar(100) DEFAULT 'Valor de lista' COMMENT 'Armazena se o convidado possui VALOR DE LISTA, VIP MASCULINO ou VIP FEMININO',
  `s_lst_cor` varchar(10) DEFAULT NULL,
  `s_lst_vip` varchar(45) DEFAULT 'NÃO',
  `f_lst_convidado_por` int(11) DEFAULT NULL COMMENT 'Armazena o ID do colaborador que trouxe o participante.',
  `f_lst_tipo` int(11) DEFAULT NULL COMMENT 'Armazena o tipo do participante (Colaborador, Participante, Hostess)',
  `t_lst_data_cadastro` datetime NOT NULL COMMENT 'Armazena a data de inserção na lista.',
  `t_lst_data_checkin` datetime DEFAULT NULL COMMENT 'Armazena a data de checkin do participante',
  `s_lst_foto` longtext DEFAULT NULL,
  `s_tipo_lista` varchar(45) DEFAULT NULL,
  `t_data_checkin` varchar(45) DEFAULT NULL,
  `s_lst_tipo` varchar(45) DEFAULT 'normal',
  `f_lst_aniversario` int(11) DEFAULT NULL,
  `f_lst_checkin_por` int(11) DEFAULT NULL,
  `n_lst_classificacao` float DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_eve_lista`
--

INSERT INTO `tb_eve_lista` (`p_lst_id`, `f_lst_evento`, `f_lst_participante`, `s_lst_nome`, `s_lst_email`, `s_lst_telefone`, `e_lst_sexo`, `t_lst_nasc`, `s_lst_documento`, `s_lst_status`, `s_lst_cor`, `s_lst_vip`, `f_lst_convidado_por`, `f_lst_tipo`, `t_lst_data_cadastro`, `t_lst_data_checkin`, `s_lst_foto`, `s_tipo_lista`, `t_data_checkin`, `s_lst_tipo`, `f_lst_aniversario`, `f_lst_checkin_por`, `n_lst_classificacao`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(495398, 2163, 3078, 'Conv 1', 'lucass_matos@hotmail.com', '61992984682', 'm', NULL, NULL, 'Valor de lista', NULL, 'NÃO', 3078, NULL, '2021-06-28 23:47:54', '2021-06-28 23:47:54', NULL, NULL, NULL, 'normal', 6033, NULL, NULL, '2021-06-28 18:51:02', '2021-06-28 18:51:02', '2021-08-20 14:50:24'),
(495399, 2163, 3078, 'Conv 2', NULL, NULL, NULL, NULL, NULL, 'Valor de lista', NULL, 'NÃO', NULL, NULL, '2021-06-28 23:47:54', NULL, NULL, NULL, NULL, 'normal', 6033, NULL, NULL, '2021-06-28 18:51:02', '2021-06-28 18:51:02', NULL),
(495400, 2165, NULL, 'Lucas', NULL, NULL, NULL, NULL, NULL, 'Homem', NULL, 'NÃO', 3078, NULL, '2021-07-03 20:29:03', NULL, NULL, NULL, NULL, 'normal', NULL, NULL, NULL, '2021-07-03 20:29:03', '2021-07-03 20:29:03', NULL),
(495401, 2165, NULL, 'Marcelo', NULL, NULL, NULL, NULL, NULL, 'Homem', NULL, 'NÃO', 3078, NULL, '2021-07-03 20:29:03', NULL, NULL, NULL, NULL, 'normal', NULL, NULL, NULL, '2021-07-03 20:29:03', '2021-07-03 20:29:03', NULL),
(495402, 2165, NULL, 'Teste', NULL, NULL, NULL, NULL, NULL, 'Vip Masculino', NULL, 'NÃO', 3078, NULL, '2021-07-04 15:00:29', NULL, NULL, NULL, NULL, 'normal', NULL, NULL, NULL, '2021-07-04 15:00:29', '2021-07-04 15:00:29', NULL),
(495403, 2163, NULL, 'Lucas Silva de Matos', 'lucass_matos@hotmail.com', '(61)99298-4682', NULL, NULL, NULL, 'Homem 30', NULL, 'NÃO', NULL, NULL, '2021-07-19 21:12:43', NULL, NULL, NULL, NULL, 'normal', 6035, NULL, NULL, '2021-07-19 21:12:43', '2021-07-19 21:12:43', NULL),
(495404, 2174, NULL, 'Lucas Silva de Matos', NULL, NULL, NULL, NULL, '03330704101', 'Valor de lista', NULL, 'NÃO', 3078, NULL, '2021-10-14 11:29:34', NULL, NULL, NULL, NULL, 'normal', 6036, NULL, NULL, '2021-10-14 11:29:34', '2021-10-14 11:29:34', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_lista_avancada`
--

CREATE TABLE `tb_eve_lista_avancada` (
  `p_lista_avancada_id` int(11) NOT NULL,
  `f_lista_tipo_lista` int(11) NOT NULL,
  `t_lista_avancada_hora_inicio` time DEFAULT NULL,
  `t_lista_avancada_hora_fim` time DEFAULT NULL,
  `n_lista_tipo_entrada` float DEFAULT NULL,
  `n_lista_tipo_consumacao` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_lista_tipos`
--

CREATE TABLE `tb_eve_lista_tipos` (
  `p_lista_tipo_id` int(11) NOT NULL,
  `f_lista_tipo_estabelecimento` int(11) DEFAULT NULL,
  `s_lista_tipo_nome` varchar(100) DEFAULT NULL,
  `s_lista_tipo_cor` varchar(45) DEFAULT NULL,
  `s_lista_tipo_valor` float DEFAULT NULL,
  `t_lista_tipo_data_cadastro` datetime DEFAULT NULL,
  `s_lista_tipo_oc` varchar(20) DEFAULT NULL,
  `s_lista_tipo_fb` varchar(20) DEFAULT NULL,
  `s_lista_tipo_status` varchar(20) DEFAULT 'Não',
  `s_lista_tipo_sexo` varchar(2) DEFAULT NULL,
  `s_lista_tipo_consumacao` float DEFAULT NULL,
  `b_lista_tipo_avancada` tinyint(2) NOT NULL DEFAULT 0,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_eve_lista_tipos`
--

INSERT INTO `tb_eve_lista_tipos` (`p_lista_tipo_id`, `f_lista_tipo_estabelecimento`, `s_lista_tipo_nome`, `s_lista_tipo_cor`, `s_lista_tipo_valor`, `t_lista_tipo_data_cadastro`, `s_lista_tipo_oc`, `s_lista_tipo_fb`, `s_lista_tipo_status`, `s_lista_tipo_sexo`, `s_lista_tipo_consumacao`, `b_lista_tipo_avancada`, `updatedAt`, `createdAt`) VALUES
(227, 3078, 'Homem', '#820333', 30, '2021-06-28 18:41:34', NULL, NULL, 'Não', 'M', 0, 0, '2021-06-28 18:41:34', '2021-06-28 18:41:34'),
(228, 3078, 'Mulher', '#C15020', 10, '2021-06-28 18:41:48', NULL, NULL, 'Não', 'F', 0, 0, '2021-06-28 18:41:48', '2021-06-28 18:41:48');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_lista_tipos_eventos`
--

CREATE TABLE `tb_eve_lista_tipos_eventos` (
  `p_lista_tipo_evento_id` int(11) NOT NULL,
  `f_lista_tipo_id` int(11) DEFAULT NULL,
  `f_lista_evento_id` int(11) DEFAULT NULL,
  `t_lista_tipo_evento_data_cadastro` datetime DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_eve_lista_tipos_eventos`
--

INSERT INTO `tb_eve_lista_tipos_eventos` (`p_lista_tipo_evento_id`, `f_lista_tipo_id`, `f_lista_evento_id`, `t_lista_tipo_evento_data_cadastro`, `updatedAt`, `createdAt`) VALUES
(1559, 227, 2163, '2021-06-28 18:42:09', '2021-06-28 18:42:09', '2021-06-28 18:42:09'),
(1560, 228, 2163, '2021-06-28 18:42:10', '2021-06-28 18:42:10', '2021-06-28 18:42:10'),
(1561, 227, 2165, '2021-07-03 20:26:16', '2021-07-03 20:26:16', '2021-07-03 20:26:16'),
(1562, 228, 2165, '2021-07-03 20:26:17', '2021-07-03 20:26:17', '2021-07-03 20:26:17'),
(1563, 227, 2166, '2021-07-05 17:41:48', '2021-07-05 17:41:48', '2021-07-05 17:41:48'),
(1564, 228, 2166, '2021-07-05 17:41:49', '2021-07-05 17:41:49', '2021-07-05 17:41:49');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_reserva`
--

CREATE TABLE `tb_eve_reserva` (
  `p_res_id` int(11) NOT NULL,
  `f_res_evento` int(11) NOT NULL,
  `f_res_cenario_mesas` int(11) DEFAULT NULL,
  `b_res_cenario_ativo` tinyint(1) NOT NULL DEFAULT 1,
  `b_res_espera_online` tinyint(1) NOT NULL DEFAULT 0,
  `n_res_espera_tolerancia` int(11) DEFAULT NULL,
  `e_res_pagamento` enum('m','p') DEFAULT NULL,
  `n_res_pagamento_pessoa` int(11) DEFAULT NULL,
  `b_res_espera_prioridade` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_reserva_ambientes`
--

CREATE TABLE `tb_eve_reserva_ambientes` (
  `p_amb_id` int(11) NOT NULL,
  `f_amb_giro` int(11) NOT NULL,
  `s_amb_nome` varchar(35) DEFAULT NULL,
  `n_amb_limite_reservas` int(11) DEFAULT NULL,
  `n_amb_limite_pessoas` int(11) DEFAULT NULL,
  `n_amb_limite_pessoas_reserva` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_eve_reserva_ambientes`
--

INSERT INTO `tb_eve_reserva_ambientes` (`p_amb_id`, `f_amb_giro`, `s_amb_nome`, `n_amb_limite_reservas`, `n_amb_limite_pessoas`, `n_amb_limite_pessoas_reserva`) VALUES
(1, 1775, 'Varanda', 4, 18, 5),
(2, 1781, 'Área Externa', 3, 15, 5),
(3, 1781, 'Área Interna', 6, 20, 7);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_subevento_tipos`
--

CREATE TABLE `tb_eve_subevento_tipos` (
  `p_sub_tipo_id` int(11) UNSIGNED NOT NULL,
  `s_sub_tipo_nome` varchar(35) NOT NULL DEFAULT '',
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_eve_subevento_vips`
--

CREATE TABLE `tb_eve_subevento_vips` (
  `p_vip_id` int(11) UNSIGNED NOT NULL,
  `f_vip_evento` int(11) DEFAULT NULL,
  `n_vip_ani` int(11) DEFAULT NULL,
  `n_vip_acom` int(11) DEFAULT NULL,
  `n_vip_desp_uni` int(11) DEFAULT NULL,
  `n_vip_hh_uni` int(11) DEFAULT NULL,
  `n_vip_conf_uni` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_dress_code`
--

CREATE TABLE `tb_oc_dress_code` (
  `p_drc_id` int(11) UNSIGNED NOT NULL,
  `f_drc_evento` int(11) NOT NULL,
  `s_drc_nome` varchar(35) NOT NULL DEFAULT '',
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_oc_dress_code`
--

INSERT INTO `tb_oc_dress_code` (`p_drc_id`, `f_drc_evento`, `s_drc_nome`, `updatedAt`, `createdAt`) VALUES
(26, 2163, 'Social', '2022-02-17 19:07:13', '2022-02-17 19:07:13');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_estabalecimento_hashtags`
--

CREATE TABLE `tb_oc_estabalecimento_hashtags` (
  `p_hsh_id` int(11) UNSIGNED NOT NULL,
  `s_hsh_nome` varchar(15) NOT NULL DEFAULT '',
  `f_hsh_estabelecimento` int(11) NOT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_estabelecimento`
--

CREATE TABLE `tb_oc_estabelecimento` (
  `p_est_id` int(11) UNSIGNED NOT NULL,
  `f_est_usuario` int(11) NOT NULL,
  `s_est_descricao` varchar(280) DEFAULT '',
  `f_est_tipo_1` int(11) DEFAULT NULL,
  `f_est_tipo_2` int(11) DEFAULT NULL,
  `f_est_tipo_3` int(11) DEFAULT NULL,
  `f_est_regiao` int(11) DEFAULT NULL,
  `s_est_preco` int(11) DEFAULT NULL,
  `t_est_hora_inicio` varchar(8) DEFAULT NULL,
  `t_est_hora_fim` varchar(8) DEFAULT NULL,
  `s_est_foto` varchar(55) DEFAULT '',
  `s_est_endereco` varchar(255) DEFAULT NULL,
  `s_est_site` varchar(250) DEFAULT NULL,
  `b_est_vallet` tinyint(1) NOT NULL DEFAULT 0,
  `n_est_vallet_valor` float DEFAULT NULL,
  `b_est_mostrar_instagram` tinyint(1) NOT NULL DEFAULT 1,
  `b_est_mostrar_facebook` tinyint(1) NOT NULL DEFAULT 1,
  `b_est_mostrar_celular` tinyint(1) NOT NULL DEFAULT 1,
  `b_est_mostrar_localizacao_mapa` tinyint(1) NOT NULL,
  `b_est_mostrar_localizacao_botoes` tinyint(1) NOT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_oc_estabelecimento`
--

INSERT INTO `tb_oc_estabelecimento` (`p_est_id`, `f_est_usuario`, `s_est_descricao`, `f_est_tipo_1`, `f_est_tipo_2`, `f_est_tipo_3`, `f_est_regiao`, `s_est_preco`, `t_est_hora_inicio`, `t_est_hora_fim`, `s_est_foto`, `s_est_endereco`, `s_est_site`, `b_est_vallet`, `n_est_vallet_valor`, `b_est_mostrar_instagram`, `b_est_mostrar_facebook`, `b_est_mostrar_celular`, `b_est_mostrar_localizacao_mapa`, `b_est_mostrar_localizacao_botoes`, `updatedAt`, `createdAt`, `deletedAt`) VALUES
(205, 3078, 'Seguimos fazendo o que sabemos de melhor, entreter as pessooas com boa música e ótimos petiscos!', 1, 3, NULL, 1, 4, NULL, NULL, '', NULL, NULL, 0, NULL, 1, 1, 1, 1, 0, '2021-06-30 12:26:37', '2021-06-30 12:26:37', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_estabelecimento_tipos`
--

CREATE TABLE `tb_oc_estabelecimento_tipos` (
  `p_tip_tipo` int(11) NOT NULL,
  `s_tip_nome` varchar(25) NOT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_oc_estabelecimento_tipos`
--

INSERT INTO `tb_oc_estabelecimento_tipos` (`p_tip_tipo`, `s_tip_nome`, `updatedAt`, `createdAt`) VALUES
(1, 'Bar', '2021-06-30 12:14:52', '2021-06-30 12:14:52'),
(2, 'Balada', '2021-06-30 12:14:52', '2021-06-30 12:14:52'),
(3, 'Restaurante', '2021-06-30 12:14:52', '2021-06-30 12:14:52');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_evento`
--

CREATE TABLE `tb_oc_evento` (
  `p_eve_id` int(11) UNSIGNED NOT NULL,
  `f_eve_estabelecimento` int(11) NOT NULL,
  `f_eve_beneficio` int(11) NOT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_evento_musica`
--

CREATE TABLE `tb_oc_evento_musica` (
  `p_atr_id` int(11) UNSIGNED NOT NULL,
  `f_atr_evento` int(11) NOT NULL,
  `s_atr_nome` varchar(55) NOT NULL DEFAULT '',
  `t_atr_hora_inicio` time DEFAULT NULL,
  `t_atr_hora_fim` time DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_oc_evento_musica`
--

INSERT INTO `tb_oc_evento_musica` (`p_atr_id`, `f_atr_evento`, `s_atr_nome`, `t_atr_hora_inicio`, `t_atr_hora_fim`, `updatedAt`, `createdAt`) VALUES
(25, 2163, 'Henrique e Diego', NULL, NULL, '2022-02-17 19:06:57', '2022-02-17 19:06:57');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_imagens_estabelecimento`
--

CREATE TABLE `tb_oc_imagens_estabelecimento` (
  `p_img_id` int(11) UNSIGNED NOT NULL,
  `f_img_usuario` int(11) NOT NULL,
  `s_img_imagem` varchar(25) NOT NULL DEFAULT '',
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_sugerir_cidade`
--

CREATE TABLE `tb_oc_sugerir_cidade` (
  `p_sug_id` int(11) UNSIGNED NOT NULL,
  `s_sug_nome` varchar(255) DEFAULT NULL,
  `s_sug_email` varchar(35) DEFAULT NULL,
  `s_sug_telefone` varchar(15) DEFAULT NULL,
  `t_sug_data_nascimento` date NOT NULL,
  `s_sug_cidade` varchar(35) NOT NULL DEFAULT '',
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_oc_sugerir_cidade`
--

INSERT INTO `tb_oc_sugerir_cidade` (`p_sug_id`, `s_sug_nome`, `s_sug_email`, `s_sug_telefone`, `t_sug_data_nascimento`, `s_sug_cidade`, `updatedAt`, `createdAt`) VALUES
(6, 'Lucas Silva de Matos', 'lucass_matos@hotmail.com', '(61)99298-4682', '1993-02-04', 'Brasília', '2021-09-01 15:04:43', '2021-09-01 15:04:43');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_sugerir_data`
--

CREATE TABLE `tb_oc_sugerir_data` (
  `p_sug_data` int(11) UNSIGNED NOT NULL,
  `f_sug_estabelecimento` int(11) NOT NULL,
  `s_sug_nome` varchar(255) NOT NULL DEFAULT '',
  `s_sug_email` varchar(100) NOT NULL DEFAULT '',
  `s_sug_telefone` varchar(55) NOT NULL DEFAULT '',
  `s_sug_data_nascimento` varchar(25) NOT NULL DEFAULT '',
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_oc_sugerir_data`
--

INSERT INTO `tb_oc_sugerir_data` (`p_sug_data`, `f_sug_estabelecimento`, `s_sug_nome`, `s_sug_email`, `s_sug_telefone`, `s_sug_data_nascimento`, `createdAt`, `updatedAt`) VALUES
(8, 205, 'Lucas Silva de Matos', 'lucass_matos@hotmail.com', '(61)99298-4682', '02/12/2021', '2021-07-22 21:13:56', '2021-07-22 21:13:56');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_oc_usu_estabelecimento`
--

CREATE TABLE `tb_oc_usu_estabelecimento` (
  `p_usu_est_id` int(11) UNSIGNED NOT NULL,
  `f_usu_est_usuario` int(11) NOT NULL,
  `f_usu_est_estabelecimento` int(11) NOT NULL,
  `n_usu_est_classificacao` float DEFAULT NULL,
  `b_usu_est_like` tinyint(1) NOT NULL DEFAULT 0,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_pais`
--

CREATE TABLE `tb_pais` (
  `p_pai_id` int(11) UNSIGNED NOT NULL,
  `s_pai_nome` varchar(55) NOT NULL DEFAULT '',
  `s_pai_nome_ingles` varchar(55) NOT NULL DEFAULT '',
  `s_pai_nome_abreviado` varchar(2) NOT NULL DEFAULT '',
  `n_pai_ddi` varchar(2) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_cenario_horarios`
--

CREATE TABLE `tb_prm_cenario_horarios` (
  `p_hor_id` int(11) UNSIGNED NOT NULL,
  `f_hor_cenario` int(11) NOT NULL,
  `s_hor_horario` varchar(15) NOT NULL DEFAULT '',
  `b_hor_ativo` tinyint(1) NOT NULL DEFAULT 1,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_cenario_mesas`
--

CREATE TABLE `tb_prm_cenario_mesas` (
  `p_cen_id` int(11) NOT NULL,
  `f_cen_usuario` int(11) DEFAULT NULL,
  `s_cen_nome` varchar(255) DEFAULT NULL,
  `s_cen_foto` varchar(100) DEFAULT NULL,
  `b_cen_icone` tinyint(1) DEFAULT 1,
  `b_cen_cor_fundo` tinyint(1) DEFAULT 1,
  `s_cen_cor_fundo` varchar(55) DEFAULT NULL,
  `b_cen_numero_mesa` tinyint(1) DEFAULT 1,
  `s_cen_cor_num` varchar(55) DEFAULT NULL,
  `b_cen_cap_mesa` tinyint(1) DEFAULT 1,
  `s_cen_cor_cap` varchar(55) DEFAULT NULL,
  `b_cen_img_mesa` tinyint(1) DEFAULT 1,
  `s_cen_img_width` varchar(25) DEFAULT '700px',
  `s_cen_img_height` varchar(25) DEFAULT '700px',
  `b_cen_invisivel` tinyint(4) DEFAULT 0,
  `b_cen_mapa_visual` tinyint(1) NOT NULL DEFAULT 0,
  `b_cen_horarios_ativo` tinyint(1) NOT NULL DEFAULT 0,
  `b_cen_espera_online` tinyint(1) DEFAULT 0,
  `b_cen_reserva_online` tinyint(1) NOT NULL DEFAULT 0,
  `t_cen_reserva_online_limite` datetime DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_prm_cenario_mesas`
--

INSERT INTO `tb_prm_cenario_mesas` (`p_cen_id`, `f_cen_usuario`, `s_cen_nome`, `s_cen_foto`, `b_cen_icone`, `b_cen_cor_fundo`, `s_cen_cor_fundo`, `b_cen_numero_mesa`, `s_cen_cor_num`, `b_cen_cap_mesa`, `s_cen_cor_cap`, `b_cen_img_mesa`, `s_cen_img_width`, `s_cen_img_height`, `b_cen_invisivel`, `b_cen_mapa_visual`, `b_cen_horarios_ativo`, `b_cen_espera_online`, `b_cen_reserva_online`, `t_cen_reserva_online_limite`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(117, 3078, 'Teste', NULL, 1, 1, NULL, 1, NULL, 1, NULL, 1, '700px', '700px', 0, 0, 0, 0, 0, NULL, '2021-08-20 10:57:27', '2021-08-20 10:57:54', NULL),
(118, 3078, 'Teste', NULL, 1, 1, NULL, 1, NULL, 1, NULL, 1, '700px', '700px', 0, 0, 0, 0, 0, '2021-07-05 09:51:29', '2021-08-20 10:57:27', '2021-08-20 10:57:54', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_espera_status`
--

CREATE TABLE `tb_prm_espera_status` (
  `p_sta_id` int(11) NOT NULL,
  `f_sta_cliente` int(11) NOT NULL,
  `s_sta_status` varchar(1) NOT NULL,
  `f_sta_alterado_por` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_mesas`
--

CREATE TABLE `tb_prm_mesas` (
  `p_mes_id` int(11) NOT NULL,
  `n_mes_numero` int(11) DEFAULT NULL,
  `f_mes_usuario` int(11) DEFAULT NULL,
  `f_mes_cenario` int(11) DEFAULT NULL,
  `n_mes_capacidade_min` int(11) DEFAULT NULL,
  `n_mes_capacidade_max` int(11) DEFAULT NULL,
  `s_mes_tipo` varchar(55) DEFAULT NULL,
  `n_mes_pos_top` float DEFAULT NULL,
  `n_mes_pos_left` float DEFAULT NULL,
  `s_mes_nome` varchar(255) DEFAULT NULL,
  `s_mes_width` varchar(25) DEFAULT '63px',
  `s_mes_height` varchar(25) DEFAULT '56px',
  `s_mes_icone_width` varchar(25) DEFAULT '103.56px',
  `s_mes_icone_height` varchar(25) DEFAULT '112px',
  `f_mes_grupo` int(11) DEFAULT NULL,
  `n_mes_preco` int(11) DEFAULT NULL,
  `s_mes_descricao` varchar(255) DEFAULT NULL,
  `s_mes_foto` varchar(15) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_prm_mesas`
--

INSERT INTO `tb_prm_mesas` (`p_mes_id`, `n_mes_numero`, `f_mes_usuario`, `f_mes_cenario`, `n_mes_capacidade_min`, `n_mes_capacidade_max`, `s_mes_tipo`, `n_mes_pos_top`, `n_mes_pos_left`, `s_mes_nome`, `s_mes_width`, `s_mes_height`, `s_mes_icone_width`, `s_mes_icone_height`, `f_mes_grupo`, `n_mes_preco`, `s_mes_descricao`, `s_mes_foto`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1130, 1, 3078, 117, 3, 6, NULL, NULL, NULL, 'Varanda', '63px', '56px', '103.56px', '112px', 32, 399, NULL, NULL, '2021-08-12 10:53:28', '2021-08-12 10:53:28', NULL),
(1131, 2, 3078, 117, 4, 8, NULL, NULL, NULL, 'Frente Palco', '63px', '56px', '103.56px', '112px', 34, 499, NULL, NULL, '2021-08-12 10:53:28', '2021-08-12 10:53:28', NULL),
(1132, 3, 3078, 117, 2, 4, NULL, NULL, NULL, 'Rooftop', '63px', '56px', '103.56px', '112px', 34, 299, NULL, NULL, '2021-08-12 10:53:28', '2021-08-12 10:53:28', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_mesa_espera`
--

CREATE TABLE `tb_prm_mesa_espera` (
  `p_esp_id` int(11) UNSIGNED NOT NULL,
  `f_esp_evento` int(11) NOT NULL,
  `s_esp_nome` varchar(255) NOT NULL DEFAULT '',
  `s_esp_fone` varchar(255) NOT NULL DEFAULT '',
  `s_esp_email` varchar(255) DEFAULT '',
  `n_esp_pager` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `n_esp_capacidade` int(11) DEFAULT NULL,
  `b_esp_ativo` tinyint(4) NOT NULL DEFAULT 1,
  `f_esp_usuario` int(11) DEFAULT NULL,
  `s_esp_status` varchar(1) NOT NULL DEFAULT 'a',
  `t_esp_horario` varchar(5) DEFAULT NULL,
  `s_esp_observacao` varchar(55) DEFAULT NULL,
  `t_esp_nasc` date DEFAULT NULL,
  `f_esp_setor` int(11) DEFAULT NULL,
  `b_esp_nec_especial` tinyint(1) NOT NULL DEFAULT 0,
  `s_esp_documento` varchar(15) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_prm_mesa_espera`
--

INSERT INTO `tb_prm_mesa_espera` (`p_esp_id`, `f_esp_evento`, `s_esp_nome`, `s_esp_fone`, `s_esp_email`, `n_esp_pager`, `created_at`, `n_esp_capacidade`, `b_esp_ativo`, `f_esp_usuario`, `s_esp_status`, `t_esp_horario`, `s_esp_observacao`, `t_esp_nasc`, `f_esp_setor`, `b_esp_nec_especial`, `s_esp_documento`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(11996, 2164, 'Lucas Matos', '(61) 99298-4682', NULL, NULL, '2021-07-16 18:02:52', 4, 1, NULL, 'a', NULL, NULL, '0000-00-00', 0, 0, NULL, '2021-05-28 16:35:24', '2021-05-28 16:35:43', NULL),
(11997, 2164, 'Lucas Silva', '(11) 98498-6504', NULL, NULL, '2021-05-28 17:57:03', 4, 1, NULL, 'c', NULL, NULL, '0000-00-00', 0, 0, NULL, '2021-05-28 17:56:54', '2021-05-28 17:57:03', NULL),
(11998, 2163, 'Lucas Matos', '61992984682', NULL, NULL, '2021-07-16 18:02:57', 8, 1, NULL, 's', NULL, NULL, '0000-00-00', 0, 0, NULL, '2021-06-14 14:46:24', '2021-06-14 14:48:12', NULL),
(11999, 2163, 'Lucas Matos', '61992984682', NULL, NULL, '0000-00-00 00:00:00', 4, 1, NULL, 'a', NULL, NULL, NULL, NULL, 0, NULL, '2021-07-23 15:22:01', '2021-07-23 15:22:01', NULL),
(12000, 2163, 'Lucas 2', '61992984682', NULL, NULL, '2021-07-23 15:22:57', 2, 1, NULL, 'c', NULL, NULL, NULL, NULL, 0, NULL, '2021-07-23 15:22:17', '2021-07-23 15:22:17', NULL),
(12001, 2163, 'Lucas 3', '61992984682', NULL, NULL, '2021-07-23 15:23:08', 3, 1, NULL, 's', NULL, NULL, NULL, NULL, 0, NULL, '2021-07-23 15:22:27', '2021-07-23 15:22:27', NULL),
(12002, 2163, 'Lucas 4', '61992984682', NULL, NULL, '2021-07-23 15:23:22', 4, 1, NULL, 'x', NULL, NULL, NULL, NULL, 0, NULL, '2021-07-23 15:22:36', '2021-07-23 15:22:36', NULL),
(12003, 2163, 'Lucas 22', '(61) 99298-4682', NULL, NULL, '2021-07-23 15:23:31', 22, 1, NULL, 'c', NULL, NULL, NULL, NULL, 0, NULL, '2021-07-23 15:22:47', '2021-07-23 15:22:47', NULL),
(12004, 2163, 'Lucas', '(61) 99298-4682', '', NULL, '2021-08-11 16:36:21', 4, 1, NULL, 'a', NULL, NULL, NULL, NULL, 1, NULL, '2021-08-11 16:36:21', '2021-08-11 16:36:21', NULL),
(12005, 2163, 'Lucas 2', '(61) 99929-8468', '', NULL, '2021-08-11 16:59:16', 4, 1, NULL, 'a', NULL, NULL, NULL, NULL, 0, NULL, '2021-08-11 16:59:16', '2021-08-11 16:59:16', NULL),
(12006, 2163, 'Lucas 3', '(61) 99298-4682', '', NULL, '2021-08-11 16:59:30', 4, 1, NULL, 'a', NULL, NULL, NULL, NULL, 1, NULL, '2021-08-11 16:59:30', '2021-08-11 16:59:30', NULL),
(12007, 1, 'Lucas Silva de Matos', '61992984682', '', NULL, '2021-10-06 11:32:55', NULL, 1, NULL, 'a', NULL, NULL, NULL, NULL, 0, NULL, '2021-10-06 11:32:55', '2021-10-06 11:32:55', NULL),
(12008, 1, 'Lucas Silva de Matos', '(61) 99298-4682', '', NULL, '2021-10-06 14:21:27', NULL, 1, NULL, 'a', NULL, NULL, '1993-04-02', NULL, 0, NULL, '2021-10-06 14:21:27', '2021-10-06 14:21:27', NULL),
(12009, 1, 'Lucas Silva de Matos', '(61) 99298-4682', '', NULL, '2021-10-06 14:22:28', NULL, 1, NULL, 'a', NULL, NULL, NULL, NULL, 0, NULL, '2021-10-06 14:22:28', '2021-10-06 14:22:28', NULL),
(12010, 2167, 'Lucas Silva de Matos', '(61) 99298-4682', '', NULL, '2021-10-07 15:24:11', NULL, 1, NULL, 'j', NULL, NULL, '1993-04-02', NULL, 0, NULL, '2021-10-06 14:27:42', '2021-10-06 14:27:42', NULL),
(12011, 2167, 'Lucas Silva de Matos 2', '(61) 99298-4682', '', NULL, '2021-10-07 15:24:14', 2, 1, NULL, 'j', NULL, NULL, '1993-04-02', NULL, 0, NULL, '2021-10-06 15:16:56', '2021-10-06 15:16:56', NULL),
(12012, 2167, 'Lucas Silva de Matos 3', '(61) 99298-4682', '', NULL, '2021-10-07 15:24:17', 2, 1, NULL, 'j', NULL, NULL, '1993-04-02', NULL, 0, NULL, '2021-10-06 15:30:59', '2021-10-06 15:30:59', NULL),
(12013, 2176, 'Lucas Silva de Matos 4', '+5561992984682', '', NULL, '2021-12-06 23:54:59', 2, 1, NULL, 'a', NULL, NULL, '1993-04-02', NULL, 0, '03330704101', '2021-10-06 15:46:36', '2021-10-06 15:46:36', NULL),
(12014, 2176, 'Lucas Silva de Matos 5', '(61) 99298-4682', '', NULL, '2021-12-06 23:56:00', 2, 1, NULL, 'c', NULL, NULL, '1993-04-02', NULL, 0, '31128844001', '2021-10-06 15:51:41', '2021-10-06 15:51:41', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_mesa_travar`
--

CREATE TABLE `tb_prm_mesa_travar` (
  `p_trv_id` int(11) UNSIGNED NOT NULL,
  `f_trv_mesa` int(11) DEFAULT NULL,
  `f_trv_evento` int(11) DEFAULT NULL,
  `f_trv_horario` int(11) DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_prm_mesa_travar`
--

INSERT INTO `tb_prm_mesa_travar` (`p_trv_id`, `f_trv_mesa`, `f_trv_evento`, `f_trv_horario`, `updatedAt`, `createdAt`) VALUES
(2161, 10, 20, 30, '2021-07-16 16:23:04', '2021-07-16 16:23:04'),
(2162, 11, 20, 29, '2021-07-16 16:23:04', '2021-07-16 16:23:04'),
(2163, 12, 20, NULL, '2021-07-16 16:23:04', '2021-07-16 16:23:04'),
(2164, 13, 19, 9, '2021-07-16 16:23:04', '2021-07-16 16:23:04'),
(2165, 14, 19, NULL, '2021-07-16 16:23:04', '2021-07-16 16:23:04');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_mesa_travar_reserva`
--

CREATE TABLE `tb_prm_mesa_travar_reserva` (
  `p_trv_id` int(11) NOT NULL,
  `f_trv_mesa` int(11) NOT NULL,
  `f_trv_evento` int(11) NOT NULL,
  `f_trv_usuario` int(11) NOT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_pos_venda`
--

CREATE TABLE `tb_prm_pos_venda` (
  `p_psv_id` int(11) UNSIGNED NOT NULL,
  `f_psv_convidado` int(11) NOT NULL,
  `b_psv_wpp_lido` tinyint(4) NOT NULL DEFAULT 0,
  `f_psv_usuario` int(11) NOT NULL,
  `f_psv_reserva` int(11) DEFAULT NULL,
  `f_psv_cardapio` int(11) DEFAULT NULL,
  `f_psv_espera` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_premium`
--

CREATE TABLE `tb_prm_premium` (
  `p_prm_id` int(11) UNSIGNED NOT NULL,
  `f_prm_usuario` int(11) NOT NULL,
  `s_prm_stripe_id` varchar(55) NOT NULL,
  `s_prm_subscription` varchar(55) DEFAULT '',
  `s_prm_subscription_start` varchar(55) DEFAULT NULL,
  `s_prm_subscription_eventos` varchar(55) DEFAULT NULL,
  `s_prm_subscription_reservas` varchar(55) DEFAULT NULL,
  `s_prm_subscription_marketing` varchar(55) DEFAULT NULL,
  `s_prm_subscription_cardapio` varchar(55) DEFAULT NULL,
  `b_prm_start` tinyint(1) NOT NULL DEFAULT 0,
  `b_prm_premium` tinyint(1) NOT NULL DEFAULT 0,
  `b_prm_eventos` tinyint(1) NOT NULL DEFAULT 0,
  `b_prm_reservas` tinyint(1) NOT NULL DEFAULT 0,
  `b_prm_marketing` tinyint(1) NOT NULL DEFAULT 0,
  `b_prm_cardapio` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_prm_premium`
--

INSERT INTO `tb_prm_premium` (`p_prm_id`, `f_prm_usuario`, `s_prm_stripe_id`, `s_prm_subscription`, `s_prm_subscription_start`, `s_prm_subscription_eventos`, `s_prm_subscription_reservas`, `s_prm_subscription_marketing`, `s_prm_subscription_cardapio`, `b_prm_start`, `b_prm_premium`, `b_prm_eventos`, `b_prm_reservas`, `b_prm_marketing`, `b_prm_cardapio`, `createdAt`, `updatedAt`) VALUES
(411, 3082, 'cus_Hjq567VJN4EcaV', '', '', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-12 10:27:06', '2021-08-12 10:27:06'),
(424, 3082, 'cus_K6K8jokgvBZcPo', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 18:49:05', '2021-08-24 18:49:05'),
(425, 3082, 'cus_K6KNfrxh7Qo7cW', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:04:00', '2021-08-24 19:04:00'),
(426, 3082, 'cus_K6KNQBwxNEi5ly', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:04:13', '2021-08-24 19:04:13'),
(427, 3082, 'cus_K6KPobOaIkCr5K', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:06:03', '2021-08-24 19:06:03'),
(428, 3082, 'cus_K6KQshshiNrzQG', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:07:19', '2021-08-24 19:07:19'),
(429, 3082, 'cus_K6KR9AAYvOYzKM', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:08:02', '2021-08-24 19:08:02'),
(430, 3082, 'cus_K6KTjxg9S7XEmJ', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:09:22', '2021-08-24 19:09:22'),
(431, 3082, 'cus_K6KUcoG9tNKvAR', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:10:24', '2021-08-24 19:10:24'),
(432, 3082, 'cus_K6KZta1ST6ujB8', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:15:50', '2021-08-24 19:15:50'),
(433, 3082, 'cus_K6KcCMTYiYAajT', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:18:32', '2021-08-24 19:18:32'),
(434, 3082, 'cus_K6Kc8QUcUNuXmy', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:19:12', '2021-08-24 19:19:12'),
(435, 3082, 'cus_K6KdRqp43CV2mI', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:19:27', '2021-08-24 19:19:27'),
(436, 3082, 'cus_K6KiJ8d9M14YpY', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:24:27', '2021-08-24 19:24:27'),
(437, 3082, 'cus_K6KiNrnBfLELPV', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:24:30', '2021-08-24 19:24:30'),
(438, 3082, 'cus_K6Ki4F3829YkPW', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:25:09', '2021-08-24 19:25:09'),
(439, 3082, 'cus_K6KkI7L7k88a5G', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:26:24', '2021-08-24 19:26:24'),
(440, 3082, 'cus_K6KkemQpsosBe2', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:26:34', '2021-08-24 19:26:34'),
(441, 3082, 'cus_K6KkzvGP17HEUh', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:27:08', '2021-08-24 19:27:08'),
(442, 3082, 'cus_K6KlEXdxi1VFRM', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, '2021-08-24 19:28:02', '2021-08-24 19:28:02'),
(443, 3078, 'cus_KytYk6Ct7715ff', '', NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 0, 0, '2022-01-17 11:01:06', '2022-01-17 11:01:06');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_reserva_mesa`
--

CREATE TABLE `tb_prm_reserva_mesa` (
  `p_res_id` int(11) NOT NULL,
  `f_res_mesa` int(11) DEFAULT NULL,
  `f_res_evento` int(11) DEFAULT NULL,
  `s_res_nome` varchar(255) DEFAULT NULL,
  `s_res_email` varchar(255) DEFAULT NULL,
  `s_res_fone` varchar(255) DEFAULT NULL,
  `f_res_aniversariante` int(11) DEFAULT 1,
  `b_res_ativa` tinyint(4) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `t_res_hora` varchar(25) DEFAULT NULL,
  `f_res_horario` int(11) DEFAULT NULL,
  `n_res_qtd_pessoas` int(11) DEFAULT NULL,
  `f_res_usuario` int(11) DEFAULT NULL,
  `s_res_observacao` varchar(255) DEFAULT NULL,
  `s_res_pagamento` varchar(35) DEFAULT NULL,
  `b_res_valido` tinyint(1) DEFAULT 1,
  `t_res_bloqueado` datetime DEFAULT current_timestamp(),
  `t_res_checkin` datetime DEFAULT NULL,
  `t_res_nasc` date DEFAULT NULL,
  `f_res_ambiente` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_prm_reserva_mesa`
--

INSERT INTO `tb_prm_reserva_mesa` (`p_res_id`, `f_res_mesa`, `f_res_evento`, `s_res_nome`, `s_res_email`, `s_res_fone`, `f_res_aniversariante`, `b_res_ativa`, `created_at`, `t_res_hora`, `f_res_horario`, `n_res_qtd_pessoas`, `f_res_usuario`, `s_res_observacao`, `s_res_pagamento`, `b_res_valido`, `t_res_bloqueado`, `t_res_checkin`, `t_res_nasc`, `f_res_ambiente`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(3640, 1130, 2174, 'Lucas Matos', 'lukssmatos@gmail.com', '(61) 99298-4682', NULL, 1, '2021-03-30 16:53:39', '12:30', 1775, 5, NULL, '', 'pi_1Ixe45I769Ccu9BypKzf491z', 1, '2021-03-30 16:53:39', NULL, NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3641, 1131, 2174, 'Lucas Matos', 'lucass_matos@hotmail.com', '61992984682', NULL, 1, '2021-04-14 17:23:26', '13:00', 1775, 4, 3079, NULL, '15151340891', 1, '2021-04-14 17:23:26', NULL, NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3642, 1132, 2174, 'Lucas Matos3', NULL, '(61) 99298-4682', NULL, 1, '2021-07-05 16:27:09', '12:00', 1775, 6, NULL, NULL, NULL, 1, '2021-07-05 16:27:09', NULL, NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3643, 1130, 2166, 'Lucas Matos3', NULL, '(61) 99298-4682', NULL, 0, '2021-07-19 15:38:20', '12:00', 1766, 4, NULL, NULL, NULL, 1, '2021-07-19 15:38:20', NULL, NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3644, 1131, 2166, 'Lucas Matos', NULL, '61992984682', NULL, 0, '2021-07-19 15:59:00', '08:00', 1766, 5, NULL, NULL, NULL, 1, '2021-07-19 15:59:00', NULL, NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3645, 1132, 2166, 'Luucas Matos', NULL, '(61) 99298-4682', NULL, 0, '2021-07-19 15:59:18', '13:13', 1766, 33, NULL, NULL, NULL, 1, '2021-07-19 15:59:18', '2021-07-19 16:15:59', NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3646, 1131, 2166, 'Lucas Matos', NULL, '61992984682', NULL, 1, '2021-07-20 11:54:51', '13:00', 1766, 3, NULL, 'Teste observação', NULL, 1, '2021-07-20 11:54:51', NULL, NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3647, 1130, 2166, 'Lucas Matos2', NULL, '61992984682', NULL, 0, '2021-07-20 14:43:24', '10:19', 1766, 5, NULL, NULL, NULL, 1, '2021-07-20 14:43:24', NULL, NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3648, 1132, 2166, 'Lucas Matos', NULL, '61992984682', NULL, 1, '2021-07-20 14:59:40', '11:00', 1766, 8, NULL, NULL, NULL, 1, '2021-07-20 14:59:40', '2021-07-20 14:59:44', NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3649, 1130, 2166, 'Lucas Matos2', NULL, '61992984682', NULL, 0, '2021-07-20 15:10:46', '19:00', 1766, 7, NULL, NULL, NULL, 1, '2021-07-20 15:10:46', NULL, NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3650, 1130, 2166, 'Michel', NULL, '', NULL, 1, '2021-07-20 15:23:16', '18:00', 1766, 4, NULL, 'testeeeeeee', NULL, 1, '2021-07-20 15:23:16', NULL, NULL, NULL, '2021-08-12 10:13:05', '2021-08-12 10:13:05', NULL),
(3651, NULL, 2174, 'Lucas Silva de Matos', 'lucass_matos@hotmail.com', '61992984682', 6036, 1, '2021-10-14 11:29:34', '16:00', 1775, 2, NULL, '', NULL, 1, '2021-10-14 11:29:34', NULL, NULL, NULL, '2021-10-14 11:29:34', '2021-10-14 11:29:34', NULL),
(3652, 1130, 2175, 'Lucas Silva de Matos', 'lucass_matos@hotmail.com', '(61) 99298-4682', 1, 1, '2021-11-03 18:52:17', '16:30', 1777, 3, NULL, '', NULL, 1, '2021-11-03 18:52:17', NULL, '1993-04-02', NULL, '2021-11-03 18:52:17', '2021-11-03 18:52:17', NULL),
(3653, 1132, 2175, 'Lucas 2', 'lucass_matos@hotmail.com', '(61) 99298-4682', 1, 1, '2021-11-03 18:52:49', '16:00', 1777, 2, NULL, '', NULL, 1, '2021-11-03 18:52:49', NULL, '1993-04-02', NULL, '2021-11-03 18:52:49', '2021-11-03 18:52:49', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_reserva_mesa_grupo`
--

CREATE TABLE `tb_prm_reserva_mesa_grupo` (
  `p_grp_id` int(11) UNSIGNED NOT NULL,
  `f_grp_cenario` int(11) NOT NULL,
  `s_grp_titulo` varchar(255) NOT NULL DEFAULT '',
  `n_grp_ordem` int(11) DEFAULT NULL,
  `n_grp_preco` float DEFAULT NULL,
  `s_grp_descricao` varchar(255) DEFAULT NULL,
  `s_grp_foto` varchar(25) DEFAULT NULL,
  `b_grp_pagamento` tinyint(1) NOT NULL DEFAULT 0,
  `s_grp_observacao` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_prm_reserva_mesa_grupo`
--

INSERT INTO `tb_prm_reserva_mesa_grupo` (`p_grp_id`, `f_grp_cenario`, `s_grp_titulo`, `n_grp_ordem`, `n_grp_preco`, `s_grp_descricao`, `s_grp_foto`, `b_grp_pagamento`, `s_grp_observacao`, `createdAt`, `updatedAt`) VALUES
(32, 117, 'Principal', 0, NULL, NULL, NULL, 0, 'Atenção, djoajd dkaodko doakd', '2021-08-12 09:47:05', '2021-08-12 09:47:05'),
(34, 117, 'Rooftop', NULL, NULL, NULL, NULL, 0, 'Teste observacao criar', '2021-08-12 09:47:05', '2021-08-12 09:47:05');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_template`
--

CREATE TABLE `tb_prm_template` (
  `p_tmp_id` int(11) NOT NULL,
  `f_tmp_template` int(11) NOT NULL,
  `f_tmp_usuario` int(11) DEFAULT NULL,
  `s_tmp_base64` longtext DEFAULT NULL,
  `n_tmp_contador` tinyint(1) DEFAULT 0,
  `s_tmp_titulo_font` varchar(30) NOT NULL DEFAULT '',
  `s_tmp_titulo_cor` varchar(15) NOT NULL DEFAULT '',
  `s_tmp_titulo_texto` varchar(55) NOT NULL DEFAULT '',
  `n_tmp_titulo_tamanho` float NOT NULL,
  `n_tmp_titulo_top` int(11) NOT NULL,
  `n_tmp_titulo_espaco` int(11) NOT NULL,
  `n_tmp_titulo_top_mobile` int(11) DEFAULT NULL,
  `n_tmp_titulo_tamanho_mobile` float DEFAULT NULL,
  `s_tmp_subtitulo_font` varchar(30) NOT NULL DEFAULT '',
  `s_tmp_subtitulo_cor` varchar(15) NOT NULL DEFAULT '',
  `s_tmp_subtitulo_texto` varchar(55) NOT NULL DEFAULT '',
  `n_tmp_subtitulo_tamanho` float NOT NULL,
  `n_tmp_subtitulo_top` int(11) NOT NULL,
  `n_tmp_subtitulo_espaco` int(11) NOT NULL,
  `n_tmp_subtitulo_top_mobile` int(11) DEFAULT NULL,
  `n_tmp_subtitulo_tamanho_mobile` float DEFAULT NULL,
  `s_tmp_data_font` varchar(30) NOT NULL DEFAULT '',
  `s_tmp_data_cor` varchar(15) NOT NULL DEFAULT '',
  `s_tmp_data_texto` varchar(55) NOT NULL DEFAULT '',
  `n_tmp_data_tamanho` float NOT NULL,
  `n_tmp_data_top` int(11) NOT NULL,
  `n_tmp_data_espaco` int(11) NOT NULL,
  `n_tmp_data_top_mobile` int(11) DEFAULT NULL,
  `n_tmp_data_tamanho_mobile` float DEFAULT NULL,
  `s_tmp_endereco_font` varchar(30) NOT NULL DEFAULT '',
  `s_tmp_endereco_cor` varchar(15) NOT NULL DEFAULT '',
  `s_tmp_endereco_texto` varchar(55) NOT NULL DEFAULT '',
  `n_tmp_endereco_top` float NOT NULL,
  `n_tmp_endereco_tamanho` float NOT NULL,
  `n_tmp_endereco_espaco` int(11) NOT NULL,
  `n_tmp_endereco_top_mobile` int(11) DEFAULT NULL,
  `n_tmp_endereco_tamanho_mobile` float DEFAULT NULL,
  `n_tmp_logo_tamanho` varchar(11) NOT NULL DEFAULT '',
  `n_tmp_logo_top` int(11) NOT NULL,
  `n_tmp_logo_top_mobile` int(11) DEFAULT NULL,
  `n_tmp_logo_tamanho_mobile` varchar(11) DEFAULT NULL,
  `n_tmp_logo_dg_top` float DEFAULT NULL,
  `n_tmp_logo_dg_tamanho` float DEFAULT NULL,
  `n_tmp_logo_dg_tamanho_mobile` float DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_prm_template_usuario`
--

CREATE TABLE `tb_prm_template_usuario` (
  `p_tmp_id` int(11) NOT NULL,
  `f_tmp_template` int(11) NOT NULL,
  `f_tmp_usuario` int(11) NOT NULL,
  `s_tmp_titulo` varchar(100) DEFAULT '',
  `s_tmp_subtitulo` varchar(100) NOT NULL DEFAULT '',
  `s_tmp_endereco` varchar(100) DEFAULT '',
  `s_tmp_logo` varchar(25) DEFAULT '',
  `s_tmp_base64` longtext DEFAULT NULL,
  `n_tmp_logo_tamanho` varchar(15) DEFAULT NULL,
  `n_tmp_logo_tamanho_mobile` varchar(15) DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_uf`
--

CREATE TABLE `tb_uf` (
  `p_uf_id` int(11) UNSIGNED NOT NULL,
  `s_uf_nome` varchar(50) NOT NULL DEFAULT '',
  `s_uf_nome_abreviado` varchar(2) NOT NULL DEFAULT '',
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_avaliacao`
--

CREATE TABLE `tb_usu_avaliacao` (
  `p_ava_id` int(11) UNSIGNED NOT NULL,
  `f_ava_estabelecimento` int(11) NOT NULL,
  `f_ava_cliente` int(11) NOT NULL,
  `n_ava_preco` int(11) DEFAULT NULL,
  `n_ava_produtos` int(11) DEFAULT NULL,
  `n_ava_ambiente` int(11) DEFAULT NULL,
  `n_ava_servico` int(11) DEFAULT NULL,
  `s_ava_comentario` varchar(200) DEFAULT NULL,
  `s_ava_nome` varchar(255) DEFAULT '',
  `s_ava_telefone` varchar(25) DEFAULT NULL,
  `b_ava_experiencia` tinyint(1) NOT NULL DEFAULT 1,
  `s_ava_critica` varchar(50) DEFAULT NULL,
  `t_ava_data` date DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_blacklist`
--

CREATE TABLE `tb_usu_blacklist` (
  `p_blk_id` int(11) NOT NULL,
  `s_blk_nome` varchar(255) DEFAULT NULL,
  `s_blk_documento` varchar(100) DEFAULT NULL,
  `t_blk_data_ocorrido` date DEFAULT NULL,
  `s_blk_observacao` varchar(1000) DEFAULT NULL,
  `f_blk_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_cardapio`
--

CREATE TABLE `tb_usu_cardapio` (
  `p_usu_car_id` int(11) UNSIGNED NOT NULL,
  `f_usu_car_usuario` int(11) NOT NULL,
  `b_usu_car_wpp` tinyint(1) NOT NULL DEFAULT 0,
  `n_usu_car_entrega` float DEFAULT NULL,
  `b_usu_car_exige_entrega` int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT 00000000000,
  `b_usu_car_permite_retirar` tinyint(1) NOT NULL DEFAULT 0,
  `s_usu_car_telefone` varchar(25) DEFAULT NULL,
  `s_usu_car_nascimento` varchar(25) DEFAULT NULL,
  `b_usu_car_exige_login` tinyint(1) NOT NULL DEFAULT 0,
  `t_usu_car_hora_inicio` varchar(15) DEFAULT '',
  `t_usu_car_hora_fim` varchar(15) DEFAULT NULL,
  `s_usu_car_wifi_rede` varchar(45) DEFAULT NULL,
  `s_usu_car_wifi` varchar(45) DEFAULT NULL,
  `s_usu_car_tipo_estabelecimento` varchar(1) DEFAULT NULL,
  `s_usu_car_observacao` varchar(500) DEFAULT NULL,
  `n_usu_car_tempo_entrega` int(11) DEFAULT NULL,
  `s_usu_car_cor_cardapio` varchar(15) DEFAULT NULL,
  `b_usu_car_template_novo` tinyint(1) NOT NULL DEFAULT 1,
  `b_usu_car_avaliacao` tinyint(1) NOT NULL DEFAULT 1,
  `b_usu_car_delivery_online` tinyint(1) DEFAULT NULL,
  `b_usu_car_delivery_pagamento` tinyint(1) DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_usu_cardapio`
--

INSERT INTO `tb_usu_cardapio` (`p_usu_car_id`, `f_usu_car_usuario`, `b_usu_car_wpp`, `n_usu_car_entrega`, `b_usu_car_exige_entrega`, `b_usu_car_permite_retirar`, `s_usu_car_telefone`, `s_usu_car_nascimento`, `b_usu_car_exige_login`, `t_usu_car_hora_inicio`, `t_usu_car_hora_fim`, `s_usu_car_wifi_rede`, `s_usu_car_wifi`, `s_usu_car_tipo_estabelecimento`, `s_usu_car_observacao`, `n_usu_car_tempo_entrega`, `s_usu_car_cor_cardapio`, `b_usu_car_template_novo`, `b_usu_car_avaliacao`, `b_usu_car_delivery_online`, `b_usu_car_delivery_pagamento`, `updatedAt`, `createdAt`) VALUES
(538, 3078, 1, 5, 00000000001, 1, '(61) 99298-4682', NULL, 0, NULL, NULL, '', '', NULL, '', 20, '', 1, 1, NULL, NULL, '2021-04-24 19:33:33', '2021-04-24 19:33:33');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_cardapio_clientes`
--

CREATE TABLE `tb_usu_cardapio_clientes` (
  `p_cli_id` int(11) NOT NULL,
  `f_cli_estabelecimento` int(11) NOT NULL,
  `s_cli_nome` varchar(255) DEFAULT NULL,
  `s_cli_telefone` varchar(55) DEFAULT NULL,
  `s_cli_email` varchar(55) DEFAULT NULL,
  `s_cli_endereco` varchar(500) DEFAULT NULL,
  `s_cli_pedido` text DEFAULT NULL,
  `t_cli_nascimento` date DEFAULT NULL,
  `e_cli_sexo` varchar(1) DEFAULT NULL,
  `b_cli_impresso` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_usu_cardapio_clientes`
--

INSERT INTO `tb_usu_cardapio_clientes` (`p_cli_id`, `f_cli_estabelecimento`, `s_cli_nome`, `s_cli_telefone`, `s_cli_email`, `s_cli_endereco`, `s_cli_pedido`, `t_cli_nascimento`, `e_cli_sexo`, `b_cli_impresso`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1, 3078, 'LUCAS', '(61) 99298-4682', 'lucass_matos@hotmail.com', 'Quadra SHIGS 703 Bloco B', 'Olá DGuests, segue meu pedido: %0a%0aNome: Lucas %0aEndereço: Quadra SHIGS 703 Bloco B, 4 %0a%0aPedido: %0a1 x Batata palito crocante  = R$ 27,90%0a%0a%0a2 x Flor de Lis = R$ 45,80%0a%0a%0aEntrega: R$ 3,00%0aTotal do Pedido: R$ 76,70%0a%0aForma de pagamento: Cartão de crédito%0a%0aAcesse: www.dguests.com/dguests', NULL, NULL, 1, NULL, NULL, NULL),
(2, 3078, 'Lucas', '61992984682', 'lucass_matos@hotmail.com', 'Quadra SHIGS 703 Bloco B', NULL, NULL, NULL, 1, NULL, NULL, NULL),
(3, 3078, 'Lucas', '61992984682', 'lucass_matos@hotmail.com', 'Quadra SHIGS 703 Bloco B', NULL, NULL, NULL, 1, NULL, NULL, NULL),
(4, 3078, 'Lucas', '61992984682', 'lucass_matos@hotmail.com', '', NULL, NULL, NULL, 1, NULL, NULL, NULL),
(5, 3078, 'Lucas', '(61) 99298-4682', '', 'SHIGS 703 BL B casa 4', NULL, '1993-04-02', NULL, 1, NULL, NULL, NULL),
(6, 3078, 'Lucas', '(61) 99298-4682', '', 'Vergueiro 3558', NULL, '1993-04-02', NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_cardapio_meio_pagamento`
--

CREATE TABLE `tb_usu_cardapio_meio_pagamento` (
  `p_pag_id` int(11) UNSIGNED NOT NULL,
  `f_pag_usuario` int(11) NOT NULL,
  `b_pag_show` tinyint(1) DEFAULT 1,
  `b_pag_dinheiro` tinyint(1) DEFAULT 1,
  `b_pag_cartao_credito` tinyint(1) DEFAULT 1,
  `b_pag_cartao_debito` tinyint(1) DEFAULT 1,
  `s_pag_vale_refeicao` varchar(100) DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_usu_cardapio_meio_pagamento`
--

INSERT INTO `tb_usu_cardapio_meio_pagamento` (`p_pag_id`, `f_pag_usuario`, `b_pag_show`, `b_pag_dinheiro`, `b_pag_cartao_credito`, `b_pag_cartao_debito`, `s_pag_vale_refeicao`, `updatedAt`, `createdAt`) VALUES
(189, 3078, 1, 1, 1, 1, NULL, '2021-07-15 10:43:39', '2021-07-15 10:43:39');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_colaborador_fixo`
--

CREATE TABLE `tb_usu_colaborador_fixo` (
  `p_fixo_id` int(11) NOT NULL COMMENT 'Armazena o ID.',
  `f_fixo_estabelecimento` int(11) NOT NULL COMMENT 'Armazena o ID do estabelecimento.',
  `f_fixo_usuario` int(11) NOT NULL COMMENT 'Armazena o ID do usuário.',
  `f_fixo_funcao` int(11) NOT NULL COMMENT 'Armazena o ID da função.',
  `e_fixo_status` enum('p','a','r') NOT NULL DEFAULT 'a' COMMENT 'Armazena o Status do convite...\nPendente, Aceito ou Recusado.',
  `t_fixo_data_cadastro` datetime NOT NULL COMMENT 'Armazena a data de cadastro.',
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_frases_wpp`
--

CREATE TABLE `tb_usu_frases_wpp` (
  `p_wpp_id` int(11) UNSIGNED NOT NULL,
  `s_wpp_frase` varchar(1000) NOT NULL DEFAULT '',
  `f_wpp_usuario` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_horario_funcionamento`
--

CREATE TABLE `tb_usu_horario_funcionamento` (
  `p_hora_id` int(11) UNSIGNED NOT NULL,
  `f_hora_usuario` int(11) NOT NULL,
  `b_hora_show` tinyint(1) DEFAULT 1,
  `b_hora_show_delivery` tinyint(1) DEFAULT 0,
  `t_hora_inicio_seg` time DEFAULT NULL,
  `t_hora_fim_seg` time DEFAULT NULL,
  `t_hora_inicio_seg2` time DEFAULT NULL,
  `t_hora_fim_seg2` time DEFAULT NULL,
  `t_hora_inicio_ter` time DEFAULT NULL,
  `t_hora_fim_ter` time DEFAULT NULL,
  `t_hora_inicio_ter2` time DEFAULT NULL,
  `t_hora_fim_ter2` time DEFAULT NULL,
  `t_hora_inicio_qua` time DEFAULT NULL,
  `t_hora_fim_qua` time DEFAULT NULL,
  `t_hora_inicio_qua2` time DEFAULT NULL,
  `t_hora_fim_qua2` time DEFAULT NULL,
  `t_hora_inicio_qui` time DEFAULT NULL,
  `t_hora_fim_qui` time DEFAULT NULL,
  `t_hora_inicio_qui2` time DEFAULT NULL,
  `t_hora_fim_qui2` time DEFAULT NULL,
  `t_hora_inicio_sex` time DEFAULT NULL,
  `t_hora_fim_sex` time DEFAULT NULL,
  `t_hora_inicio_sex2` time DEFAULT NULL,
  `t_hora_fim_sex2` time DEFAULT NULL,
  `t_hora_inicio_sab` time DEFAULT NULL,
  `t_hora_fim_sab` time DEFAULT NULL,
  `t_hora_inicio_sab2` time DEFAULT NULL,
  `t_hora_fim_sab2` time DEFAULT NULL,
  `t_hora_inicio_dom` time DEFAULT NULL,
  `t_hora_fim_dom` time DEFAULT NULL,
  `t_hora_inicio_dom2` time DEFAULT NULL,
  `t_hora_fim_dom2` time DEFAULT NULL,
  `t_hora_inicio_fer` time DEFAULT NULL,
  `t_hora_fim_fer` time DEFAULT NULL,
  `t_hora_inicio_fer2` time DEFAULT NULL,
  `t_hora_fim_fer2` time DEFAULT NULL,
  `t_hora_inicio_seg_delivery` time DEFAULT NULL,
  `t_hora_fim_seg_delivery` time DEFAULT NULL,
  `t_hora_inicio_ter_delivery` time DEFAULT NULL,
  `t_hora_fim_ter_delivery` time DEFAULT NULL,
  `t_hora_inicio_qua_delivery` time DEFAULT NULL,
  `t_hora_fim_qua_delivery` time DEFAULT NULL,
  `t_hora_inicio_qui_delivery` time DEFAULT NULL,
  `t_hora_fim_qui_delivery` time DEFAULT NULL,
  `t_hora_inicio_sex_delivery` time DEFAULT NULL,
  `t_hora_fim_sex_delivery` time DEFAULT NULL,
  `t_hora_inicio_sab_delivery` time DEFAULT NULL,
  `t_hora_fim_sab_delivery` time DEFAULT NULL,
  `t_hora_inicio_dom_delivery` time DEFAULT NULL,
  `t_hora_fim_dom_delivery` time DEFAULT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_usu_horario_funcionamento`
--

INSERT INTO `tb_usu_horario_funcionamento` (`p_hora_id`, `f_hora_usuario`, `b_hora_show`, `b_hora_show_delivery`, `t_hora_inicio_seg`, `t_hora_fim_seg`, `t_hora_inicio_seg2`, `t_hora_fim_seg2`, `t_hora_inicio_ter`, `t_hora_fim_ter`, `t_hora_inicio_ter2`, `t_hora_fim_ter2`, `t_hora_inicio_qua`, `t_hora_fim_qua`, `t_hora_inicio_qua2`, `t_hora_fim_qua2`, `t_hora_inicio_qui`, `t_hora_fim_qui`, `t_hora_inicio_qui2`, `t_hora_fim_qui2`, `t_hora_inicio_sex`, `t_hora_fim_sex`, `t_hora_inicio_sex2`, `t_hora_fim_sex2`, `t_hora_inicio_sab`, `t_hora_fim_sab`, `t_hora_inicio_sab2`, `t_hora_fim_sab2`, `t_hora_inicio_dom`, `t_hora_fim_dom`, `t_hora_inicio_dom2`, `t_hora_fim_dom2`, `t_hora_inicio_fer`, `t_hora_fim_fer`, `t_hora_inicio_fer2`, `t_hora_fim_fer2`, `t_hora_inicio_seg_delivery`, `t_hora_fim_seg_delivery`, `t_hora_inicio_ter_delivery`, `t_hora_fim_ter_delivery`, `t_hora_inicio_qua_delivery`, `t_hora_fim_qua_delivery`, `t_hora_inicio_qui_delivery`, `t_hora_fim_qui_delivery`, `t_hora_inicio_sex_delivery`, `t_hora_fim_sex_delivery`, `t_hora_inicio_sab_delivery`, `t_hora_fim_sab_delivery`, `t_hora_inicio_dom_delivery`, `t_hora_fim_dom_delivery`, `updatedAt`, `createdAt`) VALUES
(193, 3078, 1, 0, '18:00:00', '22:00:00', '22:30:00', '00:00:00', '18:00:00', '22:00:00', '22:30:00', '00:00:00', '18:00:00', '22:00:00', '22:30:00', '00:00:00', '18:00:00', '22:00:00', NULL, NULL, '18:00:00', '22:00:00', NULL, NULL, '18:00:00', '22:00:00', NULL, NULL, '18:00:00', '22:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2021-06-30 12:02:20', '2021-06-30 12:02:20');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_link`
--

CREATE TABLE `tb_usu_link` (
  `p_link_id` int(11) UNSIGNED NOT NULL,
  `f_link_usuario` int(11) NOT NULL,
  `b_link_reserva_mesa` tinyint(1) NOT NULL DEFAULT 1,
  `n_link_reserva_mesa_clicks` int(11) DEFAULT NULL,
  `b_link_cardapio` tinyint(1) NOT NULL DEFAULT 1,
  `n_link_cardapio_clicks` int(11) DEFAULT NULL,
  `b_link_nome_lista` tinyint(1) NOT NULL DEFAULT 1,
  `n_link_nome_lista_clicks` int(11) DEFAULT NULL,
  `b_link_comemorar` tinyint(1) NOT NULL DEFAULT 1,
  `n_link_comemorar_clicks` int(11) DEFAULT NULL,
  `b_link_espera` tinyint(1) NOT NULL DEFAULT 1,
  `n_link_espera_ordem` int(11) DEFAULT NULL,
  `b_link_localizacao` tinyint(1) NOT NULL DEFAULT 1,
  `b_link_avaliacao` tinyint(1) NOT NULL DEFAULT 1,
  `b_link_delivery` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_usu_link`
--

INSERT INTO `tb_usu_link` (`p_link_id`, `f_link_usuario`, `b_link_reserva_mesa`, `n_link_reserva_mesa_clicks`, `b_link_cardapio`, `n_link_cardapio_clicks`, `b_link_nome_lista`, `n_link_nome_lista_clicks`, `b_link_comemorar`, `n_link_comemorar_clicks`, `b_link_espera`, `n_link_espera_ordem`, `b_link_localizacao`, `b_link_avaliacao`, `b_link_delivery`, `createdAt`, `updatedAt`) VALUES
(97, 3078, 1, NULL, 1, NULL, 0, NULL, 0, NULL, 1, NULL, 1, 1, 0, '2021-08-11 17:50:11', '2021-08-11 17:50:11');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_link_criado`
--

CREATE TABLE `tb_usu_link_criado` (
  `p_link_id` int(11) UNSIGNED NOT NULL,
  `f_link_usuario` int(11) NOT NULL,
  `s_link_texto` varchar(50) NOT NULL DEFAULT '',
  `s_link_url` varchar(255) NOT NULL DEFAULT '',
  `n_link_ordem` int(11) DEFAULT NULL,
  `b_link_ativo` tinyint(1) NOT NULL DEFAULT 1,
  `n_link_click` int(11) NOT NULL,
  `s_link_icone` varchar(15) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_usu_link_criado`
--

INSERT INTO `tb_usu_link_criado` (`p_link_id`, `f_link_usuario`, `s_link_texto`, `s_link_url`, `n_link_ordem`, `b_link_ativo`, `n_link_click`, `s_link_icone`, `createdAt`, `updatedAt`) VALUES
(74, 3078, 'Teste', 'https://www.teste.com.br', NULL, 1, 0, NULL, '2021-08-11 17:39:43', '2021-08-11 17:39:43');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_logo`
--

CREATE TABLE `tb_usu_logo` (
  `p_logo_id` int(11) UNSIGNED NOT NULL,
  `f_logo_usuario` int(11) NOT NULL,
  `s_logo_base64` longtext DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_qualification`
--

CREATE TABLE `tb_usu_qualification` (
  `p_qua_id` int(11) NOT NULL,
  `f_qua_usuario` int(11) NOT NULL,
  `s_qua_responsavel` varchar(255) NOT NULL,
  `s_qua_cargo` varchar(255) NOT NULL,
  `b_qua_interesse_cardapio` tinyint(1) NOT NULL DEFAULT 0,
  `b_qua_interesse_delivery` tinyint(1) NOT NULL DEFAULT 0,
  `b_qua_interesse_reservas` tinyint(1) NOT NULL DEFAULT 0,
  `b_qua_interesse_espera` tinyint(1) NOT NULL DEFAULT 0,
  `b_qua_interesse_listas` tinyint(1) NOT NULL DEFAULT 0,
  `b_qua_interesse_marketing` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_recuperar_senha`
--

CREATE TABLE `tb_usu_recuperar_senha` (
  `p_rec_id` int(11) UNSIGNED NOT NULL,
  `f_rec_usuario` int(11) NOT NULL,
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_taxa_entrega`
--

CREATE TABLE `tb_usu_taxa_entrega` (
  `p_ent_id` int(11) NOT NULL,
  `f_ent_usuario` int(11) NOT NULL,
  `n_ent_taxa` float NOT NULL,
  `n_ent_raio` float NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_usu_taxa_entrega`
--

INSERT INTO `tb_usu_taxa_entrega` (`p_ent_id`, `f_ent_usuario`, `n_ent_taxa`, `n_ent_raio`, `createdAt`, `updatedAt`) VALUES
(3, 3078, 4.9, 3, '2021-08-19 16:10:25', '2021-08-19 16:10:25'),
(4, 3078, 7.9, 1.5, '2021-08-19 16:10:25', '2021-08-19 16:10:25'),
(5, 3078, 10.9, 11, '2021-08-19 16:10:25', '2021-08-19 16:10:25');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_token`
--

CREATE TABLE `tb_usu_token` (
  `p_token_id` int(11) NOT NULL,
  `f_usu_id` int(11) NOT NULL,
  `s_token` varchar(255) NOT NULL,
  `n_admin` tinyint(4) NOT NULL,
  `n_enable` tinyint(4) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_usu_token`
--

INSERT INTO `tb_usu_token` (`p_token_id`, `f_usu_id`, `s_token`, `n_admin`, `n_enable`, `dtCad`) VALUES
(15572, 3078, '3078@2b54f0b5b896f9959cc302ee171aa34b3edea39c@0', 0, 0, '2021-03-28 17:32:42'),
(15573, 3078, '3078@d79601e954c4612580cb65b62b3e1dfc44ba3dae@0', 0, 0, '2021-03-29 03:43:15'),
(15574, 3078, '3078@e9f9fb4fdb8ac435c2c56d1e786080fb609a6941@0', 0, 0, '2021-03-29 17:27:56'),
(15575, 3078, '3078@e1cd8657aa03a254751cce16f966c81fc93f2487@0', 0, 0, '2021-03-30 19:43:50'),
(15576, 3079, '3079@e95503cca3eaf820d04d00b91f5d9d98cc9a9659@0', 0, 0, '2021-03-30 19:45:59'),
(15577, 3078, '3078@4004e2aabcf6903ec39972b94e08b182bd4ea4d4@0', 0, 0, '2021-04-19 20:00:25'),
(15578, 3078, '3078@1b9b16b47462ceee00513cca4cf49d8dd0d52118@0', 0, 0, '2021-05-13 21:13:19'),
(15579, 3078, '3078@7e26a609b146b7a4628788a83c1e630d1d4ea1c6@0', 0, 0, '2021-05-17 19:49:27'),
(15580, 3078, '3078@aa77676d1c9368b59cba2512b509cb21c31b0bc3@0', 0, 0, '2021-05-17 19:50:53'),
(15581, 3078, '3078@70c48555e51e755908beb636725bbbdeac7693c8@0', 0, 0, '2021-05-18 18:06:55'),
(15582, 3078, '3078@317798e4e6940125ca3a4bd22343095bd97362b8@0', 0, 0, '2021-05-19 18:40:47'),
(15583, 3078, '3078@e8cd7b454ff746f73ad33a15f6da85161ec0b876@0', 0, 1, '2021-06-01 17:53:23'),
(15584, 3079, '3079@02e1d79a1b507f3f0be33a33bb2c9b2ba6fd20a1@0', 0, 0, '2021-06-16 14:02:37'),
(15585, 3078, '3078@c638e96d0cd3fa44f5db99158054b1e27e5a1923@0', 0, 1, '2021-06-16 22:04:25'),
(15586, 3078, '3078@68ccbfa4eec64e23e3e79e8d2a59c19d07cc4d04@0', 0, 1, '2021-06-28 17:51:48'),
(15587, 3078, '3078@9fb1401c40a527671b659a02769c63edd73ac141@0', 0, 0, '2021-07-03 23:22:43'),
(15588, 3078, '3078@67426e57969eb1e0f46731f2754c253f46741351@0', 0, 1, '2021-07-04 17:51:04'),
(15589, 3078, '3078@bd13482f84cf1bedb5f39f83f9c9f69e5800c951@0', 0, 0, '2021-07-04 21:15:09'),
(15590, 3078, '3078@2373fd05e796c0e538b627e69b5020f6ed3a2e0d@0', 0, 1, '2021-07-04 22:13:42'),
(15591, 3078, '3078@fb01e0c027e30a1475d3b9ade8abd23861b311d8@0', 0, 1, '2021-07-05 19:00:54'),
(15592, 3078, '3078@c561a774290629346bfb6fe3e790ebe220323ff7@0', 0, 0, '2021-07-13 16:32:53'),
(15593, 3078, '3078@0d8b9c92ac2fcbe33834d272410417acb44c9093@0', 0, 1, '2021-07-21 17:26:30'),
(15594, 3078, '3078@b01ee3aa6df1d68961fcf4741e1952216dcb9b8a@0', 0, 1, '2021-07-29 19:47:31'),
(15595, 3078, '3078@01f4691fdab354f42beb0dd03f9cbe33849b4536@0', 0, 1, '2021-08-17 21:12:49'),
(15596, 3078, '3078@b3cac3bdbb61a59a86ee641aebe917ed20e2d95b@0', 0, 0, '2021-08-23 17:08:49'),
(15597, 3082, '3082@47558167292843f11a0de3394c7381cb80153f83@1', 0, 0, '2021-08-24 21:46:25'),
(15598, 3082, '3082@d1c9b0ff52cb9f7440a16cab8777f99e9d823197@0', 0, 1, '2021-08-24 21:47:55'),
(15599, 3078, '3078@91890b6f696015d665ec1eb497bb26e60d960963@0', 0, 0, '2021-09-03 20:17:52'),
(15600, 3078, '3078@20f34dccaed893b1d351435c41441cd771ac7e9e@0', 0, 0, '2021-09-30 13:48:47'),
(15601, 3078, '3078@5ff972202ac9faa133a05b18f35ac245adb60743@0', 0, 1, '2021-10-11 20:10:30'),
(15602, 3078, '3078@7bcbd3e37ec3ccbfbf5a3da047db8896067c96e2@0', 0, 1, '2021-10-18 21:13:56'),
(15603, 3078, '3078@ccb7bc2593afc4e02e5fcc916c81933b29f164b0@0', 0, 1, '2021-11-09 20:52:41'),
(15604, 3078, '3078@158b68ef6d0320f075cad0062a2393326083b3b9@0', 0, 0, '2021-11-18 19:27:59'),
(15605, 3078, '3078@e165cb6dcb1e0647628440c023c62295bf918f26@0', 0, 1, '2021-11-19 18:02:45'),
(15606, 3078, '3078@e42032a8c867b7004ae1c93155eda0ccaccd92f9@0', 0, 1, '2022-01-14 16:59:46'),
(15607, 3078, '3078@80b8157e4b371455a15ab5a97512f51c26f45999@0', 0, 1, '2022-01-20 20:10:59'),
(15608, 3078, '3078@3875e40b2ac02b82f5a6e0ba844b6dc789162122@0', 0, 1, '2022-01-27 18:06:21'),
(15609, 3078, '3078@e4e8e3024375e8c028a7d1e55557b971c3f2c622@0', 0, 1, '2022-02-08 21:25:03');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_tutorial`
--

CREATE TABLE `tb_usu_tutorial` (
  `p_tut_id` int(11) UNSIGNED NOT NULL,
  `f_tut_usuario` int(11) DEFAULT NULL,
  `b_tut_criar_evento` tinyint(4) NOT NULL DEFAULT 0,
  `b_tut_box_evento` tinyint(4) NOT NULL DEFAULT 0,
  `b_tut_add_convidado` tinyint(4) NOT NULL DEFAULT 0,
  `b_tut_info_convidado` tinyint(4) NOT NULL DEFAULT 0,
  `b_tut_resultados` tinyint(4) NOT NULL DEFAULT 0,
  `b_tut_aniversarios` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usu_usuario`
--

CREATE TABLE `tb_usu_usuario` (
  `p_usu_id` int(11) NOT NULL COMMENT 'Armazena a chave primária.',
  `s_usu_nome` varchar(80) NOT NULL COMMENT 'Armazena o nome.',
  `s_usu_slug` varchar(80) DEFAULT NULL,
  `s_usu_documento` varchar(20) DEFAULT NULL,
  `s_usu_email` varchar(255) NOT NULL COMMENT 'Armazena o Email do usuário.',
  `s_usu_celular` varchar(20) DEFAULT NULL,
  `s_usu_senha` varchar(255) DEFAULT NULL COMMENT 'Armazena a senha em SHA1.',
  `s_usu_senha_b` varchar(255) DEFAULT NULL,
  `s_usu_senha_fidelize` varchar(255) DEFAULT NULL,
  `s_usu_senha_oc` varchar(255) DEFAULT NULL,
  `e_usu_status` enum('a','b','e') NOT NULL DEFAULT 'a' COMMENT 'Armazena o status do usuário.',
  `t_usu_data_cadastro` datetime NOT NULL COMMENT 'Armazena a data de cadastro.',
  `s_usu_foto` longtext DEFAULT NULL,
  `s_usu_banner` longtext DEFAULT NULL,
  `s_usu_instagram` varchar(100) DEFAULT NULL,
  `s_usu_facebook` varchar(100) DEFAULT NULL,
  `b_usu_comum` tinyint(4) DEFAULT 0,
  `b_usu_email_validado` tinyint(4) DEFAULT 1,
  `b_usu_email_validado_oc` tinyint(1) NOT NULL DEFAULT 0,
  `e_usu_sexo` enum('m','f') DEFAULT NULL,
  `t_usu_nasc` date DEFAULT NULL,
  `s_usu_frase_wpp` varchar(1000) DEFAULT NULL,
  `f_usu_cidade` int(11) DEFAULT NULL,
  `s_usu_endereco` varchar(500) DEFAULT NULL,
  `s_usu_latitude` varchar(45) DEFAULT NULL,
  `s_usu_longitude` varchar(45) DEFAULT NULL,
  `t_usu_premium_valido` datetime DEFAULT NULL,
  `f_usu_convidado_por` int(11) DEFAULT NULL,
  `b_usu_premium_trial` tinyint(1) DEFAULT 0,
  `b_usu_premium_valido` tinyint(1) DEFAULT 0,
  `b_colaborador_parceiro` tinyint(1) NOT NULL DEFAULT 0,
  `b_colaborador_parceiro_oc` tinyint(1) NOT NULL DEFAULT 0,
  `f_usu_pais` int(11) DEFAULT NULL,
  `b_usu_premium_cardapio` tinyint(1) NOT NULL DEFAULT 0,
  `b_usu_premium_delivery` tinyint(1) NOT NULL DEFAULT 0,
  `b_usu_fidelize` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Despejando dados para a tabela `tb_usu_usuario`
--

INSERT INTO `tb_usu_usuario` (`p_usu_id`, `s_usu_nome`, `s_usu_slug`, `s_usu_documento`, `s_usu_email`, `s_usu_celular`, `s_usu_senha`, `s_usu_senha_b`, `s_usu_senha_fidelize`, `s_usu_senha_oc`, `e_usu_status`, `t_usu_data_cadastro`, `s_usu_foto`, `s_usu_banner`, `s_usu_instagram`, `s_usu_facebook`, `b_usu_comum`, `b_usu_email_validado`, `b_usu_email_validado_oc`, `e_usu_sexo`, `t_usu_nasc`, `s_usu_frase_wpp`, `f_usu_cidade`, `s_usu_endereco`, `s_usu_latitude`, `s_usu_longitude`, `t_usu_premium_valido`, `f_usu_convidado_por`, `b_usu_premium_trial`, `b_usu_premium_valido`, `b_colaborador_parceiro`, `b_colaborador_parceiro_oc`, `f_usu_pais`, `b_usu_premium_cardapio`, `b_usu_premium_delivery`, `b_usu_fidelize`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(3078, 'DGuests2', 'barmodelo', '00000000000000', 'lucas@dguests.com', '61992984682', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', '$2a$12$vwyg1BNbUS7UhvaD4sfG4eIqohedZhLE9f6vQWOkxQf535TubThxi', NULL, '$2b$12$XqmGh2YUsBGwrMxavBongOhBNWc5jikIjUS/mHgUyDdpxVNY5BWX6', 'a', '2021-03-28 19:29:44', '24.png', '24.png', 'teste', '', 0, 1, 1, NULL, NULL, NULL, 1, 'Rua Leite Ferraz, 221 - Vila Mariana, São Paulo - SP, Brasil', '-23.5912677', '-46.6321097', '2021-03-28 19:29:44', NULL, 0, 1, 0, 0, NULL, 1, 0, 1, '2021-03-28 14:31:53', '2021-03-28 14:31:53', NULL),
(3079, 'Lucas Teste', 'teste', '00000000000', 'lukssmatos@gmail.com', '61992984682', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', NULL, NULL, '$2a$12$u.l.kEfuVIjxIsh4ljqfd.h1hsIz6f90p0ITIH8k0gGKN6X2T1nES', 'a', '2021-03-30 21:44:45', NULL, NULL, NULL, NULL, 0, 1, 1, 'm', NULL, NULL, 1, NULL, NULL, NULL, '2021-03-30 21:44:45', NULL, 0, 1, 0, 0, NULL, 0, 0, 0, '2021-03-30 16:45:43', '2021-03-30 16:45:43', NULL),
(3080, 'Lucas Matos', NULL, NULL, 'lukssmatsos@gmail.com', '(61) 99298-4682', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', NULL, NULL, NULL, 'a', '2021-03-30 16:59:00', NULL, NULL, NULL, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, 1, 0, 0, '2021-03-30 16:59:00', '2021-03-30 16:59:00', NULL),
(3081, 'Eu Tu Eles', 'eutueles', '00000000000000', 'eutueles@eutueles.com.br', NULL, '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', NULL, NULL, NULL, 'a', '2021-06-29 17:17:51', '650.png', '650.png', 'eutueles', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 'Itaim Bibi', NULL, NULL, '2021-06-29 17:17:51', NULL, 0, 0, 0, 0, 1, 1, 0, 0, '2021-06-29 12:20:19', '2021-06-29 12:20:19', NULL);
INSERT INTO `tb_usu_usuario` (`p_usu_id`, `s_usu_nome`, `s_usu_slug`, `s_usu_documento`, `s_usu_email`, `s_usu_celular`, `s_usu_senha`, `s_usu_senha_b`, `s_usu_senha_fidelize`, `s_usu_senha_oc`, `e_usu_status`, `t_usu_data_cadastro`, `s_usu_foto`, `s_usu_banner`, `s_usu_instagram`, `s_usu_facebook`, `b_usu_comum`, `b_usu_email_validado`, `b_usu_email_validado_oc`, `e_usu_sexo`, `t_usu_nasc`, `s_usu_frase_wpp`, `f_usu_cidade`, `s_usu_endereco`, `s_usu_latitude`, `s_usu_longitude`, `t_usu_premium_valido`, `f_usu_convidado_por`, `b_usu_premium_trial`, `b_usu_premium_valido`, `b_colaborador_parceiro`, `b_colaborador_parceiro_oc`, `f_usu_pais`, `b_usu_premium_cardapio`, `b_usu_premium_delivery`, `b_usu_fidelize`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(3082, 'Lucas Silva de Matos', 'lucas', '00000000000000', 'lucass_matos@hotmail.com', '(61)99298-4682', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', '$2a$08$9/MBekNQM8FVCLtH16z7.O/FhBTE6XnHFFlTjGjaiSoMcvQ0NsWCG', NULL, '$2a$12$xfy4/Fj1l7TtEwFmqjOVvOGaB/0Unr3v7UG8NF0a5AjQ7subkUQ7m', 'a', '2021-07-19 20:45:38', 'data:image/png;base64,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', NULL, NULL, NULL, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, NULL, 0, 0, 0, '2021-07-19 20:45:38', '2021-07-19 21:13:25', NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `tb_base_paginas`
--
ALTER TABLE `tb_base_paginas`
  ADD PRIMARY KEY (`p_pag_id`);

--
-- Índices de tabela `tb_bnf_beneficio`
--
ALTER TABLE `tb_bnf_beneficio`
  ADD PRIMARY KEY (`p_bnf_id`),
  ADD KEY `fk_tb_bnf_beneficio_tb_usu_usuario1_idx` (`f_bnf_usuario`);

--
-- Índices de tabela `tb_bnf_condicional`
--
ALTER TABLE `tb_bnf_condicional`
  ADD PRIMARY KEY (`p_cnd_id`),
  ADD KEY `fk_tb_cnd_condicional_tb_bnf_beneficio1_idx` (`f_bnf_id`);

--
-- Índices de tabela `tb_bnf_garantido`
--
ALTER TABLE `tb_bnf_garantido`
  ADD PRIMARY KEY (`p_grt_id`),
  ADD KEY `fk_tb_grt_garantido_tb_bnf_beneficio1_idx` (`f_bnf_id`);

--
-- Índices de tabela `tb_cid_cidade`
--
ALTER TABLE `tb_cid_cidade`
  ADD PRIMARY KEY (`p_cid_id`),
  ADD KEY `f_cid_pais` (`f_cid_pais`);

--
-- Índices de tabela `tb_cid_cidade_regiao`
--
ALTER TABLE `tb_cid_cidade_regiao`
  ADD PRIMARY KEY (`p_reg_regiao`);

--
-- Índices de tabela `tb_data_cardapio`
--
ALTER TABLE `tb_data_cardapio`
  ADD PRIMARY KEY (`p_car_id`);

--
-- Índices de tabela `tb_data_link_bio`
--
ALTER TABLE `tb_data_link_bio`
  ADD PRIMARY KEY (`p_link_id`);

--
-- Índices de tabela `tb_est_fin_categoria`
--
ALTER TABLE `tb_est_fin_categoria`
  ADD PRIMARY KEY (`p_cat_id`),
  ADD KEY `f_cat_usuario` (`f_cat_usuario`);

--
-- Índices de tabela `tb_est_fin_categoria_grupos`
--
ALTER TABLE `tb_est_fin_categoria_grupos`
  ADD PRIMARY KEY (`p_grp_id`),
  ADD KEY `f_grp_categoria` (`f_grp_categoria`);

--
-- Índices de tabela `tb_est_fin_categoria_horarios`
--
ALTER TABLE `tb_est_fin_categoria_horarios`
  ADD PRIMARY KEY (`p_hora_id`);

--
-- Índices de tabela `tb_est_fin_complementos`
--
ALTER TABLE `tb_est_fin_complementos`
  ADD PRIMARY KEY (`p_comp_id`),
  ADD KEY `por_prod_id` (`f_prod_id`);

--
-- Índices de tabela `tb_est_fin_complementos_itens`
--
ALTER TABLE `tb_est_fin_complementos_itens`
  ADD PRIMARY KEY (`p_comp_item_id`),
  ADD KEY `por_comp_id` (`f_comp_id`);

--
-- Índices de tabela `tb_est_fin_configuracao`
--
ALTER TABLE `tb_est_fin_configuracao`
  ADD PRIMARY KEY (`p_conf_id`);

--
-- Índices de tabela `tb_est_fin_cozinhas`
--
ALTER TABLE `tb_est_fin_cozinhas`
  ADD PRIMARY KEY (`p_coz_id`);

--
-- Índices de tabela `tb_est_fin_delivery_pedido`
--
ALTER TABLE `tb_est_fin_delivery_pedido`
  ADD PRIMARY KEY (`p_del_id`);

--
-- Índices de tabela `tb_est_fin_mesas`
--
ALTER TABLE `tb_est_fin_mesas`
  ADD PRIMARY KEY (`p_mesa_id`);

--
-- Índices de tabela `tb_est_fin_mesas_historico`
--
ALTER TABLE `tb_est_fin_mesas_historico`
  ADD PRIMARY KEY (`p_mesa_id`);

--
-- Índices de tabela `tb_est_fin_mesas_pedido`
--
ALTER TABLE `tb_est_fin_mesas_pedido`
  ADD PRIMARY KEY (`p_mesa_ped_id`);

--
-- Índices de tabela `tb_est_fin_notificacoes`
--
ALTER TABLE `tb_est_fin_notificacoes`
  ADD PRIMARY KEY (`p_not_id`);

--
-- Índices de tabela `tb_est_fin_pedidos`
--
ALTER TABLE `tb_est_fin_pedidos`
  ADD PRIMARY KEY (`p_ped_id`);

--
-- Índices de tabela `tb_est_fin_pedidos_impressao`
--
ALTER TABLE `tb_est_fin_pedidos_impressao`
  ADD PRIMARY KEY (`p_imp_id`);

--
-- Índices de tabela `tb_est_fin_pedidos_produtos`
--
ALTER TABLE `tb_est_fin_pedidos_produtos`
  ADD PRIMARY KEY (`p_ped_id`);

--
-- Índices de tabela `tb_est_fin_pedidos_simples`
--
ALTER TABLE `tb_est_fin_pedidos_simples`
  ADD PRIMARY KEY (`p_ped_id`);

--
-- Índices de tabela `tb_est_fin_pedidos_subitens`
--
ALTER TABLE `tb_est_fin_pedidos_subitens`
  ADD PRIMARY KEY (`p_ped_sub_id`);

--
-- Índices de tabela `tb_est_fin_produtos`
--
ALTER TABLE `tb_est_fin_produtos`
  ADD PRIMARY KEY (`p_prd_id`),
  ADD KEY `f_prd_categoria` (`f_prd_categoria`),
  ADD KEY `n_prd_ordem` (`n_prd_ordem`),
  ADD KEY `s_prd_titulo` (`s_prd_titulo`);

--
-- Índices de tabela `tb_est_fin_produto_grupos`
--
ALTER TABLE `tb_est_fin_produto_grupos`
  ADD PRIMARY KEY (`p_prd_grp_id`);

--
-- Índices de tabela `tb_est_fin_produto_precos`
--
ALTER TABLE `tb_est_fin_produto_precos`
  ADD PRIMARY KEY (`p_pre_id`),
  ADD KEY `f_pre_produto` (`f_pre_produto`);

--
-- Índices de tabela `tb_est_fin_produto_subitens`
--
ALTER TABLE `tb_est_fin_produto_subitens`
  ADD PRIMARY KEY (`p_prd_sub_id`),
  ADD KEY `f_prd_sub_produto` (`f_prd_sub_produto`);

--
-- Índices de tabela `tb_est_fin_subitens`
--
ALTER TABLE `tb_est_fin_subitens`
  ADD PRIMARY KEY (`p_sub_id`);

--
-- Índices de tabela `tb_eve_aniversarios`
--
ALTER TABLE `tb_eve_aniversarios`
  ADD PRIMARY KEY (`p_ani_id`);

--
-- Índices de tabela `tb_eve_aniversario_form`
--
ALTER TABLE `tb_eve_aniversario_form`
  ADD PRIMARY KEY (`p_ani_form_id`);

--
-- Índices de tabela `tb_eve_colaborador`
--
ALTER TABLE `tb_eve_colaborador`
  ADD PRIMARY KEY (`p_col_eve_id`),
  ADD KEY `fk_tb_eve_colaborador_tb_usu_usuario1_idx` (`f_col_id`),
  ADD KEY `fk_tb_eve_colaborador_tb_eve_evento1_idx` (`f_eve_id`),
  ADD KEY `fk_tb_eve_colaborador_tb_eve_funcao1_idx` (`f_col_eve_funcao`),
  ADD KEY `fk_tb_eve_colaborador_tb_bnf_beneficio1_idx` (`f_bnf_id`);

--
-- Índices de tabela `tb_eve_colaborador_lista`
--
ALTER TABLE `tb_eve_colaborador_lista`
  ADD PRIMARY KEY (`p_col_lis_id`);

--
-- Índices de tabela `tb_eve_comanda`
--
ALTER TABLE `tb_eve_comanda`
  ADD PRIMARY KEY (`p_comanda_id`);

--
-- Índices de tabela `tb_eve_espera_setores`
--
ALTER TABLE `tb_eve_espera_setores`
  ADD PRIMARY KEY (`p_set_id`);

--
-- Índices de tabela `tb_eve_evento`
--
ALTER TABLE `tb_eve_evento`
  ADD PRIMARY KEY (`p_eve_id`),
  ADD KEY `fk_tb_eve_evento_tb_usu_usuario_idx` (`f_eve_usuario`);

--
-- Índices de tabela `tb_eve_funcao`
--
ALTER TABLE `tb_eve_funcao`
  ADD PRIMARY KEY (`p_func_id`);

--
-- Índices de tabela `tb_eve_funcao_acessos`
--
ALTER TABLE `tb_eve_funcao_acessos`
  ADD PRIMARY KEY (`p_aces_id`);

--
-- Índices de tabela `tb_eve_giro_mesa`
--
ALTER TABLE `tb_eve_giro_mesa`
  ADD PRIMARY KEY (`p_gir_id`);

--
-- Índices de tabela `tb_eve_link_promover`
--
ALTER TABLE `tb_eve_link_promover`
  ADD PRIMARY KEY (`p_lnk_id`);

--
-- Índices de tabela `tb_eve_lista`
--
ALTER TABLE `tb_eve_lista`
  ADD PRIMARY KEY (`p_lst_id`),
  ADD KEY `fk_tb_eve_lista_tb_eve_evento1_idx` (`f_lst_evento`);

--
-- Índices de tabela `tb_eve_lista_avancada`
--
ALTER TABLE `tb_eve_lista_avancada`
  ADD PRIMARY KEY (`p_lista_avancada_id`);

--
-- Índices de tabela `tb_eve_lista_tipos`
--
ALTER TABLE `tb_eve_lista_tipos`
  ADD PRIMARY KEY (`p_lista_tipo_id`),
  ADD KEY `fk_tb_eve_lista_tipos_tb_usu_usuario1_idx` (`f_lista_tipo_estabelecimento`);

--
-- Índices de tabela `tb_eve_lista_tipos_eventos`
--
ALTER TABLE `tb_eve_lista_tipos_eventos`
  ADD PRIMARY KEY (`p_lista_tipo_evento_id`),
  ADD KEY `fk_tb_eve_lista_tipos_eventos_tb_eve_lista_tipos1_idx` (`f_lista_tipo_id`),
  ADD KEY `fk_tb_eve_lista_tipos_eventos_tb_eve_evento1_idx` (`f_lista_evento_id`);

--
-- Índices de tabela `tb_eve_reserva`
--
ALTER TABLE `tb_eve_reserva`
  ADD PRIMARY KEY (`p_res_id`);

--
-- Índices de tabela `tb_eve_reserva_ambientes`
--
ALTER TABLE `tb_eve_reserva_ambientes`
  ADD PRIMARY KEY (`p_amb_id`);

--
-- Índices de tabela `tb_eve_subevento_tipos`
--
ALTER TABLE `tb_eve_subevento_tipos`
  ADD PRIMARY KEY (`p_sub_tipo_id`);

--
-- Índices de tabela `tb_eve_subevento_vips`
--
ALTER TABLE `tb_eve_subevento_vips`
  ADD PRIMARY KEY (`p_vip_id`);

--
-- Índices de tabela `tb_oc_dress_code`
--
ALTER TABLE `tb_oc_dress_code`
  ADD PRIMARY KEY (`p_drc_id`);

--
-- Índices de tabela `tb_oc_estabalecimento_hashtags`
--
ALTER TABLE `tb_oc_estabalecimento_hashtags`
  ADD PRIMARY KEY (`p_hsh_id`);

--
-- Índices de tabela `tb_oc_estabelecimento`
--
ALTER TABLE `tb_oc_estabelecimento`
  ADD PRIMARY KEY (`p_est_id`);

--
-- Índices de tabela `tb_oc_estabelecimento_tipos`
--
ALTER TABLE `tb_oc_estabelecimento_tipos`
  ADD PRIMARY KEY (`p_tip_tipo`);

--
-- Índices de tabela `tb_oc_evento`
--
ALTER TABLE `tb_oc_evento`
  ADD PRIMARY KEY (`p_eve_id`);

--
-- Índices de tabela `tb_oc_evento_musica`
--
ALTER TABLE `tb_oc_evento_musica`
  ADD PRIMARY KEY (`p_atr_id`);

--
-- Índices de tabela `tb_oc_imagens_estabelecimento`
--
ALTER TABLE `tb_oc_imagens_estabelecimento`
  ADD PRIMARY KEY (`p_img_id`);

--
-- Índices de tabela `tb_oc_sugerir_cidade`
--
ALTER TABLE `tb_oc_sugerir_cidade`
  ADD PRIMARY KEY (`p_sug_id`);

--
-- Índices de tabela `tb_oc_sugerir_data`
--
ALTER TABLE `tb_oc_sugerir_data`
  ADD PRIMARY KEY (`p_sug_data`);

--
-- Índices de tabela `tb_oc_usu_estabelecimento`
--
ALTER TABLE `tb_oc_usu_estabelecimento`
  ADD PRIMARY KEY (`p_usu_est_id`);

--
-- Índices de tabela `tb_pais`
--
ALTER TABLE `tb_pais`
  ADD PRIMARY KEY (`p_pai_id`);

--
-- Índices de tabela `tb_prm_cenario_horarios`
--
ALTER TABLE `tb_prm_cenario_horarios`
  ADD PRIMARY KEY (`p_hor_id`);

--
-- Índices de tabela `tb_prm_cenario_mesas`
--
ALTER TABLE `tb_prm_cenario_mesas`
  ADD PRIMARY KEY (`p_cen_id`);

--
-- Índices de tabela `tb_prm_espera_status`
--
ALTER TABLE `tb_prm_espera_status`
  ADD PRIMARY KEY (`p_sta_id`);

--
-- Índices de tabela `tb_prm_mesas`
--
ALTER TABLE `tb_prm_mesas`
  ADD PRIMARY KEY (`p_mes_id`),
  ADD KEY `f_mes_cenario` (`f_mes_cenario`);

--
-- Índices de tabela `tb_prm_mesa_espera`
--
ALTER TABLE `tb_prm_mesa_espera`
  ADD PRIMARY KEY (`p_esp_id`);

--
-- Índices de tabela `tb_prm_mesa_travar`
--
ALTER TABLE `tb_prm_mesa_travar`
  ADD PRIMARY KEY (`p_trv_id`);

--
-- Índices de tabela `tb_prm_mesa_travar_reserva`
--
ALTER TABLE `tb_prm_mesa_travar_reserva`
  ADD PRIMARY KEY (`p_trv_id`);

--
-- Índices de tabela `tb_prm_pos_venda`
--
ALTER TABLE `tb_prm_pos_venda`
  ADD PRIMARY KEY (`p_psv_id`),
  ADD KEY `f_psv_convidado` (`f_psv_convidado`);

--
-- Índices de tabela `tb_prm_premium`
--
ALTER TABLE `tb_prm_premium`
  ADD PRIMARY KEY (`p_prm_id`);

--
-- Índices de tabela `tb_prm_reserva_mesa`
--
ALTER TABLE `tb_prm_reserva_mesa`
  ADD PRIMARY KEY (`p_res_id`),
  ADD KEY `f_res_mesa` (`f_res_mesa`),
  ADD KEY `f_res_horario` (`f_res_horario`);

--
-- Índices de tabela `tb_prm_reserva_mesa_grupo`
--
ALTER TABLE `tb_prm_reserva_mesa_grupo`
  ADD PRIMARY KEY (`p_grp_id`),
  ADD KEY `f_grp_cenario` (`f_grp_cenario`);

--
-- Índices de tabela `tb_prm_template`
--
ALTER TABLE `tb_prm_template`
  ADD PRIMARY KEY (`p_tmp_id`);

--
-- Índices de tabela `tb_prm_template_usuario`
--
ALTER TABLE `tb_prm_template_usuario`
  ADD PRIMARY KEY (`p_tmp_id`);

--
-- Índices de tabela `tb_uf`
--
ALTER TABLE `tb_uf`
  ADD PRIMARY KEY (`p_uf_id`);

--
-- Índices de tabela `tb_usu_avaliacao`
--
ALTER TABLE `tb_usu_avaliacao`
  ADD PRIMARY KEY (`p_ava_id`);

--
-- Índices de tabela `tb_usu_blacklist`
--
ALTER TABLE `tb_usu_blacklist`
  ADD PRIMARY KEY (`p_blk_id`);

--
-- Índices de tabela `tb_usu_cardapio`
--
ALTER TABLE `tb_usu_cardapio`
  ADD PRIMARY KEY (`p_usu_car_id`);

--
-- Índices de tabela `tb_usu_cardapio_clientes`
--
ALTER TABLE `tb_usu_cardapio_clientes`
  ADD PRIMARY KEY (`p_cli_id`);

--
-- Índices de tabela `tb_usu_cardapio_meio_pagamento`
--
ALTER TABLE `tb_usu_cardapio_meio_pagamento`
  ADD PRIMARY KEY (`p_pag_id`);

--
-- Índices de tabela `tb_usu_colaborador_fixo`
--
ALTER TABLE `tb_usu_colaborador_fixo`
  ADD PRIMARY KEY (`p_fixo_id`),
  ADD KEY `fk_tb_usu_colaborador_fixo_tb_usu_usuario1_idx` (`f_fixo_estabelecimento`),
  ADD KEY `fk_tb_usu_colaborador_fixo_tb_usu_usuario2_idx` (`f_fixo_usuario`),
  ADD KEY `fk_tb_usu_colaborador_fixo_tb_eve_funcao1_idx` (`f_fixo_funcao`);

--
-- Índices de tabela `tb_usu_frases_wpp`
--
ALTER TABLE `tb_usu_frases_wpp`
  ADD PRIMARY KEY (`p_wpp_id`);

--
-- Índices de tabela `tb_usu_horario_funcionamento`
--
ALTER TABLE `tb_usu_horario_funcionamento`
  ADD PRIMARY KEY (`p_hora_id`);

--
-- Índices de tabela `tb_usu_link`
--
ALTER TABLE `tb_usu_link`
  ADD PRIMARY KEY (`p_link_id`);

--
-- Índices de tabela `tb_usu_link_criado`
--
ALTER TABLE `tb_usu_link_criado`
  ADD PRIMARY KEY (`p_link_id`);

--
-- Índices de tabela `tb_usu_logo`
--
ALTER TABLE `tb_usu_logo`
  ADD PRIMARY KEY (`p_logo_id`);

--
-- Índices de tabela `tb_usu_qualification`
--
ALTER TABLE `tb_usu_qualification`
  ADD PRIMARY KEY (`p_qua_id`);

--
-- Índices de tabela `tb_usu_recuperar_senha`
--
ALTER TABLE `tb_usu_recuperar_senha`
  ADD PRIMARY KEY (`p_rec_id`);

--
-- Índices de tabela `tb_usu_taxa_entrega`
--
ALTER TABLE `tb_usu_taxa_entrega`
  ADD PRIMARY KEY (`p_ent_id`);

--
-- Índices de tabela `tb_usu_token`
--
ALTER TABLE `tb_usu_token`
  ADD PRIMARY KEY (`p_token_id`),
  ADD KEY `fk_tb_usu_token_tb_usu_usuario1_idx` (`f_usu_id`);

--
-- Índices de tabela `tb_usu_tutorial`
--
ALTER TABLE `tb_usu_tutorial`
  ADD PRIMARY KEY (`p_tut_id`);

--
-- Índices de tabela `tb_usu_usuario`
--
ALTER TABLE `tb_usu_usuario`
  ADD PRIMARY KEY (`p_usu_id`),
  ADD UNIQUE KEY `s_usu_slug_UNIQUE` (`s_usu_slug`),
  ADD KEY `s_usu_slug` (`s_usu_slug`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_bnf_beneficio`
--
ALTER TABLE `tb_bnf_beneficio`
  MODIFY `p_bnf_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de tabela `tb_bnf_condicional`
--
ALTER TABLE `tb_bnf_condicional`
  MODIFY `p_cnd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT de tabela `tb_bnf_garantido`
--
ALTER TABLE `tb_bnf_garantido`
  MODIFY `p_grt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT de tabela `tb_cid_cidade`
--
ALTER TABLE `tb_cid_cidade`
  MODIFY `p_cid_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10792;

--
-- AUTO_INCREMENT de tabela `tb_cid_cidade_regiao`
--
ALTER TABLE `tb_cid_cidade_regiao`
  MODIFY `p_reg_regiao` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `tb_data_cardapio`
--
ALTER TABLE `tb_data_cardapio`
  MODIFY `p_car_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32317;

--
-- AUTO_INCREMENT de tabela `tb_data_link_bio`
--
ALTER TABLE `tb_data_link_bio`
  MODIFY `p_link_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1030;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_categoria`
--
ALTER TABLE `tb_est_fin_categoria`
  MODIFY `p_cat_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8048;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_categoria_grupos`
--
ALTER TABLE `tb_est_fin_categoria_grupos`
  MODIFY `p_grp_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1316;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_categoria_horarios`
--
ALTER TABLE `tb_est_fin_categoria_horarios`
  MODIFY `p_hora_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_complementos`
--
ALTER TABLE `tb_est_fin_complementos`
  MODIFY `p_comp_id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_complementos_itens`
--
ALTER TABLE `tb_est_fin_complementos_itens`
  MODIFY `p_comp_item_id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_configuracao`
--
ALTER TABLE `tb_est_fin_configuracao`
  MODIFY `p_conf_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_cozinhas`
--
ALTER TABLE `tb_est_fin_cozinhas`
  MODIFY `p_coz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_delivery_pedido`
--
ALTER TABLE `tb_est_fin_delivery_pedido`
  MODIFY `p_del_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_mesas`
--
ALTER TABLE `tb_est_fin_mesas`
  MODIFY `p_mesa_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_mesas_historico`
--
ALTER TABLE `tb_est_fin_mesas_historico`
  MODIFY `p_mesa_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_mesas_pedido`
--
ALTER TABLE `tb_est_fin_mesas_pedido`
  MODIFY `p_mesa_ped_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_notificacoes`
--
ALTER TABLE `tb_est_fin_notificacoes`
  MODIFY `p_not_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_pedidos`
--
ALTER TABLE `tb_est_fin_pedidos`
  MODIFY `p_ped_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_pedidos_impressao`
--
ALTER TABLE `tb_est_fin_pedidos_impressao`
  MODIFY `p_imp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_pedidos_produtos`
--
ALTER TABLE `tb_est_fin_pedidos_produtos`
  MODIFY `p_ped_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_pedidos_simples`
--
ALTER TABLE `tb_est_fin_pedidos_simples`
  MODIFY `p_ped_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_pedidos_subitens`
--
ALTER TABLE `tb_est_fin_pedidos_subitens`
  MODIFY `p_ped_sub_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_produtos`
--
ALTER TABLE `tb_est_fin_produtos`
  MODIFY `p_prd_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56279;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_produto_grupos`
--
ALTER TABLE `tb_est_fin_produto_grupos`
  MODIFY `p_prd_grp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_produto_precos`
--
ALTER TABLE `tb_est_fin_produto_precos`
  MODIFY `p_pre_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25257;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_produto_subitens`
--
ALTER TABLE `tb_est_fin_produto_subitens`
  MODIFY `p_prd_sub_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT de tabela `tb_est_fin_subitens`
--
ALTER TABLE `tb_est_fin_subitens`
  MODIFY `p_sub_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de tabela `tb_eve_aniversarios`
--
ALTER TABLE `tb_eve_aniversarios`
  MODIFY `p_ani_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6038;

--
-- AUTO_INCREMENT de tabela `tb_eve_aniversario_form`
--
ALTER TABLE `tb_eve_aniversario_form`
  MODIFY `p_ani_form_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;

--
-- AUTO_INCREMENT de tabela `tb_eve_colaborador`
--
ALTER TABLE `tb_eve_colaborador`
  MODIFY `p_col_eve_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Armazena a chave primária.', AUTO_INCREMENT=19827;

--
-- AUTO_INCREMENT de tabela `tb_eve_colaborador_lista`
--
ALTER TABLE `tb_eve_colaborador_lista`
  MODIFY `p_col_lis_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_eve_comanda`
--
ALTER TABLE `tb_eve_comanda`
  MODIFY `p_comanda_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16944;

--
-- AUTO_INCREMENT de tabela `tb_eve_espera_setores`
--
ALTER TABLE `tb_eve_espera_setores`
  MODIFY `p_set_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `tb_eve_evento`
--
ALTER TABLE `tb_eve_evento`
  MODIFY `p_eve_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Armazena a chave primária.', AUTO_INCREMENT=2180;

--
-- AUTO_INCREMENT de tabela `tb_eve_funcao`
--
ALTER TABLE `tb_eve_funcao`
  MODIFY `p_func_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Armazena o ID da função do usuário.', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `tb_eve_funcao_acessos`
--
ALTER TABLE `tb_eve_funcao_acessos`
  MODIFY `p_aces_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4353;

--
-- AUTO_INCREMENT de tabela `tb_eve_giro_mesa`
--
ALTER TABLE `tb_eve_giro_mesa`
  MODIFY `p_gir_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1782;

--
-- AUTO_INCREMENT de tabela `tb_eve_link_promover`
--
ALTER TABLE `tb_eve_link_promover`
  MODIFY `p_lnk_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2041;

--
-- AUTO_INCREMENT de tabela `tb_eve_lista`
--
ALTER TABLE `tb_eve_lista`
  MODIFY `p_lst_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Armazena o ID da lista.', AUTO_INCREMENT=495405;

--
-- AUTO_INCREMENT de tabela `tb_eve_lista_avancada`
--
ALTER TABLE `tb_eve_lista_avancada`
  MODIFY `p_lista_avancada_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `tb_eve_lista_tipos`
--
ALTER TABLE `tb_eve_lista_tipos`
  MODIFY `p_lista_tipo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=229;

--
-- AUTO_INCREMENT de tabela `tb_eve_lista_tipos_eventos`
--
ALTER TABLE `tb_eve_lista_tipos_eventos`
  MODIFY `p_lista_tipo_evento_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1565;

--
-- AUTO_INCREMENT de tabela `tb_eve_reserva`
--
ALTER TABLE `tb_eve_reserva`
  MODIFY `p_res_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_eve_reserva_ambientes`
--
ALTER TABLE `tb_eve_reserva_ambientes`
  MODIFY `p_amb_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tb_eve_subevento_tipos`
--
ALTER TABLE `tb_eve_subevento_tipos`
  MODIFY `p_sub_tipo_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `tb_eve_subevento_vips`
--
ALTER TABLE `tb_eve_subevento_vips`
  MODIFY `p_vip_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT de tabela `tb_oc_dress_code`
--
ALTER TABLE `tb_oc_dress_code`
  MODIFY `p_drc_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de tabela `tb_oc_estabalecimento_hashtags`
--
ALTER TABLE `tb_oc_estabalecimento_hashtags`
  MODIFY `p_hsh_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=774;

--
-- AUTO_INCREMENT de tabela `tb_oc_estabelecimento`
--
ALTER TABLE `tb_oc_estabelecimento`
  MODIFY `p_est_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT de tabela `tb_oc_estabelecimento_tipos`
--
ALTER TABLE `tb_oc_estabelecimento_tipos`
  MODIFY `p_tip_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tb_oc_evento`
--
ALTER TABLE `tb_oc_evento`
  MODIFY `p_eve_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_oc_evento_musica`
--
ALTER TABLE `tb_oc_evento_musica`
  MODIFY `p_atr_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de tabela `tb_oc_imagens_estabelecimento`
--
ALTER TABLE `tb_oc_imagens_estabelecimento`
  MODIFY `p_img_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `tb_oc_sugerir_cidade`
--
ALTER TABLE `tb_oc_sugerir_cidade`
  MODIFY `p_sug_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tb_oc_sugerir_data`
--
ALTER TABLE `tb_oc_sugerir_data`
  MODIFY `p_sug_data` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `tb_oc_usu_estabelecimento`
--
ALTER TABLE `tb_oc_usu_estabelecimento`
  MODIFY `p_usu_est_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tb_pais`
--
ALTER TABLE `tb_pais`
  MODIFY `p_pai_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tb_prm_cenario_horarios`
--
ALTER TABLE `tb_prm_cenario_horarios`
  MODIFY `p_hor_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de tabela `tb_prm_cenario_mesas`
--
ALTER TABLE `tb_prm_cenario_mesas`
  MODIFY `p_cen_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT de tabela `tb_prm_espera_status`
--
ALTER TABLE `tb_prm_espera_status`
  MODIFY `p_sta_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_prm_mesas`
--
ALTER TABLE `tb_prm_mesas`
  MODIFY `p_mes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1133;

--
-- AUTO_INCREMENT de tabela `tb_prm_mesa_espera`
--
ALTER TABLE `tb_prm_mesa_espera`
  MODIFY `p_esp_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12015;

--
-- AUTO_INCREMENT de tabela `tb_prm_mesa_travar`
--
ALTER TABLE `tb_prm_mesa_travar`
  MODIFY `p_trv_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2166;

--
-- AUTO_INCREMENT de tabela `tb_prm_mesa_travar_reserva`
--
ALTER TABLE `tb_prm_mesa_travar_reserva`
  MODIFY `p_trv_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_prm_pos_venda`
--
ALTER TABLE `tb_prm_pos_venda`
  MODIFY `p_psv_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12568;

--
-- AUTO_INCREMENT de tabela `tb_prm_premium`
--
ALTER TABLE `tb_prm_premium`
  MODIFY `p_prm_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=444;

--
-- AUTO_INCREMENT de tabela `tb_prm_reserva_mesa`
--
ALTER TABLE `tb_prm_reserva_mesa`
  MODIFY `p_res_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3654;

--
-- AUTO_INCREMENT de tabela `tb_prm_reserva_mesa_grupo`
--
ALTER TABLE `tb_prm_reserva_mesa_grupo`
  MODIFY `p_grp_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de tabela `tb_prm_template`
--
ALTER TABLE `tb_prm_template`
  MODIFY `p_tmp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de tabela `tb_prm_template_usuario`
--
ALTER TABLE `tb_prm_template_usuario`
  MODIFY `p_tmp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT de tabela `tb_uf`
--
ALTER TABLE `tb_uf`
  MODIFY `p_uf_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de tabela `tb_usu_avaliacao`
--
ALTER TABLE `tb_usu_avaliacao`
  MODIFY `p_ava_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT de tabela `tb_usu_blacklist`
--
ALTER TABLE `tb_usu_blacklist`
  MODIFY `p_blk_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `tb_usu_cardapio`
--
ALTER TABLE `tb_usu_cardapio`
  MODIFY `p_usu_car_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=539;

--
-- AUTO_INCREMENT de tabela `tb_usu_cardapio_clientes`
--
ALTER TABLE `tb_usu_cardapio_clientes`
  MODIFY `p_cli_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tb_usu_cardapio_meio_pagamento`
--
ALTER TABLE `tb_usu_cardapio_meio_pagamento`
  MODIFY `p_pag_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;

--
-- AUTO_INCREMENT de tabela `tb_usu_colaborador_fixo`
--
ALTER TABLE `tb_usu_colaborador_fixo`
  MODIFY `p_fixo_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Armazena o ID.', AUTO_INCREMENT=500;

--
-- AUTO_INCREMENT de tabela `tb_usu_frases_wpp`
--
ALTER TABLE `tb_usu_frases_wpp`
  MODIFY `p_wpp_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT de tabela `tb_usu_horario_funcionamento`
--
ALTER TABLE `tb_usu_horario_funcionamento`
  MODIFY `p_hora_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT de tabela `tb_usu_link`
--
ALTER TABLE `tb_usu_link`
  MODIFY `p_link_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT de tabela `tb_usu_link_criado`
--
ALTER TABLE `tb_usu_link_criado`
  MODIFY `p_link_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de tabela `tb_usu_logo`
--
ALTER TABLE `tb_usu_logo`
  MODIFY `p_logo_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=524;

--
-- AUTO_INCREMENT de tabela `tb_usu_qualification`
--
ALTER TABLE `tb_usu_qualification`
  MODIFY `p_qua_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_usu_recuperar_senha`
--
ALTER TABLE `tb_usu_recuperar_senha`
  MODIFY `p_rec_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT de tabela `tb_usu_taxa_entrega`
--
ALTER TABLE `tb_usu_taxa_entrega`
  MODIFY `p_ent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `tb_usu_token`
--
ALTER TABLE `tb_usu_token`
  MODIFY `p_token_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15610;

--
-- AUTO_INCREMENT de tabela `tb_usu_tutorial`
--
ALTER TABLE `tb_usu_tutorial`
  MODIFY `p_tut_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `tb_usu_usuario`
--
ALTER TABLE `tb_usu_usuario`
  MODIFY `p_usu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Armazena a chave primária.', AUTO_INCREMENT=3083;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `tb_bnf_beneficio`
--
ALTER TABLE `tb_bnf_beneficio`
  ADD CONSTRAINT `fk_tb_bnf_beneficio_tb_usu_usuario1` FOREIGN KEY (`f_bnf_usuario`) REFERENCES `tb_usu_usuario` (`p_usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `tb_bnf_condicional`
--
ALTER TABLE `tb_bnf_condicional`
  ADD CONSTRAINT `fk_tb_cnd_condicional_tb_bnf_beneficio1` FOREIGN KEY (`f_bnf_id`) REFERENCES `tb_bnf_beneficio` (`p_bnf_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `tb_bnf_garantido`
--
ALTER TABLE `tb_bnf_garantido`
  ADD CONSTRAINT `fk_tb_grt_garantido_tb_bnf_beneficio1` FOREIGN KEY (`f_bnf_id`) REFERENCES `tb_bnf_beneficio` (`p_bnf_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `tb_eve_colaborador`
--
ALTER TABLE `tb_eve_colaborador`
  ADD CONSTRAINT `fk_tb_eve_colaborador_tb_bnf_beneficio1` FOREIGN KEY (`f_bnf_id`) REFERENCES `tb_bnf_beneficio` (`p_bnf_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_eve_colaborador_tb_eve_evento1` FOREIGN KEY (`f_eve_id`) REFERENCES `tb_eve_evento` (`p_eve_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_eve_colaborador_tb_eve_funcao1` FOREIGN KEY (`f_col_eve_funcao`) REFERENCES `tb_eve_funcao` (`p_func_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_eve_colaborador_tb_usu_usuario1` FOREIGN KEY (`f_col_id`) REFERENCES `tb_usu_usuario` (`p_usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `tb_eve_evento`
--
ALTER TABLE `tb_eve_evento`
  ADD CONSTRAINT `fk_tb_eve_evento_tb_usu_usuario` FOREIGN KEY (`f_eve_usuario`) REFERENCES `tb_usu_usuario` (`p_usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `tb_eve_lista`
--
ALTER TABLE `tb_eve_lista`
  ADD CONSTRAINT `fk_tb_eve_lista_tb_eve_evento1` FOREIGN KEY (`f_lst_evento`) REFERENCES `tb_eve_evento` (`p_eve_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `tb_eve_lista_tipos`
--
ALTER TABLE `tb_eve_lista_tipos`
  ADD CONSTRAINT `fk_tb_eve_lista_tipos_tb_usu_usuario1` FOREIGN KEY (`f_lista_tipo_estabelecimento`) REFERENCES `tb_usu_usuario` (`p_usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `tb_eve_lista_tipos_eventos`
--
ALTER TABLE `tb_eve_lista_tipos_eventos`
  ADD CONSTRAINT `fk_tb_eve_lista_tipos_eventos_tb_eve_evento1` FOREIGN KEY (`f_lista_evento_id`) REFERENCES `tb_eve_evento` (`p_eve_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_eve_lista_tipos_eventos_tb_eve_lista_tipos1` FOREIGN KEY (`f_lista_tipo_id`) REFERENCES `tb_eve_lista_tipos` (`p_lista_tipo_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `tb_usu_colaborador_fixo`
--
ALTER TABLE `tb_usu_colaborador_fixo`
  ADD CONSTRAINT `fk_tb_usu_colaborador_fixo_tb_eve_funcao1` FOREIGN KEY (`f_fixo_funcao`) REFERENCES `tb_eve_funcao` (`p_func_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_usu_colaborador_fixo_tb_usu_usuario1` FOREIGN KEY (`f_fixo_estabelecimento`) REFERENCES `tb_usu_usuario` (`p_usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_usu_colaborador_fixo_tb_usu_usuario2` FOREIGN KEY (`f_fixo_usuario`) REFERENCES `tb_usu_usuario` (`p_usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `tb_usu_token`
--
ALTER TABLE `tb_usu_token`
  ADD CONSTRAINT `fk_tb_usu_token_tb_usu_usuario1` FOREIGN KEY (`f_usu_id`) REFERENCES `tb_usu_usuario` (`p_usu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
