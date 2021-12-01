create database Proyecto2;
use Proyecto2;
drop table Temporal;

create Table Temporal(
	NOMBRE_ELECCION VARCHAR(50),
    ANIO_ELECCION VARCHAR(50),
    PAIS VARCHAR(50),
    REGION VARCHAR(50),
    DEPTO VARCHAR(50),
    MUNICIPIO VARCHAR(50),
    PARTIDO VARCHAR(50),
    NOMBRE_PARTIDO VARCHAR(50),
    SEXO VARCHAR(50),
    RAZA VARCHAR(50),
    ANALFABETOS integer,
    ALFABETOS integer,
    SEXO2 VARCHAR(50),
    RAZA2 VARCHAR(50),
    PRIMARIA integer,
    NIVEL_MEDIO integer,
    UNIVERSITARIOS integer
);
select *from Temporal;
/*--------------Creacion del modelo entidad Relacion--------------*/
create table Pais(
	id_pais integer not null auto_increment,
    nombre varchar(100) not null,
    primary key(id_pais)
);
select *from Pais;

create table Region(
	id_region integer not null auto_increment,
	nombre varchar(100) not null,
	id_pais integer not null,
    primary key(id_region),
	foreign key (id_pais) references Pais(id_pais)
);
select *from Region;

create table Departamento(
	id_departamento integer not null auto_increment,
    nombre varchar(100) not null,
    id_region integer not null,
    primary key(id_departamento),
	foreign key (id_region) references Region(id_region)
);
select *from Departamento;

create table Municipio(
	id_municipio integer not null auto_increment,
    nombre varchar(100) not null,
    id_departamento integer not null,
    primary key(id_municipio),
	foreign key (id_departamento) references Departamento(id_departamento)
);
select *from Municipio;

create table Eleccion(
	id_eleccion integer not null auto_increment,
    tipo varchar(100) not null,
    anio integer not null,
    primary key(id_eleccion)
);
select *from Eleccion;

create table Partido(
	id_partido integer not null auto_increment,
    partido varchar(100) not null,
    nombre varchar(100) not null,
    primary key(id_partido)
);
select *from Partido;

create table Genero(
	id_genero integer not null auto_increment,
    tipo varchar(100) not null,
    primary key(id_genero)
);
select *from Genero;

create table Raza(
	id_raza integer not null auto_increment,
    tipo varchar(100) not null,
    primary key(id_raza)
);
select *from Raza;

Create Table Detalle_Eleccion(
	id_detalle integer not null auto_increment,
    alfabetas integer,
    analfabetas integer,
    primaria integer,
    medio integer,
    universitario integer,
    id_municipio integer not null,
    id_eleccion integer not null,
    id_partido integer not null,
    id_genero integer not null,
    id_raza integer not null,
    primary key(id_detalle),
	foreign key (id_municipio) references Municipio(id_municipio),
    foreign key (id_eleccion) references Eleccion(id_eleccion),
    foreign key (id_partido) references Partido(id_Partido),
    foreign key (id_genero) references Genero(id_genero),
    foreign key (id_raza) references Raza(id_raza)
);
select *from Detalle_Eleccion;

drop table detalle_eleccion;





