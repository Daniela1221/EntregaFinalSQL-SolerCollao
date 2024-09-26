-- Creación de la base de datos de veterinaria --

CREATE SCHEMA veterinaria;
USE veterinaria;


-- Creación de tablas --
CREATE TABLE dueño(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    rut VARCHAR(20) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    direccion VARCHAR(100),
    correo VARCHAR(100) NOT NULL
);

CREATE TABLE historial_dueños(
	id INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    rut VARCHAR(20) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    direccion VARCHAR(100),
    correo VARCHAR(100) NOT NULL
);

CREATE TABLE mascota(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dueño_id INT NOT NULL,
	FOREIGN KEY (dueño_id) REFERENCES dueño(id),
    nombre VARCHAR(100) NOT NULL,
    especie VARCHAR(100) NOT NULL,
    raza VARCHAR(100) NOT NULL,
    color VARCHAR(100) NOT NULL,
    sexo VARCHAR(100) NOT NULL,
    fecha_nac DATE NOT NULL,
    esterilizado BOOLEAN NOT NULL,
    chip BOOLEAN NOT NULL, 
    peso FLOAT
);

CREATE TABLE historial_mascotas(
	id INT NOT NULL PRIMARY KEY,
    dueño_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    especie VARCHAR(100) NOT NULL,
    raza VARCHAR(100) NOT NULL,
    color VARCHAR(100) NOT NULL,
    sexo VARCHAR(100) NOT NULL,
    fecha_nac DATE NOT NULL,
    esterilizado BOOLEAN NOT NULL,
    chip BOOLEAN NOT NULL,
    peso FLOAT
);

CREATE TABLE tipoAntiparasitario(
	tipo_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE tipoVacuna(
	tipo_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE marcaAntiparasitario(
	marca_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE marcaVacuna(
	marca_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE antiparasitarios(
	antiparasitario_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	tipo INT NOT NULL,
    FOREIGN KEY (tipo) REFERENCES tipoAntiparasitario(tipo_id),
    marca INT NOT NULL,
    FOREIGN KEY (marca) REFERENCES marcaAntiparasitario(marca_id),
    fecha DATE NOT NULL,
    proxima_fecha DATE NOT NULL,
    mascota_id INT NOT NULL,
    FOREIGN KEY (mascota_id) REFERENCES mascota(id)
);

CREATE TABLE historial_antiparasitarios(
	antiparasitario_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	tipo INT NOT NULL,
    marca INT NOT NULL,
    fecha DATE NOT NULL,
    proxima_fecha DATE NOT NULL,
    mascota_id INT NOT NULL
);

CREATE TABLE vacunas(
	vacuna_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	tipo INT NOT NULL,
    FOREIGN KEY (tipo) REFERENCES tipoVacuna(tipo_id),
    fecha DATE NOT NULL,
    marca INT NOT NULL,
    FOREIGN KEY (marca) REFERENCES marcaVacuna(marca_id),
    fecha_proxima DATE NOT NULL,
    mascota_id INT NOT NULL,
    FOREIGN KEY (mascota_id) REFERENCES mascota(id)
);

CREATE TABLE historial_vacunas(
	vacuna_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	tipo INT NOT NULL,
    fecha DATE NOT NULL,
    marca INT NOT NULL,
    fecha_proxima DATE NOT NULL,
    mascota_id INT NOT NULL
);

CREATE TABLE agenda(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	fecha DATE NOT NULL,
    nombre_dueño VARCHAR(100) NOT NULL,
    nombre_mascota VARCHAR(100) NOT NULL
);

CREATE TABLE consulta(
	consulta_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	fecha_id INT NOT NULL,
	FOREIGN KEY (fecha_id) REFERENCES agenda(id),
    razon_consulta VARCHAR(200) NOT NULL,
    peso FLOAT,
    anamnesis VARCHAR(1000) NOT NULL,
    plan_diagnostico VARCHAR(1000) NOT NULL,
    plan_terapeutico VARCHAR(1000) NOT NULL,
    prediagnostico VARCHAR(300) NOT NULL,
    diagnostico VARCHAR(300) NOT NULL,
    tratamiento VARCHAR(2000) NOT NULL,
    fecha_proxima DATE,
    mascota_id INT NOT NULL,
    FOREIGN KEY (mascota_id) REFERENCES mascota(id)
);

CREATE TABLE historial_consultas(
	consulta_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	fecha_id INT NOT NULL,
    razon_consulta VARCHAR(200) NOT NULL,
    peso FLOAT,
    anamnesis VARCHAR(1000) NOT NULL,
    plan_diagnostico VARCHAR(1000) NOT NULL,
    plan_terapeutico VARCHAR(1000) NOT NULL,
    prediagnostico VARCHAR(300) NOT NULL,
    diagnostico VARCHAR(300) NOT NULL,
    tratamiento VARCHAR(2000) NOT NULL,
    fecha_proxima DATE,
    mascota_id INT NOT NULL
);
