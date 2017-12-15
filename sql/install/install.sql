SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `trashpoint`.`commune`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`commune` (
  `commune_id` INT NOT NULL AUTO_INCREMENT ,
  `commune_name` VARCHAR(145) NULL ,
  PRIMARY KEY (`commune_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`stations`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`stations` (
  `stations_id` INT NOT NULL AUTO_INCREMENT ,
  `stations_name` VARCHAR(100) NULL ,
  `stations_email` VARCHAR(150) NULL ,
  `stations_website` VARCHAR(150) NULL ,
  `stations_openinghours` LONGTEXT NULL ,
  `stations_created` DATETIME NULL ,
  `commune_id` INT NOT NULL ,
  PRIMARY KEY (`stations_id`, `commune_id`) ,
  INDEX `fk_stations_commune1_idx` (`commune_id` ASC) ,
  CONSTRAINT `fk_stations_commune1`
    FOREIGN KEY (`commune_id` )
    REFERENCES `trashpoint`.`commune` (`commune_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`roles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`roles` (
  `roles_id` INT NOT NULL AUTO_INCREMENT ,
  `roles_name` VARCHAR(45) NULL ,
  PRIMARY KEY (`roles_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`users` (
  `users_id` INT NOT NULL AUTO_INCREMENT ,
  `users_name` VARCHAR(45) NULL ,
  `users_password` VARCHAR(45) NULL ,
  `users_email` VARCHAR(45) NULL ,
  `users_created` DATETIME NULL ,
  `roles_id` INT NOT NULL ,
  PRIMARY KEY (`users_id`, `roles_id`) ,
  INDEX `fk_users_roles1_idx` (`roles_id` ASC) ,
  CONSTRAINT `fk_users_roles1`
    FOREIGN KEY (`roles_id` )
    REFERENCES `trashpoint`.`roles` (`roles_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT ,
  `category_name` VARCHAR(145) NULL ,
  PRIMARY KEY (`category_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`images`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`images` (
  `images_id` INT NOT NULL AUTO_INCREMENT ,
  `images_original` VARCHAR(255) NULL ,
  `images_thumbnail` VARCHAR(255) NULL ,
  `category_id` INT NOT NULL ,
  PRIMARY KEY (`images_id`, `category_id`) ,
  INDEX `fk_images_category1_idx` (`category_id` ASC) ,
  CONSTRAINT `fk_images_category1`
    FOREIGN KEY (`category_id` )
    REFERENCES `trashpoint`.`category` (`category_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`articles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`articles` (
  `articles_id` INT NOT NULL AUTO_INCREMENT ,
  `articles_title` VARCHAR(145) NULL ,
  `articles_byline` VARCHAR(45) NULL ,
  `articles_desc` TEXT NULL ,
  `articles_published` DATETIME NULL ,
  `articles_period` DATETIME NULL ,
  `articles_created` DATETIME NULL ,
  `users_id` INT NOT NULL ,
  `images_id` INT NOT NULL ,
  PRIMARY KEY (`articles_id`, `users_id`, `images_id`) ,
  INDEX `fk_articles_users1_idx` (`users_id` ASC) ,
  INDEX `fk_articles_images1_idx` (`images_id` ASC) ,
  CONSTRAINT `fk_articles_users1`
    FOREIGN KEY (`users_id` )
    REFERENCES `trashpoint`.`users` (`users_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articles_images1`
    FOREIGN KEY (`images_id` )
    REFERENCES `trashpoint`.`images` (`images_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`containers`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`containers` (
  `containers_id` INT NOT NULL AUTO_INCREMENT ,
  `containers_name` VARCHAR(145) NULL ,
  `containers_number` INT NULL ,
  `containers_desc` LONGTEXT NULL ,
  `containers_pickup` TINYINT(1) NULL ,
  PRIMARY KEY (`containers_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`items`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`items` (
  `items_id` INT NOT NULL AUTO_INCREMENT ,
  `items_name` VARCHAR(155) NULL ,
  `items_desc` LONGTEXT NULL ,
  `items_created` DATETIME NULL ,
  `images_id` INT NOT NULL ,
  PRIMARY KEY (`items_id`, `images_id`) ,
  INDEX `fk_items_images1_idx` (`images_id` ASC) ,
  CONSTRAINT `fk_items_images1`
    FOREIGN KEY (`images_id` )
    REFERENCES `trashpoint`.`images` (`images_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`types`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`types` (
  `types_id` INT NOT NULL AUTO_INCREMENT ,
  `types_name` VARCHAR(145) NULL ,
  `types_desc` LONGTEXT NULL ,
  PRIMARY KEY (`types_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`city`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT ,
  `city_name` VARCHAR(145) NULL ,
  `city_zipcode` INT(4) NULL ,
  `commune_id` INT NOT NULL ,
  PRIMARY KEY (`city_id`, `commune_id`) ,
  INDEX `fk_city_commune1_idx` (`commune_id` ASC) ,
  CONSTRAINT `fk_city_commune1`
    FOREIGN KEY (`commune_id` )
    REFERENCES `trashpoint`.`commune` (`commune_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`users_has_stations`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`users_has_stations` (
  `users_id` INT NOT NULL ,
  `stations_id` INT NOT NULL ,
  PRIMARY KEY (`users_id`, `stations_id`) ,
  INDEX `fk_users_has_stations_stations1_idx` (`stations_id` ASC) ,
  INDEX `fk_users_has_stations_users_idx` (`users_id` ASC) ,
  CONSTRAINT `fk_users_has_stations_users`
    FOREIGN KEY (`users_id` )
    REFERENCES `trashpoint`.`users` (`users_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_stations_stations1`
    FOREIGN KEY (`stations_id` )
    REFERENCES `trashpoint`.`stations` (`stations_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`articles_has_category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`articles_has_category` (
  `articles_id` INT NOT NULL ,
  `category_id` INT NOT NULL ,
  PRIMARY KEY (`articles_id`, `category_id`) ,
  INDEX `fk_articles_has_category_category1_idx` (`category_id` ASC) ,
  INDEX `fk_articles_has_category_articles1_idx` (`articles_id` ASC) ,
  CONSTRAINT `fk_articles_has_category_articles1`
    FOREIGN KEY (`articles_id` )
    REFERENCES `trashpoint`.`articles` (`articles_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articles_has_category_category1`
    FOREIGN KEY (`category_id` )
    REFERENCES `trashpoint`.`category` (`category_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`stations_has_containers`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`stations_has_containers` (
  `stations_id` INT NOT NULL ,
  `containers_id` INT NOT NULL ,
  PRIMARY KEY (`stations_id`, `containers_id`) ,
  INDEX `fk_stations_has_containers_containers1_idx` (`containers_id` ASC) ,
  INDEX `fk_stations_has_containers_stations1_idx` (`stations_id` ASC) ,
  CONSTRAINT `fk_stations_has_containers_stations1`
    FOREIGN KEY (`stations_id` )
    REFERENCES `trashpoint`.`stations` (`stations_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stations_has_containers_containers1`
    FOREIGN KEY (`containers_id` )
    REFERENCES `trashpoint`.`containers` (`containers_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trashpoint`.`items_has_types`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `trashpoint`.`items_has_types` (
  `items_id` INT NOT NULL ,
  `types_id` INT NOT NULL ,
  `containers_id` INT NOT NULL ,
  PRIMARY KEY (`items_id`, `types_id`, `containers_id`) ,
  INDEX `fk_items_has_types_types1_idx` (`types_id` ASC) ,
  INDEX `fk_items_has_types_items1_idx` (`items_id` ASC) ,
  INDEX `fk_items_has_types_containers1_idx` (`containers_id` ASC) ,
  CONSTRAINT `fk_items_has_types_items1`
    FOREIGN KEY (`items_id` )
    REFERENCES `trashpoint`.`items` (`items_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_has_types_types1`
    FOREIGN KEY (`types_id` )
    REFERENCES `trashpoint`.`types` (`types_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_has_types_containers1`
    FOREIGN KEY (`containers_id` )
    REFERENCES `trashpoint`.`containers` (`containers_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
