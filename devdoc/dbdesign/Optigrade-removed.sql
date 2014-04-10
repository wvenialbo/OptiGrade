-- -----------------------------------------------------
-- Table `Moneda`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Moneda` (
  `Id` INT NOT NULL ,
  `Signo` VARCHAR(4) NOT NULL ,
  `Letra` VARCHAR(32) NOT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Signo_UNIQUE` (`Signo` ASC) ,
  UNIQUE INDEX `Letra_UNIQUE` (`Letra` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pago`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Pago` (
  `Id` INT NOT NULL ,
  `CuentaId` INT NOT NULL ,
  `Fecha` TIMESTAMP NOT NULL ,
  `ConeceptoPlanId` INT NOT NULL ,
  `Unidades` INT NOT NULL DEFAULT 1 ,
  `Monto` INT NOT NULL ,
  `MonedaId` INT NOT NULL ,
  `Cambio` INT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`Id`) ,
  INDEX `fk_Pago_Cuenta_idx` (`CuentaId` ASC) ,
  INDEX `fk_Pago_Plan_idx` (`ConeceptoPlanId` ASC) ,
  INDEX `fk_Pago_Moneda_idx` (`MonedaId` ASC) ,
  CONSTRAINT `fk_Pago_Cuenta`
    FOREIGN KEY (`CuentaId` )
    REFERENCES `Cuenta` (`Id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pago_Plan`
    FOREIGN KEY (`ConeceptoPlanId` )
    REFERENCES `Plan` (`Id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pago_Moneda`
    FOREIGN KEY (`MonedaId` )
    REFERENCES `Moneda` (`Id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO `TipoCuenta` (`Id`, `Nombre`, `CuotaUnidad`, `Descripción`) VALUES (1, 'Personal (Hojas)', 'Hojas', 'Plan individual con cuota de hojas.');
INSERT INTO `TipoCuenta` (`Id`, `Nombre`, `CuotaUnidad`, `Descripción`) VALUES (2, 'Corporativa (Hojas)', 'Hojas', 'Plan institucional con cuota de hojas. Para colegios, escuelas y otras instituciones con exámenes poco frecuentes.');
INSERT INTO `TipoCuenta` (`Id`, `Nombre`, `CuotaUnidad`, `Descripción`) VALUES (4, 'Corporativa (Tiempo)', 'Dias', 'Plan institucional con cuota de tiempo. Para cursillos preparatorios y otras instituciones con exmámenes periódicos.');
INSERT INTO `TipoPlan` (`Id`, `Nombre`, `CuotaUnidad`, `Descripción`) VALUES (5, 'Paquetes', 'Hojas', 'Plan general para la compra esporádica de cuota de hojas.');

INSERT INTO `Moneda` (`Id`, `Signo`, `Letra`) VALUES (1, 'Gs', 'Guaraníes');
INSERT INTO `Moneda` (`Id`, `Signo`, `Letra`) VALUES (2, 'US$', 'Dólares Americanos');
