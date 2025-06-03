# Esquema de la Base de Datos

Este proyecto utiliza una base de datos relacional que simula la gestión de un videoclub. A continuación, se describen las principales tablas y sus relaciones:

### Tablas principales

- **film**
  - Almacena la información de cada película: título, duración, clasificación, etc.

- **actor**
  - Contiene los actores registrados.

- **film_actor**
  - Relación N:M entre películas y actores.

- **category**
  - Tipos de categorías (comedia, acción, etc.).

- **film_category**
  - Relación N:M entre películas y categorías.

- **language**
  - Idiomas disponibles para las películas.

- **inventory**
  - Copias disponibles de las películas para alquilar.

- **rental**
  - Registros de alquileres realizados.

- **payment**
  - Pagos asociados a cada alquiler.

- **customer**
  - Clientes registrados.

- **staff**
  - Trabajadores del videoclub.

- **store**
  - Tiendas físicas.

### Relaciones clave

- Una película puede tener varios actores y categorías.
- Un cliente puede alquilar múltiples películas.
- Cada alquiler tiene un pago asociado.
- `film_actor`, `film_category` y `rental` gestionan las relaciones mediante claves foráneas.

Este esquema permite hacer análisis complejos con consultas SQL usando `JOIN`, subconsultas, vistas y agregaciones.
