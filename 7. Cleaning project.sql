-- ======================================================================== --
--                            LIMPIEZA DE DATOS SQL           
-- ========================================================================= -- 

-- =========== Preparando  y explorando los datos ================== --

-- ----- Crear una base de datos 
CREATE DATABASE IF NOT EXISTS clean;

-- ----- Importar el archivo csv. 
-- ----- Seleccionar la tabla a trabajar
USE clean;

-- ----- Generar una muestra de los datos
SELECT * FROM LIMPIEZA LIMIT 10;

-- =========== Store procedure - procedimiento almacenado (macro) ================== --

Select * from limpieza; -- se quiere evitar escribirlo repetidamente

-- ----- crear el procedimiento para consultar sin escribir toda la consulta
DELIMITER //
CREATE PROCEDURE limp()
BEGIN
    SELECT * FROM limpieza;
END //
DELIMITER ;
-- ejecutar el procedimiento
CALL limp;

-- ----- Renombrar los nombres de las columnas con caracteres especiales
ALTER TABLE limpieza CHANGE COLUMN `ï»¿Id?empleado` Id_emp varchar(20) null; -- `caracteres especiales` -- 

-- =========== Verificar y remover registros duplicados ================== --

-- ----- Verificar si hay registros duplicados
SELECT Id_emp, COUNT(*) AS cantidad_duplicados
FROM limpieza
GROUP BY Id_emp  
HAVING COUNT(*) > 1;
/* Explicación:
-- Group by: Agrupa los registros por el valor de la columna Id_emp, los registros con el mismo valor en Id_emp se agruparán juntos
-- Having:especifica una condición que se aplicará después del agrupamiento, solo se seleccionarán los grupos que tengan una cantidad (COUNT(*)) mayor a 1
-- 		se mostrarán los valores de Id_emp que tengan duplicados.
-- En general, muestra los registros duplicados junto con la cantidad de ocurrencias de cada conjunto duplicado. */

-- ----- Contar el número de duplicados con Subquery 
SELECT COUNT(*) AS cantidad_duplicados
FROM (
    SELECT Id_emp
    FROM limpieza
    GROUP BY Id_emp
    HAVING COUNT(*) > 1
) AS subquery;
/* Explicación: 
SELECT count(*) as (nombre columna)
from (subconsulta) as te
-- Subconsulta: para obtener los valores de Id_emp que están duplicados en la tabla limpieza.
-- Consulta principal: se enfoca en contar la cantidad de registros devueltos por la subconsulta, es decir, la cantidad de duplicados
-- AS 'Subquery' le asigna el alias a la subconsulta, El alias se utiliza para referirse a la subconsulta en la consulta principal.
-- Al asignar un alias a la subconsulta, se puede utilizar ese alias en la consulta principal para referirse a la subconsulta como una tabla temporal.
*/

-- ----- Crear una tabla temporal con valores unicos y luego hacerla "original" (permanente)

-- # cambiar el nombre de la tabla 'limpieza' por 'conduplicados'
RENAME TABLE limpieza TO conduplicados;

-- # crear una tabla temporal (sin datos duplicados)
CREATE TEMPORARY TABLE temp_limpieza AS 									
SELECT DISTINCT *  FROM conduplicados; 	
/*Explicación: 
-- CREATE TEMPORARY TABLE: Una tabla temporal solo existe durante la duración de la sesión de la conexión de la base de datos. 
-- AS: se utiliza para indicar que la tabla temporal está siendo definida como el resultado de una consulta SELECT
-- SELECT: seleccionar únicamente los valores únicos(distinct) de las columnas en lugar de todos los registros. */

-- # verificar el número de registros
SELECT COUNT(*) AS original FROM conduplicados;
SELECT COUNT(*) AS temporal FROM temp_limpieza; 

-- # convertir la tabla temporal a permanente
CREATE TABLE limpieza AS
SELECT * FROM temp_limpieza;

-- ----- Verificar nuevamente si aún hay duplicados
SELECT COUNT(*) AS cantidad_duplicados
FROM (
    SELECT Id_emp
    FROM conduplicados -- verificar en ambas tablas
    GROUP BY Id_emp
    HAVING COUNT(*) > 1
) AS subquery;

 -- ----- Eliminar tabla que contiene los duplicados 
 DROP TABLE conduplicados;
 
-- =========== Verificar y remover registros duplicados ================== --

-- ----- Activar/Desactivar modo seguro - (0 desactivar) (1 activar) 
SET sql_safe_updates = 0;  

-- ----- Renombrar los nombres de las columnas
ALTER TABLE limpieza CHANGE COLUMN `gÃ©nero` Gender varchar(20) null;
ALTER TABLE limpieza CHANGE COLUMN Apellido Last_name varchar(50) null;
ALTER TABLE limpieza CHANGE COLUMN star_date Start_date varchar(50) null;

-- ----- Revisar los tipos de datos de la tabla
DESCRIBE limpieza; -- Hay fechas con tipo de dato texto

-- ===========  Trabajando con texto (strings) ================== --

-- ----- Identificar nombres con espacios extra
call limp();

SELECT Name FROM limpieza WHERE LENGTH(name) - LENGTH(TRIM(name)) > 0; 
/* Explicación:
El largo del nombre - nombre del nombre sin caracteres, si es mayor a 0 es porque hay más espacios
Hacer lo mismo con las columnas de texto */

-- ----- "Ensayo" del query antes de actualizar la tabla

-- # Nombres con espacios
SELECT name, TRIM(name) AS Name
FROM limpieza
WHERE LENGTH(name) - LENGTH(TRIM(name)) > 0;

-- # modificando nombres
UPDATE limpieza
SET name = TRIM(name)
WHERE LENGTH(name) - LENGTH(TRIM(name)) > 0;

-- # Apellidos con espacios
SELECT last_name, TRIM(Last_name) AS Last_name 
FROM limpieza
WHERE LENGTH(last_name) - LENGTH(TRIM(last_name)) > 0;

-- # modificando apellidos
UPDATE limpieza
SET last_name = TRIM(Last_name)
WHERE LENGTH(Last_name) - LENGTH(TRIM(Last_name)) > 0;

call limp();

-- ------ identificar espacios extra en medio de dos palabras

-- # adicionar a propósito espacios extra
UPDATE limpieza SET area = REPLACE(area, ' ', '       '); 
call limp();

-- # Explorar si hay dos o más espacios entre dos palabras  
SELECT area FROM limpieza 
WHERE area REGEXP '\\s{2,}';  

-- # Consultar los espacios extra 
Select area, TRIM(REGEXP_REPLACE(area, '\\s+', ' ')) as ensayo 
FROM limpieza; 
 /* Explicación:
 -- '\\s{2,}' : busca dos o más espacios en blanco consecutivos en una cadena
 -- '\\s+' :  busca uno o más espacios en blanco consecutivos en una cadena
 -- TRIM():  eliminar cualquier espacio en blanco adicional al inicio o al final del valor en la columna 'area'
-- La función REGEXP_REPLACE(area, '\\s+', ' ')  busca cualquier secuencia de uno o más espacios en blanco (\\s+) 
 en la columna 'area' y los reemplaza por un solo espacio en blanco (' '). */
 
UPDATE limpieza SET area = TRIM(REGEXP_REPLACE(area, '\\s+', ' ')); 

 -- ===========  Buscar y reemplazar (textos) ================== --
-- ------ Ajustar gender
-- # ensayo
SELECT gender,  
CASE
    WHEN gender = 'hombre' THEN 'Male'
    WHEN gender = 'mujer' THEN 'Female'
    ELSE 'Other'
END as gender1
FROM limpieza;

-- # actualizar tabla
UPDATE Limpieza
SET Gender = CASE
    WHEN gender = 'hombre' THEN 'Male'
    WHEN gender = 'mujer' THEN 'Female'
    ELSE 'Other'
END;
CALL limp();

 -- ===========  Cambiar propiedad y reemplazar datos ================== -- 
DESCRIBE limpieza;

ALTER TABLE limpieza MODIFY COLUMN Type TEXT;

SELECT type,
CASE 
	WHEN type = 1 THEN 'Remote'
    WHEN type = 0 THEN 'Hybrid'
    ELSE 'Other'
END as ejemplo
FROM limpieza;

UPDATE limpieza
SET Type = CASE
	WHEN type = 1 THEN 'Remote'
    WHEN type = 0 THEN 'Hybrid'
    ELSE 'Other'
END;
-- revisamos cambios
call limp();

-- ===========  Ajustar formato números ================== -- 
call limp();

-- ----- consultar :reemplazar $ por un vacío y cambiar el separador de mil por vacío.
SELECT salary,  CAST(TRIM(REPLACE(REPLACE(salary, '$', ''), ',', '')) AS DECIMAL(15, 2)) from limpieza;
/* Explicación 
-- REPLACE(salary, '$', ''):Se utiliza para eliminar el símbolo de dólar ('$') de la columna 'salary',
		y reemplaza cada aparición del símbolo $ con una cadena vacía ('').
-- REPLACE(..., ',', ''): Se utiliza nuevamente para eliminar las comas (',') de la columna 'salary'. 
		y reemplaza cada aparición de la coma con una cadena vacía ('').
-- TRIM(...): Elimina cualquier espacio en blanco adicional alrededor del valor después de eliminar los símbolos y las comas.
-- CAST(... AS DECIMAL(15, 2)): CAST() se utiliza para convertir el valor resultante en un número decimal con una precisión de 15 dígitos en total y 2 decimales. */

UPDATE limpieza SET salary = CAST(TRIM(REPLACE(REPLACE(salary, '$', ''), ',', '')) AS DECIMAL(15, 2));


-- ===========  Trabajando con fechas ================== --

-- ------ Cambiar el tipo de dato de las columnas de texto (strings) a fechas
DESCRIBE limpieza; -- hay tres fechas a ajustar (birth_day, start_day. finish_day)

-- # Birth_day # 

-- ----- Identificar como están las fechas de fecha
SELECT birth_date FROM limpieza; -- Orden en SQL AAAA-MM-DD =  año, mes, día
call limp(); -- está en mes, día, año.

-- ----- "ensayo" - dar formato a la fecha 
SELECT birth_date, CASE
    WHEN birth_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birth_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birth_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birth_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END AS new_birth_date
FROM limpieza;
/*  Explicación
-- CASE: evalua y reemplaza según condicion (similar al "si" en excel)
-- WHEN birth_date LIKE '%/%': verifica si la columna birth_date contiene una barra diagonal o guión
		(indicando un formato de fecha mes/día/año); (si esto es una fecha, entonces)
-- str_to_date(birth_date, '%m/%d/%Y'): Convierte el valor de birth_date de una cadena en formato mes/día/año a un objeto de fecha (MySQL). 
		(se convierte el texto en objeto de fecha)
-- date_format(<fecha>, '%Y-%m-%d'): Formatea el objeto de fecha resultante en una cadena con el formato AAAA-MM-DD. 
		(pasa la fecha a año, mes día) */

-- ----- Actualizar la tabla
UPDATE limpieza
SET birth_date = CASE
	WHEN birth_date LIKE '%/%' THEN date_format(str_to_date(birth_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birth_date LIKE '%-%' THEN date_format(str_to_date(birth_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

-- Cambiar el tipo de dato de la columna 
ALTER TABLE limpieza MODIFY COLUMN birth_date date;
DESCRIBE limpieza; -- comprobar el cambio 

-- # Start_date (Se repite el proceso)
-- ----- Identificar como están las fechas de fecha
SELECT start_date FROM limpieza; -- Orden en SQL AAAA-MM-DD =  año, mes, día
call limp(); -- está en mes, día, año.

-- ----- "ensayo" - dar formato a la fecha 
SELECT start_date, CASE
	WHEN start_date LIKE '%/%' THEN date_format(str_to_date(start_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN start_date LIKE '%-%' THEN date_format(str_to_date(start_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END AS new_start_date
FROM limpieza;

-- ----- Actualizar la tabla
UPDATE limpieza
SET start_date = CASE
	WHEN start_date LIKE '%/%' THEN date_format(str_to_date(start_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN start_date LIKE '%-%' THEN date_format(str_to_date(start_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

-- Cambiar el tipo de dato de la columna 
ALTER TABLE limpieza MODIFY COLUMN start_date DATE;
DESCRIBE limpieza;


-- ===========  Explorando funciones de fecha  ================== --

-- usaremos finish_date para explorar
SELECT finish_date FROM limpieza;
CALL limp();

-- # "ensayos" hacer consultas de como quedarían los datos si queremos ensayar diversos cambios.
SELECT finish_date, str_to_date(finish_date, '%Y-%m-%d %H:%i:%s') AS fecha FROM limpieza;  -- convierte el valor en objeto de fecha (timestamp)
SELECT finish_date, date_format(str_to_date(finish_date, '%Y-%m-%d %H:%i:%s'), '%Y-%m-%d') AS fecha FROM limpieza; -- objeto en formato de fecha, luego da formato en el deseado '%Y-%m-%d %H:'
SELECT finish_date, str_to_date(finish_date, '%Y-%m-%d') AS fd FROM limpieza; -- separar solo la fecha
SELECT  finish_date, str_to_date(finish_date, '%H:%i:%s') AS hour_stamp FROM limpieza; -- separar solo la hora no funciona
SELECT  finish_date, date_format(finish_date, '%H:%i:%s') AS hour_stamp FROM limpieza; -- separar solo la hora(marca de tiempo)

-- # Diviendo los elementos de la hora
SELECT finish_date,
    date_format(finish_date, '%H') AS hora,
    date_format(finish_date, '%i') AS minutos,
    date_format(finish_date, '%s') AS segundos,
    date_format(finish_date, '%H:%i:%s') AS hour_stamp
FROM limpieza;

-- ===========  Actualizaciones de fecha en la tabla  ================== --

-- ----- Copia de seguridad de la columna finish_date
call limp();
ALTER TABLE limpieza ADD COLUMN date_backup TEXT; -- Agregar columna respaldo
UPDATE limpieza SET date_backup = finish_date; -- Copiar los datos de finish_date a a la columna respaldo

-- # Actualizar la fecha a marca de tiempo: (TIMESTAMP ; DATETIME)
 Select finish_date, str_to_date(finish_date, '%Y-%m-%d %H:%i:%s UTC')  as formato from limpieza; -- (UTC)
 /* Diferencia entre timestamp y datetime
-- timestamp (YYYY-MM-DD HH:MM:SS) - desde: 01 enero 1970 a las 00:00:00 UTC , hasta milesimas de segundo
-- datetime desde año 1000 a 9999 - no tiene en cuenta la zona horaria , hasta segundos. */

UPDATE limpieza
	SET finish_date = str_to_date(finish_date, '%Y-%m-%d %H:%i:%s UTC') 
	WHERE finish_date <> '';
    
call limp();

-- --------- Dividir la finish_date en fecha y hora

 -- # Crear las columnas que albergarán los nuevos datos 
ALTER TABLE limpieza
	ADD COLUMN fecha DATE,
	ADD COLUMN hora TIME;
    
-- # actualizar los valores de dichas columnas
UPDATE limpieza
SET fecha = DATE(finish_date),
    hora = TIME(finish_date)
WHERE finish_date IS NOT NULL AND finish_date <> '';

 -- # Valores en blanco a nulos
UPDATE limpieza SET finish_date = NULL WHERE finish_date = '';

-- # Actualizar la propiedad
ALTER TABLE limpieza MODIFY COLUMN finish_date DATETIME;

-- # Revisar los datos
SELECT * FROM limpieza; 
CALL limp();
DESCRIBE limpieza;

-- ========= Cálculos con fechas ====== -- 

-- # Agregar columna para albergar la edad
ALTER TABLE limpieza ADD COLUMN age INT;
call limp();

SELECT name,birth_date, start_date, TIMESTAMPDIFF(YEAR, birth_date, start_date) AS edad_de_ingreso
FROM limpieza;


-- # Actualizar los datos en la columna edad
UPDATE limpieza
SET age = timestampdiff(YEAR, birth_date, CURDATE()); 
-- esta función diferencia en años entre dos fechas (diferencia en años YEAR "year_month", birth_date y fecha actual CURDATE)
/* Calcular diferencias
SECOND: Diferencia en segundos.
MINUTE: Diferencia en minutos.
HOUR: Diferencia en horas.
DAY: Diferencia en días.
WEEK: Diferencia en semanas.
MONTH: Diferencia en meses.
QUARTER: Diferencia en trimestres.
DAY_HOUR: Diferencia en días y horas.
YEAR_MONTH: Diferencia en años y meses. */
call limp;

-- ============ creando columnas adicionales ================= -- 

select CONCAT(SUBSTRING_INDEX(Name, ' ', 1),'_', SUBSTRING(Last_name, 1, 4), '.',SUBSTRING(Type, 1, 1), '@consulting.com') as email from limpieza;
-- correo: primer nombre, _ , dos letras del apellido, @consulting.com
-- SUBSTRING_INDEX(cadena, delimitador, ocurrencia) 
	/* Ocurrencia
	Ocurrencia: es el número de ocurrencia del delimitador a partir del cual se extraerá la parte de la cadena
		Si se especifica un número positivo, la función devolverá todos los caracteres antes del enésimo delimitador. 
		Si se especifica un número negativo, la función devolverá todos los caracteres después del enésimo delimitador.*/
-- SUBSTRING(Last_name, inicio, longitud)

ALTER TABLE limpieza
ADD COLUMN email VARCHAR(100);

UPDATE limpieza 
SET email = CONCAT(SUBSTRING_INDEX(Name, ' ', 1),'_', SUBSTRING(Last_name, 1, 4), '.',SUBSTRING(Type, 1, 1), '@consulting.com'); 

CALL limp();

-- ============ creando y exportando mi set de datos definitivo ================= -- 

SELECT * FROM limpieza
WHERE finish_date <= CURDATE() OR finish_date IS NULL
ORDER BY area, Name;

SELECT area, COUNT(*) AS cantidad_empleados FROM limpieza
GROUP BY area
ORDER BY cantidad_empleados DESC;

