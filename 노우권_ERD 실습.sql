-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db0309
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db0309
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db0309` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db0309` ;

-- -----------------------------------------------------
-- Table `db0309`.`상품`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db0309`.`상품` (
  `품명` INT NOT NULL,
  `규격` VARCHAR(45) NULL,
  `단가` VARCHAR(45) NULL,
  PRIMARY KEY (`품명`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db0309`.`견적상세`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db0309`.`견적상세` (
  `제품번호` INT NOT NULL,
  `수량` VARCHAR(45) NULL,
  `견적번호` VARCHAR(45) NULL,
  `품명` VARCHAR(45) NULL,
  `상품_품명` INT NOT NULL,
  PRIMARY KEY (`제품번호`, `상품.품명`),
  INDEX `fk_견적상세_상품1_idx` (`상품_품명` ASC),
  CONSTRAINT `fk_견적상세_상품1`
    FOREIGN KEY (`상품_품명`)
    REFERENCES `db0309`.`상품` (`품명`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db0309`.`견적서`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db0309`.`견적서` (
  `견적서번호` INT NOT NULL,
  `견적날짜` VARCHAR(45) NULL,
  `공급자번호` VARCHAR(45) NULL,
  `견적접수자` VARCHAR(45) NULL,
  `제품번호` VARCHAR(45) NULL,
  `공급가액` VARCHAR(45) NULL,
  `비고` VARCHAR(45) NULL,
  PRIMARY KEY (`견적서번호`),
  CONSTRAINT `fk_견적서_table41`
    FOREIGN KEY (`견적서번호`)
    REFERENCES `db0309`.`견적상세` (`견적번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db0309`.`공급자`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db0309`.`공급자` (
  `등록번호` INT NOT NULL,
  `상호` VARCHAR(45) NULL,
  `대표자성명` VARCHAR(45) NULL,
  `사업장주소` VARCHAR(45) NULL,
  `업태` VARCHAR(45) NULL,
  `종목` VARCHAR(45) NULL,
  `전화번호` VARCHAR(45) NULL,
  PRIMARY KEY (`등록번호`),
  CONSTRAINT `fk_공급자_견적서`
    FOREIGN KEY (`등록번호`)
    REFERENCES `db0309`.`견적서` (`공급자번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
