-- MySQL Script generated by MySQL Workbench
-- Mon May 29 19:44:19 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Destinations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Destinations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Description` VARCHAR(45) NULL,
  `Price` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Flights` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Airline` VARCHAR(45) NULL,
  `Departure_City` VARCHAR(45) NULL,
  `Arrival_City` VARCHAR(45) NULL,
  `Departure_Time` VARCHAR(45) NULL,
  `Arrival_Time` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payments` (
  `id` INT NOT NULL,
  `Payment_Method` VARCHAR(45) NULL,
  `Payment_Amount` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hotels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hotels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Hotel_Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Destinations_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Hotels_Destinations1_idx` (`Destinations_id` ASC) VISIBLE,
  UNIQUE INDEX `Destinations_id_UNIQUE` (`Destinations_id` ASC) VISIBLE,
  CONSTRAINT `fk_Hotels_Destinations1`
    FOREIGN KEY (`Destinations_id`)
    REFERENCES `mydb`.`Destinations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bookings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Booking_Date` VARCHAR(45) NOT NULL,
  `Total_Cost` VARCHAR(45) NULL,
  `Customers_id` INT NOT NULL,
  `Payments_id` INT NOT NULL,
  `Flights_id` INT NOT NULL,
  `Hotels_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Bookings_Customers1_idx` (`Customers_id` ASC) VISIBLE,
  UNIQUE INDEX `Customers_id_UNIQUE` (`Customers_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Bookings_Payments1_idx` (`Payments_id` ASC) VISIBLE,
  UNIQUE INDEX `Payments_id_UNIQUE` (`Payments_id` ASC) VISIBLE,
  INDEX `fk_Bookings_Flights1_idx` (`Flights_id` ASC) VISIBLE,
  INDEX `fk_Bookings_Hotels1_idx` (`Hotels_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customers1`
    FOREIGN KEY (`Customers_id`)
    REFERENCES `mydb`.`Customers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bookings_Payments1`
    FOREIGN KEY (`Payments_id`)
    REFERENCES `mydb`.`Payments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bookings_Flights1`
    FOREIGN KEY (`Flights_id`)
    REFERENCES `mydb`.`Flights` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bookings_Hotels1`
    FOREIGN KEY (`Hotels_id`)
    REFERENCES `mydb`.`Hotels` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rooms` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Room_Type` VARCHAR(45) NULL,
  `Price_Per_Night` VARCHAR(45) NULL,
  `Availability` SMALLINT(2) NULL,
  `Hotels_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Rooms_Hotels1_idx` (`Hotels_id` ASC) VISIBLE,
  UNIQUE INDEX `Hotels_id_UNIQUE` (`Hotels_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Rooms_Hotels1`
    FOREIGN KEY (`Hotels_id`)
    REFERENCES `mydb`.`Hotels` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Activities` (
  `id` INT NOT NULL,
  `Activity_Name` VARCHAR(45) NULL,
  `Description` VARCHAR(45) NULL,
  `Price` VARCHAR(45) NULL,
  `Destinations_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Activities_Destinations1_idx` (`Destinations_id` ASC) VISIBLE,
  UNIQUE INDEX `Destinations_id_UNIQUE` (`Destinations_id` ASC) VISIBLE,
  CONSTRAINT `fk_Activities_Destinations1`
    FOREIGN KEY (`Destinations_id`)
    REFERENCES `mydb`.`Destinations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transportation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transportation` (
  `id` INT NOT NULL,
  `Trasportation_Type` VARCHAR(45) NULL,
  `Description` VARCHAR(45) NULL,
  `Price_Per_Hour` VARCHAR(45) NULL,
  `Destinations_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Transportation_Destinations1_idx` (`Destinations_id` ASC) VISIBLE,
  UNIQUE INDEX `Destinations_id_UNIQUE` (`Destinations_id` ASC) VISIBLE,
  CONSTRAINT `fk_Transportation_Destinations1`
    FOREIGN KEY (`Destinations_id`)
    REFERENCES `mydb`.`Destinations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reviews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Rating` VARCHAR(45) NULL,
  `Review_Description` VARCHAR(45) NULL,
  `Customers_id` INT NOT NULL,
  `Hotels_id` INT NOT NULL,
  `Destinations_id` INT NOT NULL,
  `Activities_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Reviews_Customers1_idx` (`Customers_id` ASC) VISIBLE,
  UNIQUE INDEX `Customers_id_UNIQUE` (`Customers_id` ASC) VISIBLE,
  INDEX `fk_Reviews_Hotels1_idx` (`Hotels_id` ASC) VISIBLE,
  INDEX `fk_Reviews_Destinations1_idx` (`Destinations_id` ASC) VISIBLE,
  UNIQUE INDEX `Hotels_id_UNIQUE` (`Hotels_id` ASC) VISIBLE,
  UNIQUE INDEX `Destinations_id_UNIQUE` (`Destinations_id` ASC) VISIBLE,
  INDEX `fk_Reviews_Activities1_idx` (`Activities_id` ASC) VISIBLE,
  UNIQUE INDEX `Activities_id_UNIQUE` (`Activities_id` ASC) VISIBLE,
  CONSTRAINT `fk_Reviews_Customers1`
    FOREIGN KEY (`Customers_id`)
    REFERENCES `mydb`.`Customers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Reviews_Hotels1`
    FOREIGN KEY (`Hotels_id`)
    REFERENCES `mydb`.`Hotels` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Reviews_Destinations1`
    FOREIGN KEY (`Destinations_id`)
    REFERENCES `mydb`.`Destinations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Reviews_Activities1`
    FOREIGN KEY (`Activities_id`)
    REFERENCES `mydb`.`Activities` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee_Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee_Roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Role_Type` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hotel_Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hotel_Bookings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Bookings_id` INT NOT NULL,
  `Hotels_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Bookings_has_Hotels_Hotels1_idx` (`Hotels_id` ASC) VISIBLE,
  INDEX `fk_Bookings_has_Hotels_Bookings1_idx` (`Bookings_id` ASC) VISIBLE,
  UNIQUE INDEX `Bookings_id_UNIQUE` (`Bookings_id` ASC) VISIBLE,
  UNIQUE INDEX `Hotels_id_UNIQUE` (`Hotels_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_has_Hotels_Bookings1`
    FOREIGN KEY (`Bookings_id`)
    REFERENCES `mydb`.`Bookings` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bookings_has_Hotels_Hotels1`
    FOREIGN KEY (`Hotels_id`)
    REFERENCES `mydb`.`Hotels` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Flight_Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Flight_Bookings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Bookings_id` INT NOT NULL,
  `Flights_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Bookings_has_Flights_Flights1_idx` (`Flights_id` ASC) VISIBLE,
  INDEX `fk_Bookings_has_Flights_Bookings1_idx` (`Bookings_id` ASC) VISIBLE,
  UNIQUE INDEX `Bookings_id_UNIQUE` (`Bookings_id` ASC) VISIBLE,
  UNIQUE INDEX `Flights_id_UNIQUE` (`Flights_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_has_Flights_Bookings1`
    FOREIGN KEY (`Bookings_id`)
    REFERENCES `mydb`.`Bookings` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bookings_has_Flights_Flights1`
    FOREIGN KEY (`Flights_id`)
    REFERENCES `mydb`.`Flights` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Destination_Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Destination_Bookings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Destinations_id` INT NOT NULL,
  `Bookings_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Destinations_has_Bookings_Bookings1_idx` (`Bookings_id` ASC) VISIBLE,
  INDEX `fk_Destinations_has_Bookings_Destinations1_idx` (`Destinations_id` ASC) VISIBLE,
  UNIQUE INDEX `Destinations_id_UNIQUE` (`Destinations_id` ASC) VISIBLE,
  UNIQUE INDEX `Bookings_id_UNIQUE` (`Bookings_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Destinations_has_Bookings_Destinations1`
    FOREIGN KEY (`Destinations_id`)
    REFERENCES `mydb`.`Destinations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Destinations_has_Bookings_Bookings1`
    FOREIGN KEY (`Bookings_id`)
    REFERENCES `mydb`.`Bookings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roles_Employee_Has`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Roles_Employee_Has` (
  `id` INT NOT NULL,
  `Employee_Roles_id` INT NOT NULL,
  `Employees_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Employee_Roles_has_Employees_Employee_Roles1_idx` (`Employee_Roles_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Employee_Roles_id_UNIQUE` (`Employee_Roles_id` ASC) VISIBLE,
  INDEX `fk_Roles_Employee_Has_Employees1_idx` (`Employees_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Roles_has_Employees_Employee_Roles1`
    FOREIGN KEY (`Employee_Roles_id`)
    REFERENCES `mydb`.`Employee_Roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roles_Employee_Has_Employees1`
    FOREIGN KEY (`Employees_id`)
    REFERENCES `mydb`.`Employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
