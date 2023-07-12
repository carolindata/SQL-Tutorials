-- ========================================= --
-- 			FILTRAR DATOS					 -- 
-- ========================================= --

-- ____________________________________________________________
-- >> Evaluando condiciones <<--

-- where AND (todos los campos deben cumplirs la condición)
select * from productos
Where categoría = 'Accesorios'and costo < 20;

-- Where OR (al menos una condición debe cumplirse - SQL arroja la que primero se cumpla)
Select * from productos
where categoría = 'herramientas' or producto = 'cinta métrica';

-- Se tiene varias condiciones es conveniente usar parentesis
Select * from vendedores
where (nombre = 'Juan' or apellido = 'Pérez') and salario > 1500;

-- >> Video pasado: algunas condiciones <<--
-- Igualdades : > , < , = ; Desigualdades: !=  <>

-- ______________________________________________________________________________
-- Rangos: BETWEEN (seleccionar datos entre dos valores numéricos o alfabéticos)
-- BETWEEN (números, fechas, texto) (incluye el limite del rango)
Select * from ventas
 where Venta_total_$ between '500' and '1000';

 Select * from ventas
 where Fecha_venta between '2023-01-01' and '2023-01-20';

Select * from vendedores
where nombre between 'c' and 'm'; 
-- (no toma maría, porque la a está un poco más allá de la m, así que extendemos la consulta a MZ por ejemplo)
Select * from vendedores
where nombre between 'c' and 'mz'; 

Select * from vendedores
where nombre not between 'c' and 'mz'; 

-- "Membresía" (a que varios elementos se reunan según un criterio IN )
-- Vendedores que trabajen en la tienda 1 o 2)
Select * from vendedores
where tienda in ('1','2'); 

Select * from vendedores
where tienda not in ('1','2');

-- ____________________________________________________________
-- >> Identificar patrones <<--
-- Wildcards (símbolos que identifican patrones parciales en un campo)
	-- para insertar un comodín se usa LIKE
	-- "-" Exactamente un caracter
	-- "%" Culquier numero de caracteres incluyendo 0

Select Nombre from vendedores where nombre like '%dro';
Select Nombre from vendedores where nombre like 'P%';
Select Nombre from vendedores where nombre like '%dr%';
Select Nombre from vendedores where nombre like 'P__ro';
Select Nombre from vendedores where nombre like 'P_d%';

Select Nombre from vendedores where nombre like 'l%' or nombre like '%a';

-- REGEXP regular expresion (construir expresiones para que SQL realice la búsqueda)

select nombre, apellido from vendedores where nombre regexp 'an'  ; -- (buscar los nombres que tienen an)
select nombre, apellido from vendedores where nombre regexp 'an|dro'; -- (buscar los nombres que tienen an o dro)
Select nombre, apellido from vendedores where nombre regexp '^s'; -- (^ indica que el nombre debe iniciar con s)
Select nombre, apellido from vendedores where nombre regexp 'a$'; -- ($ indica que el nombre debe terminar con n)
select nombre, apellido from vendedores where nombre regexp '[ín]a'; -- ([] combina las letras dentro de los parentesis con la letra siguiente)
select nombre, apellido from vendedores where nombre regexp '[m-n]';

-- ^ inicio
-- $ final
-- |  or
-- [abcd] caracteres que contengan caracteres
-- [a-f] rango de caracteres

-- Identificar valores nulos
Select * from vendedores where nombre is null;
Select * from vendedores where nombre is not null;

-- combinando consultas con valores no nulos
Select * from productos
where categoría is null 
	or costo not between '5' and '10';



