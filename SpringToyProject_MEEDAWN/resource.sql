-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema meedawn
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema meedawn
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `meedawn` DEFAULT CHARACTER SET utf8 ;
USE `meedawn` ;

-- -----------------------------------------------------
-- Table `meedawn`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meedawn`.`member` (
  `userid` VARCHAR(12) NOT NULL,
  `userpwd` VARCHAR(20) NULL DEFAULT NULL,
  `username` VARCHAR(10) NULL DEFAULT NULL,
  `gender` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `exp` FLOAT NULL DEFAULT NULL,
  `lv` INT NULL DEFAULT NULL,
  `joindate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`userid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `meedawn`.`board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meedawn`.`board` (
  `id` INT NOT NULL,
  `subject` VARCHAR(60) NULL DEFAULT NULL,
  `content` LONGTEXT NULL DEFAULT NULL,
  `like` INT NULL DEFAULT NULL,
  `member_userid` VARCHAR(12) NOT NULL,
  `create_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_board_member_idx` (`member_userid` ASC) VISIBLE,
  CONSTRAINT `fk_board_member`
    FOREIGN KEY (`member_userid`)
    REFERENCES `meedawn`.`member` (`userid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `meedawn`.`boardlike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meedawn`.`boardlike` (
  `member_userid` VARCHAR(12) NOT NULL,
  `username` VARCHAR(10) NOT NULL,
  `board_id` INT NOT NULL,
  INDEX `fk_boardlike_member1_idx` (`member_userid` ASC) VISIBLE,
  INDEX `fk_boardlike_board1_idx` (`board_id` ASC) VISIBLE,
  CONSTRAINT `fk_boardlike_board1`
    FOREIGN KEY (`board_id`)
    REFERENCES `meedawn`.`board` (`id`),
  CONSTRAINT `fk_boardlike_member1`
    FOREIGN KEY (`member_userid`)
    REFERENCES `meedawn`.`member` (`userid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `meedawn`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meedawn`.`comment` (
  `board_id` INT NOT NULL,
  `id` INT NOT NULL,
  `comment_date` DATETIME NULL DEFAULT NULL,
  `member_userid` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_board1_idx` (`board_id` ASC) VISIBLE,
  INDEX `fk_comment_member1_idx` (`member_userid` ASC) VISIBLE,
  CONSTRAINT `fk_comment_board1`
    FOREIGN KEY (`board_id`)
    REFERENCES `meedawn`.`board` (`id`),
  CONSTRAINT `fk_comment_member1`
    FOREIGN KEY (`member_userid`)
    REFERENCES `meedawn`.`member` (`userid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
