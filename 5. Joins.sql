-- ======================================================================= --
-- 			    JOINS - Trabajar con multiples tablas					       -- 
-- ======================================================================= --

-- Cuando se desea cruzar información de dos o más tablas usamos JOINS
-- Para cruzar los datos se hace uso de las llaves primarias y foráneas

select count(*) as total_registros from ventas; -- (revisar el numero de registros)

-- INNER JOINS --
-- Combina las filas de dos o más tablas solo si tienen coincidencias en las columnas especificadas en la cláusula de unión.

-- en la tabla de ventas queremos ver el nombre de la tienda
select * from ventas;
select * from tiendas;
select * from vendedores;
select * from productos;

-- en la tabla de ventas queremos ver el nombre de la tienda
SELECT *  -- (todas las columnas de las dos tablas)
FROM ventas v
INNER JOIN tiendas t ON v.Tienda = t.Id_tienda;

SELECT V.Fecha_venta, V.Unidades, V.Venta_total_$, T.Nombre_tienda
FROM ventas v
INNER JOIN tiendas t ON v.Tienda = t.Id_tienda;

-- en la tabla de ventas queremos ver el producto, el nombre del vendedor y la fecha de venta
select V.Fecha_venta, V.Unidades, V.Venta_total_$, VS.Nombre
from ventas v
join vendedores vs on v.vendedor = vs.id_vend;

-- en la tabla de vendedores queremos ver el nombre y apellido del vendedor y el nombre de la tienda
select vs.Nombre, vs.Apellido, t.Nombre_tienda, t.País
from vendedores vs
join tiendas t on vs.tienda = t.id_tienda;

-- en la tabla de ventas queremos ver el nombre del producto, el nombre y apellido del vendedor, el nombre de la tienda, las unidades y la venta total.

select * from ventas;

select v.Fecha_venta , p.producto, vs.nombre, vs. apellido, t.Nombre_tienda, v.unidades, v.Venta_total_$
from ventas v
join productos p on v.producto = p.id_prod
join vendedores vs on v.vendedor = vs.id_vend
join tiendas t on v.tienda = t.id_tienda
where v.Venta_total_$ > 500;

-- Conjuntos
-- Crear base de datos
Create database joins;
use joins;

-- Crear tabla de países
CREATE TABLE Paises (
  id_pais INT PRIMARY KEY,
  nombre_pais VARCHAR(50)
);

drop table ciudades;
-- Crear tabla de ciudades

CREATE TABLE Ciudades (
  id_ciudad INT PRIMARY KEY,
  nombre_ciudad VARCHAR(50),
  id_pais INT,
  FOREIGN KEY (id_pais) REFERENCES Paises(id_pais)
);

-- Insertar datos de ejemplo en la tabla de países
INSERT INTO Paises (id_pais, nombre_pais)
VALUES (1, 'Estados Unidos'),
       (2, 'Canadá'),
       (3, 'México'),
       (4, 'Perú'),
       (5, 'España') ;

-- Insertar datos de ejemplo en la tabla de ciudades
INSERT INTO ciudades (id_ciudad, nombre_ciudad, id_pais)
VALUES (1, 'Nueva York', 1),
       (2, 'Toronto', 2),
       (3, 'Ciudad de México', 3),
       (4, 'Bogotá',null),
       (5, 'Buenos Aires',null);
       
-- mostrar  la intersección
Select p.nombre_pais, c.nombre_ciudad
from paises p
join ciudades c on p.id_pais = c.id_pais; -- defecto inner joinn o intersección

-- mostrar todos los datos de la tabla izquierda
Select p.nombre_pais, c.nombre_ciudad
from paises p
left join ciudades c on p.id_pais = c.id_pais;

-- mostrar todos los datos de la tabla derecha
Select p.nombre_pais, c.nombre_ciudad
from paises p
right join ciudades c on p.id_pais = c.id_pais;

-- 
Select p.nombre_pais, c.nombre_ciudad
from paises p
left join ciudades c on p.id_pais = c.id_pais
UNION                                           -- unir las consultas 
Select p.nombre_pais, c.nombre_ciudad
from paises p
right join ciudades c on p.id_pais = c.id_pais;

-- mostrar todos los datos de las dos tablas - unir las consultas (UNION ALL)
Select p.nombre_pais, c.nombre_ciudad
from paises p
left join ciudades c on p.id_pais = c.id_pais
UNION                                           -- unir las consultas (UNION ALL)
Select p.nombre_pais, c.nombre_ciudad
from paises p
right join ciudades c on p.id_pais = c.id_pais;
