SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `sacd` ;
CREATE SCHEMA IF NOT EXISTS `sacd` DEFAULT CHARACTER SET utf8 COLLATE utf8_swedish_ci ;
USE `sacd` ;

-- -----------------------------------------------------
-- Table `sacd`.`enderecos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sacd`.`enderecos` ;

CREATE  TABLE IF NOT EXISTS `sacd`.`enderecos` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `bairro` VARCHAR(100) NOT NULL ,
  `cidade` VARCHAR(100) NOT NULL ,
  `uf` VARCHAR(2) NOT NULL ,
  `numero` INT(11)  NOT NULL ,
  `complemento` VARCHAR(100) NOT NULL ,
  `cep` VARCHAR(15) NULL ,
  `logradouro` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `sacd`.`origem_conversao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sacd`.`origem_conversao` ;

CREATE  TABLE IF NOT EXISTS `sacd`.`origem_conversao` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(100) NOT NULL ,
  `nome_igreja` VARCHAR(100) NULL DEFAULT NULL ,
  `data_conversao` DATE NULL ,
  `ano` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `sacd`.`membros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sacd`.`membros` ;

CREATE  TABLE IF NOT EXISTS `sacd`.`membros` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(55) NOT NULL ,
  `data_nascimento` DATE NOT NULL ,
  `data_conversao` DATE NULL DEFAULT NULL ,
  `fone_cel` VARCHAR(15) NOT NULL ,
  `fone_resid` VARCHAR(15) NULL DEFAULT NULL ,
  `estado_civil` ENUM('solteiro(a)','casado(a)','união estável','separado','divorciado','outros') NOT NULL ,
  `enderecos_id` BIGINT(20) NOT NULL ,
  `origem_conversao_id` BIGINT(20) NOT NULL ,
  `batizado` VARCHAR(10) NOT NULL ,
  `data_batismo` DATE NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_membros_enderecos` (`enderecos_id` ASC) ,
  INDEX `fk_membros_origem_conversao` (`origem_conversao_id` ASC) ,
  CONSTRAINT `fk_membros_enderecos`
    FOREIGN KEY (`enderecos_id` )
    REFERENCES `sacd`.`enderecos` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_membros_origem_conversao1`
    FOREIGN KEY (`origem_conversao_id` )
    REFERENCES `sacd`.`origem_conversao` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `sacd`.`dependentes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sacd`.`dependentes` ;

CREATE  TABLE IF NOT EXISTS `sacd`.`dependentes` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(55) NOT NULL ,
  `data_nascimento` DATE NOT NULL ,
  `membros_id` BIGINT(20) NOT NULL ,
  `sexo` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_dependentes_membros` (`membros_id` ASC) ,
  CONSTRAINT `fk_dependentes_membros`
    FOREIGN KEY (`membros_id` )
    REFERENCES `sacd`.`membros` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `sacd`.`exerceu_ministerio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sacd`.`exerceu_ministerio` ;

CREATE  TABLE IF NOT EXISTS `sacd`.`exerceu_ministerio` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `exerceu_ministerio` VARCHAR(10) NOT NULL ,
  `quais_ministerios` VARCHAR(200) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `sacd`.`exerceu_ministerio_membros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sacd`.`exerceu_ministerio_membros` ;

CREATE  TABLE IF NOT EXISTS `sacd`.`exerceu_ministerio_membros` (
  `exerceu_ministerio_id` BIGINT(20) NOT NULL ,
  `membros_id` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`exerceu_ministerio_id`, `membros_id`) ,
  INDEX `fk_exerceu_ministerio_has_membros_membros` (`membros_id` ASC) ,
  INDEX `fk_exerceu_ministerio_has_membros_exerceu_ministerio` (`exerceu_ministerio_id` ASC) ,
  CONSTRAINT `fk_exerceu_ministerio_has_membros_exerceu_ministerio`
    FOREIGN KEY (`exerceu_ministerio_id` )
    REFERENCES `sacd`.`exerceu_ministerio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exerceu_ministerio_has_membros_membros`
    FOREIGN KEY (`membros_id` )
    REFERENCES `sacd`.`membros` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `sacd`.`perfis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sacd`.`perfis` ;

CREATE  TABLE IF NOT EXISTS `sacd`.`perfis` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `tipo` VARCHAR(55) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `sacd`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sacd`.`usuarios` ;

CREATE  TABLE IF NOT EXISTS `sacd`.`usuarios` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `login` VARCHAR(45) NOT NULL ,
  `senha` VARCHAR(45) NOT NULL ,
  `ultimo_login` DATE NULL DEFAULT NULL ,
  `perfis_id` BIGINT(20) NOT NULL ,
  `membros_id` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) ,
  INDEX `fk_usuarios_perfis` (`perfis_id` ASC) ,
  INDEX `fk_usuarios_membros` (`membros_id` ASC) ,
  CONSTRAINT `fk_usuarios_membros`
    FOREIGN KEY (`membros_id` )
    REFERENCES `sacd`.`membros` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_perfis`
    FOREIGN KEY (`perfis_id` )
    REFERENCES `sacd`.`perfis` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
