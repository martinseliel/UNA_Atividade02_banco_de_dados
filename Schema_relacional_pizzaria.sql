-- MySQL Script generated by MySQL Workbench
-- Thu Sep 15 22:20:09 2022
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
-- Table `mydb`.`Caixa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Caixa` (
  `idCaixa` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `Endereço_entrega` VARCHAR(45) NULL,
  `Telefone_cliente` VARCHAR(45) NULL,
  `Valor_total` VARCHAR(45) NULL,
  `Frete` FLOAT NOT NULL,
  `Quantidade` INT NOT NULL,
  `Forma_pagamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCaixa`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  `Telefone` VARCHAR(11) NULL,
  `CPF` INT NOT NULL,
  `Caixa_idCaixa` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `Caixa_idCaixa`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  INDEX `fk_Cliente_Caixa1_idx` (`Caixa_idCaixa` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Caixa1`
    FOREIGN KEY (`Caixa_idCaixa`)
    REFERENCES `mydb`.`Caixa` (`idCaixa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Site pizzaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Site pizzaria` (
  `idSite pizzaria` INT NOT NULL,
  `cadastro` VARCHAR(45) NULL,
  `login` VARCHAR(45) NULL,
  `produtos` VARCHAR(45) NULL,
  `endereços_unidades` VARCHAR(45) NULL,
  `telefone_contato` VARCHAR(45) NULL,
  `cardapio` VARCHAR(45) NULL,
  PRIMARY KEY (`idSite pizzaria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Tipo_produto` VARCHAR(45) NULL,
  `Quantidade` VARCHAR(45) NULL,
  `Codigo_produto` VARCHAR(45) NULL,
  `valor_produto` VARCHAR(45) NULL,
  PRIMARY KEY (`idPedido`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cardapio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cardapio` (
  `idCardapio` INT NOT NULL,
  `Tipos_Bebidas` VARCHAR(45) NULL,
  `Tipos_Pizzas` VARCHAR(45) NULL,
  `Tipos_Sobremessas` VARCHAR(45) NULL,
  `Codigo_produto` VARCHAR(45) NULL,
  `valor_produto` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  PRIMARY KEY (`idCardapio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Separação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Separação` (
  `idSeparação` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `cliente` VARCHAR(45) NULL,
  `id_cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSeparação`),
  UNIQUE INDEX `id_cliente_UNIQUE` (`id_cliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produção`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produção` (
  `idProdução` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `Cliente` VARCHAR(45) NOT NULL,
  `id_cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProdução`),
  UNIQUE INDEX `id_cliente_UNIQUE` (`id_cliente` ASC) VISIBLE,
  UNIQUE INDEX `Cliente_UNIQUE` (`Cliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`entrega` (
  `identrega` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `Id_cliente` VARCHAR(45) NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`identrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Preparação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Preparação` (
  `idPreparação` INT NOT NULL,
  `pegar_itens` VARCHAR(45) NULL,
  `Separação_idSeparação` INT NOT NULL,
  `Produção_idProdução` INT NOT NULL,
  `entrega_identrega` INT NOT NULL,
  PRIMARY KEY (`idPreparação`, `Separação_idSeparação`, `Produção_idProdução`, `entrega_identrega`),
  INDEX `fk_Preparação_Separação1_idx` (`Separação_idSeparação` ASC) VISIBLE,
  INDEX `fk_Preparação_Produção1_idx` (`Produção_idProdução` ASC) VISIBLE,
  INDEX `fk_Preparação_entrega1_idx` (`entrega_identrega` ASC) VISIBLE,
  CONSTRAINT `fk_Preparação_Separação1`
    FOREIGN KEY (`Separação_idSeparação`)
    REFERENCES `mydb`.`Separação` (`idSeparação`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Preparação_Produção1`
    FOREIGN KEY (`Produção_idProdução`)
    REFERENCES `mydb`.`Produção` (`idProdução`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Preparação_entrega1`
    FOREIGN KEY (`entrega_identrega`)
    REFERENCES `mydb`.`entrega` (`identrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente faz cadastro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente faz cadastro` (
  `Cliente_idCliente` INT NOT NULL,
  `Site pizzaria_idSite pizzaria` INT NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`, `Site pizzaria_idSite pizzaria`),
  INDEX `fk_Cliente_has_Site pizzaria_Site pizzaria1_idx` (`Site pizzaria_idSite pizzaria` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Site pizzaria_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Site pizzaria_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Site pizzaria_Site pizzaria1`
    FOREIGN KEY (`Site pizzaria_idSite pizzaria`)
    REFERENCES `mydb`.`Site pizzaria` (`idSite pizzaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente faz pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente faz pedido` (
  `Site pizzaria_idSite pizzaria` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`Site pizzaria_idSite pizzaria`, `Pedido_idPedido`),
  INDEX `fk_Site pizzaria_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Site pizzaria_has_Pedido_Site pizzaria1_idx` (`Site pizzaria_idSite pizzaria` ASC) VISIBLE,
  CONSTRAINT `fk_Site pizzaria_has_Pedido_Site pizzaria1`
    FOREIGN KEY (`Site pizzaria_idSite pizzaria`)
    REFERENCES `mydb`.`Site pizzaria` (`idSite pizzaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Site pizzaria_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido acessa cardapio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido acessa cardapio` (
  `Pedido_idPedido` INT NOT NULL,
  `Cardapio_idCardapio` INT NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Cardapio_idCardapio`),
  INDEX `fk_Pedido_has_Cardapio_Cardapio1_idx` (`Cardapio_idCardapio` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Cardapio_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Cardapio_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Cardapio_Cardapio1`
    FOREIGN KEY (`Cardapio_idCardapio`)
    REFERENCES `mydb`.`Cardapio` (`idCardapio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente realiza pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente realiza pagamento` (
  `Caixa_idCaixa` INT NOT NULL,
  `Cardapio_idCardapio` INT NOT NULL,
  `Preparação_idPreparação` INT NOT NULL,
  PRIMARY KEY (`Caixa_idCaixa`, `Cardapio_idCardapio`, `Preparação_idPreparação`),
  INDEX `fk_Caixa_has_Cardapio_Cardapio1_idx` (`Cardapio_idCardapio` ASC) VISIBLE,
  INDEX `fk_Caixa_has_Cardapio_Caixa1_idx` (`Caixa_idCaixa` ASC) VISIBLE,
  INDEX `fk_Cliente realiza pagamento_Preparação1_idx` (`Preparação_idPreparação` ASC) VISIBLE,
  CONSTRAINT `fk_Caixa_has_Cardapio_Caixa1`
    FOREIGN KEY (`Caixa_idCaixa`)
    REFERENCES `mydb`.`Caixa` (`idCaixa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caixa_has_Cardapio_Cardapio1`
    FOREIGN KEY (`Cardapio_idCardapio`)
    REFERENCES `mydb`.`Cardapio` (`idCardapio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente realiza pagamento_Preparação1`
    FOREIGN KEY (`Preparação_idPreparação`)
    REFERENCES `mydb`.`Preparação` (`idPreparação`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
