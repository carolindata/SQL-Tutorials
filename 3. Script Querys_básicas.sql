-- ================================================================ -- 
-- 					CLÁUSULAS BÁSICAS								--
-- ================================================================ -- 

					-- 	>>>>  SELECT	<<<<-- 

-- Seleccionar columnas -- 
	Select * From productos;
	Select categoría, producto from productos;

-- Identificar datos únicos 
	Select distinct Categoría from productos;

-- Seleccioanr columnas y renombrarlas en la consulta -- 
	Select categoría, producto as detalle from productos;

-- Seleccionar columnas y adicionar "modificadores"
-- Averiguar el precio de venta por unidad -- 
	Select fecha_venta, Unidades, Venta_total_$, (venta_total_$/unidades) as venta_unidad from ventas; 
	Select avg(Venta_total_$) from ventas;

					-- 	>>>>  FROM	<<<<-- 

Select * from productos;
Select p.producto from productos p; -- (útil cuando se trabaja con varias tablas joins)

					-- 	>>>>  WHERE	<<<<- (filtro)
-- Orden (Select * FROM  nombre_tabla WHERE condición GROUP BY ....')

-- Operadores de comparación más comunes  "=", "<", ">", "<=", ">= , !=
Select producto, costo from productos
where costo != 24;

-- -- Operadores lógicos más comunes  "AND", "OR", "IN", "NOT" 

-- AND (múltiples condiciones -  Diferentes columnas)
Select * from productos
where categoría = 'herramientas' and  producto = 'sierra circular' and costo > 10 ; 

Select * from productos where Categoría = 'herramientas' and  Categoría = 'Accesorios'; -- se anula

-- OR (múltiples condiciones - pero permitiendo que al menos una de las condiciones se cumpla)
Select * from tiendas where ciudad = 'Lima' or  país = 'Colombia'; -- (diferentes columnas)
Select * from productos where Categoría = 'herramientas' or  Categoría = 'Accesorios'; -- (en la misma columna)

-- IN ( filtrar los resultados de una consulta basándose en una lista de valores específicos)
Select * from productos where Categoría IN ('herramientas', 'accesorios');

-- NOT (selecciona lo contrario a la consulta) sintaxis: WHERE NOT
Select * from productos where NOT Categoría IN ('herramientas', 'accesorios');

						-- 	>>>>  GROUP BY 	<<<<- (agrupar filas o registros de una o varias columnas simula las tablas dinámicas)
-- Al agrupar los datos, se pueden realizar operaciones de agregación como SUM, COUNT, AVG, MAX, MIN, entre otras

-- (debe ir en select las columnas que están agrupando y alguna función agregación)
SELECT Categoría, COUNT(*) 
FROM productos
GROUP BY Categoría;

-- (costo promedio de la categoría) -- 
SELECT Categoría, sum(costo) as costo_total
FROM productos
GROUP BY Categoría;

-- 			 	>>>>  HAVING 	<<<<- (Se usa en conjunto con GROUP BY
-- SQL para filtrar los resultados de una consulta que utiliza la cláusula GROUP BY.
-- Mientras que la cláusula WHERE filtra las filas de la tabla de origen antes de que se agrupen y se apliquen las funciones de agregación,
--  la cláusula HAVING filtra los grupos resultantes después de que se hayan aplicado las funciones de agregación.

-- (agrupar las categorías, calcular la suma del costo, contar el numero de productos que están por encima de 10)
SELECT Categoría, sum(costo) as costo_cat
FROM productos
GROUP BY Categoría
HAVING SUM(costo) > 10; -- (se quiere conocer la cantidad total de costos de los productos en cada categoría que superan los 10 USD)

-- se está agrupando los productos por categoría y sumando el costo de cada categoría (que viene siendo la suma del costo de cada producto dentro de cada categoría)
--  la cláusula HAVING está filtrando los resultados para mostrar solo aquellas categorías donde la suma total de los costos de los productos en la categoría es mayor a 10.

-- 			 	>>>>  ORDER BY (ASC - DESC)	<<<<-

SELECT Categoría, sum(costo) as costo_cat
FROM productos
GROUP BY Categoría
HAVING SUM(costo) > 10
ORDER by Costo_cat;

SELECT Categoría, sum(costo) as costo_cat
FROM productos
GROUP BY Categoría
HAVING SUM(costo) > 10
ORDER by costo_cat desc;

-- 			 	>>>> LIMIT	<<<<-
Select * from productos;
Select count(*) from productos; -- (conocer el numero de registros)
-- Limitar el número de registros 
Select * from productos 
Limit 5;