-- Adminer 4.8.1 MySQL 8.0.30 dump

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Alumno` (`Legajo`, `IdPersona`) VALUES
(1,	2),
(2,	4);

CREATE TABLE `Anuncio` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) NOT NULL COMMENT 'Descripción resumida del puesto a cubrir',
  `descripcion` varchar(300) NOT NULL COMMENT 'Breve descripción de las tareas a complir',
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se da el alta al anuncio',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Aula` (
  `CodAula` int NOT NULL AUTO_INCREMENT,
  `capacidad` int DEFAULT NULL,
  PRIMARY KEY (`CodAula`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Aula` (`CodAula`, `capacidad`) VALUES
(1,	10);

CREATE TABLE `Curso` (
  `CodCurso` int NOT NULL AUTO_INCREMENT,
  `comision` varchar(10) DEFAULT NULL,
  `CodAula` int DEFAULT NULL,
  `CodIdioma` int DEFAULT NULL,
  `CodDocente` int DEFAULT NULL,
  `CodNivel` int DEFAULT NULL,
  PRIMARY KEY (`CodCurso`),
  KEY `AulaCurso` (`CodAula`),
  KEY `DocenteCurso` (`CodDocente`),
  KEY `IdiomaCurso` (`CodIdioma`),
  KEY `Nivel_IdiomaCurso` (`CodNivel`),
  CONSTRAINT `AulaCurso` FOREIGN KEY (`CodAula`) REFERENCES `Aula` (`CodAula`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `DocenteCurso` FOREIGN KEY (`CodDocente`) REFERENCES `Docente` (`CodDocente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `IdiomaCurso` FOREIGN KEY (`CodIdioma`) REFERENCES `Idioma` (`CodIdioma`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Nivel_IdiomaCurso` FOREIGN KEY (`CodNivel`) REFERENCES `Nivel_Idioma` (`Cod_Nivel`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Curso` (`CodCurso`, `comision`, `CodAula`, `CodIdioma`, `CodDocente`, `CodNivel`) VALUES
(1,	'A-TN',	1,	1,	1,	2),
(2,	'B-TM',	1,	1,	1,	1);

CREATE TABLE `Docente` (
  `CodDocente` int NOT NULL AUTO_INCREMENT,
  `IdPersona` int NOT NULL,
  PRIMARY KEY (`CodDocente`),
  UNIQUE KEY `IdPerona` (`IdPersona`),
  CONSTRAINT `PersonaDocente` FOREIGN KEY (`IdPersona`) REFERENCES `Persona` (`IdPersona`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Docente` (`CodDocente`, `IdPersona`) VALUES
(1,	1);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Horario` (`IdHorario`, `anio`, `periodo`, `turno`, `dia`, `hora_inicio`, `horas_catedra`, `CodCurso`) VALUES
(1,	2022,	NULL,	'Noche',	NULL,	NULL,	NULL,	1),
(3,	2021,	NULL,	'Mañana',	NULL,	NULL,	NULL,	2);

CREATE TABLE `Idioma` (
  `CodIdioma` int NOT NULL AUTO_INCREMENT,
  `idioma` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CodIdioma`),
  KEY `idioma` (`idioma`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Idioma` (`CodIdioma`, `idioma`) VALUES
(1,	'Inglés');

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
  `fecha` date DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `CodCurso` int DEFAULT NULL,
  `Legajo` int DEFAULT NULL,
  PRIMARY KEY (`IdMatricula`),
  KEY `AlumnoMatricula` (`Legajo`),
  KEY `CursoMatricula` (`CodCurso`),
  CONSTRAINT `AlumnoMatricula` FOREIGN KEY (`Legajo`) REFERENCES `Alumno` (`Legajo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `CursoMatricula` FOREIGN KEY (`CodCurso`) REFERENCES `Curso` (`CodCurso`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Matricula` (`IdMatricula`, `fecha`, `estado`, `CodCurso`, `Legajo`) VALUES
(1,	'2022-09-30',	'ACTIVO',	1,	1),
(2,	'2021-03-12',	'ACTIVO',	2,	2);

CREATE TABLE `Nivel_Idioma` (
  `Cod_Nivel` int NOT NULL AUTO_INCREMENT,
  `nivel` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Cod_Nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Nivel_Idioma` (`Cod_Nivel`, `nivel`) VALUES
(1,	'A1'),
(2,	'A2');

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
  UNIQUE KEY `IdPersona` (`IdPersona`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Persona` (`IdPersona`, `documento`, `tipo_documento`, `nombre`, `apellido`, `sexo`, `fecha_nac`, `email`, `calle`, `numero`, `departamento`, `localidad`, `provincia`, `pais`) VALUES
(1,	NULL,	NULL,	'Nahuel',	'Tarello',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	NULL,	NULL,	'Danlois',	'Tovar',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	NULL,	NULL,	'Sergio',	'Suarez',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	NULL,	NULL,	'Ulices',	'Lopez',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

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
  `contrasenia` varchar(100) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `vencimiento` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `es_admin` tinyint NOT NULL,
  `IdPersona` int NOT NULL,
  PRIMARY KEY (`IdUsuario`),
  UNIQUE KEY `PersonaUsuario` (`IdPersona`),
  UNIQUE KEY `IdPersona` (`IdPersona`) USING BTREE,
  CONSTRAINT `Usuario_ibfk_1` FOREIGN KEY (`IdPersona`) REFERENCES `Persona` (`IdPersona`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Usuario` (`IdUsuario`, `contrasenia`, `fecha_creacion`, `vencimiento`, `estado`, `es_admin`, `IdPersona`) VALUES
(2,	'admin',	NULL,	NULL,	NULL,	2,	1),
(3,	NULL,	NULL,	NULL,	NULL,	3,	2),
(4,	NULL,	NULL,	NULL,	NULL,	1,	3),
(5,	NULL,	'2022-09-30',	NULL,	NULL,	3,	4);

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
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del usuario',
  `tipo_usuario` tinyint NOT NULL COMMENT 'Si el usuario es un postulante =1 , o es un solicitante = 2 , o es Administrativo = 3',
  `nombre_completo` varchar(50) NOT NULL COMMENT 'Nombres y apellidos del usuario',
  `username` char(20) NOT NULL COMMENT 'Alias con el que ingresa al sistema',
  `password` varchar(35) NOT NULL COMMENT 'Clave necesaria para ingresar al sistema',
  `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se da el alta al usuario',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 2022-10-01 06:07:44

SET foreign_key_checks = 1;
