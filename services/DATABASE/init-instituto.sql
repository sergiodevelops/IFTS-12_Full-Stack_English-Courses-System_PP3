-- Adminer 4.8.1 MySQL 8.0.31 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `InstitutoIdiomas`;
CREATE DATABASE `InstitutoIdiomas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `InstitutoIdiomas`;

CREATE TABLE `Alumno` (
  `Legajo` int NOT NULL AUTO_INCREMENT,
  `IdPersona` int NOT NULL,
  PRIMARY KEY (`Legajo`),
  UNIQUE KEY `IdPersona` (`IdPersona`),
  CONSTRAINT `PersonaAlumno` FOREIGN KEY (`IdPersona`) REFERENCES `Persona` (`IdPersona`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Anuncio` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) NOT NULL COMMENT 'DescripciÃ³n resumida del puesto a cubrir',
  `descripcion` varchar(300) NOT NULL COMMENT 'Breve descripciÃ³n de las tareas a complir',
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se da el alta al anuncio',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Aula` (
  `CodAula` int NOT NULL AUTO_INCREMENT,
  `capacidad` int DEFAULT NULL,
  PRIMARY KEY (`CodAula`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Aula` (`CodAula`, `capacidad`) VALUES
(1,	30),
(2,	20),
(3,	20),
(4,	30);

CREATE TABLE `Curso` (
  `CodCurso` int NOT NULL AUTO_INCREMENT,
  `comision` varchar(10) DEFAULT NULL,
  `CodAula` int DEFAULT NULL,
  `CodIdioma` int NOT NULL DEFAULT '1',
  `CodDocente` int unsigned DEFAULT NULL,
  `CodNivel` int DEFAULT NULL,
  PRIMARY KEY (`CodCurso`),
  UNIQUE KEY `Nivel_comision` (`CodNivel`,`comision`),
  KEY `AulaCurso` (`CodAula`),
  KEY `DocenteCurso` (`CodDocente`),
  KEY `IdiomaCurso` (`CodIdioma`),
  CONSTRAINT `AulaCurso` FOREIGN KEY (`CodAula`) REFERENCES `Aula` (`CodAula`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `DocenteCurso` FOREIGN KEY (`CodDocente`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `IdiomaCurso` FOREIGN KEY (`CodIdioma`) REFERENCES `Idioma` (`CodIdioma`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Curso` (`CodCurso`, `comision`, `CodAula`, `CodIdioma`, `CodDocente`, `CodNivel`) VALUES
(1,	'A',	1,	1,	2,	1),
(3,	'A',	2,	1,	3,	2),
(6,	'B',	4,	1,	4,	1);

CREATE TABLE `Docente` (
  `CodDocente` int NOT NULL AUTO_INCREMENT,
  `IdPersona` int NOT NULL,
  PRIMARY KEY (`CodDocente`),
  UNIQUE KEY `IdPerona` (`IdPersona`),
  CONSTRAINT `PersonaDocente` FOREIGN KEY (`IdPersona`) REFERENCES `Persona` (`IdPersona`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Empleado` (
  `CodEmpleado` int NOT NULL AUTO_INCREMENT,
  `fecha_ingreso` date DEFAULT NULL,
  `fecha_egreso` date DEFAULT NULL,
  `cargo` varchar(30) DEFAULT NULL,
  `sueldo` int DEFAULT NULL,
  `jefe` int DEFAULT NULL,
  `IdPersona` int DEFAULT NULL,
  PRIMARY KEY (`CodEmpleado`),
  UNIQUE KEY `IdPersona` (`IdPersona`),
  KEY `jefe` (`jefe`),
  CONSTRAINT `PersonaEmpleado` FOREIGN KEY (`IdPersona`) REFERENCES `Persona` (`IdPersona`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Horario` (
  `IdHorario` int NOT NULL AUTO_INCREMENT,
  `anio` int DEFAULT NULL,
  `periodo` varchar(20) DEFAULT NULL,
  `turno` varchar(10) DEFAULT NULL,
  `dia` varchar(10) DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `horas_catedra` int DEFAULT NULL,
  `CodCurso` int DEFAULT NULL,
  PRIMARY KEY (`IdHorario`),
  KEY `CursoHorario` (`CodCurso`),
  CONSTRAINT `CursoHorario` FOREIGN KEY (`CodCurso`) REFERENCES `Curso` (`CodCurso`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Idioma` (
  `CodIdioma` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CodIdioma`),
  KEY `idioma` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Idioma` (`CodIdioma`, `nombre`) VALUES
(1,	'INGLES');

CREATE TABLE `Idioma_Docente` (
  `CodIdioma` int NOT NULL,
  `CodDocente` int NOT NULL,
  PRIMARY KEY (`CodIdioma`,`CodDocente`),
  KEY `DocenteIdioma_Docente` (`CodDocente`),
  CONSTRAINT `DocenteIdioma_Docente` FOREIGN KEY (`CodDocente`) REFERENCES `Docente` (`CodDocente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `IdiomaIdioma_Docente` FOREIGN KEY (`CodIdioma`) REFERENCES `Idioma` (`CodIdioma`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Matricula` (
  `IdMatricula` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT (curdate()),
  `estado` varchar(30) DEFAULT 'ACTIVO',
  `CodCurso` int DEFAULT NULL,
  `Legajo` int unsigned DEFAULT NULL,
  PRIMARY KEY (`IdMatricula`),
  UNIQUE KEY `Curso_Legajo` (`CodCurso`,`Legajo`),
  KEY `AlumnoMatricula` (`Legajo`),
  CONSTRAINT `AlumnoMatricula` FOREIGN KEY (`Legajo`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `CursoMatricula` FOREIGN KEY (`CodCurso`) REFERENCES `Curso` (`CodCurso`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Matricula` (`IdMatricula`, `fecha`, `estado`, `CodCurso`, `Legajo`) VALUES
(1,	'2022-11-22',	'ACTIVO',	1,	5),
(2,	'2022-11-22',	'BAJA',	1,	6),
(3,	'2022-11-22',	'ACTIVO',	1,	7),
(5,	'2022-11-22',	'ACTIVO',	3,	8),
(6,	'2022-11-22',	'ACTIVO',	6,	9),
(7,	'2022-11-22',	'ACTIVO',	6,	10),
(8,	'2022-11-22',	'ACTIVO',	6,	11),
(9,	'2022-11-22',	'ACTIVO',	6,	13);

CREATE TABLE `Notas` (
  `IdNota` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(20) DEFAULT NULL,
  `detalle` varchar(30) DEFAULT NULL,
  `calificacion` int DEFAULT NULL,
  `CodCurso` int DEFAULT NULL,
  `Legajo` int DEFAULT NULL,
  PRIMARY KEY (`IdNota`),
  KEY `AlumnoNotas` (`Legajo`),
  KEY `CursoNotas` (`CodCurso`),
  CONSTRAINT `AlumnoNotas` FOREIGN KEY (`Legajo`) REFERENCES `Alumno` (`Legajo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `CursoNotas` FOREIGN KEY (`CodCurso`) REFERENCES `Curso` (`CodCurso`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Perfil` (
  `IdPerfil` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`IdPerfil`),
  KEY `IdPerfil` (`IdPerfil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Perfil_Permiso` (
  `IdPerfil` int NOT NULL,
  `IdPermiso` int NOT NULL,
  PRIMARY KEY (`IdPerfil`,`IdPermiso`),
  KEY `PermisoPerfil_Permiso` (`IdPermiso`),
  CONSTRAINT `PerfilPerfil_Permiso` FOREIGN KEY (`IdPerfil`) REFERENCES `Perfil` (`IdPerfil`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PermisoPerfil_Permiso` FOREIGN KEY (`IdPermiso`) REFERENCES `Permiso` (`IdPermiso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Permiso` (
  `IdPermiso` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`IdPermiso`),
  KEY `IdPermiso` (`IdPermiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Persona` (
  `IdPersona` int NOT NULL AUTO_INCREMENT,
  `documento` varchar(20) DEFAULT NULL,
  `tipo_documento` varchar(30) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `sexo` varchar(20) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `calle` varchar(100) DEFAULT NULL,
  `numero` int DEFAULT NULL,
  `departamento` varchar(10) DEFAULT NULL,
  `localidad` varchar(100) DEFAULT NULL,
  `provincia` varchar(100) DEFAULT NULL,
  `pais` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IdPersona`),
  UNIQUE KEY `IdPersona` (`IdPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Telefonos` (
  `IdTelefono` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(40) DEFAULT NULL,
  `cod_pais` int DEFAULT NULL,
  `cod_local` int DEFAULT NULL,
  `numero` int DEFAULT NULL,
  `IdPersona` int DEFAULT NULL,
  PRIMARY KEY (`IdTelefono`),
  KEY `PersonaTelefonos` (`IdPersona`),
  CONSTRAINT `PersonaTelefonos` FOREIGN KEY (`IdPersona`) REFERENCES `Persona` (`IdPersona`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Usuario` (
  `IdUsuario` int NOT NULL AUTO_INCREMENT,
  `password` varchar(100) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `vencimiento` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `es_admin` tinyint(1) NOT NULL,
  `IdPersona` int NOT NULL,
  PRIMARY KEY (`IdUsuario`),
  UNIQUE KEY `IdPersona` (`IdPersona`),
  CONSTRAINT `PersonaUsuario` FOREIGN KEY (`IdPersona`) REFERENCES `Persona` (`IdPersona`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Usuario_Perfil` (
  `IdUsuario` int NOT NULL,
  `IdPerfil` int NOT NULL,
  PRIMARY KEY (`IdUsuario`,`IdPerfil`),
  KEY `PerfilUsuario_Perfil` (`IdPerfil`),
  CONSTRAINT `PerfilUsuario_Perfil` FOREIGN KEY (`IdPerfil`) REFERENCES `Perfil` (`IdPerfil`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UsuarioUsuario_Perfil` FOREIGN KEY (`IdUsuario`) REFERENCES `Usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Usuario_Permiso` (
  `IdUsuario` int NOT NULL,
  `IdPermiso` int NOT NULL,
  PRIMARY KEY (`IdUsuario`,`IdPermiso`),
  KEY `PermisoUsuario_Permiso` (`IdPermiso`),
  CONSTRAINT `PermisoUsuario_Permiso` FOREIGN KEY (`IdPermiso`) REFERENCES `Permiso` (`IdPermiso`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UsuarioUsuario_Permiso` FOREIGN KEY (`IdUsuario`) REFERENCES `Usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `usuarios` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador Ãºnico del usuario',
  `tipo_usuario` tinyint NOT NULL COMMENT 'Si el usuario es un postulante =1 , o es un solicitante = 2 , o es Administrativo = 3',
  `nombre_completo` varchar(50) NOT NULL COMMENT 'Nombres y apellidos del usuario',
  `username` char(20) NOT NULL COMMENT 'Alias con el que ingresa al sistema',
  `password` varchar(35) NOT NULL COMMENT 'Clave necesaria para ingresar al sistema',
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se da el alta al usuario',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `usuarios` (`id`, `tipo_usuario`, `nombre_completo`, `username`, `password`, `fecha_alta`) VALUES
(1,	2,	'Juan Pérez',	'jperez',	'jperez',	'2022-11-22 00:19:14'),
(2,	2,	'María Fernanda Fofa',	'mf_fofa',	'mf_fofa',	'2022-11-22 00:21:04'),
(3,	2,	'Enrique Noguera',	'enoguera',	'enoguera',	'2022-11-22 00:22:30'),
(4,	2,	'Florencia Moyano',	'fmoyano',	'fmoyano',	'2022-11-22 00:23:06'),
(5,	3,	'Danlois Tovar',	'dtovar',	'dtovar',	'2022-11-22 00:37:46'),
(6,	3,	'Sergio Juárez',	'sjuarez',	'sjuarez',	'2022-11-22 00:38:39'),
(7,	3,	'Juan Pablo Alvarez',	'jp_alvarez',	'jp_alvarez',	'2022-11-22 00:40:32'),
(8,	3,	'Sebastián Vargas',	'svargas',	'svargas',	'2022-11-22 00:41:23'),
(9,	3,	'Uriel Carvallo',	'ucarvallo',	'ucarvallo',	'2022-11-22 00:41:54'),
(10,	3,	'Nahuel Tarello',	'ntarello',	'ntarello',	'2022-11-22 00:42:29'),
(11,	3,	'Sebastián Torres',	'storres',	'storres',	'2022-11-22 00:44:14'),
(13,	3,	'Lionel Messi',	'lmessi',	'lmessi',	'2022-11-22 00:44:38');

-- 2022-11-23 08:22:04
