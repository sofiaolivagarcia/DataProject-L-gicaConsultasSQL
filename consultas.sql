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

SELECT CONCAT(a."first_name",' ',a."last_name"),
		f."title"
FROM "actor" AS a
INNER JOIN "film_actor" AS fa
ON a."actor_id" = fa."actor_id"
INNER JOIN "film" AS f
ON f."film_id" = fa."film_id"
WHERE f."title" = 'EGG IGBY';


-- 18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT "title"
FROM "film" AS a;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”

SELECT f."title",
		c."name",
		f."length"
FROM "film" AS f
INNER JOIN "film_category" AS fc
ON f."film_id" = fc."film_id"
INNER JOIN "category" AS c
ON fc."category_id" = c."category_id"
WHERE f."length" > 180 AND c."name" = 'Comedy';

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

SELECT c."name",
		f."length"
FROM "film" AS f
INNER JOIN "film_category" AS fc
ON f."film_id" = fc."film_id"
INNER JOIN "category" AS c
ON fc."category_id" = c."category_id"
WHERE f."length" > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?  NO SE SI ESTÁ BIEN O HE DADO MUCHAS VUELTAS

SELECT AVG(f."length")
FROM "rental" AS r
INNER JOIN "inventory" AS i
ON r."inventory_id" = i."inventory_id"
INNER JOIN "film" AS f
ON f."film_id" = i."film_id";


-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT CONCAT("first_name",' ',"last_name")
FROM "actor"

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT COUNT(DATE("rental_date"))
FROM "rental" AS r
GROUP BY DATE("rental_date")
ORDER BY COUNT(DATE("rental_date")) DESC;

-- 24. Encuentra las películas con una duración superior al promedio.

SELECT AVG("length")
FROM "film" AS f

-- sabemos que la media de duración de las peliculas es de 115 mins. 

SELECT f."title",
		f."length"
FROM "film" AS f
WHERE "length" > (SELECT AVG(f2."length") 
					FROM "film" AS f2)
ORDER BY f."length" ASC 

-- está correctamente calculado, ya que vemos como la película que menos minutos tiene pero más que la media es WORDS HUNTER

-- 25. Averigua el número de alquileres registrados por mes. REVISAR

SELECT 
    EXTRACT(YEAR FROM r."rental_date") AS "año",
    EXTRACT(MONTH FROM r."rental_date") AS "mes",
    COUNT(*) AS "total_alquileres"
FROM rental r
GROUP BY "año", "mes"
ORDER BY "año" ASC, "mes" ASC;



-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT 
		AVG("amount") AS promedio,
		VARIANCE("amount") AS varianza,
		STDDEV("amount") AS desviacion_estandar
FROM "payment" AS p;

-- 27. ¿Qué películas se alquilan por encima del precio medio?

SELECT f."title",
		f."rental_rate"
FROM "film" AS f
WHERE "rental_rate" > (SELECT AVG(f2."rental_rate") 
						FROM "film" AS f2);

SELECT AVG(f."rental_rate")
FROM "film" AS f;

-- como hemos comprobado en la lista de peliculas, los precios de alquiler deben ser mayor que 2,98

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

SELECT "actor_id",
		COUNT("film_id") AS numero_peliculas
FROM "film_actor" AS fa
GROUP BY "actor_id"
HAVING COUNT("film_id") > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT f."title",
		COUNT(i."film_id") AS copias_disponibles
FROM "film" AS f
INNER JOIN "inventory" AS i
ON i."film_id" = f."film_id"
GROUP BY f."film_id"
ORDER BY copias_disponibles DESC;

-- 30. Obtener los actores y el número de películas en las que ha actuado.

SELECT a."actor_id", 
		CONCAT(a."first_name",' ',a."last_name") AS nombre_actores,
		COUNT(fa.film_id) AS numero_peliculas
FROM "actor" AS a
INNER JOIN "film_actor" AS fa
ON fa."actor_id" = a."actor_id"
GROUP BY a."actor_id"
ORDER BY numero_peliculas DESC;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

SELECT f."title",
		CONCAT(a."first_name",' ',a."last_name") AS nombre_actores
FROM "film" AS f
LEFT JOIN "film_actor" AS fa
ON fa."film_id" = f."film_id"
LEFT JOIN "actor" AS a
ON a."actor_id" = fa."actor_id"
ORDER BY f."title",
			nombre_actores;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

SELECT a."actor_id",
		CONCAT(a."first_name",' ',a."last_name") AS nombre_actores,
		f."title" AS pelicula
FROM "film" AS f
RIGHT JOIN "film_actor" AS fa
ON fa."film_id" = f."film_id"
RIGHT JOIN "actor" AS a
ON a."actor_id" = fa."actor_id"
ORDER BY f."title",
			a."actor_id";

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT f."film_id",
		f."title" AS peliculas,
		r."rental_id",
		r."rental_date",
		r."return_date",
		CONCAT(c."first_name",' ',c."last_name")
FROM "film" AS f 
FULL JOIN "inventory" AS i
ON i."film_id" = f."film_id"
FULL JOIN "rental" AS r
ON r."inventory_id" = i."inventory_id"
LEFT JOIN "customer" AS c
ON c."customer_id" = r."customer_id"
ORDER BY f."title",
			r."rental_date";

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT CONCAT(c."first_name",' ',c."last_name") AS nombre_completo,
		SUM(p."amount") AS total_gastado
FROM "customer" AS c
INNER JOIN "rental" AS r
ON r."customer_id" = c."customer_id"
INNER JOIN "payment" AS p
ON p."customer_id" = c."customer_id"
GROUP BY c."customer_id",
			nombre_completo
ORDER BY total_gastado DESC
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es ' Johnny'.

SELECT *
FROM "actor" AS a
WHERE "first_name" = 'JOHNNY'


-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

SELECT "first_name" AS Nombre,
		"last_name" AS Apellido
FROM "actor" AS a

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MIN("actor_id") AS ID_mas_bajo,
		MAX("actor_id") AS ID_mas_alto
FROM "actor" AS a;

-- 38. Cuenta cuántos actores hay en la tabla “actor”

SELECT COUNT("actor_id")
FROM "actor" AS a;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT *
FROM "actor" AS a
ORDER BY "last_name" ASC

-- 40. Selecciona las primeras 5 películas de la tabla “film”

SELECT "title"
FROM "film" AS f
ORDER BY "title"
LIMIT 5;


-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

SELECT "first_name",
		COUNT("first_name") AS numero
FROM "actor" AS a
GROUP BY "first_name"
ORDER BY numero DESC
LIMIT 5;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT *
FROM
























