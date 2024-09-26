USE veterinaria;

-- CREACIÓN DE REGISTROS a modo de ejemplo --
-- Dueños --
INSERT INTO dueño(nombre, apellido, rut, telefono, direccion, correo) VALUES
	("Constanza", "Jimenez", "17228544-9", "+56987333455", "Comuna de San Ramón, Santiago, Chile", "constanza@gmail.com"),
    ("Fernando", "López", "7665409-1", "+56977778888", "Comuna de Las Condes, Santiago, Chile", "fernando@gmail.com"),
	("Salvador", "De la Jara", "4665980-0", "+56922335544", "Comuna de La Pintana, Santiago, Chile", "salvador@gmail.com"),
	("Luis", "Moraga", "9876778-k", "+56911435577", "Comuna de La Reina, Santiago, Chile", "luis@gmail.com"),
	("Iñaki", "Vergara", "18546770-k", "+56977640998", "Comuna de San Bernardo, Santiago, Chile", "iñaki@gmail.com");

-- Mascotas --
INSERT INTO mascota(dueño_id, nombre, especie, raza, color, sexo, esterilizado, chip, peso, fecha_nac) VALUES
	(1, "Mayra", "Perro", "Pastor Alemán", "Típico", "Hembra", true, true, 31.5, "2017-05-30"),
	(2, "Saiph", "Gato", "British Shorthair", "Gris", "Macho", true, false, 6.7, "2012-02-11"),
	(5, "Pelusa", "Perro", "Poodle", "Blanco", "Hembra", false, false, 4.3, "2020-12-15"),
	(3, "Dobby", "Perro", "Fox Terrier", "Típico", "Macho", true, true, 8.2, "2016-10-01"),
	(4, "Pelusa", "Perro", "Bichón maltés", "Blanco", "Macho", true, true, 3.8, "2022-03-21"),
	(2, "Nannuq", "Gato", "Cymric", "Negro con blanco", "Macho", true, false, 6.3, "2012-01-01"),
	(2, "Ray", "Perro", "Basset leonado de Bretaña", "Típico", "Macho", false, false, 7.8, "2019-02-05"),
	(5, "Maqui", "Perro", "Golden Retriever", "Rubio", "Macho", true, false, 28.8, "2015-06-30"),
	(5, "Copito", "Gato", "Bosque de Noruega", "Típico", "Macho", true, true, 3.7, "2014-11-20"),
	(5, "Leoncito", "Gato", "Bombay de pelo largo", "Negro", "Macho", true, false, 4.1, "2010-12-12");

-- Tipo de Antiparasitario --
INSERT INTO tipoAntiparasitario(nombre) VALUES
	('Interno'),
    ('Externo');

-- Tipo de Vacuna --
INSERT INTO tipoVacuna(nombre) VALUES
	('Antirrábica'),
    ('Óctuple'),
    ('Triple Felina'),
    ('KC');

-- Marcas --
INSERT INTO marcaAntiparasitario(nombre) VALUES
	('Simparica'),
    ('Drontal'),
    ('Bravecto');
    
INSERT INTO marcaVacuna(nombre) VALUES
    ('Novibac'),
    ('Versiguard'),
    ('Felocell');

-- Antiparasitarios --
INSERT INTO antiparasitarios(tipo, marca, fecha, proxima_fecha, mascota_id) VALUES
	(1, 2, "2024-04-24", "2024-07-24", 1),
	(1, 2, "2024-05-20", "2024-08-20", 1),
	(2, 3, "2023-12-24", "2024-03-24", 5),
	(1, 2, "2024-03-30", "2024-06-30", 5),
	(1, 1, "2024-07-05", "2024-10-05", 5),
	(1, 2, "2024-04-24", "2024-07-24", 3),
	(2, 3, "2022-04-24", "2022-07-24", 2),
	(1, 1, "2022-12-30", "2023-03-30", 2),
	(1, 2, "2021-11-08", "2022-02-08", 4),
	(1, 1, "2022-03-10", "2022-06-10", 4),
	(2, 3, "2022-06-17", "2022-09-17", 4);

-- Vacunas --
INSERT INTO vacunas(tipo, marca, fecha, fecha_proxima, mascota_id) VALUES
	(1, 1, "2024-01-28", "2026-01-28", 10),
	(2, 2, "2024-04-30", "2025-04-30", 9),
	(2, 1, "2023-10-10", "2024-10-10", 10),
	(3, 3, "2024-07-10", "2025-07-10", 6),
	(4, 1, "2024-05-03", "2025-05-03", 1),
	(2, 1, "2024-05-13", "2025-05-13", 1),
	(1, 2, "2024-05-13", "2026-05-13", 1),
	(2, 2, "2024-06-22", "2025-06-22", 8),
	(3, 3, "2022-10-07", "2023-10-07", 2);

-- Agenda --
INSERT INTO agenda(fecha, nombre_dueño, nombre_mascota) VALUES
	("2024-08-05", "Iñaki Vergara", "Pelusa"),
	("2024-09-20", "Catalina Ortuzar", "Manchas"),
	("2024-09-11", "Daniela Astudillo", "Yuki"),
	("2024-08-31", "Patricio Collao", "Esponjoso"),
	("2024-07-25", "Luis Moraga", "Pelusa");

-- Consultas --
INSERT INTO consulta(fecha_id, razon_consulta, peso, anamnesis, plan_diagnostico, plan_terapeutico, prediagnostico, diagnostico, tratamiento, mascota_id) VALUES
(
	1, 
    "Control para vacunas", 
    4.5, 
    "Buen estaado de salud, sin hallazgos encontrados", 
    "Proseguir con vacunaciones",
    "Ninguno",
    "Ninguno",
    "Ninguno",
    "Se aplica la vauna antirrábica y óctuple. Dejar a disposición abundante agua",
    3
);
INSERT INTO consulta(fecha_id, razon_consulta, anamnesis, plan_diagnostico, plan_terapeutico, prediagnostico, diagnostico, tratamiento, fecha_proxima, mascota_id) VALUES -- Sin peso
(
	5, 
    "Urgencia por atropello", 
    "A primera vista se ve dañada la pata izquierda trasera y la cola",
    "Se prosigue realizar radiografías y ecografía para ver daño de huesos y tejidos",
    "Requerirá terapia de movilidad una vez haya reposado por los días a determinar",
    "Fractura de para izquierda trasera",
    "Fractura interna del hueso x de la pata trasera izquierda y esguince de grado 2 en la cola",
    "Mantener movilizado y que se mueva lo menos posible. Se receta x remedio cada 12 horas por 10 días. Próximo control en 10 días",
    "2024-08-04",
    5
);