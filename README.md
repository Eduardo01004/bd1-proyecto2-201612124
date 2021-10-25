# Proyecto 2 Bases de Datos 1

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

### Informacion
| Nombre | Carné |
| ------ | ------ |
| Eduardo Saul Tun Aguilar | 201612124|
| Curso | Seccion |
| ------ | ------ |
| Base de Datos 1 | B|

## Solicitud
El Instituto Centroamericano Electoral (ICE) contrata sus servicios profesionales para realizar reingeniería al proceso de almacenamiento debido a que actualmente hay demasiada inconsistencia que puede provocarles serios problemas legales. El Instituto realiza el esfuerzo de exportar toda la información actual a un archivo Excel que usted tendrá a disposición para realizar el análisis correspondiente, deberá aplicar las formas de normalización que considere adecuada con el objetivo de eliminar la redundancia y crear una nueva plataforma escalable. 

## Documentacion 
El ICE solicita que realice un documento de análisis que le permita determinar el alcance de la nueva plataforma. El documento deberá tener como mínimo una descripción de las reglas de normalización aplicadas al archivo de Excel fuente, modelo entidad relación explicativo que permita visualizar de mejor manera la nueva estructura y de cómo se almacenará la información

## Modelo logico
  ![imagen0](Logico.png)

## Modelo Relacional
  ![imagen0](Relational_1.png)

## Requisitos para Normalizar 
  - No pueden haber dos filas iguales
  - No se permiten duplicados
  - Todos los datos de una columna tienen que ser del mismo tipo 
  - Cada tabla debe de tener su nombre unico
 
# Primera Regla de Normalizacion (1FN)
  - Todos los atributos, valores almacenados en las columnas deben de ser indivisibles
  - No deben exisitir grupos de valores repetidos
  
  En el caso del CSV los datos son indivisibles ya que no se pueden separar o dividir los datos y en este Caso las Columnas RAZA y SEXO se repetian por lo tanto se eliminan
  Por lo tanto el archivo de carga esta en la primera forma normalizada.
  
 # Segunda Regla de Normalizacion (2FN)
  - En esta regla se verifica que no existan dependencias funcionales parciales. Esto quiere decir que todos los valores de las columnas de una fila deben depender de la clave 
    primaria que le corresponde.
