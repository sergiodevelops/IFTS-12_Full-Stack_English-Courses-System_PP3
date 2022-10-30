# Gestión de cursos de Ingles
- [Sintaxis elegante para esta documentación](https://docs.github.com/es/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)
- [Repositorio en GITHUB](https://github.com/sergioarieljuarez/ei-pp3-2022)

## Proyecto para materia PRACTICA PROFESIONAL 3 IFTS 12
Integrantes:
    Danlois Tovar
    Sergio Ariel Juarez
    Nahuel Tarello
    Juan Pablo Alvarez Piñero
    Sebastian Vargas
    Uriel Carvallo

## Ambiente de DESARROLLO

#### Puertos de conexión utilizados para "localhost" (127.0.0.1)
**OS PORT**:DOCKER PORT
1. **9906**:3306 <-- MySQL db server - "DATABASE"
2. **8000**:8080 <-- MySQL db client - "ADMINER"
3. **4005**:4005 <-- API Express JS - "API"
4. **3005**:3005 <-- UI React JS - "UI"


#### Importar modelos de la DB ya creada al codigo fuente en desarrollo

1. Cómo conectar a server db para importar los modelos (de base ya existente):
```
./node_modules/sequelize-auto/bin/sequelize-auto \
-h <host> \
-d <database> \
-u <user> \
-x [password] \
-p [port]  \
--dialect [dialect] \
-c [/path/to/config] \
-o [/path/to/models] \
-t [tableName1] \
-t [tableName2] \
-t [tableName3]
```

### Requerimientos o dependencias de software para esta aplicación
1. DOCKER: Docker version 20.10.7, build f0df350
2. **NODE JS v14** (entorno de desarrollo para el desarrollo del producto)
3. **YARN**: gestor de paquetes dentro de nuestro proyecto web (añade o quita librería, ejecuta scripts para correr el proyecto)
