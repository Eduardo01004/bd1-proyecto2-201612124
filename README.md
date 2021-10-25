# Proyecto 2 Bases de Datos 1

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

### Informacion
| Nombre | Carné |
| ------ | ------ |
| Eduardo Saul Tun Aguilar | 201612124|
| Curso | Seccion |
| Base de Datos 1 | B|

# Solicitud
El Instituto Centroamericano Electoral (ICE) contrata sus servicios profesionales para realizar reingeniería al proceso de almacenamiento debido a que actualmente hay demasiada inconsistencia que puede provocarles serios problemas legales. El Instituto realiza el esfuerzo de exportar toda la información actual a un archivo Excel que usted tendrá a disposición para realizar el análisis correspondiente, deberá aplicar las formas de normalización que considere adecuada con el objetivo de eliminar la redundancia y crear una nueva plataforma escalable. 

# Documentacion 
El ICE solicita que realice un documento de análisis que le permita determinar el alcance de la nueva plataforma. El documento deberá tener como mínimo una descripción de las reglas de normalización aplicadas al archivo de Excel fuente, modelo entidad relación explicativo que permita visualizar de mejor manera la nueva estructura y de cómo se almacenará la información

## Modelo logico
  ![imagen0](Logico.png)

## Modelo Relacional
  ![imagen0](Relational_1.png)

## Listado de Entidades

![imagen0](imagenes/img4.png)

# Listado de Atributos

## Pais
| Nombre    | Tipo      | key       |
| ------    | ------    | ------    |
|id_pais| integer|PK
|nombre|varchar|

## Region
| Nombre    | Tipo      | key       |
| ------    | ------    | ------    |
|id_region| integer|PK
|nombre|varchar|
|id_pais|integer|FK|

## Departamento
| Nombre    | Tipo      | key       |
| ------    | ------    | ------    |
|id_departamento| integer|PK
|nombre|varchar|
|id_region|integer|FK|

## Municipio
| Nombre    | Tipo      | key       |
| ------    | ------    | ------    |
|id_municipio| integer|PK
|nombre|varchar|
|id_departamento|integer|FK|

## Eleccion
| Nombre    | Tipo      | key       |
| ------    | ------    | ------    |
|id_eleccion| integer|PK
|nombre|varchar|
|anio|integer||

## Partido
| Nombre    | Tipo      | key       |
| ------    | ------    | ------    |
|id_partido| integer|PK
|partido|varchar|
|nombre|varchar|

## Raza
| Nombre    | Tipo      | key       |
| ------    | ------    | ------    |
|id_raza| integer|PK
|tipo|varchar|

## Genero
| Nombre    | Tipo      | key       |
| ------    | ------    | ------    |
|id_genero| integer|PK
|tipo|varchar|

## Detalle_Eleccion
| Nombre    | Tipo      | key       |
| ------    | ------    | ------    |
|id_detalle_eleccion| integer|PK
|alfabetos|integer|
|Analfabetas|integer|
|primario|integer|
|Medio|integer|
|Universitario|integer|
|Id_municipio|integer|Fk
|id_partido|integer|FK
|id_eleccion|integer|FK
|id_raza|integer|FK
|id_genero|integer|FK


# Descripcion de Relaciones
| Tabla 1    | Tabla2     | Relacion       |
| ------    | ------    | ------    |
|Pais|Region|Un pais tiene muchas regiones y una region pertenece a un pais.
|Region|Departamento| Una region tiene muchos departamentos y un departamento pertenece solo a una region.
|Departamento|Municipio|Un departamento tiene muchos municipios y un municipio pertenece solo a un departamento.
|Municipio |Detalle_eleccion| un municipio puede tener muchos votos, pero un voto solo pertenecera a una persona.
|Partido|Detalle_eleccion|Un partido tendra muchos votos, pero una persona solo votara por un partido.
|Raza|Detalle_eleccion|una raza puede tener muchos votos, pero una persona de esa raza solo emitira un voto.
|genero|Detalle_Eleccion|Un Genero tiene muchos votos,pero una persona de un solo genero emitira solo un voto.

# Restricciones
  - Los votantes solo pueden hacerlo una vez.
  - Los votantes solo pueden pertenecer a una raza.
  - Las cantidades de votos solo pueden tener como tipo de dato integer.
  - los votos solo pueden ser de educacion primaria,media y universitaria.




# Requisitos para Normalizar 
  - No pueden haber dos filas iguales
  - No se permiten duplicados
  - Todos los datos de una columna tienen que ser del mismo tipo 
  - Cada tabla debe de tener su nombre unico
 
# Primera Regla de Normalizacion (1FN)
  - Todos los atributos, valores almacenados en las columnas deben de ser indivisibles
  - No deben exisitir grupos de valores repetidos
  
  En el caso del CSV los datos son indivisibles ya que no se pueden separar o dividir los datos y en este Caso las Columnas RAZA y SEXO se repetian por lo tanto se eliminan
  Por lo tanto el archivo de carga esta en la primera forma normalizada quedaria de la forma siguiente.

  <img src="imagenes/img1.png" width=800px> 

 # Segunda Regla de Normalizacion (2FN)
  - En esta regla se verifica que no existan dependencias funcionales parciales. Esto quiere decir que todos los valores de las columnas de una fila deben depender de la clave 
    primaria que le corresponde.

  En este proyecto se aplico la segunda regla a las tablas que no dependen de una tabla unica Como se muestra A continuacion.

  <img src="imagenes/img2.png" width=800px> 

 # Tercera Regla de Normalizacion (2FN)
  - En la Tercera forma normal se indica que no deben existir dependencias transitivas entre las columnas de una tabla. esto significa que las comlumnas que no forman parte de la clave primaria deben de depender solo de la clave,nunca de otra columna no clave.

  En este Caso la Tabla Detalle_Eleccion tiene dos atributos que son Sexo y Raza que no depende de la clave primaria de esta
  Entonces se procede a separara estos dos atributos y se agregan dos tablas nuevas que son las siguientes

  <img src="imagenes/img2.png" width=800px> 



  
