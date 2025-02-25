# DataProject-LogicaConsultasSQL
## Descripción
Este proyecto contiene una serie de consultas SQL realizadas sobre una base de datos en PostgreSQL. Se han aplicado diferentes tipos de consultas, incluyendo selecciones simples, uniones entre tablas, subconsultas, vistas y estructuras de datos temporales.

## Requisitos
Para ejecutar este proyecto necesitas las siguientes herramientas:
- PostgreSQL
- DBeaver

## Estructura del Repositorio

Este repositorio contiene los siguientes archivos:

- README.md: Este archivo con la descripción del proyecto.

- BBDD_ProyectoSQL.sql: Archivo SQL que contiene la estructura y datos de la base de datos.

- consultas.sql: Archivo con todas las consultas realizadas.

- esquema.md: Esquema de la base de datos utilizada en el proyecto.

## Instalación y Configuración

1. Configurar PostgreSQL

  Descarga e instala PostgreSQL.
  Asegúrate de que el servicio de PostgreSQL esté corriendo.
  Crea una nueva base de datos con el siguiente comando:
  CREATE DATABASE ProyectoSQL;
  Conéctate a la base de datos:
  \c ProyectoSQL;

2. Importar la Base de Datos en DBeaver

  Abre DBeaver y conéctate a PostgreSQL.
  Abre la consola SQL y carga el archivo BBDD_Proyecto.sql.
  Ejecuta el script para crear todas las tablas y datos.

3. Ejecutar las Consultas

  Abre consultas.sql en la consola de DBeaver.
  Ejecuta cada consulta para ver los resultados.
  Contenido del Proyecto
  El proyecto incluye consultas SQL para:
  Seleccionar datos específicos de una tabla.
  Filtrar datos según condiciones establecidas.
  Realizar uniones entre tablas.
  Utilizar subconsultas para obtener información relacionada.
  Crear vistas para optimizar consultas frecuentes.
  Utilizar estructuras temporales para almacenar información.

## Buenas Prácticas Aplicadas

- Uso de alias en las tablas y columnas para mayor legibilidad.
- Comentarios en las consultas para facilitar su comprensión.
- Estandarización de nombres de columnas y tablas.
- Optimización de consultas para mejorar el rendimiento.

## Autores

Sofía Oliva García
Este repositorio será actualizado según se realicen mejoras en las consultas y la estructura de la base de datos.



