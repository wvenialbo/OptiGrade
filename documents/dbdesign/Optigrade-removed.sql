

-- -----------------------------------------------------
-- Table `CriterioInstituci�n`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CriterioInstituci�n` (
  `ActaId` INT NOT NULL,
  `Item` INT NOT NULL,
  `Puntos` INT NOT NULL DEFAULT 1,
  `Penalizaci�nIncorrecto` INT NOT NULL DEFAULT 0,
  `Penalizaci�nM�ltiple` INT NOT NULL DEFAULT 0,
  `Penalizaci�nIgnorado` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ActaId`, `Item`),
  CONSTRAINT `fk_CriterioInstituci�n_ExamenInstituci�n`
    FOREIGN KEY (`ActaId`)
    REFERENCES `ExamenInstituci�n` (`ActaId`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NotaInstituci�nRevisi�n`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NotaInstituci�nRevisi�n` (
  `DataRevisi�n` TIMESTAMP NOT NULL,
  `ActaId` INT NOT NULL,
  `AlumnoId` INT NOT NULL,
  `Calificaci�nId` INT NOT NULL,
  `Comentario` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`DataRevisi�n`, `ActaId`, `AlumnoId`),
  INDEX `fk_NotaInstituci�nRevisi�n_NotaInstituci�n_idx` (`ActaId` ASC, `AlumnoId` ASC),
  INDEX `fk_NotaInstituci�nRevisi�n_Calificaci�n_idx` (`Calificaci�nId` ASC),
  CONSTRAINT `fk_NotaInstituci�nRevisi�n_NotaInstituci�n`
    FOREIGN KEY (`ActaId` , `AlumnoId`)
    REFERENCES `NotaInstituci�n` (`ActaId` , `AlumnoId`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_NotaInstituci�nRevisi�n_Calificaci�n`
    FOREIGN KEY (`Calificaci�nId`)
    REFERENCES `Calificaci�n` (`Id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NotaProfesorRevisi�n`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NotaProfesorRevisi�n` (
  `DataRevisi�n` TIMESTAMP NOT NULL,
  `ActaId` INT NOT NULL,
  `AlumnoId` INT NOT NULL,
  `Calificaci�nId` INT NOT NULL,
  `Comentario` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`DataRevisi�n`, `ActaId`, `AlumnoId`),
  INDEX `fk_NotaProfesorRevisi�n_Calificaci�n_idx` (`Calificaci�nId` ASC),
  INDEX `fk_NotaProfesorRevisi�n_NotaProfesor_idx` (`ActaId` ASC, `AlumnoId` ASC),
  CONSTRAINT `fk_NotaProfesorRevisi�n_NotaProfesor`
    FOREIGN KEY (`ActaId` , `AlumnoId`)
    REFERENCES `NotaProfesor` (`ActaId` , `AlumnoId`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_NotaProfesorRevisi�n_Calificaci�n`
    FOREIGN KEY (`Calificaci�nId`)
    REFERENCES `Calificaci�n` (`Id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Calificaci�n`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Calificaci�n` (
  `Id` INT NOT NULL,
  `EscalaId` INT NOT NULL,
  `Desde` DECIMAL NOT NULL,
  `Hasta` DECIMAL NOT NULL,
  `Nota` VARCHAR(16) NOT NULL,
  `Letra` VARCHAR(16) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `EscalaId_Nota_UNIQUE` (`EscalaId` ASC, `Nota` ASC),
  UNIQUE INDEX `EscalaId_Letra_UNIQUE` (`EscalaId` ASC, `Letra` ASC),
  CONSTRAINT `fk_Calificaci�n_Escala`
    FOREIGN KEY (`EscalaId`)
    REFERENCES `Escala` (`Id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


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

INSERT INTO `TipoCuenta` (`Id`, `Nombre`, `CuotaUnidad`, `Descripci�n`) VALUES (1, 'Personal (Hojas)', 'Hojas', 'Plan individual con cuota de hojas.');
INSERT INTO `TipoCuenta` (`Id`, `Nombre`, `CuotaUnidad`, `Descripci�n`) VALUES (2, 'Corporativa (Hojas)', 'Hojas', 'Plan institucional con cuota de hojas. Para colegios, escuelas y otras instituciones con ex�menes poco frecuentes.');
INSERT INTO `TipoCuenta` (`Id`, `Nombre`, `CuotaUnidad`, `Descripci�n`) VALUES (4, 'Corporativa (Tiempo)', 'Dias', 'Plan institucional con cuota de tiempo. Para cursillos preparatorios y otras instituciones con exm�menes peri�dicos.');
INSERT INTO `TipoPlan` (`Id`, `Nombre`, `CuotaUnidad`, `Descripci�n`) VALUES (5, 'Paquetes', 'Hojas', 'Plan general para la compra espor�dica de cuota de hojas.');

INSERT INTO `Moneda` (`Id`, `Signo`, `Letra`) VALUES (1, 'Gs', 'Guaran�es');
INSERT INTO `Moneda` (`Id`, `Signo`, `Letra`) VALUES (2, 'US$', 'D�lares Americanos');
