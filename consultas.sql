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

SELECT  r."rental_id",
    r."rental_date",
    CONCAT(c."first_name", ' ', c."last_name") AS "cliente"
FROM "rental" AS r
INNER JOIN "customer" AS c 
ON r."customer_id" = c."customer_id"
ORDER BY r."rental_date" DESC;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT  r."rental_id",
    r."rental_date",
    CONCAT(c."first_name", ' ', c."last_name") AS "cliente"
FROM "rental" AS r
RIGHT JOIN "customer" AS c 
ON r."customer_id" = c."customer_id"
ORDER BY r."rental_date" DESC;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

SELECT  r."rental_id",
   		 r."rental_date",
   		 CONCAT(c."first_name", ' ', c."last_name") AS "cliente"
FROM "rental" AS r
CROSS JOIN "customer" AS c;

-- No aporta valor, ya que el CROSS JOIN genera un producto cartesiano. No da información real, ya que mezcla uno con otro sin ningun sentido lógico.


-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.

-- usamos select distinct para que no hay anombres repetidos

SELECT DISTINCT CONCAT(a."first_name", ' ', a."last_name") AS actores,
		c."name"
FROM "category" AS c
INNER JOIN "film_category" AS fc
ON fc."category_id"=c."category_id"
INNER JOIN "film" AS f
ON f."film_id"=fc."film_id"
INNER JOIN "film_actor" AS fa
ON f."film_id"=fa."film_id"
INNER JOIN "actor" AS a
ON a."actor_id"=fa."actor_id"
WHERE "name" = 'Action'
ORDER BY actores;

-- 46. Encuentra todos los actores que no han participado en películas.

SELECT CONCAT(a."first_name", ' ', a."last_name") AS actores,
		f."title"
FROM "actor" AS a
FULL OUTER JOIN "film_actor" AS fa
ON fa."actor_id" = a."actor_id"
LEFT JOIN "film" AS f
ON fa."film_id" = f."film_id"
WHERE f."title" IS NULL;

-- No hay actores que no hayan participado en ninguna película

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT CONCAT(a."first_name", ' ', a."last_name") AS actores,
 		COUNT (f."film_id")
FROM "actor" AS a
INNER JOIN "film_actor" AS fa
ON fa."actor_id" = a."actor_id"
LEFT JOIN "film" AS f
ON fa."film_id" = f."film_id"
GROUP BY actores
ORDER BY actores;


-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.


CREATE VIEW "actor_num_peliculas" AS
SELECT CONCAT(a."first_name", ' ', a."last_name") AS actores,
 		COUNT (f."film_id")
FROM "actor" AS a
	INNER JOIN "film_actor" AS fa
		ON fa."actor_id" = a."actor_id"
	LEFT JOIN "film" AS f
		ON fa."film_id" = f."film_id"
	GROUP BY actores
	ORDER BY actores;

SELECT * 
FROM actor_num_peliculas;

-- 49. Calcula el número total de alquileres realizados por cada cliente.

SELECT CONCAT(c."first_name", ' ', c."last_name") AS clientes,
		COUNT (r."rental_id") AS alquileres_realizados
FROM "customer" AS c
INNER JOIN "rental" AS r
ON c."customer_id" = r."customer_id"
GROUP BY clientes;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT SUM(f."length")
FROM "category" AS c
	INNER JOIN "film_category" AS fc
		ON fc."category_id" = c."category_id"
	INNER JOIN "film" AS f
		ON f."film_id" = fc."film_id"
	WHERE c."name" = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

CREATE TEMP TABLE cliente__rentas__temporal AS
SELECT 'customer_id' AS clientes,
		COUNT(rental_id) AS total_alquileres
FROM "rental" AS r
GROUP BY "customer_id";

- veo la tabla creada

SELECT * FROM cliente__rentas__temporal;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

CREATE TEMP TABLE peliculas_____alquiladas AS
SELECT f."title",
		f."film_id",
		COUNT(r."rental_id") AS numero_alquileres
FROM "film" AS f
INNER JOIN "inventory" AS i
ON f."film_id" = i."film_id"
INNER JOIN "rental" AS r
ON i."inventory_id" = r."inventory_id"
GROUP BY f.film_id, 
		f.title
HAVING COUNT(r.rental_id) >= 10;

SELECT *
FROM peliculas_____alquiladas;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre 
-- ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película

SELECT DISTINCT  f."title"
FROM "customer" AS c
INNER JOIN "rental" AS r
ON c."customer_id" = r."customer_id"
INNER JOIN "inventory" AS i
ON i."inventory_id" = r."inventory_id"
INNER JOIN "film" AS f
ON i."film_id" = f."film_id"
WHERE c."first_name" = 'Tammy'
	AND c."last_name" = 'Sanders'
	AND r."return_date" IS NULL
ORDER BY f."title" ASC;


-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
	-- alfabéticamente por apellido.

SELECT DISTINCT a."first_name" AS nombre,
		a."last_name" AS apellido,
		c."name" AS categoria
FROM "actor" AS a
INNER JOIN "film_actor" AS fa
ON a."actor_id" = fa."actor_id"
INNER JOIN "film_category" AS fc
ON fc."film_id" = fa."film_id"
INNER JOIN "category" AS c
ON c."category_id" = fc."category_id"
WHERE c."name" = 'Sci-Fi'
ORDER BY a."last_name";

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
	--Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

SELECT MIN(r."rental_date") AS primera_fecha
FROM "film" AS f
JOIN "inventory" AS i 
ON f."film_id" = i."film_id"
JOIN "rental" AS r 
ON i."inventory_id" = r."inventory_id"
WHERE f."title" = 'Spartacus Cheaper';

		--No hay ninguna película que se llame con ese título (nos da NULL). Igualmente a continuación se muestra como sería la consulta
MIRAR REVISAR 

SELECT DISTINCT a."first_name" AS nombre, 
				a."last_name" AS apellido
FROM "actor" AS a
INNER JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id"
INNER JOIN "film" AS f 
ON fa."film_id" = f."film_id"
INNER JOIN "inventory" AS i 
ON f."film_id" = i."film_id"
INNER JOIN "rental" AS r 
ON i."inventory_id" = r."inventory_id"
WHERE r.rental_date > 'FECHA QUE NOS DE LA CONSULTA ANTERIOR'
ORDER BY a.last_name, a.first_name;


-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.



MAL MAL 

SELECT DISTINCT
		fa."first_name" AS nombre,
		fa."last_name" AS apellido
FROM "category" AS c
INNER JOIN "film_catgeory" AS fc
ON c."category_id" = fc."category_id"
INNER JOIN "film_actor" AS fa
ON fc."film_id" = fa."film_id"
INNER JOIN "actor" AS a
ON a."actor_id" = fa."actor_id"



SELECT a."first_name", 
		a."last_name"
FROM "actor" AS a
WHERE a.actor_id NOT IN (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc ON fa.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Music'
)
ORDER BY a.last_name, a.first_name;







-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

SELECT f."title" AS titulo
FROM "rental" AS r
INNER JOIN "inventory" AS i
ON r."inventory_id" = i."inventory_id"
INNER JOIN "film" AS f
ON i."film_id" = f."film_id"
WHERE r."return_date" IS NOT NULL 
		AND DATE_PART('day', r."return_date" - r."rental_date") > 8;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’

SELECT f."title" AS nombre_pelicula,
		c."name" AS categoria
FROM "film" AS f
INNER JOIN "film_category" AS fc
ON f."film_id" = fc."film_id"
INNER JOIN "category" AS c
ON fc."category_id" = c."category_id"
WHERE c."name" = 'Animation';

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. 
		--Ordena los resultados alfabéticamente por título de película.

SELECT "title"
FROM "film"
WHERE "length" = (
		SELECT "length"
		FROM "film"
		WHERE "title" = 'Dancing Fever'
		)
ORDER BY "title" ASC;


-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
		-- Ordena los resultados alfabéticamente por apellido.

SELECT c."first_name",
		c."last_name"
FROM "customer" AS c
INNER JOIN "rental" AS r
ON r."customer_id" = c."customer_id"



--NO LO ENTIENDO

INNER JOIN "inventory" AS i
ON r."inventory_id" = i."inventory_id"
INNER JOIN "film" AS f
ON i."film_id" = f."film_id"

SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name, c.first_name;



--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la 
		--categoría junto con el recuento de alquileres.


SELECT c."name" AS categoria, 
		COUNT(r."rental_id") AS total_alquileres
FROM "rental" AS r
INNER JOIN "inventory" AS i 
ON r."inventory_id" = i."inventory_id"
INNER JOIN "film" AS f 
ON i."film_id" = f."film_id"
INNER JOIN "film_category" AS fc 
ON f."film_id" = fc."film_id"
INNER JOIN "category" AS c 
ON fc."category_id" = c."category_id"
GROUP BY c."name"
ORDER BY "total_alquileres" DESC;


--62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT c."name" AS categoria,
		COUNT (f."film_id") AS peliculas_totales
FROM "film" AS f
INNER JOIN "film_category" AS fc
ON f."film_id" = fc."film_id"
INNER JOIN "category" AS c
ON fc."category_id" = c."category_id"
WHERE f."release_year" = '2006'
GROUP BY c."name"
ORDER BY peliculas_totales;



--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

		--USANDO CROSS JOIN PODEMOS GENERAR TODAS LAS COMBINACIONES POSIBLES


SELECT s."first_name" AS nombre_empleado,
		s."last_name" AS apellido_empleado,
      	 t."store_id"
FROM "staff" AS s
CROSS JOIN "store" AS t
ORDER BY nombre_empleado;



--64.Encuentra la cantidad total de películas alquiladas por cada cliente y
	--muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas


SELECT c."customer_id",
       c."first_name",
       c."last_name",
       COUNT(r."rental_id") AS total_alquileres
FROM "customer" AS c
INNER JOIN "rental" AS r 
ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY total_alquileres DESC;
















