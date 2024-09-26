USE veterinaria;

-- CONSULTAS, SUBCONSULTAS, VISTAS Y LLAMADOS DE STORED PROCEDURES --
-- Muestra la agenda de los días próximos --
CREATE OR REPLACE VIEW agenda_proxima AS 
SELECT * FROM agenda WHERE fecha >= DATE(NOW()); 

SELECT * FROM agenda_proxima;

-- Muestra las mascotas ordenadas por dueño --
CREATE OR REPLACE VIEW mascotas_por_dueño AS
SELECT * FROM mascota ORDER BY dueño_id ASC;

SELECT * FROM mascotas_por_dueño;

-- Vacunas y Antiparasitarios pendientes (1: pendiente, 0: no vencido), usando la función nombre_y_apellido --
CREATE OR REPLACE VIEW pendientes_vacunas AS 
SELECT 
	MAX(fecha_proxima) < DATE(NOW()) AS "Vencimiento Vacuna", 
    MAX(fecha_proxima) AS "Próxima Vacuna", 
    m.nombre AS "Nombre Mascota", 
    tipo AS "Tipo Vacuna", 
    nombre_y_apellido(d.nombre, d.apellido) AS "Nombre Dueño"
FROM vacunas
JOIN mascota AS m
ON vacunas.mascota_id = m.id 
JOIN dueño AS d
ON d.id = m.dueño_id
GROUP BY mascota_id, tipo
ORDER BY MAX(fecha_proxima), MAX(fecha_proxima) < DATE(NOW()) DESC;

SELECT * FROM pendientes_vacunas;

CREATE OR REPLACE VIEW pendientes_antiparasitarios AS
SELECT 
	MAX(proxima_fecha) < DATE(NOW()) AS "Vencimiento Antiparasitario", 
    MAX(proxima_fecha) AS "Próxima vacuna", 
    m.nombre AS "Nombre Mascota", 
    tipo AS "Tipo Antiparasitario", 
    nombre_y_apellido(d.nombre, d.apellido) AS "Nombre Dueño"
FROM antiparasitarios
JOIN mascota AS m
ON antiparasitarios.mascota_id = m.id 
JOIN dueño AS d
ON d.id = m.dueño_id
GROUP BY mascota_id, tipo
ORDER BY MAX(proxima_fecha), MAX(proxima_fecha) < DATE(NOW()) DESC;

SELECT * FROM pendientes_antiparasitarios;

-- Mascotas asociadas a cada dueño, usando la función nombre_y_apellido --
CREATE OR REPLACE VIEW mascotas_de_un_dueño AS
SELECT nombre_y_apellido(d.nombre, d.apellido) AS 'Nombre Dueño', m.nombre AS 'Nombre Mascota' 
FROM dueño AS d
JOIN mascota AS m
ON d.id = m.dueño_id;

SELECT * FROM mascotas_de_un_dueño;

-- Número de mascotas por dueño usando la función nombre_y_apellido -- 
CREATE OR REPLACE VIEW numero_mascotas_por_dueño AS
SELECT nombre_y_apellido(d.nombre, d.apellido) AS "Nombre Dueño", count(m.dueño_id) AS "Número de mascotas" 
FROM dueño AS d
JOIN mascota AS m
ON d.id = m.dueño_id
GROUP BY m.dueño_id;

SELECT * FROM numero_mascotas_por_dueño;

-- Nombre de mascota 'Pelusa' repetido o cualquier otro que pueda repetirse, se hace esta consulta para evitar confusiones entre distintas mascotas con el mismo nombre --
CALL nombre_mascota_repetido('Pelusa');

-- Mostrar los dueños que han puesto chip a alguna mascota, usando la función nombre_y_apellido --
CREATE OR REPLACE VIEW chip_puestos AS
SELECT nombre_y_apellido(d.nombre, d.apellido) AS 'Nombre Dueño', m.chip AS 'Chip' 
FROM dueño AS d
JOIN mascota AS m
ON d.id = m.dueño_id
WHERE chip = 1;

SELECT * FROM chip_puestos;

-- Mostrar historial de Antiparasitarios para una mascota en particular --
CALL historial('antiparasitarios', 5);

-- Historial de Vacunas para una mascota en particular --
CALL historial('vacunas', 1);

-- Cantidad de mascotas sin chip (chip = 0) -- 
CALL contar_chips(0); 

-- Mostrar las mascotas que no tienen chip, para hablar con su dueño e insentivar la incorporación de este --
CALL mascota_con_o_sin_chip(0);

-- Cálculo de la edad por mascota usando la función calculo_edad--
CREATE OR REPLACE VIEW registro_edad_mascota AS
SELECT nombre, especie, raza, color, calculo_edad(fecha_nac) AS "edad"
FROM mascota;

SELECT * FROM registro_edad_mascota;