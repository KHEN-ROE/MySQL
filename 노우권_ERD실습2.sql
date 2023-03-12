-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db0309_1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db0309_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db0309_1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db0309_1` ;

-- -----------------------------------------------------
-- Table `db0309_1`.`전공정보`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db0309_1`.`전공정보` (
  `전공코드` INT NOT NULL,
  `전공명` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`전공코드`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db0309_1`.`학생정보`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db0309_1`.`학생정보` (
  `학번` INT NOT NULL,
  `이름` VARCHAR(45) NOT NULL,
  `전공코드` VARCHAR(45) NOT NULL,
  `전공정보_전공코드` INT NOT NULL,
  PRIMARY KEY (`학번`, `전공정보_전공코드`),
  INDEX `fk_학생정보_전공정보_idx` (`전공정보_전공코드` ASC) VISIBLE,
  CONSTRAINT `fk_학생정보_전공정보`
    FOREIGN KEY (`전공정보_전공코드`)
    REFERENCES `db0309_1`.`전공정보` (`전공코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db0309_1`.`수강내역`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db0309_1`.`수강내역` (
  `학번` INT NOT NULL,
  `과목코드` INT NOT NULL,
  `학생정보_학번` INT NOT NULL,
  `학생정보_전공정보_전공코드` INT NOT NULL,
  PRIMARY KEY (`학생정보_학번`, `학생정보_전공정보_전공코드`),
  CONSTRAINT `fk_수강내역_학생정보1`
    FOREIGN KEY (`학생정보_학번` , `학생정보_전공정보_전공코드`)
    REFERENCES `db0309_1`.`학생정보` (`학번` , `전공정보_전공코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db0309_1`.`수강과목`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db0309_1`.`수강과목` (
  `과목코드` INT NOT NULL,
  `과목명` VARCHAR(45) NOT NULL,
  `학점` INT NOT NULL,
  `수강내역_학생정보_학번` INT NOT NULL,
  `수강내역_학생정보_전공정보_전공코드` INT NOT NULL,
  PRIMARY KEY (`과목코드`, `수강내역_학생정보_학번`, `수강내역_학생정보_전공정보_전공코드`),
  INDEX `fk_수강과목_수강내역1_idx` (`수강내역_학생정보_학번` ASC, `수강내역_학생정보_전공정보_전공코드` ASC) VISIBLE,
  CONSTRAINT `fk_수강과목_수강내역1`
    FOREIGN KEY (`수강내역_학생정보_학번` , `수강내역_학생정보_전공정보_전공코드`)
    REFERENCES `db0309_1`.`수강내역` (`학생정보_학번` , `학생정보_전공정보_전공코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
