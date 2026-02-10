-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema airport
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `airport` ;

-- -----------------------------------------------------
-- Schema airport
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `airport` ;
USE `airport` ;

-- -----------------------------------------------------
-- Table `airport`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`employee` ;

CREATE TABLE IF NOT EXISTS `airport`.`employee` (
  `ssn` CHAR(8) NOT NULL,
  `f_name` VARCHAR(20) NULL,
  `minit` CHAR NULL,
  `l_name` VARCHAR(20) NULL,
  `job_title` VARCHAR(45) NULL,
  `salary` INT NULL,
  `b_date` DATE NULL,
  `gender` CHAR NULL,
  `education` VARCHAR(80) NULL,
  `zip_code` INT NULL,
  `city` VARCHAR(100) NULL,
  `street` VARCHAR(100) NULL,
  PRIMARY KEY (`ssn`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `ssn_UNIQUE` ON `airport`.`employee` (`ssn` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`employee_phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`employee_phone` ;

CREATE TABLE IF NOT EXISTS `airport`.`employee_phone` (
  `phone` CHAR(11) NOT NULL,
  `employee_ssn` CHAR(8) NOT NULL,
  PRIMARY KEY (`phone`, `employee_ssn`),
  CONSTRAINT `fk_employee_phone_employee`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `airport`.`employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_employee_phone_employee_idx` ON `airport`.`employee_phone` (`employee_ssn` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`mechanic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`mechanic` ;

CREATE TABLE IF NOT EXISTS `airport`.`mechanic` (
  `certificate_no` INT NOT NULL,
  `i_date` DATE NULL,
  `employee_ssn` CHAR(8) NOT NULL,
  PRIMARY KEY (`employee_ssn`),
  CONSTRAINT `fk_mechanic_employee1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `airport`.`employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mechanic_employee1_idx` ON `airport`.`mechanic` (`employee_ssn` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`ame`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`ame` ;

CREATE TABLE IF NOT EXISTS `airport`.`ame` (
  `certificate_no` INT NOT NULL,
  `i_date` DATE NULL,
  `employee_ssn` CHAR(8) NOT NULL,
  PRIMARY KEY (`employee_ssn`),
  CONSTRAINT `fk_ame_employee1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `airport`.`employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_ame_employee1_idx` ON `airport`.`ame` (`employee_ssn` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`airline`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`airline` ;

CREATE TABLE IF NOT EXISTS `airport`.`airline` (
  `iata` CHAR(4) NULL,
  `icao` CHAR(4) NOT NULL,
  `base-airport` CHAR(4) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`icao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`air_employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`air_employee` ;

CREATE TABLE IF NOT EXISTS `airport`.`air_employee` (
  `id` INT NOT NULL,
  `airline_icao` CHAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_air_crew_airline1`
    FOREIGN KEY (`airline_icao`)
    REFERENCES `airport`.`airline` (`icao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_air_crew_airline1_idx` ON `airport`.`air_employee` (`airline_icao` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`flight_attendant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`flight_attendant` ;

CREATE TABLE IF NOT EXISTS `airport`.`flight_attendant` (
  `flight_hours` INT NULL,
  `employee_ssn` CHAR(8) NOT NULL,
  `air_emp_id` INT NOT NULL,
  PRIMARY KEY (`employee_ssn`),
  CONSTRAINT `fk_flight_attendant_employee1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `airport`.`employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_attendant_air_crew1`
    FOREIGN KEY (`air_emp_id`)
    REFERENCES `airport`.`air_employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_flight_attendant_employee1_idx` ON `airport`.`flight_attendant` (`employee_ssn` ASC) ;

CREATE INDEX `fk_flight_attendant_air_crew1_idx` ON `airport`.`flight_attendant` (`air_emp_id` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`language` ;

CREATE TABLE IF NOT EXISTS `airport`.`language` (
  `language` CHAR(2) NOT NULL,
  `employee_ssn` CHAR(8) NOT NULL,
  PRIMARY KEY (`employee_ssn`, `language`),
  CONSTRAINT `fk_language_flight_attendant1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `airport`.`flight_attendant` (`employee_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_language_flight_attendant1_idx` ON `airport`.`language` (`employee_ssn` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`pilot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`pilot` ;

CREATE TABLE IF NOT EXISTS `airport`.`pilot` (
  `flight_hours` INT ZEROFILL NOT NULL,
  `certificate_no` INT NOT NULL,
  `i_date` DATE NULL,
  `employee_ssn` CHAR(8) NOT NULL,
  `air_emp_id` INT NOT NULL,
  PRIMARY KEY (`employee_ssn`),
  CONSTRAINT `fk_pilot_employee1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `airport`.`employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pilot_air_crew1`
    FOREIGN KEY (`air_emp_id`)
    REFERENCES `airport`.`air_employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pilot_employee1_idx` ON `airport`.`pilot` (`employee_ssn` ASC) ;

CREATE INDEX `fk_pilot_air_crew1_idx` ON `airport`.`pilot` (`air_emp_id` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`hanger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`hanger` ;

CREATE TABLE IF NOT EXISTS `airport`.`hanger` (
  `no` INT NOT NULL,
  `location` VARCHAR(45) NULL,
  PRIMARY KEY (`no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`bus_hanger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`bus_hanger` ;

CREATE TABLE IF NOT EXISTS `airport`.`bus_hanger` (
  `Capacity` INT NULL,
  `hanger_no` INT NOT NULL,
  PRIMARY KEY (`hanger_no`),
  CONSTRAINT `fk_bus_hanger_hanger1`
    FOREIGN KEY (`hanger_no`)
    REFERENCES `airport`.`hanger` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`bus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`bus` ;

CREATE TABLE IF NOT EXISTS `airport`.`bus` (
  `bus_no` INT NOT NULL,
  `bus_type` CHAR NULL,
  `capacity` INT NULL,
  `bus_status` CHAR NULL,
  `hanger_no` INT NOT NULL,
  PRIMARY KEY (`bus_no`),
  CONSTRAINT `fk_bus_bus_hanger1`
    FOREIGN KEY (`hanger_no`)
    REFERENCES `airport`.`bus_hanger` (`hanger_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_bus_bus_hanger1_idx` ON `airport`.`bus` (`hanger_no` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`weather_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`weather_data` ;

CREATE TABLE IF NOT EXISTS `airport`.`weather_data` (
  `cd` CHAR(9) NOT NULL,
  `country_code` CHAR(2) NULL,
  `latitude` FLOAT NULL,
  `logitude` FLOAT NULL,
  `log_date` DATE NULL,
  `weather_condition` VARCHAR(25) NULL,
  `wind_speed` FLOAT NULL,
  `wind_direction` CHAR(3) NULL,
  `wind_gust` FLOAT NULL,
  `precipitation` DECIMAL NULL,
  `humidity` INT NULL,
  `air_pressure` INT NULL,
  `relative_visibility` INT NULL,
  `cloud_coverage` INT NULL,
  PRIMARY KEY (`cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`maintain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`maintain` ;

CREATE TABLE IF NOT EXISTS `airport`.`maintain` (
  `m_date` DATE NULL,
  `bus_malfunction` VARCHAR(45) NULL,
  `repair_time` TIME NULL,
  `bus_no` INT NOT NULL,
  `employee_ssn` CHAR(8) NOT NULL,
  PRIMARY KEY (`bus_no`, `employee_ssn`),
  CONSTRAINT `fk_maintain_bus1`
    FOREIGN KEY (`bus_no`)
    REFERENCES `airport`.`bus` (`bus_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_maintain_mechanic1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `airport`.`mechanic` (`employee_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_maintain_mechanic1_idx` ON `airport`.`maintain` (`employee_ssn` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`plane`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`plane` ;

CREATE TABLE IF NOT EXISTS `airport`.`plane` (
  `plane_id` INT NOT NULL,
  `capacity` INT NULL,
  `weight` INT NULL,
  `model` VARCHAR(6) NULL,
  `status` CHAR NULL,
  `airline_icao` CHAR(4) NOT NULL,
  `hanger_no` INT NOT NULL,
  `brand` VARCHAR(25) NULL,
  PRIMARY KEY (`plane_id`),
  CONSTRAINT `fk_plane_airline1`
    FOREIGN KEY (`airline_icao`)
    REFERENCES `airport`.`airline` (`icao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plane_hanger1`
    FOREIGN KEY (`hanger_no`)
    REFERENCES `airport`.`hanger` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_plane_airline1_idx` ON `airport`.`plane` (`airline_icao` ASC) ;

CREATE INDEX `fk_plane_hanger1_idx` ON `airport`.`plane` (`hanger_no` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`P_maintains`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`P_maintains` ;

CREATE TABLE IF NOT EXISTS `airport`.`P_maintains` (
  `p_malfunction` VARCHAR(45) NULL,
  `p_end_maintains_date` DATE NULL,
  `p_start_mantains_date` DATE NULL,
  `plane_id` INT NOT NULL,
  `mechanic_ssn` CHAR(8) NOT NULL,
  `ame_ssn` CHAR(8) NOT NULL,
  PRIMARY KEY (`plane_id`, `mechanic_ssn`, `ame_ssn`),
  CONSTRAINT `fk_P_maintains_plane1`
    FOREIGN KEY (`plane_id`)
    REFERENCES `airport`.`plane` (`plane_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_P_maintains_mechanic1`
    FOREIGN KEY (`mechanic_ssn`)
    REFERENCES `airport`.`mechanic` (`employee_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_P_maintains_ame1`
    FOREIGN KEY (`ame_ssn`)
    REFERENCES `airport`.`ame` (`employee_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_P_maintains_mechanic1_idx` ON `airport`.`P_maintains` (`mechanic_ssn` ASC) ;

CREATE INDEX `fk_P_maintains_ame1_idx` ON `airport`.`P_maintains` (`ame_ssn` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`passenger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`passenger` ;

CREATE TABLE IF NOT EXISTS `airport`.`passenger` (
  `passport_no` CHAR(10) NOT NULL,
  `f_name` VARCHAR(25) NULL,
  `minit` CHAR NULL,
  `l_name` VARCHAR(25) NULL,
  `nationality` VARCHAR(30) NULL,
  `passport_type` CHAR(3) NULL,
  `country_code` CHAR(3) NULL,
  `gender` CHAR NULL,
  `i_date` DATE NULL,
  `e_date` DATE NULL,
  `b_date` DATE NULL,
  `place_of_birth` VARCHAR(25) NULL,
  PRIMARY KEY (`passport_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`gate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`gate` ;

CREATE TABLE IF NOT EXISTS `airport`.`gate` (
  `no` INT NOT NULL,
  `location` VARCHAR(45) NULL,
  PRIMARY KEY (`no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`flight`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`flight` ;

CREATE TABLE IF NOT EXISTS `airport`.`flight` (
  `no` CHAR(5) NOT NULL,
  `from` CHAR(4) NULL,
  `to` CHAR(4) NULL,
  `status` CHAR NULL,
  `departure` DATETIME NULL,
  `arrival` DATETIME NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  `airline_icao` CHAR(4) NOT NULL,
  `plane_id` INT NOT NULL,
  `gate_no` INT NOT NULL,
  PRIMARY KEY (`no`, `airline_icao`),
  CONSTRAINT `fk_flight_airline1`
    FOREIGN KEY (`airline_icao`)
    REFERENCES `airport`.`airline` (`icao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_plane1`
    FOREIGN KEY (`plane_id`)
    REFERENCES `airport`.`plane` (`plane_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_gate1`
    FOREIGN KEY (`gate_no`)
    REFERENCES `airport`.`gate` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_flight_airline1_idx` ON `airport`.`flight` (`airline_icao` ASC) ;

CREATE INDEX `fk_flight_plane1_idx` ON `airport`.`flight` (`plane_id` ASC) ;

CREATE INDEX `fk_flight_gate1_idx` ON `airport`.`flight` (`gate_no` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`Country` ;

CREATE TABLE IF NOT EXISTS `airport`.`Country` (
  `Country_Code` CHAR(2) NOT NULL,
  `flight_no` CHAR(5) NOT NULL,
  PRIMARY KEY (`Country_Code`, `flight_no`),
  CONSTRAINT `fk_Country_flight1`
    FOREIGN KEY (`flight_no`)
    REFERENCES `airport`.`flight` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Country_flight1_idx` ON `airport`.`Country` (`flight_no` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`send`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`send` ;

CREATE TABLE IF NOT EXISTS `airport`.`send` (
  `weather_data_cd` CHAR(9) NOT NULL,
  `flight_no` CHAR(5) NOT NULL,
  PRIMARY KEY (`weather_data_cd`, `flight_no`),
  CONSTRAINT `fk_weather_data_has_flight_weather_data1`
    FOREIGN KEY (`weather_data_cd`)
    REFERENCES `airport`.`weather_data` (`cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_weather_data_has_flight_flight1`
    FOREIGN KEY (`flight_no`)
    REFERENCES `airport`.`flight` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_weather_data_has_flight_flight1_idx` ON `airport`.`send` (`flight_no` ASC) ;

CREATE INDEX `fk_weather_data_has_flight_weather_data1_idx` ON `airport`.`send` (`weather_data_cd` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`flight_has_bus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`flight_has_bus` ;

CREATE TABLE IF NOT EXISTS `airport`.`flight_has_bus` (
  `bus_no` INT NOT NULL,
  `flight_no` CHAR(5) NOT NULL,
  PRIMARY KEY (`bus_no`, `flight_no`),
  CONSTRAINT `fk_bus_has_flight_bus1`
    FOREIGN KEY (`bus_no`)
    REFERENCES `airport`.`bus` (`bus_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_has_flight_flight1`
    FOREIGN KEY (`flight_no`)
    REFERENCES `airport`.`flight` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_bus_has_flight_flight1_idx` ON `airport`.`flight_has_bus` (`flight_no` ASC) ;

CREATE INDEX `fk_bus_has_flight_bus1_idx` ON `airport`.`flight_has_bus` (`bus_no` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`ticket` ;

CREATE TABLE IF NOT EXISTS `airport`.`ticket` (
  `no` INT NOT NULL,
  `price` INT NULL,
  `class` CHAR NULL,
  PRIMARY KEY (`no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airport`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`book` ;

CREATE TABLE IF NOT EXISTS `airport`.`book` (
  `ticket_no` INT NOT NULL,
  `passport_no` CHAR(10) NOT NULL,
  `flight_no` CHAR(5) NOT NULL,
  `book_date` DATE NULL,
  CONSTRAINT `fk_book_ticket1`
    FOREIGN KEY (`ticket_no`)
    REFERENCES `airport`.`ticket` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_passenger1`
    FOREIGN KEY (`passport_no`)
    REFERENCES `airport`.`passenger` (`passport_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_flight1`
    FOREIGN KEY (`flight_no`)
    REFERENCES `airport`.`flight` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_book_ticket1_idx` ON `airport`.`book` (`ticket_no` ASC) ;

CREATE INDEX `fk_book_passenger1_idx` ON `airport`.`book` (`passport_no` ASC) ;

CREATE INDEX `fk_book_flight1_idx` ON `airport`.`book` (`flight_no` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`on_board`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`on_board` ;

CREATE TABLE IF NOT EXISTS `airport`.`on_board` (
  `air_emp_id` INT NOT NULL,
  `flight_no` CHAR(5) NOT NULL,
  PRIMARY KEY (`air_emp_id`, `flight_no`),
  CONSTRAINT `fk_air_crew_has_flight_air_crew1`
    FOREIGN KEY (`air_emp_id`)
    REFERENCES `airport`.`air_employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_air_crew_has_flight_flight1`
    FOREIGN KEY (`flight_no`)
    REFERENCES `airport`.`flight` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_air_crew_has_flight_flight1_idx` ON `airport`.`on_board` (`flight_no` ASC) ;

CREATE INDEX `fk_air_crew_has_flight_air_crew1_idx` ON `airport`.`on_board` (`air_emp_id` ASC) ;


-- -----------------------------------------------------
-- Table `airport`.`security_employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `airport`.`security_employee` ;

CREATE TABLE IF NOT EXISTS `airport`.`security_employee` (
  `employee_ssn` CHAR(8) NOT NULL,
  `gate_no` INT NOT NULL,
  PRIMARY KEY (`employee_ssn`, `gate_no`),
  CONSTRAINT `fk_employee_has_gate_employee1`
    FOREIGN KEY (`employee_ssn`)
    REFERENCES `airport`.`employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_gate_gate1`
    FOREIGN KEY (`gate_no`)
    REFERENCES `airport`.`gate` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_employee_has_gate_gate1_idx` ON `airport`.`security_employee` (`gate_no` ASC) ;

CREATE INDEX `fk_employee_has_gate_employee1_idx` ON `airport`.`security_employee` (`employee_ssn` ASC) ;


-- -----------------------------------------------------
-- Data for table `airport`.`employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('33965967', 'ahmed', 'G', 'Hussein', 'security guard', 7000, '2000-05-04', 'M', 'Bechelor of commerce', 11511, 'Cairo main', 'No 1 bdel Khalek Tharwat St. - Ataba Square');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('37933718', 'mohamed', 'H', ' Karim', 'security guard', 7100, '1998-08-09', 'M', 'Bechelor of commerce', 11765, 'Nasr City', 'St. Ahmed Fouad Naseem - Behind the Workforce - Nasr City - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('67349879', 'khaled', 'D', 'Tareq', 'security guard', 7800, '2000-12-27', 'M', 'Bechelor of commerce', 11728, 'Maadi', 'Street 9 - Maadi');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('85419647', 'Mohamed', 'S', 'Abdelrahman', 'security guard', 7200, '1992-01-26', 'M', 'secondary', 11522, 'Ramses', 'No. 57 amses Street - Azbakia');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('10549059', ' Youssef', 'F', 'Adama', 'security guard', 7100, '2000-03-12', 'M', 'secondary', 11561, 'El Zamalek', 'No 3 Brazil St. - El Zamalek');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('37785122', ' Ahmed', 'G', 'Bakary', 'security guard', 7905, '2000-03-22', 'M', 'Bechelor of rights', 11757, 'Heliopolis', 'Post Street - El Korba - Masr El Gadeda');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('78726579', ' Mahmoud', 'J', 'Abdoulaye', 'security guard', 6800, '2005-09-16', 'M', 'secondary', 11835, '5th Settlement New Cairo', 'First Quarter - 5th Settlement - Nasr City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('51082588', ' Mustafa', 'F', 'Modibo', 'security guard', 5200, '1970-11-24', 'M', 'Bechelor of rights', 11571, 'Mokattam City', 'Fountain Square - Mokattam City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('91176872', 'Yassin', 'S', 'Oumar', 'security guard', 7900, '1980-05-21', 'M', 'secondary', 11837, 'El Shorouq City', 'El Shorouq City - Commercial Market');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('95317540', 'Taha', 'A', 'Sekou', 'security guard', 5500, '1975-01-15', 'M', 'Bechelor of arts', 11574, 'Tawfeer El Alfy', 'No 1 El Alfy St. - Downtown Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('16227346', 'Khaled', 'F', 'Wassim', 'mechanic', 5000, '1970-01-03', 'M', 'secondary', 11631, 'Rod El Farag', 'No 137 Ebeid Street - Rod El Farag - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('38551291', 'Hamza', 'S', 'Ali', 'mechanic', 5500, '1972-12-03', 'M', 'secondary', 11841, 'Rehab City', 'Rehab City - New Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('45799284', 'Bilal', 'S', 'Amine', 'mechanic', 5800, '1966-02-10', 'M', 'secondary', 11632, 'Old Egypt', 'Police Street - Next to The Old Egypt Section');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('14019955', 'Ibrahim', 'A', 'Medhat', 'mechanic', 5100, '1964-05-27', 'M', 'secondary', 11768, 'District VI Nasr City', 'No 68 Khalifa Al-Zafar Street - 6th District - Nasr City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('74394299', ' Hassan', 'W', 'Youssef', 'mechanic', 4500, '1973-09-10', 'M', 'secondary', 11672, 'Shubra Misr', 'No 81 Shubra Street - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('30181194', 'Hussein', 'E', 'Aziz', 'mechanic', 5900, '1976-11-28', 'M', 'secondary', 11843, 'New Nozha', 'Division of the city flower - End of the New Nozha');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('72148359', ' Karim', 'R', 'Karim', 'mechanic', 6000, '1970-09-16', 'M', 'secondary', 11722, 'Helwan pools', 'No 33 Mohamed Sayed Ahmed Street - Helwan');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('53292373', 'Tareq', 'W', 'ahmed', 'mechanic', 5200, '1973-06-14', 'M', 'secondary', 11828, 'Obour City', 'First Quarter next to the City Transit system');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('22444081', 'Abdelrahman', 'F', 'mohamed', 'mechanic', 5600, '1989-07-23', 'M', 'secondary', 11772, 'Ain Shams', 'El Mahdy Street - Ahmed Esmat - Ain Shams');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('45771026', 'Ali', 'S', 'khaled', 'mechanic', 5500, '1986-02-01', 'M', 'commercial diplome', 11725, 'hadayeq El Zaitoun', '   in front of hadayeq El Zaitoun Metro Station - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('94101071', 'Omar', 'G', 'Mohamed', 'mechanic', 4900, '1959-02-11', 'M', 'commercial diplome', 0, 'Al Asmarat', '  Al Asmarat District - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('25394954', 'Halim', 'D', ' Youssef', 'mechanic', 5800, '1988-06-19', 'M', 'commercial diplome', 11556, 'The Egyptian Museum', 'Egyptian Museum Building - Tahrir Square');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('26392847', 'Murad', 'S', 'walid', 'mechanic', 5000, '1976-01-14', 'M', 'commercial diplome', 11555, 'Manial El Roda West', 'No 115 Abdul Aziz Al Saude - El Manial');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('61397430', 'Selim', 'A', 'abdelnassar', 'mechanic', 5100, '2003-08-04', 'M', 'commercial diplome', 11554, 'Abu Saud Old Egypt', 'East of the tunnel - field of ancient Egypt');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('64399581', 'Abdallah', 'H', 'ismail', 'mechanic', 4700, '1989-03-15', 'M', 'industrial diplome', 11553, 'Manial El Rawda', 'No 9 El Manial Palace - Manial El Rawda');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('40322395', 'Abdallah', 'Z', 'Amir ', 'mechanic', 4000, '1984-11-02', 'M', 'industrial diplome', 11552, 'Journalists Syndicate', 'Khaliq TharwatSt. - Journalists Syndicate building - Uzbek Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('48374362', 'Peter', 'R', ' George', 'mechanic', 4000, '1978-10-18', 'M', 'industrial diplome', 11551, 'Missions Islamic city', 'Islamic Missions City - study');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('24870503', ' Pierre', 'I', 'adel', 'mechanic', 4400, '1970-01-01', 'M', 'industrial diplome', 11549, 'Elsabel Land', 'St. workshops telephone St. - Elsabel Land Shubra');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('75030339', ' George', 'G', 'nasim', 'mechanic', 4300, '1971-02-02', 'M', 'industrial diplome', 11541, 'Cairos main parcels', 'Ataba Square - post office building');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('81920258', 'John', 'T', ' Kirollos', 'mechanic', 5000, '1972-03-03', 'M', 'industrial diplome', 11536, 'Cairo Sporting Club', 'Ahmed Maher Square island - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('44198755', ' Mina', 'P', 'Habib', 'engineer', 8000, '1973-04-04', 'M', 'Bechelor of arts in aeronautical and space engineering', 11535, 'Second Abbasid', 'No. 2 Elsarayat St. Abdu Pasha Square');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('91641034', ' Beshoi', 'L', ' Fadi', 'engineer', 8900, '1974-05-05', 'M', 'Bechelor of arts in aeronautical and space engineering', 11534, 'Ministry of Tourism', 'No. 5 Adly Street - Ministry of Tourism / Azbakiya');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('22675891', ' Kirollos', 'G', ' Beshoi', 'engineer', 8500, '1975-06-06', 'M', 'Bechelor of arts in aeronautical and space engineering', 11527, 'Republican Palace dome', 'Inside the Republican Palace - Gardens dome');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('80459206', ' Mark', 'F', 'metwally', 'engineer', 8100, '1976-07-07', 'M', 'Bechelor of arts in aeronautical and space engineering', 11524, 'Ministry of Education', 'The Ministry of Education Building');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('75087307', ' Fadi', 'S', 'John', 'engineer', 8700, '1977-08-08', 'M', 'Bechelor of arts in aeronautical and space engineering', 11523, 'Faggala', 'No. 11 Sirajuddin St. Al-Fagala - Azbakiya');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('93913838', 'Habib', 'A', ' Mina', 'captain', 8000, '1978-09-09', 'M', 'Bachelor of aviation', 11521, 'ElDawaeen', 'No.15 Noubar Basha St. - Saida Zeinab - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('78715471', 'Amir', 'G', 'mounir', 'captain', 8900, '1979-10-10', 'M', 'Bachelor of aviation', 11518, 'Mohamed Farid', 'No1 Mohamed Farid Street - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('17649414', 'Omar', 'S', 'adel', 'captain', 8500, '1980-11-11', 'M', 'Bachelor of aviation', 11516, 'Magles Al Shaeb', 'Magles Al Shaeb St.');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('58733011', 'Abdelkader', 'L', 'nasim', 'captain', 8100, '1981-12-12', 'M', 'Bachelor of aviation', 11515, 'Television ', 'Television building - Nile Corniche building - cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('77706885', 'Ahmed', 'K', 'shahin', 'captain', 8700, '1982-02-13', 'M', 'Bachelor of aviation', 11513, 'Bab El Louk', '  No.21 El Azhar St. Elfalaki field - Bab El Louk');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('92233307', 'Mohammed', 'H', 'osama', 'captain', 9000, '1983-03-14', 'M', 'Bachelor of aviation', 11512, 'tahrir complex', 'Tahrir complex - Tahrir Square Building - cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('37218044', 'Ali', 'G', 'islam', 'captain', 9800, '1984-04-15', 'M', 'Bachelor of aviation', 11554, 'Abu Saud Old Egypt', 'East of the tunnel - field of ancient Egypt');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('68422285', 'Said', 'F', 'hazem', 'captain', 10000, '1985-05-16', 'M', 'Bachelor of aviation', 11535, 'Second Abbasid', 'No. 2 Elsarayat St. Abdu Pasha Square');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('37128823', 'Ibrahim', 'S', 'metwally', 'copilot', 8900, '1986-06-17', 'M', 'Bachelor of aviation', 11536, 'Cairo Sporting Club', 'Ahmed Maher Square island - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('92936760', 'Omar', 'R', 'essa', 'copilot', 8500, '1987-07-18', 'M', 'Bachelor of aviation', 11538, 'the primary court of north cairo abassia', 'Abbasia Square , building of the primary court of north cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('22231509', 'Ahmed', 'E', 'Youssef', 'copilot', 8100, '1988-08-19', 'M', 'Bachelor of aviation', 11527, 'Republican Palace dome', 'Inside the Republican Palace - Gardens dome');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('44342315', 'Ali', 'W', 'Aziz', 'copilot', 8700, '1989-09-20', 'M', 'Bachelor of aviation', 11541, 'Cairos main parcels', 'Ataba Square - post office building');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('14891503', 'Hamza', 'Q', 'Karim', 'copilot', 8000, '1990-10-21', 'M', 'Bachelor of aviation', 11549, 'Elsabel Land', 'St. workshops telephone St. - Elsabel Land Shubra');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('27769776', 'Ibrahim', 'T', 'Aziz', 'copilot', 8900, '1991-11-22', 'M', 'Bachelor of aviation', 11551, 'Missions Islamic city', 'Islamic Missions City - study');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('73579221', 'Mahmoud', 'F', 'Karim', 'copilot', 8500, '1992-12-23', 'M', 'Bachelor of aviation', 11552, 'Journalists Syndicate', 'Khaliq TharwatSt. - Journalists Syndicate building - Uzbek Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('42940045', 'Abdallah', 'D', 'Mamadou', 'copilot', 11000, '1993-02-24', 'M', 'Bachelor of aviation', 11553, 'Manial El Rawda', 'No 9 El Manial Palace - Manial El Rawda');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('77018858', 'Tareq', 'S', 'Fahd ', 'attendant', 7000, '1994-03-25', 'M', 'diplome airline', 11534, 'Ministry of Tourism', 'No. 5 Adly Street - Ministry of Tourism / Azbakiya');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('16455966', 'Khaled', 'Q', 'Taha', 'attendant', 7800, '1995-04-26', 'M', 'diplome airline', 11555, 'Manial El Roda West', 'No 115 Abdul Aziz Al Saude - El Manial');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('48845427', 'Mamadou', 'E', 'Khaled', 'attendant', 7000, '1996-05-27', 'M', 'diplome airline', 11556, 'The Egyptian Museum', 'Egyptian Museum Building - Tahrir Square');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('16248780', 'Moussa', 'W', 'Mahmoud', 'attendant', 7800, '1997-06-28', 'M', 'diplome airline', 11524, 'Ministry of Education', 'The Ministry of Education Building');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('68740701', 'Mahamadou', 'K', 'Abdallah', 'attendant', 7000, '1998-07-29', 'M', 'diplome airline', 11523, 'Faggala', 'No. 11 Sirajuddin St. Al-Fagala - Azbakiya');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('78720420', 'Adama', 'J', 'Tareq', 'attendant', 7800, '1999-08-02', 'M', 'diplome airline', 11521, 'ElDawaeen', 'No.15 Noubar Basha St. - Saida Zeinab - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('80185212', 'Bakary', 'D', 'Khaled', 'attendant', 9000, '2000-09-03', 'M', 'diplome airline', 11518, 'Mohamed Farid', 'No1 Mohamed Farid Street - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('71688757', 'Abdoulaye', 'A', 'Mamadou', 'attendant', 7800, '2001-10-04', 'M', 'diplome airline', 11516, 'Magles Al Shaeb', 'Magles Al Shaeb St.');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('45970645', 'Modibo', 'K', 'Moussa', 'attendant', 8000, '2002-11-05', 'M', 'diplome airline', 11567, 'Cairo Tower', 'Tower building / El Gazirah / Nile Palace');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('86677298', 'Oumar', 'J', 'Mahamadou', 'attendant', 7000, '1975-09-29', 'M', 'diplome airline', 11552, 'Journalists Syndicate', 'Khaliq TharwatSt. - Journalists Syndicate building - Uzbek Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('48157238', 'Sekou', 'I', 'Adama', 'attendant', 8000, '1976-10-02', 'M', 'diplome airline', 11553, 'Manial El Rawda', 'No 9 El Manial Palace - Manial El Rawda');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('58673754', 'Souleymane', 'N', 'Bakary', 'attendant', 7800, '1977-11-03', 'M', 'diplome airline', 11554, 'Abu Saud Old Egypt', 'East of the tunnel - field of ancient Egypt');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('67115657', 'Mohamed', 'R', 'Belal', 'attendant', 7500, '1978-12-04', 'M', 'diplome airline', 11555, 'Manial El Roda West', 'No 115 Abdul Aziz Al Saude - El Manial');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('32747979', 'Amir', 'T', 'walid', 'attendant', 7000, '1979-02-05', 'M', 'diplome tourist division and hotels', 11556, 'The Egyptian Museum', 'Egyptian Museum Building - Tahrir Square');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('95252321', 'Ibrahim', 'Y', 'Amir', 'attendant', 7800, '1980-03-06', 'M', 'diplome tourist division and hotels', 11588, 'Ain Shams Specialized Hospital', 'Hospital building - El Khalifa El maemon Street');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('16161450', 'Ayoub', 'U', 'Omar', 'attendant', 7000, '1981-04-07', 'M', 'diplome tourist division and hotels', 11559, 'El malek El Saleh ', 'No 8 El Siala ElRoda St. - El Manial');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('42058942', 'Youssef', 'P', 'Abdelkader', 'attendant', 7500, '1982-05-08', 'M', 'diplome tourist division and hotels', 11523, 'Faggala', 'No. 11 Sirajuddin St. Al-Fagala - Azbakiya');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('52864290', 'Younès', 'O', 'Ahmed', 'attendant', 8000, '1983-06-09', 'M', 'diplome tourist division and hotels', 11562, 'El Qasr al Aini', 'No 71 El Kasr El Aini St.');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('57187381', 'Wassim', 'P', 'Mohammed', 'attendant', 7000, '1984-07-10', 'M', 'diplome tourist division and hotels', 11563, 'El Zaher', 'No 70 El Zaher St.');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('90105586', 'Ali', 'A', 'Taha', 'attendant', 7000, '1985-08-11', 'M', 'diplome tourist division and hotels', 11564, 'Uzbek court complex', 'Courts Complex building - El Galaa St. - Uzbek');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('74512931', 'Amine', 'S', 'Khaled', 'attendant', 7500, '1986-09-12', 'M', 'diplome tourist division and hotels', 11567, 'Cairo Tower', 'Tower building / El Gazirah / Nile Palace');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('40140478', 'Medhat', 'Z', 'Hamza', 'attendant', 7000, '1987-10-13', 'M', 'diplome tourist division and hotels', 11568, '?El Gazirah Zamalek', 'No 3 Shagara El Dor - Zamalek');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('21945556', 'Youssef', 'X', 'Bilal', 'attendant', 7000, '1988-11-14', 'M', 'diplome tourist division and hotels', 11521, 'ElDawaeen', 'No.15 Noubar Basha St. - Saida Zeinab - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('61081562', 'Aziz', 'C', 'Ibrahim', 'attendant', 7000, '1989-12-15', 'M', 'diplome tourist division and hotels', 11575, 'El Tunsy', 'Sanada St. from Elkordy Street - El Khalifa - cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('72581757', 'Karim', 'B', 'Ashraf', 'attendant', 7000, '1990-02-16', 'M', 'diplome tourist division and hotels', 11576, 'Sales Tax Shobra', 'Agha Khan Buildings - Shubra');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('97494228', 'Mamadou', 'N', 'gamal', 'attendant', 7500, '1991-03-17', 'M', 'diplome tourist division and hotels', 11577, 'El Qubaisi', 'No 39 Esmail El Falaky St. - Elzaher');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('32014634', 'Fahd ', 'D', 'glal', 'attendant', 8000, '1992-04-18', 'M', 'diplome tourist division and hotels', 11581, 'El Emam El Shafei', 'No 176 El Emam El Shafei St. - El Khalifa');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('93763380', 'Taha', 'F', 'anwar', 'attendant', 7000, '1993-05-19', 'M', 'diplome tourist division and hotels', 11584, 'Ministry of International Cooperation', 'No 8 Adly St.- Ministry of International Cooperation');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('12533980', 'Khaled', 'G', 'Amine', 'attendant', 7000, '1994-06-20', 'M', 'diplome tourist division and hotels', 11528, 'Tenth District', 'Tenth District 14 El Mahdy Arafh St. - Tower seedbed');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('20046157', 'Hamza', 'H', 'Medhat', 'attendant', 7400, '1995-07-21', 'M', 'diplome tourist division and hotels', 11835, '5th Settlement New Cairo', 'First Quarter - 5th Settlement - Nasr City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('95023229', 'Bilal', 'J', 'Youssef', 'attendant', 7800, '1996-08-22', 'M', 'diplome tourist division and hotels', 11571, 'Mokattam City', 'Fountain Square - Mokattam City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('40533284', 'Ibrahim', 'K', 'Aziz', 'attendant', 8000, '1997-09-23', 'M', 'diplome tourist division and hotels', 11837, 'El Shorouq City', 'El Shorouq City - Commercial Market');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('26107194', ' Hassan', 'L', 'Karim', 'attendant', 7000, '1998-10-24', 'M', 'diplome tourist division and hotels', 11574, 'Tawfeer El Alfy', 'No 1 El Alfy St. - Downtown Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('51552081', 'amina', 'G', 'Mamadou', 'attendant', 7500, '1999-11-25', 'F', 'diplome tourist division and hotels', 11631, 'Rod El Farag', 'No 137 Ebeid Street - Rod El Farag - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('74160746', 'Sara', 'F', 'Abbas', 'attendant', 7000, '2000-12-26', 'F', 'diplome tourist division and hotels', 11841, 'Rehab City', 'Rehab City - New Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('34285151', 'Yasmine', 'E', 'ashraf', 'attendant', 8500, '2001-02-27', 'F', 'diplome tourist division and hotels', 11555, 'Manial El Roda West', 'No 115 Abdul Aziz Al Saude - El Manial');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('35922745', 'Lyna', 'B', 'ayman', 'attendant', 7000, '2002-03-28', 'F', 'diplome airline', 11556, 'The Egyptian Museum', 'Egyptian Museum Building - Tahrir Square');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('75134291', 'Maria', 'N', 'bassem', 'attendant', 7000, '2003-04-29', 'F', 'diplome airline', 11588, 'Ain Shams Specialized Hospital', 'Hospital building - El Khalifa El maemon Street');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('30913540', 'Meriem', 'R', 'ehab', 'attendant', 8500, '1978-05-09', 'F', 'diplome airline', 11577, 'El Qubaisi', 'No 39 Esmail El Falaky St. - Elzaher');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('96884121', 'Karima', 'R', 'essam', 'attendant', 7500, '1979-06-10', 'F', 'diplome airline', 11581, 'El Emam El Shafei', 'No 176 El Emam El Shafei St. - El Khalifa');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('64820357', 'Melissa', 'R', 'farouk', 'attendant', 7400, '1980-07-11', 'F', 'diplome airline', 11584, 'Ministry of International Cooperation', 'No 8 Adly St.- Ministry of International Cooperation');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('60787775', 'Lydia', 'D', 'abdelfattah', 'attendant', 7000, '1981-08-12', 'F', 'diplome airline', 11528, 'Tenth District', 'Tenth District 14 El Mahdy Arafh St. - Tower seedbed');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('78310572', 'Shaimaa', 'C', 'fuad', 'attendant', 7800, '1982-09-13', 'F', 'diplome airline', 11835, '5th Settlement New Cairo', 'First Quarter - 5th Settlement - Nasr City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('99541637', 'Fatma', 'S', 'hatem', 'attendant', 8000, '1983-10-14', 'F', 'diplome airline', 11571, 'Mokattam City', 'Fountain Square - Mokattam City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('92161552', 'Maha', 'N', 'hamza', 'attendant', 7000, '1984-11-15', 'F', 'diplome airline', 11554, 'Abu Saud Old Egypt', 'East of the tunnel - field of ancient Egypt');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('22086526', 'Reem', 'T', 'tamer', 'attendant', 7000, '1985-12-16', 'F', 'diplome airline', 11535, 'Second Abbasid', 'No. 2 Elsarayat St. Abdu Pasha Square');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('37995831', 'Farida', 'G', 'hisham', 'attendant', 8500, '1986-02-17', 'F', 'secondary', 11536, 'Cairo Sporting Club', 'Ahmed Maher Square island - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('79021788', 'Aya', 'K', 'hsni', 'attendant', 7000, '1987-03-18', 'F', 'secondary', 11538, 'the primary court of north cairo abassia', 'Abbasia Square , building of the primary court of north cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('68878821', 'Shahd', 'U', 'hossam', 'attendant', 7000, '1988-04-19', 'F', 'secondary', 11541, 'Cairos main parcels', 'Ataba Square - post office building');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('75001883', 'Ashraqat', 'R', 'kamal', 'attendant', 8000, '1989-05-20', 'F', 'secondary', 11549, 'Elsabel Land', 'St. workshops telephone St. - Elsabel Land Shubra');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('60753431', 'Sahar', 'E', 'kamel', 'attendant', 7000, '1990-06-21', 'F', 'secondary', 11551, 'Missions Islamic city', 'Islamic Missions City - study');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('18060107', 'Fatin', 'B', 'magdi', 'attendant', 7800, '1991-07-22', 'F', 'secondary', 11552, 'Journalists Syndicate', 'Khaliq TharwatSt. - Journalists Syndicate building - Uzbek Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('92079146', 'Dalal', 'V', 'mustafa', 'attendant', 7400, '1992-08-23', 'F', 'secondary', 11553, 'Manial El Rawda', 'No 9 El Manial Palace - Manial El Rawda');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('88635327', 'Doha', 'X', 'nabil', 'attendant', 7000, '1993-09-24', 'F', 'secondary', 11534, 'Ministry of Tourism', 'No. 5 Adly Street - Ministry of Tourism / Azbakiya');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('36405055', 'Fajr', 'X', 'nader', 'attendant', 7000, '1994-10-25', 'F', 'secondary', 11511, 'Cairo main', 'No 1 bdel Khalek Tharwat St. - Ataba Square');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('44030574', 'Suha', 'C', 'naguib', 'attendant', 8500, '1995-11-26', 'F', 'secondary', 11765, 'Nasr City', 'St. Ahmed Fouad Naseem - Behind the Workforce - Nasr City - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('24330910', 'Rowan', 'V', 'nour', 'attendant', 7800, '1996-12-27', 'F', 'secondary', 11728, 'Maadi', 'Street 9 - Maadi');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('19285567', 'Hosniya', 'B', 'Karim', 'attendant', 7000, '1997-02-28', 'F', 'secondary', 11522, 'Ramses', 'No. 57 amses Street - Azbakia');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('43040787', 'Hasnaa', 'N', 'ahmed', 'attendant', 8000, '1998-03-29', 'F', 'secondary', 11561, 'El Zamalek', 'No 3 Brazil St. - El Zamalek');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('29123378', 'Hosna', 'M', 'mohamed', 'attendant', 7000, '1999-04-02', 'F', 'secondary', 11757, 'Heliopolis', 'Post Street - El Korba - Masr El Gadeda');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('17269439', 'Gamila', 'D', 'khaled', 'attendant', 7800, '2000-05-03', 'F', 'secondary', 11835, '5th Settlement New Cairo', 'First Quarter - 5th Settlement - Nasr City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('54896683', 'Gamalat', 'A', 'Mohamed', 'attendant', 7000, '2001-06-04', 'F', 'secondary', 11571, 'Mokattam City', 'Fountain Square - Mokattam City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('52251241', 'Habiba', 'E', ' Youssef', 'attendant', 7800, '2002-07-05', 'F', 'secondary', 11837, 'El Shorouq City', 'El Shorouq City - Commercial Market');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('44725567', 'Mary', 'R', 'walid', 'attendant', 7800, '2003-08-06', 'F', 'diplome tourist division and hotels', 11574, 'Tawfeer El Alfy', 'No 1 El Alfy St. - Downtown Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('36969958', 'Marie', 'Y', 'abdelnassar', 'attendant', 7800, '2004-09-07', 'F', 'diplome tourist division and hotels', 11631, 'Rod El Farag', 'No 137 Ebeid Street - Rod El Farag - Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('63530617', 'Mariam', 'T', 'ismail', 'captain', 9000, '1994-10-25', 'F', 'Bachelor of aviiation', 11841, 'Rehab City', 'Rehab City - New Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('39849186', ' Marina', 'Y', 'Amir ', 'captain', 9500, '1995-11-26', 'F', 'Bachelor of aviiation', 11588, 'Ain Shams Specialized Hospital', 'Hospital building - El Khalifa El maemon Street');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('31751135', 'Irene', 'I', 'mounir', 'copilot', 9000, '1996-12-27', 'F', 'Bachelor of aviiation', 11559, 'El malek El Saleh ', 'No 8 El Siala ElRoda St. - El Manial');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('62992334', 'Malak', 'O', 'adel', 'copilot', 9600, '1997-02-28', 'F', 'Bachelor of aviiation', 11523, 'Faggala', 'No. 11 Sirajuddin St. Al-Fagala - Azbakiya');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('36969959', 'Mohamed', 'A', 'abdelnassar', 'security guard', 7000, '1998-08-10', 'M', 'secondary', 11571, 'Mokattam City', 'Fountain Square - Mokattam City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('36959958', 'abdelnassar', 'S', ' Youssef', 'security guard', 7500, '1998-08-09', 'M', 'secondary', 11574, 'Tawfeer El Alfy', 'No 5 El Alfy St. - Downtown Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('46969958', ' Youssef', 'D', 'walid', 'security guard', 7200, '1995-08-09', 'M', 'diplome tourist division and hotels', 11574, 'Tawfeer El Alfy', 'No 6 El Alfy St. - Downtown Cairo');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('36985958', 'Mohamed', 'F', 'Mohamed', 'security guard', 7100, '1998-11-09', 'M', 'secondary', 11571, 'Mokattam City', 'Fountain Square - Mokattam City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('79969958', 'walid', 'T', ' Youssef', 'security guard', 7300, '1988-11-09', 'M', 'diplome tourist division and hotels', 11571, 'Mokattam City', 'Fountain Square - Mokattam City');
INSERT INTO `airport`.`employee` (`ssn`, `f_name`, `minit`, `l_name`, `job_title`, `salary`, `b_date`, `gender`, `education`, `zip_code`, `city`, `street`) VALUES ('36901958', 'abdelnassar', 'Y', 'Mohamed', 'security guard', 7400, '1998-01-01', 'M', 'diplome tourist division and hotels', 11574, 'Tawfeer El Alfy', 'No 9 El Alfy St. - Downtown Cairo');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`employee_phone`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1039039649', '33965967');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1192485990', '37933718');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1283299769', '67349879');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1567616924', '85419647');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1079076100', '10549059');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1591873351', '37785122');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1123191681', '78726579');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1296019590', '51082588');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1026570251', '91176872');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1221999364', '95317540');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1589301389', '16227346');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1051876728', '38551291');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1075789699', '45799284');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1028873261', '14019955');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1574594511', '74394299');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1296999915', '30181194');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1069981846', '72148359');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1075571722', '53292373');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1096396375', '22444081');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1013343724', '45771026');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1029117909', '94101071');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1164937590', '25394954');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1259330987', '26392847');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1560313020', '61397430');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1036459682', '64399581');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1544579684', '40322395');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1115781654', '48374362');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1289900856', '24870503');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1012825089', '75030339');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1246141527', '81920258');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1592894050', '44198755');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1064460127', '91641034');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1049185024', '22675891');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1091425357', '80459206');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1528738944', '75087307');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1230833746', '93913838');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1063768431', '78715471');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1046264552', '17649414');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1074242810', '58733011');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1072404408', '77706885');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1072359030', '92233307');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1114386080', '37218044');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1296792997', '68422285');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1512699879', '37128823');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1064149042', '92936760');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1533226259', '22231509');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1188658313', '44342315');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1248743634', '14891503');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1066485670', '27769776');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1240472727', '73579221');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1559397885', '42940045');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1075381249', '77018858');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1019094536', '16455966');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1088749138', '48845427');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1512441807', '16248780');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1274699109', '68740701');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1095823942', '78720420');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1086838868', '80185212');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1059301836', '71688757');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1067645325', '45970645');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1082868194', '86677298');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1163814845', '48157238');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1215999719', '58673754');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1546762346', '67115657');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1091955540', '32747979');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1556516574', '95252321');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1141417109', '16161450');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1218813535', '42058942');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1064986037', '52864290');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1235512949', '57187381');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1595843620', '90105586');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1095084053', '74512931');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1070058020', '40140478');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1057426015', '21945556');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1524262578', '61081562');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1295202393', '72581757');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1013504964', '97494228');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1092292371', '32014634');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1012422786', '93763380');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1038404028', '12533980');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1088232095', '20046157');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1135598136', '95023229');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1241346122', '40533284');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1545716654', '26107194');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1011914173', '51552081');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1555453016', '74160746');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1153640323', '34285151');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1225377798', '35922745');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1092479810', '75134291');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1229875980', '30913540');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1581059839', '96884121');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1093244809', '64820357');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1080760458', '60787775');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1019646221', '78310572');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1581226043', '99541637');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1243077803', '92161552');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1055814761', '22086526');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1044648441', '37995831');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1048603116', '79021788');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1069596622', '68878821');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1048963130', '75001883');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1167510688', '60753431');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1247870595', '18060107');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1519430424', '92079146');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1078752855', '88635327');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1587014161', '36405055');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1169037788', '44030574');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1220814185', '24330910');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1063690119', '19285567');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1289434122', '43040787');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1560621578', '29123378');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1048031766', '17269439');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1095315692', '54896683');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1046119030', '52251241');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1517476255', '44725567');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1217568342', '36969958');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1012707109', '63530617');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1044040290', '39849186');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1082246395', '31751135');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1078220765', '62992334');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1090039986', '10549059');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1115973191', '37785122');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1230291668', '78726579');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1591080469', '51082588');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1040472236', '91176872');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1556910218', '95317540');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1195666959', '16227346');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1257667909', '38551291');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1079180025', '45799284');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1288120228', '14019955');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1598931454', '60753431');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1012352172', '18060107');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1065572003', '92079146');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1096183937', '88635327');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1559122222', '36405055');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1243014567', '44030574');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1047510052', '24330910');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1081354510', '19285567');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1059775650', '43040787');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1061191196', '29123378');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1040033386', '17269439');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1177506340', '72581757');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1269947916', '97494228');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1536826206', '32014634');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1082076526', '93763380');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1580482075', '12533980');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1183736964', '20046157');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1259224028', '95023229');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1085359612', '40533284');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1266481642', '26107194');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1543584751', '44342315');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1013356957', '14891503');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1064361571', '27769776');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1083487972', '73579221');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1548889708', '42940045');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1220927985', '77018858');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1053440990', '16455966');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1069667404', '48845427');
INSERT INTO `airport`.`employee_phone` (`phone`, `employee_ssn`) VALUES ('1090138250', '16248780');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`mechanic`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5951, '2020-08-08', '16227346');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5952, '2021-09-08', '38551291');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5963, '2019-09-08', '45799284');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5954, '2015-10-25', '14019955');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (6955, '2018-12-03', '74394299');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5956, '2014-02-01', '30181194');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5957, '2010-08-15', '72148359');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (7958, '2014-01-09', '53292373');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5959, '2014-08-17', '22444081');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5960, '2013-09-16', '45771026');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5961, '2022-09-07', '94101071');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5962, '2020-07-12', '25394954');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5963, '2023-01-15', '26392847');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5964, '2023-12-05', '61397430');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (9965, '2020-09-15', '64399581');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5966, '2020-07-13', '40322395');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5867, '2021-05-28', '48374362');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5968, '2020-08-09', '24870503');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5969, '2020-01-20', '75030339');
INSERT INTO `airport`.`mechanic` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (5900, '2021-05-28', '81920258');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`ame`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`ame` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (6598, '2020-09-17', '44198755');
INSERT INTO `airport`.`ame` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (6599, '2021-08-06', '91641034');
INSERT INTO `airport`.`ame` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (6660, '2022-01-30', '22675891');
INSERT INTO `airport`.`ame` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (6681, '2020-02-28', '80459206');
INSERT INTO `airport`.`ame` (`certificate_no`, `i_date`, `employee_ssn`) VALUES (6602, '2019-04-15', '75087307');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`airline`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('RJ', 'RJA', 'OJAI', 'royal jordanian');
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('AF', 'AFR', 'LFPG', 'air france');
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('TK', 'THY', 'LTFM', 'turkish airlines');
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('LH', 'DLH', 'EDDF', 'lufthansa');
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('EK', 'UAE', 'OMDB', 'emirates');
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('LX', 'SWR', 'LSZH', 'swiss');
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('TU', 'TAR', 'DTTA', 'tunisair');
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('QR', 'QTR', 'OTHH', 'qatar airways');
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('SV', 'SVA', 'OERK', 'saudi airlines');
INSERT INTO `airport`.`airline` (`iata`, `icao`, `base-airport`, `name`) VALUES ('MS', 'MSR', 'HECA', 'egyptair');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`air_employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (0, 'RJA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (1, 'RJA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (2, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (3, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (4, 'THY');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (5, 'THY');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (6, 'DLH');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (7, 'DLH');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (8, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (9, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (10, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (11, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (12, 'SVA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (13, 'SVA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (14, 'QTR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (15, 'QTR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (16, 'TAR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (17, 'TAR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (18, 'SWR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (19, 'SWR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (20, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (21, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (22, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (23, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (24, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (25, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (26, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (27, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (28, 'AFR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (29, 'RJA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (30, 'RJA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (31, 'RJA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (32, 'RJA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (33, 'THY');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (34, 'THY');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (35, 'THY');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (36, 'THY');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (37, 'THY');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (38, 'THY');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (39, 'THY');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (40, 'DLH');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (41, 'DLH');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (42, 'DLH');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (43, 'DLH');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (44, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (45, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (46, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (47, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (48, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (49, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (50, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (51, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (52, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (53, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (54, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (55, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (56, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (57, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (58, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (59, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (60, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (61, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (62, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (63, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (64, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (65, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (66, 'MSR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (67, 'SVA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (68, 'SVA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (69, 'SVA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (70, 'SVA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (71, 'SVA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (72, 'SVA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (73, 'SVA');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (74, 'QTR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (75, 'QTR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (76, 'QTR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (77, 'QTR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (78, 'TAR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (79, 'TAR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (80, 'TAR');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (81, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (82, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (83, 'UAE');
INSERT INTO `airport`.`air_employee` (`id`, `airline_icao`) VALUES (84, 'UAE');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`flight_attendant`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (100, '77018858', 20);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (150, '16455966', 21);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (122, '12533980', 22);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (15, '20046157', 23);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (98, '95023229', 24);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (65, '48845427', 25);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (56, '16248780', 26);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (15, '40533284', 27);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (98, '26107194', 28);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (65, '51552081', 29);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (45, '68740701', 30);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (23, '78720420', 31);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (91, '74160746', 32);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (154, '34285151', 33);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (12, '35922745', 34);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (55, '80185212', 35);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (65, '71688757', 36);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (26, '75134291', 37);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (65, '30913540', 38);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (89, '96884121', 39);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (65, '45970645', 40);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (23, '86677298', 41);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (312, '64820357', 42);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (65, '60787775', 43);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (32, '78310572', 44);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (12, '48157238', 45);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (56, '58673754', 46);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (60, '99541637', 47);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (56, '92161552', 48);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (32, '22086526', 49);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (69, '67115657', 50);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (95, '32747979', 51);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (98, '95252321', 52);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (65, '37995831', 53);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (32, '79021788', 54);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (5, '68878821', 55);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (45, '16161450', 56);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (53, '42058942', 57);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (52, '52864290', 58);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (51, '75001883', 59);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (50, '60753431', 60);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (49, '18060107', 61);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (49, '57187381', 62);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (48, '90105586', 63);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (47, '92079146', 64);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (46, '88635327', 65);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (45, '36405055', 66);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (44, '74512931', 67);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (44, '40140478', 68);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (43, '44030574', 69);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (42, '24330910', 70);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (41, '19285567', 71);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (40, '21945556', 72);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (39, '61081562', 73);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (39, '43040787', 74);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (38, '29123378', 75);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (37, '17269439', 76);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (36, '72581757', 77);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (35, '97494228', 78);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (34, '54896683', 79);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (34, '52251241', 80);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (33, '44725567', 81);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (32, '36969958', 82);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (31, '32014634', 83);
INSERT INTO `airport`.`flight_attendant` (`flight_hours`, `employee_ssn`, `air_emp_id`) VALUES (30, '93763380', 84);

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`language`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '77018858');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '16455966');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '48845427');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '16248780');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '68740701');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '78720420');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '80185212');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '71688757');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '45970645');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '86677298');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '48157238');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '58673754');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '67115657');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '32747979');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '95252321');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '16161450');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '42058942');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '52864290');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '57187381');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '90105586');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '74512931');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '40140478');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '21945556');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '61081562');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '72581757');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '97494228');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '32014634');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '93763380');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '12533980');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '20046157');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '95023229');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '40533284');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '26107194');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '51552081');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '74160746');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '34285151');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '35922745');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '75134291');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '30913540');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '96884121');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '64820357');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '60787775');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '78310572');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '99541637');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '92161552');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '22086526');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '37995831');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '79021788');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '68878821');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '75001883');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '60753431');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '18060107');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '92079146');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '88635327');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '36405055');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '44030574');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '24330910');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '19285567');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '43040787');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '29123378');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '17269439');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '54896683');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '52251241');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '44725567');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('ar', '36969958');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '77018858');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '16455966');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '48845427');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '16248780');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '68740701');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '78720420');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '80185212');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '71688757');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '45970645');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '86677298');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '48157238');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '58673754');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '67115657');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '32747979');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '95252321');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '16161450');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '42058942');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '52864290');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '57187381');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '90105586');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '74512931');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '40140478');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '21945556');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '61081562');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '72581757');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '97494228');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '32014634');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '93763380');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '12533980');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '20046157');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '95023229');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '40533284');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '26107194');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '51552081');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '74160746');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '34285151');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '35922745');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '75134291');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '30913540');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '96884121');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '64820357');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '60787775');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '78310572');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '99541637');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '92161552');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '22086526');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '37995831');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '79021788');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('en', '68878821');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '75001883');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '60753431');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '18060107');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '92079146');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '88635327');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '36405055');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '44030574');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '24330910');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '19285567');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '43040787');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '29123378');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '17269439');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '54896683');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '52251241');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '44725567');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('es', '36969958');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '77018858');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '16455966');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '48845427');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '16248780');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '68740701');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '78720420');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '80185212');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '71688757');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '45970645');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '86677298');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '48157238');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '58673754');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '67115657');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '32747979');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '95252321');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '16161450');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '42058942');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '52864290');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '57187381');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '90105586');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '74512931');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('de', '40140478');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '21945556');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '61081562');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '72581757');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '97494228');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '32014634');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '93763380');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '12533980');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '20046157');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '95023229');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '40533284');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '26107194');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '51552081');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '74160746');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '34285151');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '35922745');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '75134291');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '30913540');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '96884121');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '64820357');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '60787775');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '78310572');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '99541637');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '92161552');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '22086526');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '37995831');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '79021788');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '68878821');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '75001883');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '60753431');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '18060107');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '92079146');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '88635327');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('tr', '36405055');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '44030574');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '24330910');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '19285567');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '43040787');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '29123378');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '17269439');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '54896683');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '52251241');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '44725567');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '36969958');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '51552081');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '74160746');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '34285151');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '35922745');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '75134291');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '30913540');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '96884121');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '64820357');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('zh', '60787775');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '78310572');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '99541637');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '92161552');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '22086526');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '37995831');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '79021788');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '68878821');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '75001883');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '60753431');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '18060107');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '92079146');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '88635327');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '36405055');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '42058942');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '52864290');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '57187381');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '90105586');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '74512931');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '40140478');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '21945556');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '61081562');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '72581757');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '97494228');
INSERT INTO `airport`.`language` (`language`, `employee_ssn`) VALUES ('sv', '32014634');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`pilot`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (71, 7331, '2019-09-17', '93913838', 0);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (164, 7244, '2022-07-22', '62992334', 1);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (47, 8041, '2022-08-23', '78715471', 2);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (61, 3749, '2021-06-21', '31751135', 3);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (85, 8872, '2021-08-08', '17649414', 4);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (88, 3419, '2021-05-10', '39849186', 5);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (148, 2932, '2022-01-20', '58733011', 6);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (93, 4176, '2020-04-19', '63530617', 7);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (38, 7571, '2020-09-28', '77706885', 8);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (38, 3358, '2019-04-15', '92233307', 9);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (49, 4351, '2015-05-09', '37218044', 10);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (36, 3072, '2016-06-10', '68422285', 11);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (166, 4163, '2015-07-12', '37128823', 12);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (39, 3758, '2017-08-12', '92936760', 13);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (50, 5333, '2017-09-19', '22231509', 14);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (164, 6983, '2018-10-14', '44342315', 15);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (108, 4671, '2018-11-15', '14891503', 16);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (156, 8139, '2019-12-16', '27769776', 17);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (98, 1947, '2019-02-17', '73579221', 18);
INSERT INTO `airport`.`pilot` (`flight_hours`, `certificate_no`, `i_date`, `employee_ssn`, `air_emp_id`) VALUES (50, 7059, '2020-03-18', '42940045', 19);

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`hanger`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (1, 'next to terminal1');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (2, 'next to terminal2');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (3, 'next to runway 1');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (4, 'next to runway 2');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (5, 'close to runway 1');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (6, 'close to terminal3');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (7, 'close to terminal4');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (8, 'between terminal4 and  terminal3');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (9, 'between terminal1 and  terminal2');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (10, 'next to terminal4');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (11, 'next to hanger10');
INSERT INTO `airport`.`hanger` (`no`, `location`) VALUES (12, 'next to hanger11');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`bus_hanger`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`bus_hanger` (`Capacity`, `hanger_no`) VALUES (3, 1);
INSERT INTO `airport`.`bus_hanger` (`Capacity`, `hanger_no`) VALUES (3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`bus`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`bus` (`bus_no`, `bus_type`, `capacity`, `bus_status`, `hanger_no`) VALUES (1, 'A', 100, 'a', 1);
INSERT INTO `airport`.`bus` (`bus_no`, `bus_type`, `capacity`, `bus_status`, `hanger_no`) VALUES (2, 'B', 120, 'a', 1);
INSERT INTO `airport`.`bus` (`bus_no`, `bus_type`, `capacity`, `bus_status`, `hanger_no`) VALUES (3, 'C', 80, 'a', 1);
INSERT INTO `airport`.`bus` (`bus_no`, `bus_type`, `capacity`, `bus_status`, `hanger_no`) VALUES (4, 'C', 80, 'a', 2);
INSERT INTO `airport`.`bus` (`bus_no`, `bus_type`, `capacity`, `bus_status`, `hanger_no`) VALUES (5, 'A', 100, 'a', 2);
INSERT INTO `airport`.`bus` (`bus_no`, `bus_type`, `capacity`, `bus_status`, `hanger_no`) VALUES (6, 'B', 120, 'd', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`weather_data`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('DT_231130', 'DT', 36.8, 10.18, '2023-11-30', 'Partly cloudy', 24.1, 'WSW', 23, 0, 40, 1011, 10, 50);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('ED_231129', 'ED', 52.52, 13.4, '2023-11-29', 'Clear', 13, 'WSW', 17.8, 0, 82, 1020, 10, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('HE_231130', 'HE', 30.05, 31.25, '2023-11-30', 'Partly cloudy', 19.1, 'NW', 15.1, 0, 46, 1008, 10, 50);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('HE_231129', 'HE', 30.05, 31.25, '2023-11-29', 'Clear', 19.1, 'E', 27.4, 0, 46, 1006, 10, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('HE_231128', 'HE', 30.05, 31.25, '2023-11-28', 'Clear', 9, 'NNW', 21.6, 0, 70, 1012, 6, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('K_231129', 'K', 46.6, -120.49, '2023-11-29', 'Sunny', 34.9, 'SSW', 20.7, 0, 45, 1016, 16, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LF_231128', 'LF', 48.87, 2.33, '2023-11-28', 'Overcast', 13, 'SW', 23.9, 0, 94, 1005, 10, 100);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LF_231129', 'LF', 48.87, 2.33, '2023-11-29', 'Moderate rain', 22, 'SW', 30.7, 2.8, 82, 998, 10, 50);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LH_231129', 'LH', 47.5, 19.08, '2023-11-29', 'Light rain shower', 11.2, 'SSW', 7.2, 1.37, 88, 1005, 10, 75);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LI_231128', 'LI', 41.9, 12.48, '2023-11-28', 'Sunny', 13, 'W', 17.3, 0, 48, 1017, 10, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LI_231129', 'LI', 41.9, 12.48, '2023-11-29', 'Clear', 6.1, 'SSE', 14, 0, 69, 1019, 10, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LL_231129', 'LL', 31.78, 35.23, '2023-11-29', 'Moderate rain', 13, 'S', 26.5, 2.55, 65, 1014, 10, 75);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LN_231128', 'LN', 43.73, 7.42, '2023-11-28', 'Partly cloudy', 20.2, 'S', 22.3, 0, 73, 1002, 10, 50);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LS_231128', 'LS', 46.92, 7.47, '2023-11-28', 'Partly cloudy', 3.6, 'SSE', 4, 0, 77, 1013, 10, 75);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LS_231129', 'LS', 46.92, 7.47, '2023-11-29', 'Fog', 3.6, 'S', 12.9, 0, 99, 1020, 4, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LT_231128', 'LT', 39.93, 32.86, '2023-11-28', 'Heavy rain with thunder', 55.3, 'W', 11, 7.6, 83, 1020, 10, 75);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('LW_231129', 'LW', 42, 21.43, '2023-11-29', 'Light rain', 3.6, 'WNW', 20.9, 1.4, 88, 1006, 10, 100);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('OB_231130', 'OB', 26.24, 50.58, '2023-11-30', 'Partly cloudy', 11.2, 'NNW', 29.1, 0, 75, 1012, 10, 25);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('OE_231128', 'OE', 24.64, 46.77, '2023-11-28', 'Clear', 4, 'ESE', 23.3, 0, 65, 1017, 10, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('OE_231130', 'OE', 24.64, 46.77, '2023-11-30', 'Mist', 4, 'N', 20.6, 0, 85, 1022, 5, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('OJ_231128', 'OJ', 31.95, 35.93, '2023-11-28', 'Mist', 3.6, 'N', 15.8, 0, 51, 1011, 5, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('OM_231128', 'OM', 24.47, 54.37, '2023-11-28', 'Sunny', 11.2, 'WNW', 40.3, 0, 10, 999, 10, 0);
INSERT INTO `airport`.`weather_data` (`cd`, `country_code`, `latitude`, `logitude`, `log_date`, `weather_condition`, `wind_speed`, `wind_direction`, `wind_gust`, `precipitation`, `humidity`, `air_pressure`, `relative_visibility`, `cloud_coverage`) VALUES ('OT_231130', 'OT', 25.29, 51.53, '2023-11-30', 'Clear', 6.8, 'W', 18, 0, 60, 999, 10, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`maintain`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`maintain` (`m_date`, `bus_malfunction`, `repair_time`, `bus_no`, `employee_ssn`) VALUES ('2023-11-30', 'Engine failure', '06:32:00', 6, '16227346');
INSERT INTO `airport`.`maintain` (`m_date`, `bus_malfunction`, `repair_time`, `bus_no`, `employee_ssn`) VALUES ('2023-11-30', 'Engine failure', '06:32:00', 6, '38551291');
INSERT INTO `airport`.`maintain` (`m_date`, `bus_malfunction`, `repair_time`, `bus_no`, `employee_ssn`) VALUES ('2023-11-30', 'Engine failure', '06:32:00', 6, '45799284');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`plane`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (1, 853, 560000, 'A380-8', 'D', 'UAE', 3, 'airbus');
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (2, 240, 90000, 'A321ne', 'A', 'DLH', 4, 'airbus');
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (3, 406, 242000, 'A330', 'A', 'THY', 5, 'airbus');
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (4, 480, 322000, 'A350-9', 'A', 'AFR', 6, 'airbus');
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (5, 190, 78000, 'A320', 'A', 'RJA', 7, 'airbus');
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (6, 550, 351000, '777-30', 'A', 'MSR', 8, 'boeing');
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (7, 440, 247200, '777-20', 'A', 'SVA', 9, 'boeing');
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (8, 254, 127900, '787-8', 'A', 'QTR', 10, 'boeing');
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (9, 150, 75500, '316-14', 'A', 'TAR', 12, 'airbus');
INSERT INTO `airport`.`plane` (`plane_id`, `capacity`, `weight`, `model`, `status`, `airline_icao`, `hanger_no`, `brand`) VALUES (10, 190, 78000, 'A320', 'A', 'SWR', 11, 'airbus');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`P_maintains`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`P_maintains` (`p_malfunction`, `p_end_maintains_date`, `p_start_mantains_date`, `plane_id`, `mechanic_ssn`, `ame_ssn`) VALUES ('Engine failure', '2023-11-30', '2023-11-28', 1, '14019955', '44198755');
INSERT INTO `airport`.`P_maintains` (`p_malfunction`, `p_end_maintains_date`, `p_start_mantains_date`, `plane_id`, `mechanic_ssn`, `ame_ssn`) VALUES ('Engine failure', '2023-11-30', '2023-11-28', 1, '74394299', '44198755');
INSERT INTO `airport`.`P_maintains` (`p_malfunction`, `p_end_maintains_date`, `p_start_mantains_date`, `plane_id`, `mechanic_ssn`, `ame_ssn`) VALUES ('Engine failure', '2023-11-30', '2023-11-28', 1, '30181194', '44198755');
INSERT INTO `airport`.`P_maintains` (`p_malfunction`, `p_end_maintains_date`, `p_start_mantains_date`, `plane_id`, `mechanic_ssn`, `ame_ssn`) VALUES ('Engine failure', '2023-11-30', '2023-11-28', 1, '72148359', '44198755');
INSERT INTO `airport`.`P_maintains` (`p_malfunction`, `p_end_maintains_date`, `p_start_mantains_date`, `plane_id`, `mechanic_ssn`, `ame_ssn`) VALUES ('Engine failure', '2023-11-30', '2023-11-28', 1, '53292373', '44198755');
INSERT INTO `airport`.`P_maintains` (`p_malfunction`, `p_end_maintains_date`, `p_start_mantains_date`, `plane_id`, `mechanic_ssn`, `ame_ssn`) VALUES ('Engine failure', '2023-11-30', '2023-11-28', 1, '22444081', '44198755');
INSERT INTO `airport`.`P_maintains` (`p_malfunction`, `p_end_maintains_date`, `p_start_mantains_date`, `plane_id`, `mechanic_ssn`, `ame_ssn`) VALUES ('Engine failure', '2023-11-30', '2023-11-28', 1, '45771026', '44198755');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`passenger`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2252295396', 'Mckinley ', 'P', ' Harris', 'garman', 'p', 'DEU', 'M', '2021-04-06', '2028-04-05', '1989-08-12', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2283592982', 'Johnnie ', 'Z', ' Haley', 'garman', 'p', 'DEU', 'F', '2020-09-25', '2027-09-25', '1927-10-03', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2286325238', 'Queen ', 'W', ' Woods', 'garman', 's', 'DEU', 'F', '2021-03-11', '2028-03-10', '1999-12-25', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2295588457', 'Sheldon ', 'J', ' Mccoy', 'garman', 'd', 'DEU', 'M', '2022-02-02', '2029-02-01', '1950-11-11', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2328755336', 'Tamra ', 'V', ' Gilmore', 'garman', 'p', 'DEU', 'F', '2023-10-24', '2030-10-23', '1935-01-22', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2335546342', 'Kristofer ', 'J', ' Richard', 'garman', 'd', 'DEU', 'M', '2017-01-12', '2024-01-12', '1966-10-26', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2335773385', 'Polly ', 'C', ' Velasquez', 'garman', 'p', 'DEU', 'F', '2021-03-03', '2028-03-02', '1985-12-16', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2347565765', 'Meredith ', 'R', ' Carrillo', 'garman', 'd', 'DEU', 'F', '2020-11-12', '2027-11-12', '1957-08-03', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2353459876', 'Laurence ', 'I', ' Benton', 'garman', 'd', 'DEU', 'M', '2020-01-01', '2026-12-31', '2017-03-07', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2382922852', 'Janelle ', 'Q', ' Dalton', 'garman', 'p', 'DEU', 'F', '2019-01-14', '2026-01-13', '2000-07-12', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2447439384', 'Oscar ', 'N', ' Noble', 'garman', 'p', 'DEU', 'M', '2023-09-07', '2030-09-06', '2008-10-29', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2453828595', 'Ila ', 'Y', ' Duke', 'garman', 'd', 'DEU', 'F', '2017-04-01', '2024-03-31', '2004-03-22', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2463998398', 'Cherie ', 'L', ' Weaver', 'garman', 'd', 'DEU', 'F', '2017-04-22', '2024-04-21', '1999-10-29', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2523877429', 'Cornelius ', 'V', ' Morton', 'garman', 'p', 'DEU', 'M', '2019-11-23', '2026-11-22', '1951-06-20', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2535829596', 'Pete ', 'V', ' Thompson', 'garman', 'lp', 'DEU', 'M', '2023-01-18', '2030-01-17', '1961-02-14', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2555498976', 'Ruthie ', 'P', ' Mills', 'garman', 'p', 'DEU', 'F', '2023-05-28', '2030-05-27', '1954-06-06', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2635276349', 'Brett ', 'B', ' Raymond', 'garman', 'p', 'DEU', 'M', '2017-06-21', '2024-06-20', '1938-02-18', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2648348953', 'Chris ', 'I', ' Lane', 'garman', 'dlp', 'DEU', 'M', '2021-12-16', '2028-12-15', '1961-12-17', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2674572237', 'Rebecca ', 'K', ' Dickerson', 'garman', 'p', 'DEU', 'F', '2018-11-09', '2025-11-08', '1943-01-18', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2686899866', 'Aurelia ', 'V', ' Ramos', 'garman', 'dlp', 'DEU', 'F', '2022-08-18', '2029-08-17', '2002-01-24', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2724298754', 'Erick ', 'T', ' Black', 'garman', 'd', 'DEU', 'M', '2021-11-14', '2028-11-13', '1994-03-25', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2728363359', 'Vicki ', 'I', ' Ward', 'garman', 'lp', 'DEU', 'F', '2022-07-17', '2029-07-16', '1949-10-20', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2747564776', 'Huey ', 'E', ' Craig', 'garman', 'p', 'DEU', 'M', '2017-09-07', '2024-09-06', '1971-03-13', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2749284536', 'Karen ', 'T', ' Edwards', 'garman', 'dlp', 'DEU', 'F', '2021-01-28', '2028-01-28', '1944-04-12', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2749469593', 'Janine ', 'U', ' Stewart', 'garman', 'p', 'DEU', 'F', '2022-06-24', '2029-06-23', '2021-02-03', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2762945453', 'Yolanda ', 'G', ' Petty', 'garman', 'p', 'DEU', 'F', '2022-06-02', '2029-06-01', '1937-05-18', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2764826498', 'Kermit ', 'G', ' York', 'garman', 'd', 'DEU', 'M', '2023-07-25', '2030-07-24', '1992-07-11', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2773285673', 'Michael ', 'Z', ' Beltran', 'garman', 'p', 'DEU', 'F', '2021-08-26', '2028-08-25', '1965-10-08', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2787789457', 'Josefa ', 'T', ' Owens', 'garman', 'p', 'DEU', 'F', '2019-06-25', '2026-06-24', '1944-03-11', 'munich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2832567477', 'Daron ', 'T', ' Werner', 'french', 'p', 'FRA', 'M', '2020-06-11', '2027-06-11', '1982-05-03', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2839738325', 'Susanna ', 'z', ' Villanueva', 'french', 'p', 'FRA', 'F', '2017-07-28', '2024-07-27', '1928-03-30', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2844595857', 'Hilario ', 'A', ' Gardner', 'french', 'p', 'FRA', 'M', '2017-06-08', '2024-06-07', '2018-10-25', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2892976634', 'Patsy ', 'Y', ' Beltran', 'french', 'p', 'FRA', 'F', '2018-06-16', '2025-06-15', '2021-07-01', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2922593887', 'Estella ', 'O', ' Beasley', 'french', 'p', 'FRA', 'F', '2018-12-07', '2025-12-06', '2008-03-05', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2947667352', 'Richie ', 'H', ' Cooley', 'french', 'p', 'FRA', 'M', '2019-05-01', '2026-04-30', '1947-04-08', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2956345993', 'Kurtis ', 'A', ' Jefferson', 'french', 'p', 'FRA', 'M', '2019-04-29', '2026-04-28', '1927-06-11', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('2959234696', 'Dolores ', 'C', ' Ortiz', 'french', 'p', 'FRA', 'F', '2020-08-20', '2027-08-20', '1981-12-30', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3258442443', 'Alma ', 'J', ' House', 'french', 'p', 'FRA', 'F', '2022-03-30', '2029-03-29', '1928-11-16', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3259865689', 'Horace ', 'L', ' Wells', 'french', 'p', 'FRA', 'M', '2022-07-02', '2029-07-01', '1976-10-08', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3274935229', 'Rodger ', 'D', ' Patton', 'french', 'd', 'FRA', 'M', '2023-10-11', '2030-10-10', '1923-11-29', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3275284847', 'Kendra ', 'J', ' Webb', 'french', 'p', 'FRA', 'F', '2019-06-10', '2026-06-09', '2007-04-24', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3288475294', 'Alissa ', 'H', ' Larsen', 'french', 'd', 'FRA', 'F', '2017-12-12', '2024-12-11', '2018-03-20', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3345968595', 'Reba ', 'I', ' Wilcox', 'french', 'p', 'FRA', 'F', '2017-10-30', '2024-10-29', '1945-04-05', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3424446763', 'Greg ', 'N', ' Schaefer', 'french', 's', 'FRA', 'M', '2019-04-07', '2026-04-06', '1959-06-20', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3449882282', 'Debbie ', 'W', ' Russell', 'french', 'p', 'FRA', 'F', '2022-01-24', '2029-01-23', '2007-10-28', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3522399854', 'Antoinette ', 'F', ' Solis', 'french', 'p', 'FRA', 'F', '2017-05-25', '2024-05-24', '1945-10-14', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3522796642', 'Shelby ', 'N', ' Hopkins', 'french', 'p', 'FRA', 'F', '2020-04-22', '2027-04-22', '1933-01-24', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3565756995', 'Lester ', 'W', ' Archer', 'french', 'p', 'FRA', 'M', '2017-12-03', '2024-12-02', '1934-04-18', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3626984258', 'Lester ', 'X', ' Washington', 'french', 'p', 'FRA', 'M', '2022-11-14', '2029-11-13', '2019-01-19', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3635977824', 'Blaine ', 'V', ' Chen', 'french', 'p', 'FRA', 'M', '2017-02-20', '2024-02-20', '2023-11-03', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3639355687', 'Ferdinand ', 'M', ' Patrick', 'french', 'p', 'FRA', 'M', '2020-07-11', '2027-07-11', '2009-10-27', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3666926388', 'Rey ', 'z', ' Hickman', 'french', 'p', 'FRA', 'M', '2018-07-21', '2025-07-20', '1928-01-06', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3698538489', 'Maude ', 'Q', ' Burgess', 'french', 'd', 'FRA', 'F', '2021-07-22', '2028-07-21', '1922-01-18', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3742973539', 'Edgardo ', 'O', ' Foster', 'french', 'p', 'FRA', 'M', '2023-03-20', '2030-03-19', '1948-03-31', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3748943442', 'Jaclyn ', 'D', ' Fitzpatrick', 'french', 'p', 'FRA', 'F', '2016-12-23', '2023-12-23', '1954-05-05', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3772237436', 'Jerrod ', 'S', ' Woods', 'french', 'p', 'FRA', 'M', '2023-05-16', '2030-05-15', '1993-11-03', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3775594333', 'Lincoln ', 'T', ' Buck', 'french', 'p', 'FRA', 'M', '2023-02-04', '2030-02-03', '2016-08-16', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3834836835', 'Irving ', 'E', ' Harrison', 'french', 'p', 'FRA', 'M', '2018-07-11', '2025-07-10', '2013-10-06', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3837496798', 'Adolph ', 'Q', ' Vang', 'french', 'p', 'FRA', 'M', '2021-04-13', '2028-04-12', '1990-05-14', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3845636933', 'Jolene ', 'M', ' Maxwell', 'swiss', 'd', 'CHE', 'F', '2022-12-31', '2029-12-30', '1978-07-06', 'paris');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3848473468', 'Kimberly ', 'Q', ' Barrett', 'swiss', 'p', 'CHE', 'F', '2023-09-17', '2030-09-16', '1944-12-07', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3896957555', 'Kenton ', 'D', ' Sheppard', 'swiss', 'd', 'CHE', 'M', '2020-03-23', '2027-03-23', '1973-08-31', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3897945276', 'Mary ', 'Y', ' Case', 'swiss', 'd', 'CHE', 'M', '2022-05-22', '2029-05-21', '2003-08-01', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3936226835', 'Vivian ', 'C', ' Obrien', 'swiss', 'lp', 'CHE', 'F', '2023-04-06', '2030-04-05', '2002-10-05', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3977675334', 'Latonya ', 'A', ' Patrick', 'swiss', 'p', 'CHE', 'F', '2022-12-13', '2029-12-12', '1928-07-21', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3979448924', 'Felix ', 'U', ' Ballard', 'swiss', 'p', 'CHE', 'M', '2022-01-28', '2029-01-27', '1976-02-03', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3985522757', 'Karla ', 'M', ' Mcknight', 'swiss', 'p', 'CHE', 'F', '2022-01-29', '2029-01-28', '1949-12-06', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3986338888', 'Brittney ', 'I', ' Frye', 'swiss', 'p', 'CHE', 'F', '2017-05-27', '2024-05-26', '1965-11-08', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3987866894', 'Jacquelyn ', 'I', ' Hill', 'swiss', 'dlp', 'CHE', 'F', '2023-06-19', '2030-06-18', '2022-06-19', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('3989963958', 'Benedict ', 'Y', ' Sparks', 'swiss', 'p', 'CHE', 'M', '2022-06-03', '2029-06-02', '1965-01-19', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4224872334', 'Sophie ', 'A', ' Holder', 'swiss', 'lp', 'CHE', 'F', '2017-09-23', '2024-09-22', '1946-05-31', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4226529867', 'Leo ', 'O', ' Bass', 'swiss', 'p', 'CHE', 'M', '2017-10-29', '2024-10-28', '2012-04-24', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4226574923', 'Rita ', 'P', ' Armstrong', 'swiss', 'dlp', 'CHE', 'F', '2018-07-13', '2025-07-12', '1936-07-04', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4229659453', 'Reyna ', 'S', ' Bradford', 'swiss', 'p', 'CHE', 'F', '2019-12-03', '2026-12-02', '2003-11-27', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4237869933', 'Angelique ', 'S', ' Mcfarland', 'swiss', 'lp', 'CHE', 'F', '2019-02-04', '2026-02-03', '2010-03-13', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4272943933', 'Beverley ', 'I', ' Fernandez', 'swiss', 'p', 'CHE', 'F', '2023-08-30', '2030-08-29', '1992-06-26', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4275484462', 'Alphonso ', 'W', ' Sherman', 'swiss', 'p', 'CHE', 'M', '2017-10-20', '2024-10-19', '1921-02-18', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4282583398', 'Tracie ', 'E', ' Carey', 'swiss', 'p', 'CHE', 'F', '2020-12-31', '2027-12-31', '2001-11-10', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4284667858', 'Curtis ', 'I', ' Rice', 'swiss', 's', 'CHE', 'M', '2017-11-13', '2024-11-12', '2006-11-19', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4325944875', 'Bob ', 'Y', ' Nunez', 'swiss', 'lp', 'CHE', 'M', '2018-08-09', '2025-08-08', '1926-11-16', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4332644299', 'Jerald ', 'C', ' Pena', 'swiss', 'p', 'CHE', 'M', '2018-06-12', '2025-06-11', '2021-05-08', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4339827945', 'Herminia ', 'I', ' Ponce', 'swiss', 'lp', 'CHE', 'F', '2022-08-18', '2029-08-17', '2015-09-24', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4343322574', 'Shawna ', 'D', ' Ryan', 'swiss', 'dlp', 'CHE', 'F', '2023-02-01', '2030-01-31', '1987-09-07', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4355653375', 'Chris ', 'V', ' Whitaker', 'swiss', 'p', 'CHE', 'F', '2017-09-26', '2024-09-25', '2009-01-22', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4374974334', 'Jessica ', 'I', ' Dickson', 'swiss', 's', 'CHE', 'F', '2020-12-16', '2027-12-16', '1965-10-04', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4422886842', 'Cedric ', 'O', ' Campos', 'swiss', 'd', 'CHE', 'M', '2017-05-26', '2024-05-25', '1956-02-07', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4426834682', 'Thurman ', 'Z', ' Blair', 'swiss', 'p', 'CHE', 'M', '2021-09-22', '2028-09-21', '2012-09-23', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4438687828', 'Daron ', 'X', ' Sullivan', 'swiss', 'd', 'CHE', 'M', '2021-11-27', '2028-11-26', '1927-03-10', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4452563658', 'Trisha ', 'T', ' Berg', 'swiss', 'p', 'CHE', 'F', '2020-10-29', '2027-10-29', '1930-06-12', 'zurich');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4484845979', 'Catalina ', 'L', ' Jimenez', 'turkish', 'p', 'TUR', 'F', '2021-05-27', '2028-05-26', '1983-06-21', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4544397867', 'Kirk ', 'J', ' Casey', 'turkish', 'lp', 'TUR', 'M', '2023-03-28', '2030-03-27', '1991-12-05', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4553876858', 'Lenora ', 'I', ' Hamilton', 'turkish', 'p', 'TUR', 'F', '2017-04-28', '2024-04-27', '1946-06-07', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4633355548', 'Steve ', 'z', ' Soto', 'turkish', 'lp', 'TUR', 'M', '2017-10-29', '2024-10-28', '1920-09-21', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4642267586', 'Cruz ', 'Q', ' Navarro', 'turkish', 'p', 'TUR', 'M', '2023-09-15', '2030-09-14', '1973-08-14', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4645874298', 'Derrick ', 'H', ' Ashley', 'turkish', 'd', 'TUR', 'M', '2023-10-21', '2030-10-20', '1958-01-03', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4675394848', 'Donald ', 'U', ' Cain', 'turkish', 's', 'TUR', 'M', '2021-05-26', '2028-05-25', '1955-04-19', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4738832259', 'Man ', 'Y', ' Goodman', 'turkish', 'lp', 'TUR', 'M', '2023-06-04', '2030-06-03', '1967-03-11', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4739658926', 'Everett ', 'S', ' Lin', 'turkish', 'dlp', 'TUR', 'M', '2017-08-14', '2024-08-13', '2013-07-09', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4754269574', 'Dorothy ', 'I', ' Turner', 'turkish', 'p', 'TUR', 'F', '2020-06-29', '2027-06-29', '1956-09-08', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4793955829', 'Lesley ', 'P', ' Osborn', 'turkish', 'p', 'TUR', 'F', '2018-04-13', '2025-04-12', '2001-06-07', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4822835897', 'Kirsten ', 'C', ' Ayala', 'turkish', 'p', 'TUR', 'F', '2020-06-08', '2027-06-08', '1944-12-12', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4852562395', 'Rolland ', 'A', ' Schneider', 'turkish', 'p', 'TUR', 'M', '2020-07-23', '2027-07-23', '1968-10-27', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4853536689', 'Melissa ', 'T', ' Chapman', 'turkish', 'p', 'TUR', 'F', '2018-02-20', '2025-02-19', '1920-08-20', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4868593725', 'Irene ', 'U', ' Benitez', 'turkish', 's', 'TUR', 'F', '2019-02-15', '2026-02-14', '1979-08-13', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4869656699', 'Sam ', 'z', ' Noble', 'turkish', 'd', 'TUR', 'M', '2020-03-31', '2027-03-31', '1996-03-30', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4892824494', 'Ty ', 'E', ' Lam', 'turkish', 'p', 'TUR', 'M', '2019-03-09', '2026-03-08', '2006-02-24', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4924637784', 'Denny ', 'A', ' Zhang', 'turkish', 'dlp', 'TUR', 'M', '2022-11-14', '2029-11-13', '1977-09-23', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4978729297', 'Jordan ', 'R', ' Cuevas', 'turkish', 'd', 'TUR', 'F', '2020-04-14', '2027-04-14', '1933-08-08', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('4982642432', 'Eugene ', 'G', ' Murphy', 'turkish', 's', 'TUR', 'M', '2020-02-02', '2027-02-01', '1995-04-08', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5258656556', 'Felicia ', 'J', ' Forbes', 'turkish', 'd', 'TUR', 'F', '2020-07-07', '2027-07-07', '2014-02-07', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5282793343', 'Adele ', 'z', ' Whitney', 'turkish', 'p', 'TUR', 'F', '2018-11-14', '2025-11-13', '2021-11-07', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5324495724', 'Emilia ', 'O', ' Liu', 'turkish', 'p', 'TUR', 'F', '2018-04-14', '2025-04-13', '1935-12-30', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5332433337', 'Sharon ', 'z', ' Gould', 'turkish', 'p', 'TUR', 'F', '2021-08-24', '2028-08-23', '1994-03-04', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5353957944', 'Toni ', 'A', ' Miles', 'turkish', 'p', 'TUR', 'F', '2021-12-14', '2028-12-13', '2023-02-06', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5387285678', 'Sybil ', 'D', ' Villarreal', 'turkish', 'p', 'TUR', 'F', '2019-10-23', '2026-10-22', '2014-04-06', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5396975762', 'Dorthy ', 'U', ' Baker', 'turkish', 'p', 'TUR', 'F', '2020-04-23', '2027-04-23', '1954-04-13', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5398853575', 'Sharon ', 'Y', ' Kline', 'turkish', 'p', 'TUR', 'F', '2020-06-13', '2027-06-13', '1977-05-09', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5399663589', 'Andrea ', 'U', ' Johns', 'turkish', 'p', 'TUR', 'F', '2022-10-24', '2029-10-23', '1997-03-26', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5443584855', 'Lynn ', 'X', ' Nicholson', 'turkish', 'p', 'TUR', 'F', '2021-07-29', '2028-07-28', '2011-11-03', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5443898654', 'Roslyn ', 'D', ' Munoz', 'american', 'p', 'USA', 'F', '2017-10-14', '2024-10-13', '1974-11-21', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5462387973', 'Jamaal ', 'P', ' Garner', 'american', 'd', 'USA', 'M', '2018-09-25', '2025-09-24', '1996-06-16', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5479838989', 'Eliza ', 'H', ' Mclean', 'american', 'p', 'USA', 'F', '2022-06-21', '2029-06-20', '1986-02-10', 'istanbul');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5488457393', 'Morton ', 'B', ' Mcmahon', 'american', 's', 'USA', 'M', '2017-04-06', '2024-04-05', '2018-01-27', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5542538383', 'Clara ', 'R', ' Brock', 'american', 's', 'USA', 'F', '2019-12-28', '2026-12-27', '2014-01-01', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5598423646', 'Stephan ', 'Y', ' Gentry', 'american', 'p', 'USA', 'M', '2023-03-26', '2030-03-25', '1981-05-02', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5627965586', 'Cedric ', 'O', ' Gray', 'american', 'p', 'USA', 'M', '2023-04-18', '2030-04-17', '1927-05-12', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5655429452', 'Mindy ', 'P', ' Bray', 'american', 'p', 'USA', 'F', '2021-04-13', '2028-04-12', '1966-07-22', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5672346259', 'Earle ', 'Y', ' Moss', 'american', 'p', 'USA', 'M', '2021-08-11', '2028-08-10', '1992-08-03', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5672839764', 'Juana ', 'G', ' Molina', 'american', 'p', 'USA', 'F', '2018-12-28', '2025-12-27', '1944-10-06', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5684349335', 'Armand ', 'J', ' Beck', 'american', 'p', 'USA', 'M', '2020-10-04', '2027-10-04', '1978-05-28', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5687949549', 'Mavis ', 'Q', ' Blevins', 'american', 'p', 'USA', 'F', '2021-05-21', '2028-05-20', '1981-01-27', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5755723699', 'Johanna ', 'T', ' Jensen', 'american', 'p', 'USA', 'F', '2021-12-16', '2028-12-15', '1987-11-19', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5767637726', 'Patrica ', 'N', ' Callahan', 'american', 'dlp', 'USA', 'F', '2021-09-02', '2028-09-01', '2019-08-09', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5787546627', 'Nolan ', 'S', ' Davies', 'american', 'p', 'USA', 'M', '2021-11-24', '2028-11-23', '1937-04-03', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5828232397', 'Kristopher ', 'U', ' Hart', 'american', 'p', 'USA', 'M', '2019-08-01', '2026-07-31', '1921-07-12', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5833486889', 'Mabel ', 'P', ' Hopkins', 'american', 'p', 'USA', 'F', '2017-07-10', '2024-07-09', '1944-06-08', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5856394474', 'Edna ', 'K', ' Watson', 'american', 'p', 'USA', 'F', '2021-04-30', '2028-04-29', '1977-01-31', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5858278272', 'Hassan ', 'J', ' Edwards', 'american', 'dlp', 'USA', 'M', '2021-08-08', '2028-08-07', '1976-12-21', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5874876773', 'Margie ', 'U', ' Ellison', 'american', 'p', 'USA', 'F', '2023-04-11', '2030-04-10', '1998-06-29', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5969976282', 'Darrin ', 'I', ' Mack', 'american', 'p', 'USA', 'M', '2021-10-01', '2028-09-30', '1946-10-19', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5977587788', 'Lucile ', 'A', ' Brewer', 'american', 'p', 'USA', 'F', '2017-04-14', '2024-04-13', '2020-05-13', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5978264624', 'Connie ', 'N', ' Garza', 'american', 'p', 'USA', 'M', '2020-06-15', '2027-06-15', '2003-09-21', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('5987539796', 'Hilton ', 'T', ' Cameron', 'american', 'p', 'USA', 'M', '2022-08-07', '2029-08-06', '1920-12-14', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6228658389', 'Shawn ', 'H', ' Bryant', 'american', 'p', 'USA', 'F', '2016-12-05', '2023-12-05', '2004-01-19', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6274342626', 'Reggie ', 'C', ' Mann', 'american', 'lp', 'USA', 'M', '2019-08-20', '2026-08-19', '1933-01-03', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6274639784', 'Kristy ', 'W', ' Gray', 'american', 'p', 'USA', 'F', '2017-10-31', '2024-10-30', '2004-11-22', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6284322463', 'Elsa ', 'G', ' Schroeder', 'american', 'lp', 'USA', 'F', '2021-01-12', '2028-01-12', '1965-09-06', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6288657624', 'Erna ', 'P', ' Russell', 'american', 'p', 'USA', 'F', '2022-08-28', '2029-08-27', '1937-02-11', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6294958898', 'Mervin ', 'R', ' Munoz', 'american', 'dlp', 'USA', 'M', '2019-01-30', '2026-01-29', '1944-12-08', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6345977489', 'Agnes ', 'X', ' Stokes', 'tunisian', 'lp', 'TUN', 'F', '2016-12-07', '2023-12-07', '1982-05-31', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6349353247', 'Elias ', 'Z', ' Sims', 'tunisian', 'p', 'TUN', 'M', '2017-10-10', '2024-10-09', '1994-02-27', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6352388493', 'Jody ', 'z', ' Woodard', 'tunisian', 'p', 'TUN', 'M', '2019-10-15', '2026-10-14', '1991-10-22', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6358338897', 'Jordan ', 'V', ' Rasmussen', 'tunisian', 'd', 'TUN', 'F', '2020-08-28', '2027-08-28', '1972-02-11', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6393769684', 'Madge ', 'N', ' Hanson', 'tunisian', 'p', 'TUN', 'F', '2019-11-23', '2026-11-22', '1957-09-11', 'new york');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6438699325', 'Shayne ', 'Q', ' Molina', 'tunisian', 'p', 'TUN', 'M', '2021-03-29', '2028-03-28', '1927-12-19', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6524998596', 'Ralph ', 'D', ' Finley', 'tunisian', 'd', 'TUN', 'M', '2017-04-26', '2024-04-25', '2009-09-30', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6547545828', 'Dina ', 'S', ' Romero', 'tunisian', 'dlp', 'TUN', 'F', '2017-10-12', '2024-10-11', '1920-08-31', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6556784686', 'Jonathon ', 'U', ' Beard', 'tunisian', 'p', 'TUN', 'M', '2023-01-21', '2030-01-20', '1995-12-28', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6562523289', 'Garland ', 'G', ' Ellis', 'tunisian', 's', 'TUN', 'M', '2017-02-11', '2024-02-11', '1929-06-26', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6572928323', 'Colton ', 'U', ' Sellers', 'tunisian', 'p', 'TUN', 'M', '2017-10-06', '2024-10-05', '1966-01-09', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6575964548', 'Raul ', 'S', ' Hurley', 'tunisian', 'p', 'TUN', 'M', '2022-08-14', '2029-08-13', '1924-01-05', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6579932285', 'Janell ', 'F', ' Chandler', 'tunisian', 'p', 'TUN', 'F', '2021-12-10', '2028-12-09', '1955-11-12', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6636727769', 'Reuben ', 'E', ' May', 'tunisian', 'p', 'TUN', 'M', '2017-08-12', '2024-08-11', '1974-06-25', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6638477369', 'Elbert ', 'U', ' Fry', 'tunisian', 'p', 'TUN', 'M', '2018-06-15', '2025-06-14', '1947-02-22', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6679545869', 'Ricky ', 'W', ' Lawson', 'tunisian', 's', 'TUN', 'M', '2018-08-16', '2025-08-15', '1930-08-17', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6686222732', 'Howard ', 'D', ' Howell', 'tunisian', 'dlp', 'TUN', 'M', '2022-09-28', '2029-09-27', '1996-01-07', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6692329373', 'Jon ', 'S', ' Campbell', 'tunisian', 'p', 'TUN', 'M', '2018-04-05', '2025-04-04', '1949-06-24', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6695384675', 'Kristin ', 'P', ' Rice', 'tunisian', 'p', 'TUN', 'F', '2019-10-06', '2026-10-05', '2007-05-22', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6722248354', 'Maria ', 'P', ' Goodwin', 'tunisian', 'dlp', 'TUN', 'F', '2018-01-30', '2025-01-29', '1949-07-31', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6722362727', 'Ellis ', 'W', ' Frazier', 'tunisian', 'p', 'TUN', 'M', '2020-04-15', '2027-04-15', '1977-03-05', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6726465589', 'Juliet ', 'P', ' English', 'tunisian', 'p', 'TUN', 'F', '2017-07-20', '2024-07-19', '1976-07-20', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6753284337', 'Beatrice ', 'C', ' Mullins', 'tunisian', 's', 'TUN', 'F', '2021-05-24', '2028-05-23', '2008-08-22', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6775369328', 'Susie ', 'N', ' Ray', 'tunisian', 'lp', 'TUN', 'F', '2019-10-30', '2026-10-29', '1926-01-20', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6783795682', 'Laverne ', 'B', ' Houston', 'tunisian', 'p', 'TUN', 'F', '2020-11-02', '2027-11-02', '2000-07-28', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6799223285', 'Darren ', 'Z', ' Nichols', 'tunisian', 'p', 'TUN', 'M', '2023-07-22', '2030-07-21', '1938-07-20', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6823387754', 'Monty ', 'B', ' Frank', 'tunisian', 's', 'TUN', 'M', '2020-07-17', '2027-07-17', '1954-09-21', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6823952372', 'Hyman ', 'U', ' Glover', 'tunisian', 'lp', 'TUN', 'M', '2020-09-28', '2027-09-28', '1980-08-22', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6894547225', 'Frances ', 'N', ' Reynolds', 'tunisian', 'p', 'TUN', 'M', '2019-01-09', '2026-01-08', '1936-07-07', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6922962455', 'Jerome ', 'H', ' Maldonado', 'tunisian', 'p', 'TUN', 'M', '2016-12-08', '2023-12-08', '1941-08-19', 'tunis');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6938866936', 'Shannon ', 'S', ' Santos', 'saudi', 'p', 'SAU', 'M', '2018-03-04', '2025-03-03', '1935-10-07', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('6989356576', 'Rhoda ', 'N', ' Crosby', 'saudi', 'p', 'SAU', 'F', '2021-08-31', '2028-08-30', '1992-04-04', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7238685893', 'Freida ', 'F', ' Cervantes', 'saudi', 'p', 'SAU', 'F', '2017-03-13', '2024-03-12', '1934-01-24', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7239624477', 'Shelby ', 'V', ' Douglas', 'saudi', 'p', 'SAU', 'M', '2017-09-15', '2024-09-14', '1958-10-26', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7246583845', 'Isiah ', 'O', ' Flowers', 'saudi', 'lp', 'SAU', 'M', '2017-10-13', '2024-10-12', '1951-11-05', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7284943359', 'Rosie ', 'D', ' Harvey', 'saudi', 's', 'SAU', 'F', '2022-06-21', '2029-06-20', '1935-02-09', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7289784559', 'Lolita ', 'E', ' Mayer', 'saudi', 'd', 'SAU', 'F', '2022-03-08', '2029-03-07', '1982-05-18', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7333544954', 'Millie ', 'L', ' Rogers', 'saudi', 'dlp', 'SAU', 'F', '2021-07-27', '2028-07-26', '1997-03-27', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7355789348', 'Louisa ', 'z', ' Duke', 'saudi', 'p', 'SAU', 'F', '2018-06-14', '2025-06-13', '1984-03-14', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7359665635', 'Courtney ', 'Q', ' Glass', 'saudi', 'd', 'SAU', 'M', '2018-04-29', '2025-04-28', '1935-12-16', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7374645659', 'Evelyn ', 'Q', ' Rivers', 'saudi', 'p', 'SAU', 'F', '2021-04-09', '2028-04-08', '2021-01-10', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7382527757', 'Jeannie ', 'Y', ' Wang', 'saudi', 'p', 'SAU', 'F', '2018-03-11', '2025-03-10', '2004-08-20', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7385652594', 'Edmond ', 'G', ' Dyer', 'saudi', 'p', 'SAU', 'M', '2021-05-28', '2028-05-27', '1965-06-25', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7394974639', 'Christa ', 'C', ' Hartman', 'saudi', 'p', 'SAU', 'F', '2020-06-24', '2027-06-24', '1944-10-08', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7398999864', 'Diego ', 'M', ' Mckee', 'saudi', 'p', 'SAU', 'M', '2021-06-20', '2028-06-19', '2020-03-26', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7443633663', 'Hester ', 'U', ' Dunn', 'saudi', 'lp', 'SAU', 'F', '2022-12-06', '2029-12-05', '1950-05-09', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7455942793', 'Forest ', 'I', ' Marks', 'saudi', 'p', 'SAU', 'M', '2016-12-09', '2023-12-09', '2004-04-10', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7474642593', 'Mickey ', 'H', ' Grant', 'saudi', 'p', 'SAU', 'M', '2021-05-28', '2028-05-27', '2022-04-07', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7495435566', 'Gene ', 'X', ' Reyes', 'saudi', 'd', 'SAU', 'M', '2021-06-21', '2028-06-20', '2020-12-14', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7498639945', 'Debbie ', 'H', ' Palmer', 'saudi', 'p', 'SAU', 'F', '2018-02-27', '2025-02-26', '1983-07-25', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7538924378', 'Rocco ', 'H', ' Cooley', 'saudi', 'lp', 'SAU', 'M', '2019-12-06', '2026-12-05', '1989-04-15', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7544556675', 'Celia ', 'z', ' Gibson', 'saudi', 'p', 'SAU', 'F', '2021-08-16', '2028-08-15', '1996-12-28', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7564445558', 'Graham ', 'O', ' Padilla', 'saudi', 'lp', 'SAU', 'M', '2018-10-05', '2025-10-04', '1977-04-01', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7597889782', 'Suzanne ', 'J', ' Richardson', 'saudi', 'p', 'SAU', 'F', '2020-05-08', '2027-05-08', '1950-01-29', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7622954398', 'Andrew ', 'K', ' Christensen', 'saudi', 'd', 'SAU', 'M', '2018-05-23', '2025-05-22', '1977-04-08', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7649722698', 'Jesse ', 'K', ' Roman', 'saudi', 'd', 'SAU', 'M', '2019-12-12', '2026-12-11', '2020-12-27', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7657699865', 'Adrian ', 'T', ' Hines', 'saudi', 'lp', 'SAU', 'M', '2017-02-17', '2024-02-17', '1953-02-16', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7674452873', 'Francis ', 'R', ' Montgomery', 'saudi', 'p', 'SAU', 'M', '2023-03-15', '2030-03-14', '1971-07-17', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7743958234', 'Marie ', 'N', ' Mosley', 'saudi', 'p', 'SAU', 'F', '2022-12-29', '2029-12-28', '1927-01-11', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7745748349', 'Marilyn ', 'V', ' Doyle', 'saudi', 'dlp', 'SAU', 'F', '2023-10-18', '2030-10-17', '1949-09-14', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7856473625', 'Lizzie ', 'C', ' Walsh', 'egyptian', 'p', 'EGY', 'F', '2023-09-23', '2030-09-22', '1978-10-29', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7859596622', 'Clint ', 'S', ' Morton', 'egyptian', 'p', 'EGY', 'M', '2020-09-12', '2027-09-12', '1954-05-20', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7865543828', 'Art ', 'D', ' Salinas', 'egyptian', 'p', 'EGY', 'M', '2017-10-31', '2024-10-30', '1999-10-20', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7874959338', 'Andy ', 'X', ' Morgan', 'egyptian', 'p', 'EGY', 'M', '2022-04-04', '2029-04-03', '1944-08-20', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7877956685', 'Ava ', 'P', ' Trevino', 'egyptian', 'p', 'EGY', 'F', '2018-04-18', '2025-04-17', '2002-02-12', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7882385826', 'Tyrone ', 'J', ' Wilkins', 'egyptian', 's', 'EGY', 'M', '2017-04-12', '2024-04-11', '1941-09-24', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7898693973', 'Elnora ', 'N', ' Glass', 'egyptian', 'p', 'EGY', 'F', '2017-10-22', '2024-10-21', '1971-07-06', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7925572649', 'Terrance ', 'R', ' Mayer', 'egyptian', 's', 'EGY', 'M', '2017-11-13', '2024-11-12', '1972-04-10', 'jeddah');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7928427255', 'Matilda ', 'D', ' Park', 'egyptian', 'p', 'EGY', 'F', '2017-08-22', '2024-08-21', '1929-10-16', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7938449237', 'Lessie ', 'J', ' Parks', 'egyptian', 'p', 'EGY', 'F', '2018-11-09', '2025-11-08', '2019-11-08', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7963557344', 'Nestor ', 'K', ' Hull', 'egyptian', 'd', 'EGY', 'M', '2019-05-10', '2026-05-09', '1954-09-27', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('7972525723', 'Prince ', 'z', ' Chan', 'egyptian', 'p', 'EGY', 'M', '2019-12-22', '2026-12-21', '1966-07-01', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8236296445', 'Terence ', 'L', ' Guerra', 'egyptian', 'p', 'EGY', 'M', '2019-03-14', '2026-03-13', '1929-02-23', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8257974242', 'Darrick ', 'U', ' Lynch', 'egyptian', 'p', 'EGY', 'M', '2017-06-06', '2024-06-05', '1975-12-06', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8276748874', 'Alfreda ', 'L', ' Cowan', 'egyptian', 'p', 'EGY', 'F', '2020-12-01', '2027-12-01', '1922-11-19', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8289364723', 'Sebastian ', 'E', ' Clay', 'egyptian', 'p', 'EGY', 'M', '2017-07-20', '2024-07-19', '1990-11-02', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8337568349', 'Paris ', 'B', ' Tapia', 'egyptian', 'lp', 'EGY', 'M', '2019-09-21', '2026-09-20', '1973-09-10', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8356326975', 'Frank ', 'G', ' Massey', 'egyptian', 'd', 'EGY', 'M', '2019-07-02', '2026-07-01', '1997-02-13', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8373383536', 'Stuart ', 'M', ' Miller', 'egyptian', 'p', 'EGY', 'M', '2016-12-24', '2023-12-24', '1926-12-01', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8378592957', 'Nickolas ', 'C', ' Rhodes', 'egyptian', 'lp', 'EGY', 'M', '2021-04-29', '2028-04-28', '1994-12-02', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8385777542', 'Dawn ', 'C', ' Kaiser', 'egyptian', 'p', 'EGY', 'F', '2021-03-29', '2028-03-28', '2009-08-04', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8392749539', 'Michelle ', 'N', ' Higgins', 'egyptian', 'p', 'EGY', 'F', '2023-02-18', '2030-02-17', '1920-10-01', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8397425549', 'Lela ', 'H', ' Barnes', 'egyptian', 'p', 'EGY', 'F', '2022-08-08', '2029-08-07', '2006-11-11', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8426233273', 'Tracie ', 'G', ' Vasquez', 'egyptian', 'd', 'EGY', 'F', '2019-09-20', '2026-09-19', '1982-08-23', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8427728396', 'Erika ', 'Q', ' Carroll', 'egyptian', 'lp', 'EGY', 'F', '2020-09-06', '2027-09-06', '1994-10-13', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8453965547', 'Clarice ', 'G', ' Olson', 'egyptian', 'p', 'EGY', 'F', '2018-01-15', '2025-01-14', '1981-11-05', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8465768625', 'Delbert ', 'O', ' Hubbard', 'egyptian', 'p', 'EGY', 'M', '2017-08-07', '2024-08-06', '1987-10-09', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8485823926', 'Douglas ', 'B', ' Gamble', 'egyptian', 'p', 'EGY', 'M', '2019-03-13', '2026-03-12', '2004-01-15', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8498684353', 'Sang ', 'W', ' Mason', 'egyptian', 'p', 'EGY', 'M', '2019-07-15', '2026-07-14', '1932-09-24', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8499967662', 'Claudio ', 'T', ' Nolan', 'egyptian', 'p', 'EGY', 'M', '2020-10-07', '2027-10-07', '2002-03-01', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8534576862', 'Ollie ', 'C', ' Harmon', 'jordanian', 'p', 'JOR', 'M', '2020-12-18', '2027-12-18', '1941-11-30', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8543965662', 'Rory ', 'Z', ' Morales', 'jordanian', 'd', 'JOR', 'M', '2023-02-16', '2030-02-15', '1980-07-20', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8557467532', 'Rosendo ', 'H', ' Parsons', 'jordanian', 'p', 'JOR', 'M', '2020-11-08', '2027-11-08', '1958-11-15', 'cairo');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8562838423', 'Errol ', 'R', ' Hogan', 'jordanian', 'p', 'JOR', 'M', '2020-04-06', '2027-04-06', '2010-03-16', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8566389957', 'Freda ', 'z', ' Ross', 'jordanian', 'p', 'JOR', 'F', '2020-03-31', '2027-03-31', '1932-05-09', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8569449778', 'Julianne ', 'S', ' Hodges', 'jordanian', 'p', 'JOR', 'F', '2022-07-19', '2029-07-18', '2020-06-12', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8584279284', 'Norbert ', 'I', ' Blackburn', 'jordanian', 'p', 'JOR', 'M', '2021-06-29', '2028-06-28', '1964-01-19', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8589236328', 'Eugenia ', 'z', ' Valencia', 'jordanian', 's', 'JOR', 'F', '2019-07-10', '2026-07-09', '1972-06-28', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8625755982', 'Brendan ', 'S', ' Cooke', 'jordanian', 'p', 'JOR', 'M', '2018-08-29', '2025-08-28', '1973-01-16', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8625954384', 'Joshua ', 'G', ' Powers', 'jordanian', 'p', 'JOR', 'M', '2017-07-25', '2024-07-24', '1971-09-20', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8659457937', 'Liz ', 'D', ' Stanley', 'jordanian', 'p', 'JOR', 'F', '2022-06-28', '2029-06-27', '1980-01-27', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8663376366', 'Dwight ', 'F', ' Robles', 'jordanian', 'p', 'JOR', 'M', '2023-03-08', '2030-03-07', '1982-06-13', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8667237898', 'Yesenia ', 'A', ' Horn', 'jordanian', 'd', 'JOR', 'F', '2022-03-16', '2029-03-15', '1998-03-02', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8726359889', 'Dollie ', 'C', ' Moses', 'jordanian', 'p', 'JOR', 'F', '2023-05-11', '2030-05-10', '1927-01-13', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8726539734', 'Derick ', 'I', ' Calhoun', 'jordanian', 'p', 'JOR', 'M', '2017-02-19', '2024-02-19', '1972-03-18', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8764723848', 'Beth ', 'Z', ' Howe', 'jordanian', 'p', 'JOR', 'F', '2021-07-11', '2028-07-10', '1967-12-11', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8769484696', 'Patrica ', 'R', ' Small', 'jordanian', 's', 'JOR', 'F', '2020-04-29', '2027-04-29', '2012-07-21', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8797882569', 'Nancy ', 'T', ' Moran', 'jordanian', 'p', 'JOR', 'F', '2020-03-13', '2027-03-13', '1939-09-18', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8798285295', 'Ernie ', 'Z', ' Daniels', 'jordanian', 'p', 'JOR', 'M', '2021-09-10', '2028-09-09', '1970-10-22', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8824252456', 'Candace ', 'A', ' Rodriguez', 'jordanian', 'p', 'JOR', 'F', '2018-01-14', '2025-01-13', '1923-04-26', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8832425496', 'Selma ', 'X', ' Horn', 'jordanian', 'p', 'JOR', 'F', '2021-03-15', '2028-03-14', '1936-04-18', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8837226689', 'Claud ', 'G', ' Garza', 'jordanian', 'p', 'JOR', 'M', '2021-08-29', '2028-08-28', '2015-04-21', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8875792476', 'Buddy ', 'O', ' Arnold', 'jordanian', 'p', 'JOR', 'M', '2018-07-05', '2025-07-04', '1925-11-05', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8895682696', 'Carol ', 'R', ' Patton', 'jordanian', 'p', 'JOR', 'F', '2017-07-15', '2024-07-14', '1927-10-19', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8898922725', 'Emilia ', 'H', ' Mcgee', 'jordanian', 's', 'JOR', 'F', '2020-05-04', '2027-05-04', '1938-07-18', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8922573725', 'Pansy ', 'H', ' Bush', 'jordanian', 'p', 'JOR', 'F', '2020-05-22', '2027-05-22', '1931-02-26', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8982939233', 'Vicky ', 'E', ' Murillo', 'jordanian', 'd', 'JOR', 'F', '2017-12-18', '2024-12-17', '2001-04-11', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('8995235559', 'Lolita ', 'K', ' Mahoney', 'jordanian', 'p', 'JOR', 'F', '2019-05-31', '2026-05-30', '2019-10-31', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9263877889', 'Cherry ', 'Z', ' Burch', 'jordanian', 's', 'JOR', 'F', '2020-02-11', '2027-02-10', '2014-06-05', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9287983554', 'Otis ', 'T', ' Green', 'jordanian', 'p', 'JOR', 'M', '2023-01-13', '2030-01-12', '2018-05-15', 'amman');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9298967986', 'Mary ', 'P', ' Savage', 'qatari', 'p', 'QAT', 'F', '2021-08-15', '2028-08-14', '1953-11-14', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9299988394', 'Adolfo ', 'L', ' Brewer', 'qatari', 'dlp', 'QAT', 'M', '2022-02-20', '2029-02-19', '1947-08-22', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9359822569', 'Miquel ', 'W', ' Alvarez', 'qatari', 'd', 'QAT', 'M', '2023-10-08', '2030-10-07', '1992-09-06', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9363884363', 'Mae ', 'T', ' Harding', 'qatari', 'p', 'QAT', 'F', '2018-01-25', '2025-01-24', '1948-05-22', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9373798487', 'Lloyd ', 'O', ' Barker', 'qatari', 'd', 'QAT', 'M', '2019-04-14', '2026-04-13', '1983-03-26', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9445343764', 'Miles ', 'R', ' Moody', 'qatari', 'p', 'QAT', 'M', '2016-12-20', '2023-12-20', '2008-07-08', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9494392345', 'Angelo ', 'W', ' Stanton', 'qatari', 'p', 'QAT', 'M', '2017-07-07', '2024-07-06', '1964-10-21', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9536438959', 'Terry ', 'O', ' Griffin', 'qatari', 's', 'QAT', 'F', '2022-10-24', '2029-10-23', '1924-08-15', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9574598882', 'Alphonse ', 'C', ' Malone', 'qatari', 'lp', 'QAT', 'M', '2018-05-21', '2025-05-20', '1986-05-12', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9593897367', 'Caitlin ', 'M', ' Rush', 'qatari', 'p', 'QAT', 'F', '2023-05-19', '2030-05-18', '1931-04-24', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9598686938', 'Vickie ', 'T', ' Romero', 'qatari', 'd', 'QAT', 'F', '2022-02-09', '2029-02-08', '1966-11-02', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9626564853', 'Maria ', 'M', ' Bush', 'qatari', 's', 'QAT', 'F', '2023-01-12', '2030-01-11', '1959-07-26', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9669484292', 'Milton ', 'N', ' Gordon', 'qatari', 'p', 'QAT', 'M', '2021-11-30', '2028-11-29', '1952-02-03', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9678498353', 'Debora ', 'J', ' Johnston', 'qatari', 'p', 'QAT', 'F', '2021-03-21', '2028-03-20', '1983-10-30', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9689536646', 'Fred ', 'B', ' Zamora', 'qatari', 'p', 'QAT', 'M', '2019-10-05', '2026-10-04', '1951-10-24', 'doha');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9699867725', 'Silvia ', 'E', ' Hahn', 'emirati', 'p', 'ARE', 'F', '2020-07-22', '2027-07-22', '1968-08-06', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9736299695', 'Edward ', 'V', ' York', 'emirati', 'p', 'ARE', 'M', '2021-07-01', '2028-06-30', '1949-02-10', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9778674879', 'Norbert ', 'M', ' Macdonald', 'emirati', 'p', 'ARE', 'M', '2021-01-19', '2028-01-19', '1965-11-04', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9796564853', 'Larry ', 'X', ' Valdez', 'emirati', 'p', 'ARE', 'M', '2018-08-15', '2025-08-14', '2022-12-20', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9799747243', 'Mitzi ', 'D', ' Crosby', 'emirati', 'p', 'ARE', 'F', '2019-06-29', '2026-06-28', '1974-07-15', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9828337723', 'Dominique ', 'N', ' Olson', 'emirati', 'lp', 'ARE', 'M', '2020-06-18', '2027-06-18', '1954-12-14', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9837667655', 'Sybil ', 'I', ' Silva', 'emirati', 'p', 'ARE', 'F', '2019-10-22', '2026-10-21', '2021-09-29', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9853224725', 'Lakeisha ', 'V', ' Hudson', 'emirati', 'd', 'ARE', 'F', '2023-03-08', '2030-03-07', '2021-05-28', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9868539744', 'Naomi ', 'T', ' Yates', 'emirati', 'p', 'ARE', 'F', '2017-03-31', '2024-03-30', '2010-04-11', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9875265545', 'Rudolf ', 'S', ' Townsend', 'emirati', 'd', 'ARE', 'M', '2021-03-09', '2028-03-08', '1951-07-04', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9876295338', 'Ofelia ', 'Q', ' Proctor', 'emirati', 'p', 'ARE', 'F', '2020-01-06', '2027-01-05', '1997-12-03', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9925887863', 'Lemuel ', 'O', ' Walsh', 'emirati', 'p', 'ARE', 'M', '2021-07-10', '2028-07-09', '1962-12-13', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9969477946', 'Vern ', 'B', ' Ritter', 'emirati', 'p', 'ARE', 'M', '2022-03-08', '2029-03-07', '1994-08-28', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9969647298', 'Elisha ', 'L', ' Conner', 'emirati', 'p', 'ARE', 'M', '2019-07-17', '2026-07-16', '2014-03-21', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9988938899', 'Refugio ', 'F', ' Daniel', 'emirati', 'p', 'ARE', 'M', '2020-10-25', '2027-10-25', '1978-10-05', 'dubi');
INSERT INTO `airport`.`passenger` (`passport_no`, `f_name`, `minit`, `l_name`, `nationality`, `passport_type`, `country_code`, `gender`, `i_date`, `e_date`, `b_date`, `place_of_birth`) VALUES ('9989754775', 'Rod ', 'G', ' Cordova', 'emirati', 'p', 'ARE', 'M', '2023-01-26', '2030-01-25', '2002-10-15', 'dubi');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`gate`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`gate` (`no`, `location`) VALUES (1, 'terminal1,floor1');
INSERT INTO `airport`.`gate` (`no`, `location`) VALUES (2, 'terminal1,floor1');
INSERT INTO `airport`.`gate` (`no`, `location`) VALUES (3, 'terminal2,floor1');
INSERT INTO `airport`.`gate` (`no`, `location`) VALUES (4, 'terminal2,floor2');
INSERT INTO `airport`.`gate` (`no`, `location`) VALUES (5, 'terminal3,floor2');
INSERT INTO `airport`.`gate` (`no`, `location`) VALUES (6, 'terminal3,floor2');
INSERT INTO `airport`.`gate` (`no`, `location`) VALUES (7, 'terminal4,floor2');
INSERT INTO `airport`.`gate` (`no`, `location`) VALUES (8, 'terminal4,floor3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`flight`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('RJ507', 'OJAI', 'HECA', 'E', '2023-11-28 23:45:00', '2023-11-29 00:25:00', '2023-11-29', '01:25:00', 'RJA', 5, 3);
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('AF568', 'LFPG', 'HECA', 'E', '2023-11-28 19:50:00', '2023-11-28 23:50:00', '2023-11-29', '00:37:00', 'AFR', 4, 5);
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('TK692', 'LTFM', 'HECA', 'O', '2023-11-28 00:35:00', '2023-11-29 02:20:00', '2023-11-29', '02:20:00', 'THY', 3, 7);
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('LH586', 'EDDM', 'HECA', 'O', '2023-11-29 21:35:00', '2023-11-30 02:20:00', '2023-11-30', '02:18:00', 'DLH', 2, 4);
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('EK927', 'OMDB', 'HECA', 'E', '2023-11-28 08:10:00', '2023-11-28 10:25:00', '2023-11-28', '11:00:00', 'UAE', 1, 8);
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('MS985', 'HECA', 'KJFK', 'O', '2023-11-29 04:00:00', '2023-11-29 09:00:00', '2023-11-29', '08:40:00', 'MSR', 6, 8);
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('SV306', 'HECA', 'OEJN', 'O', '2023-11-30 00:05:00', '2023-11-30 01:30:00', '2023-11-30', '01:30:00', 'SVA', 7, 6);
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('QR136', 'HECA', 'OTHH', 'O', '2023-11-30 01:20:00', '2023-11-30 05:20:00', '2023-11-30', '05:10:00', 'QTR', 8, 4);
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('TU814', 'HECA', 'DTTA', 'E', '2023-11-30 03:30:00', '2023-11-30 05:45:00', '2023-11-30', '05:58:00', 'TAR', 9, 1);
INSERT INTO `airport`.`flight` (`no`, `from`, `to`, `status`, `departure`, `arrival`, `date`, `time`, `airline_icao`, `plane_id`, `gate_no`) VALUES ('LX238', 'HECA', 'LSZH', 'O', '2023-11-29 13:20:00', '2023-11-30 17:50:00', '2023-11-30', '17:35:00', 'SWR', 10, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`Country`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LS', 'LX238');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LW', 'LX238');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'LX238');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'TU814');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('DT', 'TU814');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'QR136');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('OT', 'QR136');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('OE', 'QR136');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('OB', 'QR136');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'SV306');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('OE', 'SV306');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'MS985');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LI', 'MS985');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LF', 'MS985');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('K', 'MS985');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'EK927');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('OM', 'EK927');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('OE', 'EK927');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LH', 'LH586');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('ED', 'LH586');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'LH586');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LJ', 'LH586');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LT', 'TK692');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'TK692');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'AF568');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LF', 'AF568');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LI', 'AF568');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LS', 'AF568');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LN', 'AF568');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('OJ', 'RJ507');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('LL', 'RJ507');
INSERT INTO `airport`.`Country` (`Country_Code`, `flight_no`) VALUES ('HE', 'RJ507');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`send`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('DT_231130', 'TU814');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('ED_231129', 'LH586');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231128', 'AF568');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231129', 'EK927');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231130', 'LH586');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231129', 'LX238');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231129', 'MS985');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231130', 'QR136');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231129', 'RJ507');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231130', 'SV309');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231129', 'TK692');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('HE_231130', 'TU814');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('K_231129', 'MS985');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LF_231128', 'AF568');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LF_231129', 'MS985');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LH_231129', 'LH586');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LI_231128', 'AF568');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LI_231129', 'MS985');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LI_231129', 'LH586');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LL_231129', 'RJ507');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LN_231128', 'AF568');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LS_231128', 'AF568');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LS_231129', 'LX238');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LT_231128', 'TK692');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('LW_231129', 'LX238');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('OB_231130', 'QR136');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('OE_231128', 'EK927');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('OE_231130', 'QR136');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('OE_231130', 'SV309');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('OJ_231128', 'RJ507');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('OM_231128', 'EK927');
INSERT INTO `airport`.`send` (`weather_data_cd`, `flight_no`) VALUES ('OT_231130', 'QR136');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`flight_has_bus`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`flight_has_bus` (`bus_no`, `flight_no`) VALUES (3, 'TU814');
INSERT INTO `airport`.`flight_has_bus` (`bus_no`, `flight_no`) VALUES (4, 'TU814');
INSERT INTO `airport`.`flight_has_bus` (`bus_no`, `flight_no`) VALUES (1, 'LX238');
INSERT INTO `airport`.`flight_has_bus` (`bus_no`, `flight_no`) VALUES (5, 'LX238');
INSERT INTO `airport`.`flight_has_bus` (`bus_no`, `flight_no`) VALUES (2, 'RJ507');
INSERT INTO `airport`.`flight_has_bus` (`bus_no`, `flight_no`) VALUES (3, 'RJ507');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`ticket`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (663, 7156, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (463, 7606, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (986, 7620, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (777, 5162, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (657, 5703, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (547, 7764, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (834, 5468, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (833, 6911, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (455, 6633, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (762, 6511, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (984, 7484, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (885, 7838, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (394, 6514, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (676, 5901, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (226, 6312, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (236, 6721, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (687, 6139, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (346, 5312, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (562, 7141, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (235, 6100, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (249, 7688, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (698, 7761, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (752, 5486, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (544, 5512, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (983, 5134, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (528, 5801, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (633, 6723, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (335, 7721, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (533, 6185, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (466, 5166, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (767, 7482, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (858, 5317, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (578, 7241, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (323, 5516, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (959, 5834, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (553, 7797, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (866, 5986, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (582, 7845, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (385, 5744, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (243, 6038, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (745, 7098, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (743, 7734, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (736, 7349, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (792, 7220, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (254, 7935, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (855, 7748, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (958, 5840, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (878, 6349, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (844, 6390, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (332, 6347, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (943, 5477, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (425, 7813, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (487, 5036, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (927, 6643, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (737, 6662, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (784, 6809, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (248, 6207, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (288, 7346, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (759, 6087, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (772, 7210, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (969, 5600, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (594, 5398, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (693, 5070, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (552, 7864, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (325, 5471, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (852, 6879, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (369, 6955, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (445, 6626, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (926, 7232, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (875, 5569, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (836, 5906, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (358, 7988, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (645, 5659, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (427, 7125, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (824, 6019, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (465, 5637, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (574, 6518, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (523, 6327, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (977, 5580, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (826, 6838, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (489, 6110, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (846, 5575, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (827, 7807, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (484, 7865, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (246, 5601, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (383, 5853, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (924, 7884, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (849, 6967, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (395, 5467, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (879, 7186, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (638, 5977, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (863, 6775, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (485, 6398, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (828, 5262, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (886, 6075, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (378, 7732, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (963, 5588, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (896, 6880, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (448, 5148, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (384, 6861, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (449, 7161, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (884, 7176, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (297, 5934, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (938, 6215, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (237, 7564, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (568, 6869, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (982, 6036, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (695, 5581, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (328, 6251, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (444, 5276, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (373, 5696, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (672, 6703, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (494, 7564, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (892, 6240, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (723, 5850, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (344, 5268, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (433, 5676, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (389, 6594, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (794, 6206, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (393, 7990, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (993, 7255, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (732, 7883, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (664, 5111, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (366, 5836, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (483, 6228, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (882, 6014, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (546, 7256, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (479, 7411, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (375, 6487, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (352, 6978, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (636, 7926, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (535, 7614, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (493, 5497, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (694, 6910, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (586, 5722, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (387, 5821, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (968, 6933, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (897, 6968, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (438, 6958, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (696, 6281, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (242, 6540, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (738, 6539, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (469, 5710, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (273, 7604, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (948, 6278, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (673, 7021, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (928, 5476, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (873, 7558, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (222, 6457, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (437, 7492, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (443, 7586, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (647, 7902, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (258, 6976, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (289, 5971, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (227, 7395, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (399, 5524, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (295, 6655, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (229, 6627, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (967, 5945, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (467, 5746, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (422, 7703, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (374, 6063, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (542, 7769, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (798, 5826, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (822, 7412, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (655, 7760, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (543, 6086, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (867, 7967, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (686, 5385, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (724, 6332, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (932, 7027, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (239, 7281, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (649, 6859, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (952, 5523, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (987, 6686, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (947, 5861, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (735, 6826, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (933, 6431, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (453, 5965, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (624, 6140, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (567, 6133, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (795, 7948, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (973, 5972, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (854, 5619, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (256, 7051, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (434, 6002, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (893, 6294, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (238, 5345, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (492, 7930, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (426, 5252, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (832, 5875, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (746, 7807, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (363, 6427, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (269, 5541, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (233, 5876, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (572, 7005, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (876, 6152, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (477, 5726, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (763, 6493, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (446, 5258, 'E');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (597, 21675, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (835, 20057, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (789, 29349, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (556, 28073, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (585, 29058, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (266, 28579, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (677, 25147, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (529, 21332, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (549, 21910, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (656, 22233, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (278, 21891, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (953, 28817, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (268, 28880, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (397, 23531, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (847, 26761, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (944, 20742, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (265, 23833, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (576, 21228, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (979, 20424, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (675, 20944, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (579, 21678, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (995, 25062, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (825, 25412, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (725, 29902, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (398, 25405, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (733, 21188, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (634, 28000, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (742, 21334, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (293, 25086, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (388, 24837, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (692, 28814, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (939, 26001, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (577, 20639, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (468, 25281, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (299, 21404, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (653, 25593, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (232, 21373, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (498, 29443, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (253, 29417, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (989, 26436, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (495, 26461, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (823, 20513, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (396, 23250, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (749, 22938, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (564, 29832, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (339, 29628, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (538, 23386, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (629, 21585, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (244, 22038, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (527, 24688, 'F');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (679, 15672, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (729, 10192, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (786, 14212, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (327, 11991, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (354, 15019, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (345, 10155, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (773, 11383, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (563, 16565, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (259, 11979, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (936, 11035, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (283, 13910, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (276, 13646, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (294, 16382, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (575, 11715, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (329, 16362, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (245, 10766, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (783, 15111, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (796, 15718, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (456, 12022, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (964, 13978, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (748, 10776, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (379, 13743, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (842, 16759, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (747, 12783, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (382, 15170, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (356, 14437, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (945, 15903, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (279, 13798, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (899, 12775, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (734, 16743, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (338, 12551, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (333, 16599, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (436, 12552, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (935, 14760, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (623, 12933, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (764, 15805, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (435, 10359, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (539, 15737, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (486, 10304, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (593, 10451, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (322, 10120, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (534, 11635, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (439, 16496, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (522, 10012, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (277, 13634, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (728, 12786, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (829, 16466, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (739, 11806, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (988, 13697, 'B');
INSERT INTO `airport`.`ticket` (`no`, `price`, `class`) VALUES (565, 11956, 'B');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`book`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (222, '2252295396', 'LH586', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (226, '2283592982', 'LH586', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (227, '2286325238', 'LH586', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (229, '2295588457', 'LH586', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (232, '2328755336', 'LH586', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (233, '2335546342', 'LH586', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (235, '2335773385', 'LH586', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (236, '2347565765', 'LH586', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (237, '2353459876', 'LH586', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (238, '2382922852', 'LH586', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (239, '2447439384', 'LH586', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (242, '2453828595', 'LH586', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (243, '2463998398', 'LH586', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (244, '2523877429', 'LH586', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (245, '2535829596', 'LH586', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (246, '2555498976', 'LH586', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (248, '2635276349', 'LH586', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (249, '2648348953', 'LH586', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (253, '2674572237', 'LH586', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (254, '2686899866', 'LH586', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (256, '2724298754', 'LH586', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (258, '2728363359', 'LH586', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (259, '2747564776', 'LH586', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (265, '2749284536', 'LH586', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (266, '2749469593', 'LH586', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (268, '2762945453', 'LH586', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (269, '2764826498', 'LH586', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (273, '2773285673', 'LH586', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (276, '2787789457', 'LH586', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (277, '2832567477', 'LH586', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (278, '2839738325', 'AF568', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (279, '2844595857', 'AF568', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (283, '2892976634', 'AF568', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (288, '2922593887', 'AF568', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (289, '2947667352', 'AF568', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (293, '2956345993', 'AF568', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (294, '2959234696', 'AF568', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (295, '3258442443', 'AF568', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (297, '3259865689', 'AF568', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (299, '3274935229', 'AF568', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (322, '3275284847', 'AF568', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (323, '3288475294', 'AF568', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (325, '3345968595', 'AF568', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (327, '3424446763', 'AF568', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (328, '3449882282', 'AF568', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (329, '3522399854', 'AF568', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (332, '3522796642', 'AF568', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (333, '3565756995', 'AF568', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (335, '3626984258', 'AF568', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (338, '3635977824', 'AF568', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (339, '3639355687', 'AF568', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (344, '3666926388', 'AF568', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (345, '3698538489', 'AF568', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (346, '3742973539', 'AF568', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (352, '3748943442', 'AF568', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (354, '3772237436', 'AF568', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (356, '3775594333', 'AF568', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (358, '3834836835', 'AF568', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (363, '3837496798', 'AF568', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (366, '3845636933', 'AF568', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (369, '3848473468', 'LX238', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (373, '3896957555', 'LX238', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (374, '3897945276', 'LX238', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (375, '3936226835', 'LX238', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (378, '3977675334', 'LX238', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (379, '3979448924', 'LX238', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (382, '3985522757', 'LX238', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (383, '3986338888', 'LX238', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (384, '3987866894', 'LX238', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (385, '3989963958', 'LX238', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (387, '4224872334', 'LX238', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (388, '4226529867', 'LX238', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (389, '4226574923', 'LX238', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (393, '4229659453', 'LX238', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (394, '4237869933', 'LX238', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (395, '4272943933', 'LX238', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (396, '4275484462', 'LX238', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (397, '4282583398', 'LX238', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (398, '4284667858', 'LX238', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (399, '4325944875', 'LX238', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (422, '4332644299', 'LX238', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (425, '4339827945', 'LX238', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (426, '4343322574', 'LX238', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (427, '4355653375', 'LX238', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (433, '4374974334', 'LX238', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (434, '4422886842', 'LX238', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (435, '4426834682', 'LX238', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (436, '4438687828', 'LX238', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (437, '4452563658', 'LX238', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (438, '4484845979', 'LX238', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (439, '4544397867', 'TK692', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (443, '4553876858', 'TK692', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (444, '4633355548', 'TK692', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (445, '4642267586', 'TK692', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (446, '4645874298', 'TK692', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (448, '4675394848', 'TK692', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (449, '4738832259', 'TK692', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (453, '4739658926', 'TK692', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (455, '4754269574', 'TK692', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (456, '4793955829', 'TK692', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (463, '4822835897', 'TK692', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (465, '4852562395', 'TK692', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (466, '4853536689', 'TK692', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (467, '4868593725', 'TK692', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (468, '4869656699', 'TK692', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (469, '4892824494', 'TK692', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (477, '4924637784', 'TK692', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (479, '4978729297', 'TK692', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (483, '4982642432', 'TK692', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (484, '5258656556', 'TK692', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (485, '5282793343', 'TK692', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (486, '5324495724', 'TK692', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (487, '5332433337', 'TK692', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (489, '5353957944', 'TK692', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (492, '5387285678', 'TK692', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (493, '5396975762', 'TK692', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (494, '5398853575', 'TK692', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (495, '5399663589', 'TK692', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (498, '5443584855', 'TK692', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (522, '5443898654', 'TK692', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (523, '5462387973', 'MS985', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (527, '5479838989', 'MS985', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (528, '5488457393', 'MS985', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (529, '5542538383', 'MS985', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (533, '5598423646', 'MS985', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (534, '5627965586', 'MS985', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (535, '5655429452', 'MS985', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (538, '5672346259', 'MS985', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (539, '5672839764', 'MS985', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (542, '5684349335', 'MS985', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (543, '5687949549', 'MS985', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (544, '5755723699', 'MS985', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (546, '5767637726', 'MS985', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (547, '5787546627', 'MS985', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (549, '5828232397', 'MS985', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (552, '5833486889', 'MS985', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (553, '5856394474', 'MS985', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (556, '5858278272', 'MS985', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (562, '5874876773', 'MS985', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (563, '5969976282', 'MS985', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (564, '5977587788', 'MS985', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (565, '5978264624', 'MS985', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (567, '5987539796', 'MS985', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (568, '6228658389', 'MS985', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (572, '6274342626', 'MS985', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (574, '6274639784', 'MS985', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (575, '6284322463', 'MS985', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (576, '6288657624', 'MS985', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (577, '6294958898', 'MS985', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (578, '6345977489', 'MS985', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (579, '6349353247', 'TU814', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (582, '6352388493', 'TU814', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (585, '6358338897', 'TU814', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (586, '6393769684', 'TU814', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (593, '6438699325', 'TU814', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (594, '6524998596', 'TU814', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (597, '6547545828', 'TU814', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (623, '6556784686', 'TU814', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (624, '6562523289', 'TU814', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (629, '6572928323', 'TU814', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (633, '6575964548', 'TU814', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (634, '6579932285', 'TU814', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (636, '6636727769', 'TU814', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (638, '6638477369', 'TU814', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (645, '6679545869', 'TU814', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (647, '6686222732', 'TU814', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (649, '6692329373', 'TU814', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (653, '6695384675', 'TU814', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (655, '6722248354', 'TU814', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (656, '6722362727', 'TU814', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (657, '6726465589', 'TU814', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (663, '6753284337', 'TU814', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (664, '6775369328', 'TU814', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (672, '6783795682', 'TU814', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (673, '6799223285', 'TU814', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (675, '6823387754', 'TU814', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (676, '6823952372', 'TU814', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (677, '6894547225', 'TU814', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (679, '6922962455', 'TU814', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (686, '6938866936', 'TU814', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (687, '6989356576', 'SV309', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (692, '7238685893', 'SV309', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (693, '7239624477', 'SV309', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (694, '7246583845', 'SV309', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (695, '7284943359', 'SV309', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (696, '7289784559', 'SV309', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (698, '7333544954', 'SV309', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (723, '7355789348', 'SV309', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (724, '7359665635', 'SV309', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (725, '7374645659', 'SV309', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (728, '7382527757', 'SV309', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (729, '7385652594', 'SV309', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (732, '7394974639', 'SV309', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (733, '7398999864', 'SV309', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (734, '7443633663', 'SV309', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (735, '7455942793', 'SV309', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (736, '7474642593', 'SV309', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (737, '7495435566', 'SV309', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (738, '7498639945', 'SV309', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (739, '7538924378', 'SV309', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (742, '7544556675', 'SV309', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (743, '7564445558', 'SV309', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (745, '7597889782', 'SV309', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (746, '7622954398', 'SV309', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (747, '7649722698', 'SV309', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (748, '7657699865', 'SV309', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (749, '7674452873', 'SV309', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (752, '7743958234', 'SV309', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (759, '7745748349', 'SV309', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (762, '7856473625', 'SV309', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (763, '7859596622', 'QR136', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (764, '7865543828', 'QR136', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (767, '7874959338', 'QR136', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (772, '7877956685', 'QR136', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (773, '7882385826', 'QR136', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (777, '7898693973', 'QR136', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (783, '7925572649', 'QR136', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (784, '7928427255', 'QR136', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (786, '7938449237', 'QR136', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (789, '7963557344', 'QR136', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (792, '7972525723', 'QR136', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (794, '8236296445', 'QR136', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (795, '8257974242', 'QR136', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (796, '8276748874', 'QR136', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (798, '8289364723', 'QR136', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (822, '8337568349', 'EK927', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (823, '8356326975', 'EK927', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (824, '8373383536', 'EK927', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (825, '8378592957', 'EK927', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (826, '8385777542', 'EK927', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (827, '8392749539', 'EK927', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (828, '8397425549', 'EK927', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (829, '8426233273', 'EK927', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (832, '8427728396', 'EK927', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (833, '8453965547', 'EK927', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (834, '8465768625', 'EK927', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (835, '8485823926', 'EK927', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (836, '8498684353', 'EK927', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (842, '8499967662', 'EK927', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (844, '8534576862', 'EK927', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (846, '8543965662', 'RJ507', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (847, '8557467532', 'RJ507', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (849, '8562838423', 'RJ507', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (852, '8566389957', 'RJ507', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (854, '8569449778', 'RJ507', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (855, '8584279284', 'RJ507', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (858, '8589236328', 'RJ507', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (863, '8625755982', 'RJ507', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (866, '8625954384', 'RJ507', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (867, '8659457937', 'RJ507', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (873, '8663376366', 'RJ507', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (875, '8667237898', 'RJ507', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (876, '8726359889', 'RJ507', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (878, '8726539734', 'RJ507', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (879, '8764723848', 'RJ507', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (882, '8769484696', 'RJ507', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (884, '8797882569', 'RJ507', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (885, '8798285295', 'RJ507', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (886, '8824252456', 'RJ507', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (892, '8832425496', 'RJ507', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (893, '8837226689', 'RJ507', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (896, '8875792476', 'RJ507', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (897, '8895682696', 'RJ507', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (899, '8898922725', 'RJ507', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (924, '8922573725', 'RJ507', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (926, '8982939233', 'RJ507', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (927, '8995235559', 'RJ507', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (928, '9263877889', 'RJ507', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (932, '9287983554', 'RJ507', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (933, '9298967986', 'RJ507', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (935, '9299988394', 'QR136', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (936, '9359822569', 'QR136', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (938, '9363884363', 'QR136', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (939, '9373798487', 'QR136', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (943, '9445343764', 'QR136', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (944, '9494392345', 'QR136', '2023-10-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (945, '9536438959', 'QR136', '2023-10-30');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (947, '9574598882', 'QR136', '2023-10-31');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (948, '9593897367', 'QR136', '2023-11-01');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (952, '9598686938', 'QR136', '2023-11-02');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (953, '9626564853', 'QR136', '2023-11-03');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (958, '9669484292', 'QR136', '2023-11-06');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (959, '9678498353', 'QR136', '2023-11-07');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (963, '9689536646', 'QR136', '2023-11-08');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (964, '9699867725', 'QR136', '2023-11-09');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (967, '9736299695', 'EK927', '2023-11-10');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (968, '9778674879', 'EK927', '2023-11-13');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (969, '9796564853', 'EK927', '2023-11-14');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (973, '9799747243', 'EK927', '2023-11-15');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (977, '9828337723', 'EK927', '2023-11-16');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (979, '9837667655', 'EK927', '2023-11-17');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (982, '9853224725', 'EK927', '2023-11-20');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (983, '9868539744', 'EK927', '2023-11-21');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (984, '9875265545', 'EK927', '2023-11-22');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (986, '9876295338', 'EK927', '2023-11-23');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (987, '9925887863', 'EK927', '2023-11-24');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (988, '9969477946', 'EK927', '2023-11-27');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (989, '9969647298', 'EK927', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (993, '9988938899', 'EK927', '2023-11-28');
INSERT INTO `airport`.`book` (`ticket_no`, `passport_no`, `flight_no`, `book_date`) VALUES (995, '9989754775', 'EK927', '2023-11-28');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`on_board`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (2, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (3, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (20, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (21, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (22, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (23, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (24, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (25, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (26, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (27, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (28, 'AF568');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (6, 'LH586');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (7, 'LH586');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (40, 'LH586');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (41, 'LH586');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (42, 'LH586');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (43, 'LH586');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (10, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (11, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (58, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (59, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (60, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (61, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (62, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (63, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (64, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (65, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (66, 'MS985');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (14, 'QR138');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (15, 'QR138');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (74, 'QR138');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (75, 'QR138');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (76, 'QR138');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (77, 'QR138');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (0, 'RJ507');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (1, 'RJ507');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (29, 'RJ507');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (30, 'RJ507');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (31, 'RJ507');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (32, 'RJ507');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (12, 'SV309');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (13, 'SV309');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (67, 'SV309');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (68, 'SV309');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (69, 'SV309');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (70, 'SV309');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (71, 'SV309');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (72, 'SV309');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (73, 'SV309');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (18, 'LX238');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (19, 'LX238');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (16, 'TU814');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (17, 'TU814');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (78, 'TU814');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (79, 'TU814');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (80, 'TU814');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (4, 'TK692');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (5, 'TK692');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (33, 'TK692');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (34, 'TK692');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (35, 'TK692');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (36, 'TK692');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (37, 'TK692');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (38, 'TK692');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (39, 'TK692');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (8, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (9, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (44, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (45, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (46, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (47, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (48, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (49, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (50, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (51, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (52, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (53, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (54, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (55, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (56, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (57, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (81, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (82, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (83, 'EK927');
INSERT INTO `airport`.`on_board` (`air_emp_id`, `flight_no`) VALUES (84, 'EK927');

COMMIT;


-- -----------------------------------------------------
-- Data for table `airport`.`security_employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `airport`;
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('33965967', 1);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('37933718', 1);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('67349879', 2);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('85419647', 2);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('10549059', 3);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('37785122', 3);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('78726579', 4);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('51082588', 4);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('91176872', 5);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('95317540', 5);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('36969959', 6);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('36959958', 6);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('46969958', 7);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('36985958', 7);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('79969958', 8);
INSERT INTO `airport`.`security_employee` (`employee_ssn`, `gate_no`) VALUES ('36901958', 8);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
