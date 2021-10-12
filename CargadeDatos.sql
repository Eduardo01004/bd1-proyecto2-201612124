use Proyecto2;
/*---------------CARGA DE DATOS A LA TABLA TEMPORAL-----------------------------------*/
LOAD DATA 
INFILE 'carga/Datos.csv' 
INTO TABLE Temporal
CHARACTER SET UTF8
FIELDS TERMINATED BY ';' 
ignore 1 lines
(
	NOMBRE_ELECCION,
    ANIO_ELECCION,
    PAIS,
    REGION,
    DEPTO,
    MUNICIPIO,
    PARTIDO,
    NOMBRE_PARTIDO,
    SEXO,
    RAZA,
    ANALFABETOS,
    ALFABETOS,
    SEXO2,
    RAZA2,
    PRIMARIA,
    NIVEL_MEDIO,
    UNIVERSITARIOS
);
select *from temporal;
/*------------------------CARGA DE DATOS DEL MODELO RELACIONAL -----------------------*/

insert into Pais(nombre)
select distinct temporal.pais from Temporal;
select *from pais;

insert into Region(nombre,id_pais)
select distinct temporal.region, pais.id_pais from Temporal,Pais
where Temporal.pais = Pais.nombre;
select *from Region;

insert into Departamento(nombre,id_region)
select distinct temporal.depto, region.id_region from Temporal,region,pais
where Temporal.region = region.nombre
and Temporal.pais = Pais.nombre;
select *from Departamento;

insert into Municipio(nombre,id_departamento)
select distinct temporal.municipio,departamento.id_departamento from Temporal,region,pais,departamento
where Temporal.depto = departamento.nombre
and temporal.region = region.nombre
and departamento.id_region = region.id_region
and Temporal.pais = Pais.nombre
and region.id_pais = pais.id_pais;
delete from municipio;
select count(*) from Municipio;
select *from Municipio;

insert into Partido(partido,nombre)
select distinct temporal.partido,temporal.nombre_partido from temporal;
select *from Partido;

insert into raza(tipo)
select distinct temporal.raza from temporal;
select *from raza;
delete from raza;
SET SQL_SAFE_UPDATES = 0;

insert into Eleccion(tipo,anio)
select distinct temporal.nombre_eleccion, temporal.anio_eleccion from temporal;
select *from Eleccion;
delete from eleccion;

insert into Genero(tipo)
select distinct temporal.sexo from temporal;
select *from genero;

insert into Detalle_Eleccion(alfabetas,analfabetas,primaria,medio,universitario,id_municipio,id_eleccion,id_partido,id_genero,id_raza)
select  temporal.alfabetos,temporal.analfabetos,temporal.primaria,temporal.nivel_medio,temporal.universitarios,municipio.id_municipio,
				eleccion.id_eleccion,partido.id_partido,genero.id_genero,raza.id_raza
from temporal,municipio,departamento,region,pais,eleccion,partido,genero,raza
where temporal.municipio = municipio.nombre
and temporal.pais = pais.nombre
and temporal.region = region.nombre
and temporal.depto = departamento.nombre
and temporal.nombre_eleccion = eleccion.tipo
and temporal.anio_eleccion = eleccion.anio
and temporal.partido = partido.partido 
and temporal.nombre_partido = partido.nombre
and temporal.sexo = genero.tipo
and temporal.raza = raza.tipo
and municipio.id_departamento = departamento.id_departamento
and departamento.id_region = region.id_region
and region.id_pais = pais.id_pais;

select count(*) from detalle_eleccion;
delete from detalle_eleccion;

select *from detalle_eleccion;

