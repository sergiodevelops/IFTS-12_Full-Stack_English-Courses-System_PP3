CREATE DATABASE `rrhh1`;
USE `rrhh1`;

CREATE TABLE IF NOT EXISTS `administrativos` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `apellido` varchar(100) DEFAULT NULL COMMENT 'Apellido del integrante del staf de la empresa',
    `nombres` varchar(100) DEFAULT NULL COMMENT 'Nombres del integrante del staf de la empresa',
    `tel` varchar(100) DEFAULT NULL COMMENT 'Nros telefónicos',
    `email` varchar(100) DEFAULT NULL COMMENT 'Correos electrónico',
    `cargo` varchar(100) DEFAULT NULL COMMENT 'Cargo que ocupa en la empresa',
    `id_usuario` int(11) unsigned DEFAULT NULL COMMENT 'Nro de usuario',
    PRIMARY KEY (`id`),
    KEY `idx_apellido` (`apellido`),
    KEY `fk_usuario_idx` (`id_usuario`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Personal Administrativo própio de la empresa de Recursos Humanos';

CREATE TABLE IF NOT EXISTS `codigos_postales` (
    `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Código Postal',
    `ciudad` varchar(100) NOT NULL COMMENT 'Ciudad que corespode al código Postal',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Listado de Códigos Postales de las ciudades';

CREATE TABLE IF NOT EXISTS `idiomas` (
    `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
    `Descripcion` varchar(45) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Listado de Idiomas';

CREATE TABLE IF NOT EXISTS `instituciones_academicas` (
    `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
    `nombre` varchar(100) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Listado de Instituciónes académicas del país';

CREATE TABLE IF NOT EXISTS `nivel_estudio` (
    `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
    `estudio_alcanzado` varchar(50) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Nivel Formal de estudios, Primario, Secundario. etc';

CREATE TABLE IF NOT EXISTS `nivel_idiomas` (
    `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
    `descripcion` varchar(20) NOT NULL COMMENT 'Conocimiento del idioma',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Niveles de dominio del idioma solicitado o del postulado';

CREATE TABLE IF NOT EXISTS `postulantes` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `dni` int(11) unsigned DEFAULT NULL COMMENT 'Nro de documento',
    `apellido` varchar(100) DEFAULT NULL COMMENT 'Apellidos',
    `nombres` varchar(100) DEFAULT NULL COMMENT 'Nombres',
    `tel` varchar(100) DEFAULT NULL COMMENT 'teléfonos',
    `email` varchar(100) DEFAULT NULL COMMENT 'direcciones de correos electrónicos',
    `fecha_nacimiento` date DEFAULT NULL COMMENT 'fecha de su natalicio',
    `estado` tinyint(1) unsigned DEFAULT NULL COMMENT '0 no busca trabajo por ahora, 1 En busca de trabajo',
    `codigo_postal` smallint(5) unsigned DEFAULT NULL COMMENT 'Código postal del domicilio del postulado',
    `id_nivel_estudio` tinyint(3) unsigned DEFAULT NULL COMMENT 'Estudio formal alcanzado:  Primario, Universitario, etc.',
    `id_instituciones_academicas` smallint(5) unsigned DEFAULT NULL COMMENT 'Universidad o Instituto donde logró su título',
    `domicilio` varchar(200) DEFAULT NULL COMMENT 'Domicilio del postulante',
    `id_usuario` int(11) unsigned DEFAULT NULL COMMENT 'Nro de usuario',
    PRIMARY KEY (`id`),
    KEY `idx_dni` (`dni`),
    KEY `idx_apellido` (`apellido`,`nombres`),
    KEY `fk_post_nivest_idx` (`id_nivel_estudio`),
    KEY `fk_post_instacad_idx` (`id_instituciones_academicas`),
    KEY `fk_post_codpos_idx` (`codigo_postal`),
    KEY `fk_usuario_post_idx` (`id_usuario`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Lista de empleados ofrecidos';

CREATE TABLE IF NOT EXISTS `postulantes_entrevista` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `id_postulantes` int(11) unsigned NOT NULL COMMENT 'id del Postulante',
    `entrevista` varchar(500) NOT NULL COMMENT 'Resultado de la entrevista personal',
    `evaluacion` tinyint(3) unsigned DEFAULT NULL COMMENT 'Resultado de la entrevista en números.   De 1 a 5.   1 = Muy poco satisfactorio... 5 = Muy satisfactorio',
    PRIMARY KEY (`id`),
    KEY `fk_posentr_post_idx` (`id_postulantes`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Resultado de la entrevista personal del postulante';

CREATE TABLE IF NOT EXISTS `postulantes_estudios` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `id_postulantes` int(11) unsigned DEFAULT NULL COMMENT 'Identificador del postulante',
    `descripcion` varchar(500) DEFAULT NULL COMMENT 'Estudio o conocimiento sobre un tema específico',
    PRIMARY KEY (`id`),
    KEY `fk_posest_post_idx` (`id_postulantes`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Estudios realizados por los postulantes';

CREATE TABLE IF NOT EXISTS `postulantes_experiencias` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `id_postulante` int(11) unsigned NOT NULL COMMENT 'identificador del postulante',
    `empresa_organismo` varchar(255) NOT NULL COMMENT 'Nombre de la empresa/organismo en la que trabajó',
    `ambito` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1 = Privado,  2 = Público, 3 =  independiente',
    `puesto` varchar(100) DEFAULT NULL COMMENT 'Nombre del puesto o tarea desarrollada en la empresa/organismo',
    `anio_inicio` smallint(5) unsigned DEFAULT NULL COMMENT 'año de ingreso a dicha empresa',
    `anio_fin` smallint(5) unsigned DEFAULT NULL COMMENT 'Año de egreso de dicha empresa',
    `tareas` varchar(1000) DEFAULT NULL COMMENT 'Descripcion de la tarea realizada en esa empresa/organismo',
    `tel` varchar(100) DEFAULT NULL COMMENT 'Teléfonos de contacto con la empresa',
    `email` varchar(100) DEFAULT NULL COMMENT 'Correo electrónico de contacto con la empresa',
    `contacto` varchar(100) DEFAULT NULL COMMENT 'Persona a contactar para pedir las referencias del caso',
    `verificacion` tinyint(3) DEFAULT '0' COMMENT 'La información suministrada:   0 =  No fué verificada aún  ,   1 = Si fué verificada y coincide ,   2 = Si fué verificada y NO coincide,   3 = Imposible de verificar',
    PRIMARY KEY (`id`),
    KEY `fk_posex_post_idx` (`id_postulante`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Experiencia Laboral del postulante';

CREATE TABLE IF NOT EXISTS `postulantes_idiomas` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `id_postulantes` int(11) unsigned NOT NULL COMMENT 'Postulante de referenciada',
    `id_idiomas` tinyint(3) unsigned DEFAULT NULL,
    `id_nivel_idioma` tinyint(3) unsigned DEFAULT NULL COMMENT '0 = mínimo, 1 = solo lee , 2 = solo lee y escribe, 3 = lee escribe y habla regular, 4 domina el idioma ',
    PRIMARY KEY (`id`),
    KEY `fk_posidiom_soltud_idx` (`id_postulantes`),
    KEY `fk_postudidiom_idioma_idx` (`id_idiomas`),
    KEY `fk_postudnividiom_nivIdioma_idx` (`id_nivel_idioma`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='idiomas conocidos o dominados por el postulante';

CREATE TABLE IF NOT EXISTS `solicitantes` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `empresa` varchar(100) DEFAULT NULL COMMENT 'Nombre de la empresa solicitante',
    `contacto` varchar(200) DEFAULT NULL COMMENT 'Persona de contacto (nombre y apellido)',
    `telefonos` varchar(100) DEFAULT NULL COMMENT 'teléfonos',
    `email` varchar(100) DEFAULT NULL COMMENT 'Correos electrónicos',
    `codigo_postal` smallint(5) unsigned DEFAULT NULL COMMENT 'Código postal del domicilio de la empresa',
    `estado` tinyint(1) DEFAULT NULL COMMENT '0 con solicitudes abiertas, 1 sin solicitudes ',
    `observaciones` varchar(500) DEFAULT NULL,
    `domicilio` varchar(100) DEFAULT NULL,
    `id_usuario` int(11) unsigned DEFAULT NULL COMMENT 'id de la tabla de usuarios',
    PRIMARY KEY (`id`),
    KEY `idx_dni` (`empresa`),
    KEY `idx_apellido` (`contacto`,`observaciones`),
    KEY `fk_sttes_cospos_idx` (`codigo_postal`),
    KEY `fk_usuario_idx` (`id_usuario`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Empresa que genera una solicitud de empleo para un puesto determinado';

CREATE TABLE IF NOT EXISTS `solicitudes` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `id_solicitantes` int(11) unsigned NOT NULL COMMENT 'id del usuario que pide el puesto a cubrir',
    `puesto_vacante` varchar(100) DEFAULT NULL COMMENT 'Descripción resumida del puesto a cubrir',
    `cantidad_vacantes` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'Cantidad de empleados que necesita',
    `descripcion_tareas` varchar(200) NOT NULL COMMENT 'Breve descripción de las tareas a complir',
    `modalidad` tinyint(3) unsigned DEFAULT NULL COMMENT '1 = Presencial , 2 = Remoto , 3 = Mixto',
    `periodo_a_cubrir` tinyint(3) unsigned DEFAULT NULL COMMENT '1 = temporal, 2, permanente, 3 = 1 año',
    `id_nivel_estudio` tinyint(3) unsigned DEFAULT NULL COMMENT 'Primario completo, Universitario sin terminar,  etc',
    `fecha_alta` date NOT NULL,
    `fecha_baja` date DEFAULT NULL COMMENT 'Fecha que el usuario cliente dejó de tener la necesidad del empleado/s',
    `estado` tinyint(3) unsigned DEFAULT NULL COMMENT '0 = inactiva, 1 = registrado, 2 = en espera de respuesta del solicitante, 3  = en espera de respuesta del postulante, 4 = aprobado por ambos',
    `observaciones` varchar(200) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `idx_usuario` (`id_solicitantes`),
    KEY `fk_stud_nivestud_idx` (`id_nivel_estudio`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Pedidos de cargos a cubrir con sus descripciones y sus necesidades';

CREATE TABLE IF NOT EXISTS `solicitudes_conocimientos` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `id_solicitud` int(11) unsigned NOT NULL COMMENT 'id que referencia la solicitud',
    `conocimiento_requerido` varchar(200) NOT NULL COMMENT 'Descripción del conocimiento necesario del postulante para cubrir la solicitud',
    `nivel` tinyint(3) NOT NULL COMMENT '1= Básico Deseable, 2 Básico Excluyente, 3 = Intermedio Deseable, 4 = Intermedio Excluyente, 5 = Experto Deseable, 6 = Experto Excluyente',
    PRIMARY KEY (`id`),
    KEY `fk_sotudescon_soltud_idx` (`id_solicitud`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla que relaciona cada solicitud con los conocimientos necesarios para la tarea';

CREATE TABLE IF NOT EXISTS `solicitudes_otros_requisitos` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `id_solicitudes` int(11) unsigned NOT NULL COMMENT 'id de la solicitud referenciada',
    `descripcion` varchar(200) NOT NULL COMMENT 'Conocimiento necesario para el puesto',
    `nivel_coicidencia` tinyint(3) DEFAULT NULL COMMENT 'Que tanto cumple el Postulante con las expectativas de la Solicitud,  de 1 a 5   1 = apenas cumple, 5 = cumple totalmente',
    PRIMARY KEY (`id`),
    KEY `fk_soltudotro_solitud_idx` (`id_solicitudes`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cconocimiento o requisitos adicionales, uno por registro';

CREATE TABLE IF NOT EXISTS `solicitudes_postulantes` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `id_solicitud` int(11) unsigned NOT NULL COMMENT 'id de la solicitud\\\\n',
    `id_postulante` int(11) unsigned NOT NULL COMMENT 'id del postulante sugerido',
    `fecha_sugerencia` date NOT NULL COMMENT 'Fecha en la que se registró la sugerencia\n',
    `estado_solicitante` tinyint(3) unsigned NOT NULL COMMENT '1 = Sugerido, 2 = Aceptado, 3 Rechazado',
    `fecha_respuesta_solicitante` date DEFAULT NULL COMMENT 'Fecha en la que se registró la respuesta del Solicitante',
    `estado_postulante` tinyint(3) unsigned NOT NULL COMMENT '1 = Sugerido (por RRHH), 2 = Aceptado (por solicitante) , 3 = Rechazado (por solicitante)',
    `fecha_resp_postulante` date DEFAULT NULL COMMENT 'Fecha en la que se registró la respuesta del P\nostulante',
    PRIMARY KEY (`id`),
    KEY `fk_solitpos_solitud_idx` (`id_solicitud`),
    KEY `fk_solitpos_post_idx` (`id_postulante`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Postulantes propuestos para cada solicitud';

CREATE TABLE IF NOT EXISTS `usuarios` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del usuario',
    `tipo_usuario` tinyint(3) NOT NULL COMMENT 'Si el usuario es un postulante =1 , o es un solicitante = 2 , o es Administrativo = 3',
    `nombre_completo` varchar(50) NOT NULL COMMENT 'Nombres y apellidos del usuario',
    `username` char(20) UNIQUE NOT NULL COMMENT 'Alias con el que ingresa al sistema',
    `password` varchar(35) NOT NULL COMMENT 'Clave necesaria para ingresar al sistema',
    `fecha_alta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se dió de alta el usuario',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Usuarios que pueden ingresar al sistema.  Postulantes, Solicitantes y Administradores';

CREATE TABLE IF NOT EXISTS `solicitudes_idiomas` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `id_solicitudes` int(11) unsigned NOT NULL COMMENT 'Solicitud referenciada',
    `id_idiomas` tinyint(3) unsigned DEFAULT NULL,
    `id_nivel_idioma` tinyint(3) unsigned DEFAULT NULL COMMENT '0 = mínimo, 1 = solo lee , 2 = solo lee y escribe, 3 = lee escribe y habla regular, 4 domina el idioma ',
    PRIMARY KEY (`id`),
    KEY `fk_solidiom_soltud_idx` (`id_solicitudes`),
    KEY `fk_soltudidiom_idioma_idx` (`id_idiomas`),
    KEY `fk_soltudnividiom_nivIdioma_idx` (`id_nivel_idioma`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica cada idioma con su nivel de conocimiento necesario para el puesto solicitado';

ALTER TABLE `administrativos`
    ADD CONSTRAINT `fk_usuario_adm` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `postulantes`
    ADD CONSTRAINT `fk_poscp_codpost` FOREIGN KEY (`codigo_postal`) REFERENCES `codigos_postales` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_post_instacad` FOREIGN KEY (`id_instituciones_academicas`) REFERENCES `instituciones_academicas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_post_nivest` FOREIGN KEY (`id_nivel_estudio`) REFERENCES `nivel_estudio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_usuario_post` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `postulantes_entrevista`
    ADD CONSTRAINT `fk_posentr_post` FOREIGN KEY (`id_postulantes`) REFERENCES `postulantes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `postulantes_estudios`
    ADD CONSTRAINT `fk_posest_post` FOREIGN KEY (`id_postulantes`) REFERENCES `postulantes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `postulantes_experiencias`
    ADD CONSTRAINT `fk_posex_post` FOREIGN KEY (`id_postulante`) REFERENCES `postulantes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `postulantes_idiomas`
    ADD CONSTRAINT `fk_posidiom_soltud` FOREIGN KEY (`id_postulantes`) REFERENCES `postulantes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_postudidiom_idioma` FOREIGN KEY (`id_idiomas`) REFERENCES `idiomas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_postudnividiom_nivIdioma` FOREIGN KEY (`id_nivel_idioma`) REFERENCES `nivel_idiomas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `solicitantes`
    ADD CONSTRAINT `fk_solttecp_codpos` FOREIGN KEY (`codigo_postal`) REFERENCES `codigos_postales` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_usuario_sol` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `solicitudes`
    ADD CONSTRAINT `fk_sotud_solttes` FOREIGN KEY (`id_solicitantes`) REFERENCES `solicitantes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_stud_nivestud` FOREIGN KEY (`id_nivel_estudio`) REFERENCES `nivel_estudio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `solicitudes_conocimientos`
    ADD CONSTRAINT `fk_sotudescon_soltud` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitudes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `solicitudes_otros_requisitos`
    ADD CONSTRAINT `fk_soltudotro_solitud` FOREIGN KEY (`id_solicitudes`) REFERENCES `solicitudes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `solicitudes_postulantes`
    ADD CONSTRAINT `fk_solitpos_post` FOREIGN KEY (`id_postulante`) REFERENCES `postulantes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_solitpos_solitud` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitudes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `solicitudes_idiomas`
    ADD CONSTRAINT `fk_solidiom_soltud` FOREIGN KEY (`id_solicitudes`) REFERENCES `solicitudes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_soltudidiom_idioma` FOREIGN KEY (`id_idiomas`) REFERENCES `idiomas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_soltudnividiom_nivIdioma` FOREIGN KEY (`id_nivel_idioma`) REFERENCES `nivel_idiomas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
