-- CASE -- 

SELECT producto, vendedor, venta_total_$,
  CASE 
    WHEN venta_total_$ > 600 THEN 'cumplido'
    ELSE 'no cumplido'
  END AS 'cumplimiento_meta'
FROM ventas;

SELECT producto, vendedor, tienda, venta_total_$,
  CASE 
  when tienda = 1 then 'sin metrica'
    WHEN venta_total_$ > 600 THEN 'cumplido'
    ELSE 'no cumplido'
  END AS 'cumplimiento_meta'
FROM ventas
order by tienda, cumplimiento_meta;

-- subquerys
Select avg(costo) from productos; -- sub 
Select categoría, producto, (Select avg(costo) from productos) as costoprom
from productos;

SELECT AVG(Venta_total_$) FROM Ventas; -- sub
SELECT * FROM Ventas
WHERE Venta_total_$ > (SELECT AVG(Venta_total_$) FROM Ventas);

create table tiendaserr (
id_tienda int,
país varchar(45),
ciudad varchar(45),
nombre_tienda varchar(45)
); 

insert into tiendaserr (select * from tiendas); -- insertamos los resultados de tiendas en tiendas err

update tiendaserr set nombre_tienda = '  Pintuland' where id_tienda = 1;
update tiendaserr set nombre_tienda = 'la casa del pintor' where id_tienda = 2;
update tiendaserr set nombre_tienda = 'Pinturama   ' where id_tienda = 3;

-- STRING
select * from tiendaserr;

select nombre_tienda, rtrim(nombre_tienda) as'sin_espacios_derecha' from tiendaserr; -- derecha pinturama
select nombre_tienda, ltrim(nombre_tienda) as'sin_espacios_izq' from tiendaserr; -- izquierda pintuland
select nombre_tienda, trim(nombre_tienda) as'sin_espacios_derecha' from tiendaserr; -- izquierda y derecha
select replace (nombre_tienda, ' ', '_') AS 'sin_espacios' from tiendaserr;
select nombre_tienda, substring(nombre_tienda, 1,3) as 'subtexto' from tiendas; -- extraer cierto numero caracteres
select nombre_tienda, upper(nombre_tienda) as 'Mayusc' from tiendas;
select nombre_tienda, lower(nombre_tienda) as 'Minusc' from tiendas;



