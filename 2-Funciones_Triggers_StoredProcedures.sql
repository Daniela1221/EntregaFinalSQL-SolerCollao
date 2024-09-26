USE veterinaria;

-- FUNCIONES --
-- Calculo de la edad de una mascota en base a su fecha de nacimiento --
DELIMITER $$
CREATE FUNCTION `calculo_edad`(n_fecha DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE edad INT;
    SET edad = TIMESTAMPDIFF(YEAR, n_fecha, CURDATE()); 
	RETURN edad;
END $$

-- Concatenación de nombre y apellido a partir de la tabla dueño --
DELIMITER $$
CREATE FUNCTION `nombre_y_apellido`(nombre VARCHAR(100), apellido VARCHAR(100)) 
RETURNS VARCHAR(201)
DETERMINISTIC
BEGIN
	DECLARE nombre_completo VARCHAR(201);
    SET nombre_completo = CONCAT(nombre, ' ', apellido);
	RETURN nombre_completo;
END $$


-- TRIGGERS --
-- Dueño --
DELIMITER $$
CREATE TRIGGER respaldo_dueño
AFTER INSERT ON dueño 
FOR EACH ROW
BEGIN 
	INSERT INTO historial_dueños(id, nombre, apellido, rut, telefono, direccion, correo)
	VALUES (NEW.id, NEW.nombre, NEW.apellido, NEW.rut, NEW.telefono, NEW.direccion, NEW.correo);
END $$

-- Mascota --
DELIMITER $$
CREATE TRIGGER respaldo_mascota
AFTER INSERT ON mascota 
FOR EACH ROW
BEGIN 
	INSERT INTO historial_mascotas(id, dueño_id, nombre, especie, raza, color, sexo, fecha_nac, esterilizado, chip, peso)
	VALUES (NEW.id, NEW.dueño_id, NEW.nombre, NEW.especie, NEW.raza, NEW.color, NEW.sexo, NEW.fecha_nac, NEW.esterilizado, NEW.chip, NEW.peso);
END $$

-- Antiparasitarios --
DELIMITER $$
CREATE TRIGGER respaldo_antiparasitario
AFTER INSERT ON antiparasitarios
FOR EACH ROW
BEGIN 
	INSERT INTO historial_antiparasitarios(antiparasitario_id, tipo, marca, fecha, proxima_fecha, mascota_id)
	VALUES (NEW.antiparasitario_id, NEW.tipo, NEW.marca, NEW.fecha, NEW.proxima_fecha, NEW.mascota_id);
END $$

-- Vacunas --
DELIMITER $$
CREATE TRIGGER respaldo_vacuna
AFTER INSERT ON vacunas
FOR EACH ROW
BEGIN 
	INSERT INTO historial_vacunas(vacuna_id, tipo, fecha, marca, fecha_proxima, mascota_id)
	VALUES (NEW.vacuna_id, NEW.tipo, NEW.fecha, NEW.marca, NEW.fecha_proxima, NEW.mascota_id);
END $$

-- Consultas --
DELIMITER $$
CREATE TRIGGER respaldo_consulta
AFTER INSERT ON consulta
FOR EACH ROW
BEGIN 
	INSERT INTO historial_consultas(consulta_id, fecha_id, razon_consulta, peso, anamnesis, plan_diagnostico, plan_terapeutico, prediagnostico, diagnostico, tratamiento, fecha_proxima, mascota_id)
	VALUES (NEW.consulta_id, NEW.fecha_id, NEW.razon_consulta, NEW.peso, NEW.anamnesis, NEW.plan_diagnostico, NEW.plan_terapeutico, NEW.prediagnostico, NEW.diagnostico, NEW.tratamiento, NEW.fecha_proxima, NEW.mascota_id);
END $$

-- STORED PROCEDURES --
-- Buscar mascota por nombre --
DELIMITER $$
CREATE PROCEDURE nombre_mascota_repetido(IN p_nombre VARCHAR(50))
BEGIN
	SELECT * FROM mascota WHERE nombre = p_nombre;
END $$

-- Cantidad de mascotas si chip = 1 (tiene chip) o chip = 0 (no tiene chip)
DELIMITER $$
CREATE PROCEDURE contar_chips(IN numero INT)
BEGIN 
	SELECT COUNT(chip) FROM mascota WHERE chip = numero;
END $$

-- Muestra las mascotas con o sin chip
DELIMITER $$
CREATE PROCEDURE mascota_con_o_sin_chip(IN numero INT)
BEGIN
	SELECT * FROM mascota WHERE chip = numero;
END $$

-- Generación de historial de una mascota --
DELIMITER $$
CREATE PROCEDURE historial(
    IN tipo_historial VARCHAR(20),
    IN p_mascota INT
)
BEGIN
    SET @query = CONCAT('SELECT m.nombre AS "nombre mascota", a.* FROM ', tipo_historial, ' AS a ',
                        'JOIN mascota AS m ',
                        'ON m.id = a.mascota_id AND m.id =', p_mascota,
                        ' ORDER BY a.fecha DESC');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$