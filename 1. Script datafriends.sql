-- ===========================================================-- 
-- 		CREAR, ELIMINAR Y RENOMBRAR LA BASE DE DATOS -- 
-- ===========================================================-- 

-- crear base de datos --
CREATE DATABASE Youtubechan;
DROP DATABASE Youtubechan;

-- crear base de datos --
CREATE DATABASE YT;


-- mostrar listado de bases de datos -- 
show databases;

-- indicar la base de datos con la que se desea trabajar
use YT; 

-- ===========================================================-- 
-- 		CREAR TABLAS DENTRO DE LA BASE DATOS -- 
-- ===========================================================-- 

-- Las tablas deben llevar: 
-- 	Nombre tabla, Id unico (pk), atributos (columnas) y el tipo de dato que va a contener la columna
-- Se debe identificar la propiedad ,la PK y la FK si es el caso:

-- crear base de datos --
create table suscriptores (
id_df int not null auto_increment,
nombrre varchar (255),
email varchar (255),
primary key (id_df)
);

-- quiero ver mi tabla --  
select * from suscriptores;
SHOW CREATE TABLE suscriptores; -- copy field --


-- ===========================================================-- 
-- 		MODIFICAR TABLAS DENTRO DE LA BASE DE DATOS -- 
-- ===========================================================-- 

-- cambiar el nombre de la tabla --
ALTER TABLE suscriptores RENAME TO datafriends;

-- insertar una columna (se olvidó whatsapp) --
ALTER TABLE datafriends ADD whatsapp int;

-- cambiar el nombre de una columna --
ALTER TABLE datafriends RENAME COLUMN nombrre TO nombre;

-- cambiar el tipo de dato y una propiedad de una columna -- 
-- (a pesar que es un número telefónico, lo dejo como caracter por los indicativos o un numero puede iniciar en 0 o +) --
-- queremos que estos datos siempre sean diligenciados - not null -- 
ALTER TABLE datafriends MODIFY whatsapp VARCHAR(30) not null;

-- Ahora quiero ver el comando ver el código de mi tabla ya creada
Select * from datafriends;
SHOW CREATE TABLE datafriends; -- copy field -- 

-- ===========================================================-- 
-- 		INSERTAR DATOS DENTRO DE LA TABLA -- 
-- ===========================================================-- 

-- insertar registro por registro --
INSERT INTO datafriends (nombre, email, whatsapp ) values ('Kennys Botero', 'kennys@gmail.com', '+57123456789');
INSERT INTO datafriends (nombre, email, whatsapp ) values ('Luis Ibarra', 'Luis@gmail.com', '+57213456798');

-- ver los registros -- 
Select * from datafriends; 

-- insertar varios registros en una sola consulta
INSERT INTO datafriends (nombre, email, whatsapp) 
values
	('Gastón', 'gastónmiau@gmail.com', '+578734567890'),
	('Crokylol', 'crokylol@gmail.com', '+899876543210'),
	('Mary', 'mary@gmail.com', '+899873443670');
        -- ejecutar x 2 (error a propósito)

-- ===========================================================-- 
-- 		MODIFICAR REGISTROS DENTRO DE LA TABLA -- 
-- ===========================================================-- 

SELECT * FROM Datafriends;
-- borrar un registro --
DELETE FROM datafriends where id_df = '6';
DELETE FROM datafriends where id_df between 7 and 8;

-- actualizar un registro --
update datafriends set nombre = 'Gastón Miau' where id_df = 3;
    
-- ===========================================================-- 
-- 		CREAR OTRA TABLA -- 
-- ===========================================================-- 

-- Crear la tabla "compras"
CREATE TABLE compras (
  id_c INT NOT NULL AUTO_INCREMENT,
  comprador INT,
  producto VARCHAR(50),
  cantidad INT,
  PRIMARY KEY (id_c),
  FOREIGN KEY (comprador) REFERENCES datafriends(id_df)
);

-- Insertar algunos datos en la tabla "compras" 
INSERT INTO compras (comprador, producto, cantidad)
values
  (1, 'sticker', 2),
  (4, 'supergracias', 3),
  (2, 'supergracias', 1),
  (1, 'supergracias', 2),
  (3, 'supergracias', 1),
  (5, 'paypal', 3);
  
  -- ver los registros -- 
Select * from compras; 
SHOW CREATE TABLE compras; -- copy field -- 

-- actualizar un registro
update compras set producto = 'paypal' where id_c = 3 ;

-- ver registros
select * from compras;

-- ===========================================================-- 
-- 		Diagrama Entidad relación  -- 
-- ===========================================================-- 

-- Pestaña database>> reverse eningenier

-- ===========================================================-- 
-- 		Eliminar tablas y bases de datos  -- 
-- ===========================================================-- 

Drop table compras;
Drop database yt;
create database yt; -- se debe ejecutar nuevamente la consulta -- 