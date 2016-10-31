-- MySQL Script generated by MySQL Workbench
-- Sun 30 Oct 2016 16:24:19 EET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`role` (
  `id_role` INT NOT NULL AUTO_INCREMENT,
  `user_role` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `enable` TINYINT(1) NULL DEFAULT NULL,
  `created_date` VARCHAR(45) NULL DEFAULT NULL,
  `updated_date` VARCHAR(45) NULL DEFAULT NULL,
  `usercol` VARCHAR(45) NULL DEFAULT NULL,
  `id_role` INT NOT NULL,
  PRIMARY KEY (`id_user`, `id_role`),
  INDEX `fk_user_role_idx` (`id_role` ASC),
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`id_role`)
    REFERENCES `mydb`.`role` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`event` (
  `id_event` INT NOT NULL AUTO_INCREMENT,
  `party_name` VARCHAR(45) NULL DEFAULT NULL,
  `date` VARCHAR(45) NULL DEFAULT NULL,
  `time` VARCHAR(45) NULL DEFAULT NULL,
  `location` VARCHAR(45) NULL DEFAULT NULL,
  `party_capacity` VARCHAR(45) NULL DEFAULT NULL,
  `club_capacity` VARCHAR(45) NULL DEFAULT NULL,
  `fact_table_amount` VARCHAR(45) NULL DEFAULT NULL,
  `booked_table_amount` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_event`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_has_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_has_event` (
  `user_id_user` INT NOT NULL,
  `user_id_role` INT NOT NULL,
  `event_id_event` INT NOT NULL,
  PRIMARY KEY (`user_id_user`, `user_id_role`, `event_id_event`),
  INDEX `fk_user_has_event_event1_idx` (`event_id_event` ASC),
  INDEX `fk_user_has_event_user1_idx` (`user_id_user` ASC, `user_id_role` ASC),
  CONSTRAINT `fk_user_has_event_user1`
    FOREIGN KEY (`user_id_user` , `user_id_role`)
    REFERENCES `mydb`.`user` (`id_user` , `id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_event_event1`
    FOREIGN KEY (`event_id_event`)
    REFERENCES `mydb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table_type` (
  `id_table_type` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_table_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table` (
  `id_table` INT NOT NULL AUTO_INCREMENT,
  `price` VARCHAR(45) NULL DEFAULT NULL,
  `id_table_type` INT NOT NULL,
  PRIMARY KEY (`id_table`, `id_table_type`),
  INDEX `fk_table_table_type1_idx` (`id_table_type` ASC),
  CONSTRAINT `fk_table_table_type1`
    FOREIGN KEY (`id_table_type`)
    REFERENCES `mydb`.`table_type` (`id_table_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bottle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bottle` (
  `id_bottle` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `prise` VARCHAR(45) NULL DEFAULT NULL,
  `created_date` VARCHAR(45) NULL DEFAULT NULL,
  `fact_amount` VARCHAR(45) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `booked_amount` VARCHAR(45) NULL DEFAULT NULL,
  `id_event` INT NOT NULL,
  `id_table` INT NOT NULL,
  PRIMARY KEY (`id_bottle`, `id_event`, `id_table`),
  INDEX `fk_bottle_event1_idx` (`id_event` ASC),
  INDEX `fk_bottle_table1_idx` (`id_table` ASC),
  CONSTRAINT `fk_bottle_event1`
    FOREIGN KEY (`id_event`)
    REFERENCES `mydb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bottle_table1`
    FOREIGN KEY (`id_table`)
    REFERENCES `mydb`.`table` (`id_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ticket` (
  `id_ticket` INT NOT NULL AUTO_INCREMENT,
  `fact_amount` VARCHAR(45) NULL DEFAULT NULL,
  `price` VARCHAR(45) NULL DEFAULT NULL,
  `created_date` VARCHAR(45) NULL DEFAULT NULL,
  `id_event` INT NOT NULL,
  `booked_amount` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ticket`, `id_event`),
  INDEX `fk_ticket_event1_idx` (`id_event` ASC),
  CONSTRAINT `fk_ticket_event1`
    FOREIGN KEY (`id_event`)
    REFERENCES `mydb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`photo` (
  `id_photo` INT NOT NULL AUTO_INCREMENT,
  `photo` VARCHAR(45) NULL,
  `id_event` INT NOT NULL,
  PRIMARY KEY (`id_photo`, `id_event`),
  INDEX `fk_photo_event1_idx` (`id_event` ASC),
  CONSTRAINT `fk_photo_event1`
    FOREIGN KEY (`id_event`)
    REFERENCES `mydb`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
