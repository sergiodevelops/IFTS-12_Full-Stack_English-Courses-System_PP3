-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: InstitutoIdiomas
-- Source Schemata: InstitutoIdiomas
-- Created: Sun Nov  7 16:14:23 2021
-- Workbench Version: 8.0.27
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema InstitutoIdiomas
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `InstitutoIdiomas`;
CREATE SCHEMA IF NOT EXISTS `InstitutoIdiomas`;

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Nivel_Idioma
-- ----------------------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Nivel_Idioma`
-- (
--     `Cod_Nivel` INT(10)     NOT NULL AUTO_INCREMENT,
--     `nivel`     VARCHAR(30) NULL,
--     PRIMARY KEY (`Cod_Nivel`)
-- );

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Telefonos
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Telefonos`
(
    `IdTelefono` INT(10)     NOT NULL AUTO_INCREMENT,
    `tipo`       VARCHAR(40) NULL,
    `cod_pais`   INT(10)     NULL,
    `cod_local`  INT(10)     NULL,
    `numero`     INT(10)     NULL,
    `IdPersona`  INT(10)     NULL,
    PRIMARY KEY (`IdTelefono`),
    CONSTRAINT `PersonaTelefonos`
        FOREIGN KEY (`IdPersona`)
            REFERENCES `InstitutoIdiomas`.`Persona` (`IdPersona`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Perfil_Permiso
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Perfil_Permiso`
(
    `IdPerfil`  INT(10) NOT NULL,
    `IdPermiso` INT(10) NOT NULL,
    PRIMARY KEY (`IdPerfil`, `IdPermiso`),
    CONSTRAINT `PerfilPerfil_Permiso`
        FOREIGN KEY (`IdPerfil`)
            REFERENCES `InstitutoIdiomas`.`Perfil` (`IdPerfil`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `PermisoPerfil_Permiso`
        FOREIGN KEY (`IdPermiso`)
            REFERENCES `InstitutoIdiomas`.`Permiso` (`IdPermiso`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Persona
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Persona`
(
    `IdPersona`      INT(10)      NOT NULL AUTO_INCREMENT,
    `documento`      VARCHAR(20)  NULL,
    `tipo_documento` VARCHAR(30)  NULL,
    `nombre`         VARCHAR(100) NULL,
    `apellido`       VARCHAR(100) NULL,
    `sexo`           VARCHAR(20)  NULL,
    `fecha_nac`      DATE         NULL,
    `email`          VARCHAR(100) NULL,
    `calle`          VARCHAR(100) NULL,
    `numero`         INT(10)      NULL,
    `departamento`   VARCHAR(10)  NULL,
    `localidad`      VARCHAR(100) NULL,
    `provincia`      VARCHAR(100) NULL,
    `pais`           VARCHAR(100) NULL,
    PRIMARY KEY (`IdPersona`),
    UNIQUE INDEX `IdPersona` (`IdPersona` ASC) VISIBLE
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Perfil
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Perfil`
(
    `IdPerfil`    INT(10)      NOT NULL AUTO_INCREMENT,
    `nombre`      VARCHAR(30)  NULL,
    `descripcion` VARCHAR(100) NULL,
    `estado`      TINYINT(1)   NOT NULL,
    PRIMARY KEY (`IdPerfil`),
    INDEX `IdPerfil` (`IdPerfil` ASC) VISIBLE
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Idioma_Docente
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Idioma_Docente`
(
    `CodIdioma`  INT(10) NOT NULL,
    `CodDocente` INT(10) NOT NULL,
    PRIMARY KEY (`CodIdioma`, `CodDocente`),
    CONSTRAINT `DocenteIdioma_Docente`
        FOREIGN KEY (`CodDocente`)
            REFERENCES `InstitutoIdiomas`.`Docente` (`CodDocente`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `IdiomaIdioma_Docente`
        FOREIGN KEY (`CodIdioma`)
            REFERENCES `InstitutoIdiomas`.`Idioma` (`CodIdioma`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Permiso
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Permiso`
(
    `IdPermiso`   INT(10)      NOT NULL AUTO_INCREMENT,
    `nombre`      VARCHAR(50)  NULL,
    `descripcion` VARCHAR(100) NULL,
    `estado`      TINYINT(1)   NOT NULL,
    PRIMARY KEY (`IdPermiso`),
    INDEX `IdPermiso` (`IdPermiso` ASC) VISIBLE
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Notas
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Notas`
(
    `IdNota`       INT(10)     NOT NULL AUTO_INCREMENT,
    `tipo`         VARCHAR(20) NULL,
    `detalle`      VARCHAR(30) NULL,
    `calificacion` INT(3)      NULL,
    `CodCurso`     INT(10)     NULL,
    `Legajo`       INT(10)     NULL,
    PRIMARY KEY (`IdNota`),
    CONSTRAINT `AlumnoNotas`
        FOREIGN KEY (`Legajo`)
            REFERENCES `InstitutoIdiomas`.`Alumno` (`Legajo`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    CONSTRAINT `CursoNotas`
        FOREIGN KEY (`CodCurso`)
            REFERENCES `InstitutoIdiomas`.`Curso` (`CodCurso`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Usuario
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Usuario`
(
    `IdUsuario`      INT(10)      NOT NULL AUTO_INCREMENT,
    `contrasenia`    VARCHAR(100) NULL,
    `fecha_creacion` DATE         NULL,
    `vencimiento`    DATE         NULL,
    `estado`         TINYINT(1)   NULL,
    `es_admin`       TINYINT(1)   NOT NULL,
    `IdPersona`      INT(10)      NOT NULL,
    UNIQUE INDEX `IdPersona` (`IdPersona` ASC) VISIBLE,
    PRIMARY KEY (`IdUsuario`),
    CONSTRAINT `PersonaUsuario`
        FOREIGN KEY (`IdPersona`)
            REFERENCES `InstitutoIdiomas`.`Persona` (`IdPersona`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Curso
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Curso`
(
    `CodCurso`   INT(10)     NOT NULL AUTO_INCREMENT,
    `comision`   VARCHAR(10) NULL,
    `CodAula`    INT(10)     NULL,
    `CodIdioma`  INT(10)     NOT NULL DEFAULT 1,
    `CodDocente` INT(10)     UNSIGNED NULL,
    `CodNivel`   INT(10)     NULL,
    PRIMARY KEY (`CodCurso`),
    CONSTRAINT `AulaCurso`
        FOREIGN KEY (`CodAula`)
            REFERENCES `InstitutoIdiomas`.`Aula` (`CodAula`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    -- CONSTRAINT `DocenteCurso`
    --     FOREIGN KEY (`CodDocente`)
    --         REFERENCES `InstitutoIdiomas`.`Docente` (`CodDocente`)
    --         ON DELETE RESTRICT
    --         ON UPDATE RESTRICT,
    CONSTRAINT `DocenteCurso`
        FOREIGN KEY (`CodDocente`)
            REFERENCES `InstitutoIdiomas`.`usuarios` (`id`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    CONSTRAINT `IdiomaCurso`
        FOREIGN KEY (`CodIdioma`)
            REFERENCES `InstitutoIdiomas`.`Idioma` (`CodIdioma`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Usuario_Perfil
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Usuario_Perfil`
(
    `IdUsuario` INT(10) NOT NULL,
    `IdPerfil`  INT(10) NOT NULL,
    PRIMARY KEY (`IdUsuario`, `IdPerfil`),
    CONSTRAINT `PerfilUsuario_Perfil`
        FOREIGN KEY (`IdPerfil`)
            REFERENCES `InstitutoIdiomas`.`Perfil` (`IdPerfil`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `UsuarioUsuario_Perfil`
        FOREIGN KEY (`IdUsuario`)
            REFERENCES `InstitutoIdiomas`.`Usuario` (`IdUsuario`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Usuario_Permiso
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Usuario_Permiso`
(
    `IdUsuario` INT(10) NOT NULL,
    `IdPermiso` INT(10) NOT NULL,
    PRIMARY KEY (`IdUsuario`, `IdPermiso`),
    CONSTRAINT `PermisoUsuario_Permiso`
        FOREIGN KEY (`IdPermiso`)
            REFERENCES `InstitutoIdiomas`.`Permiso` (`IdPermiso`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `UsuarioUsuario_Permiso`
        FOREIGN KEY (`IdUsuario`)
            REFERENCES `InstitutoIdiomas`.`Usuario` (`IdUsuario`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Horario
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Horario`
(
    `IdHorario`     INT(10)     NOT NULL AUTO_INCREMENT,
    `anio`          INT(4)      NULL,
    `periodo`       VARCHAR(20) NULL,
    `turno`         VARCHAR(10) NULL,
    `dia`           VARCHAR(10) NULL,
    `hora_inicio`   TIME        NULL,
    `horas_catedra` INT(2)      NULL,
    `CodCurso`      INT(10)     NULL,
    PRIMARY KEY (`IdHorario`),
    CONSTRAINT `CursoHorario`
        FOREIGN KEY (`CodCurso`)
            REFERENCES `InstitutoIdiomas`.`Curso` (`CodCurso`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Aula
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Aula`
(
    `CodAula`   INT(10) NOT NULL AUTO_INCREMENT,
    `capacidad` INT(3)  NULL,
    PRIMARY KEY (`CodAula`)
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Matricula
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Matricula`
(
    `IdMatricula` INT(10)     NOT NULL AUTO_INCREMENT,
    `fecha`       date        DEFAULT (CURRENT_DATE),
    `estado`      varchar(30) default 'activo',
    `CodCurso`    INT(10)     NULL,
    `Legajo`      INT(10) UNSIGNED     NULL,
    PRIMARY KEY (`IdMatricula`),
    CONSTRAINT `AlumnoMatricula`
        FOREIGN KEY (`Legajo`)
            REFERENCES `InstitutoIdiomas`.`usuarios` (`id`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    CONSTRAINT `CursoMatricula`
        FOREIGN KEY (`CodCurso`)
            REFERENCES `InstitutoIdiomas`.`Curso` (`CodCurso`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Docente
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Docente`
(
    `CodDocente` INT(10) NOT NULL AUTO_INCREMENT,
    `IdPersona`  INT(10) NOT NULL,
    UNIQUE INDEX `IdPerona` (`IdPersona` ASC) VISIBLE,
    PRIMARY KEY (`CodDocente`),
    CONSTRAINT `PersonaDocente`
        FOREIGN KEY (`IdPersona`)
            REFERENCES `InstitutoIdiomas`.`Persona` (`IdPersona`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Alumno
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Alumno`
(
    `Legajo`    INT(10) NOT NULL AUTO_INCREMENT,
    `IdPersona` INT(10) NOT NULL,
    UNIQUE INDEX `IdPersona` (`IdPersona` ASC) VISIBLE,
    PRIMARY KEY (`Legajo`),
    CONSTRAINT `PersonaAlumno`
        FOREIGN KEY (`IdPersona`)
            REFERENCES `InstitutoIdiomas`.`Persona` (`IdPersona`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Idioma
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Idioma`
(
    `CodIdioma` INT(10)     NOT NULL AUTO_INCREMENT,
    `nombre`    VARCHAR(50) NULL,
    PRIMARY KEY (`CodIdioma`),
    INDEX `idioma` (`nombre` ASC) VISIBLE
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Empleado
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Empleado`
(
    `CodEmpleado`   INT(10)     NOT NULL AUTO_INCREMENT,
    `fecha_ingreso` DATE        NULL,
    `fecha_egreso`  DATE        NULL,
    `cargo`         VARCHAR(30) NULL,
    `sueldo`        INT(10)     NULL,
    `jefe`          INT(10)     NULL,
    `IdPersona`     INT(10)     NULL,
    UNIQUE INDEX `IdPersona` (`IdPersona` ASC) VISIBLE,
    PRIMARY KEY (`CodEmpleado`),
    INDEX `jefe` (`jefe` ASC) VISIBLE,
    CONSTRAINT `PersonaEmpleado`
        FOREIGN KEY (`IdPersona`)
            REFERENCES `InstitutoIdiomas`.`Persona` (`IdPersona`)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.usuarios
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`usuarios` (
                            `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del usuario',
                            `tipo_usuario` tinyint NOT NULL COMMENT 'Si el usuario es un postulante =1 , o es un solicitante = 2 , o es Administrativo = 3',
                            `nombre_completo` varchar(50) NOT NULL COMMENT 'Nombres y apellidos del usuario',
                            `username` char(20) NOT NULL COMMENT 'Alias con el que ingresa al sistema',
                            `password` varchar(35) NOT NULL COMMENT 'Clave necesaria para ingresar al sistema',
                            `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se da el alta al usuario',
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `username` (`username`)
);

-- ----------------------------------------------------------------------------
-- Table InstitutoIdiomas.Anuncio
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `InstitutoIdiomas`.`Anuncio` (
                           `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
                           `titulo` varchar(50) NOT NULL COMMENT 'Descripción resumida del puesto a cubrir',
                           `descripcion` varchar(300) NOT NULL COMMENT 'Breve descripción de las tareas a complir',
                           `fecha_alta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que se da el alta al anuncio',
                           PRIMARY KEY (`id`)
);

# ----------------------------------------------------
#  INSERTS
# ----------------------------------------------------
INSERT INTO `InstitutoIdiomas`.`Aula` (`CodAula`, `capacidad`) VALUES
                                                (1,	30),
                                                (2,	20),
                                                (3,	20),
                                                (4,	30)
ON DUPLICATE KEY UPDATE `CodAula` = VALUES(`CodAula`), `capacidad` = VALUES(`capacidad`);

# ----------------------------------------------------
INSERT INTO `InstitutoIdiomas`.`Idioma` (`CodIdioma`, `nombre`) VALUES
    (1,	'INGLES')
ON DUPLICATE KEY UPDATE `CodIdioma` = VALUES(`CodIdioma`), `nombre` = VALUES(`nombre`);

# ----------------------------------------------------
SET FOREIGN_KEY_CHECKS = 1;