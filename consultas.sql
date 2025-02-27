-- Archivo para consultas SQL
-- 2.Muestra los nombres de todas las películas con una clasificación por edades de 'R'

-- lo primero que voy a hacer es mostrar toda la tabla de film que es con la que voy a trabajar y ver los tipos de datos.
SELECT *
FROM "film" AS f
LIMIT 10;


SELECT "title"
FROM "film" AS f 
WHERE rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un "actor_id" entre 30 y 40.

SELECT CONCAT("first_name", ' ' , "last_name") AS "actores",
		a."actor_id"
FROM "actor" AS a
WHERE "actor_id" >= 30 AND "actor_id" <= 40;

--otra forma 

SELECT CONCAT("first_name", ' ' , "last_name") AS "actores",
		a."actor_id"
FROM "actor" AS a
WHERE "actor_id" BETWEEN 30 AND 40;


-- 4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT "title","original_language_id","language_id"
FROM "film" AS f
WHERE "original_language_id"  = "language_id";

-- no me aparece ningun resultado en la tabla, para ello vamos a confirmar en la tabla completa si es verdad que no hay.

SELECT "title","original_language_id","language_id"
FROM "film" AS f;

--podemos ver como no hay registrados los idiomas de las columnas originales, es por ello que al no haber datos nos sale la tabla vacía.

-- 5. Ordena las películas por duración de forma ascendente.

SELECT "title",
		"length"
FROM "film" AS f
ORDER BY "length" ASC;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

SELECT *
FROM "actor" AS a
WHERE "last_name" = 'ALLEN';


-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

SELECT COUNT("film_id"),"rating"
FROM "film" AS f
GROUP BY "rating";

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.

SELECT "title",
		"rating",
		"length"
FROM "film" AS f
WHERE "rating" = 'PG-13' 
OR "length" > 180;


-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT "title","replacement_cost"
FROM "film" AS f;

-- para calcular la variabilidad se pueden usar medidas estadísticas como la varianza (VARIANCE) o la desviación estándar (STDDEV)

SELECT 
		AVG("replacement_cost") AS media,
		VARIANCE("replacement_cost") AS varianza,
		STDDEV("replacement_cost") AS desviacion_estandar
FROM "film" AS f;

-- mostrar títulos
SELECT 
		"title",
		AVG("replacement_cost") AS media,
		VARIANCE("replacement_cost") AS varianza,
		STDDEV("replacement_cost") AS desviacion_estandar
FROM "film" AS f
GROUP BY "title";

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT 
		MAX("length") AS mayor_duracion,
		MIN("length") AS menor_duracion
FROM "film" AS f;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT p."amount",
		r."rental_date"
FROM "rental" AS r
INNER JOIN "payment" AS p
ON r."rental_id" = p."rental_id"
ORDER BY r."rental_date" DESC
LIMIT 1 
OFFSET 2;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.

SELECT "title",
		"rating"
FROM "film" AS f
WHERE "rating" NOT IN ('NC-17','G');

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT "rating",
		AVG("length") AS media_duracion
FROM "film" AS f
GROUP BY "rating";

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT "title",
		"length"
FROM "film" AS f
WHERE "length" > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM("amount") AS dinero_total
FROM "payment" AS p;

-- 16. Muestra los 10 clientes con mayor valor de id.

SELECT CONCAT("first_name",' ',"last_name") AS nombre_cliente,
		"customer_id"
FROM "customer" AS c
ORDER BY "customer_id"
LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

SELECT CONCAT(a."first_name",' ',a."last_name") AS nombre_cliente,
FROM "actor" AS a
INNER JOIN "film" AS f
ON a."last_update" = f."last_update"




SELECT CONCAT("a."first_name",' ',a."last_name") AS nombre_actor,
FROM "actor" AS a;
INNER JOIN "film_actor" AS fa
ON a."actor_id" = fa."actor_id"
INNER JOIN "film_actor
ON f."last_update" = a."last_update"
WHERE CONCAT("a."first_name",' ',a."last_name") = 'EGG IGBY'


SELECT a."first_name", a."last_name"
FROM "actor" AS a
INNER JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
INNER JOIN "film" AS f ON fa."film_id" = f."film_id"
WHERE f."title" = 'EGG IGBY';












