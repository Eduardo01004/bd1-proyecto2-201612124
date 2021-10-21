use Proyecto2;

/*--------------consulta 1-----------*/
select C1.Eleccion, C1.anio,C1.pais,C4.partido,round(C1.total/C3.total*100,2) as porcentaje 
from( select C2.nombre as Eleccion,C2.anio as anio,C2.pais as pais,max(C2.suma) as total from(
	select eleccion.tipo as nombre,eleccion.anio as anio,pais.nombre as pais,partido.nombre as partido,sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as suma
    from detalle_eleccion
    inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
    inner join partido on detalle_eleccion.id_partido = partido.id_partido
	inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
	inner join departamento on municipio.id_departamento = departamento.id_departamento
	inner join region on departamento.id_region = region.id_region
	inner join pais on region.id_pais = pais.id_pais
    group by eleccion.tipo,eleccion.anio,pais.nombre,partido.nombre
    order by pais.nombre)C2 group by C2.nombre,C2.anio,C2.pais) as C1
    inner join
(select eleccion.tipo as nombre, eleccion.anio as anio, pais.nombre as pais,sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total
from detalle_eleccion
    inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
	inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
	inner join departamento on municipio.id_departamento = departamento.id_departamento
	inner join region on departamento.id_region = region.id_region
	inner join pais on region.id_pais = pais.id_pais
    group by eleccion.tipo,eleccion.anio,pais.nombre
    order by pais.nombre) as C3
inner join 
(select eleccion.tipo as nombre,eleccion.anio as anio,pais.nombre as pais,partido.nombre as partido,sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as suma
    from detalle_eleccion
    inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
    inner join partido on detalle_eleccion.id_partido = partido.id_partido
	inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
	inner join departamento on municipio.id_departamento = departamento.id_departamento
	inner join region on departamento.id_region = region.id_region
	inner join pais on region.id_pais = pais.id_pais
    group by eleccion.tipo,eleccion.anio,pais.nombre,partido.nombre
    order by pais.nombre) as C4
on  C3.nombre = C1.eleccion
and C1.anio = C3.anio
and C1.pais = C3.pais
and C1.eleccion = C4.nombre
and C1.anio = C4.anio
and C1.pais = C4.pais
and C1.total = C4.suma;


select C2.nombre as Eleccion,C2.anio as anio,C2.pais as pais,max(C2.suma) as total from(
	select eleccion.tipo as nombre,eleccion.anio as anio,pais.nombre as pais,partido.nombre as partido,sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as suma
    from detalle_eleccion
    inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
    inner join partido on detalle_eleccion.id_partido = partido.id_partido
	inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
	inner join departamento on municipio.id_departamento = departamento.id_departamento
	inner join region on departamento.id_region = region.id_region
	inner join pais on region.id_pais = pais.id_pais
    group by eleccion.tipo,eleccion.anio,pais.nombre,partido.nombre
    order by pais.nombre)C2 group by C2.nombre,C2.anio,C2.pais;/*-----------------maximo de votos-------*/
    
    select eleccion.tipo as nombre,eleccion.anio as anio,pais.nombre as pais,partido.nombre as partido,sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as suma
    from detalle_eleccion
    inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
    inner join departamento on municipio.id_departamento = departamento.id_departamento
    inner join region on departamento.id_region = region.id_region
	inner join pais on region.id_pais = pais.id_pais
    inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
    inner join partido on detalle_eleccion.id_partido = partido.id_partido
    group by eleccion.tipo,eleccion.anio,pais.nombre,partido.nombre; /*------total de votos por partido--------*/


/*-------------consulta 2--------------*/
select (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) from detalle_eleccion) as Total_votos,C2.total,C2.depa,C2.pais,round(C2.total/C1.total*100,2) as porcentaje
from (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total, pais.nombre as pais from detalle_eleccion
						inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
						inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
						inner join departamento on municipio.id_departamento = departamento.id_departamento
						inner join region on departamento.id_region = region.id_region
						inner join pais on region.id_pais = pais.id_pais
						inner join genero on detalle_eleccion.id_genero = genero.id_genero
						where upper(genero.tipo ) = 'MUJERES'
                        group by pais.nombre)as C1
inner join 
		(select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total, pais.nombre as pais,departamento.nombre as depa from detalle_eleccion
						inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
						inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
						inner join departamento on municipio.id_departamento = departamento.id_departamento
						inner join region on departamento.id_region = region.id_region
						inner join pais on region.id_pais = pais.id_pais
						inner join genero on detalle_eleccion.id_genero = genero.id_genero
						where upper(genero.tipo) = 'MUJERES'
                        group by pais.nombre,departamento.nombre) as C2
                        on C1.pais = C2.pais;
                        
/*----------------Consulta 3------------------*/


/*----------------Consulta 4 -----------------*/
select C2.pais, C2.region, C2.raza,round(C2.total_votos/2,0)
	from (select pais.nombre as pais,region.nombre as region,raza.tipo as raza,
    sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total_votos
		from detalle_eleccion
		inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
		inner join departamento on municipio.id_departamento = departamento.id_departamento
		inner join region on departamento.id_region = region.id_region
		inner join pais  on region.id_pais = pais.id_pais
		inner join raza on detalle_eleccion.id_raza = raza.id_raza
        group by pais.nombre,region.nombre,raza.tipo) as C2
        inner join 
		(select MAX(C1.total) as votos,C1.p1 as p1,C1.r1 as r1,C1.total as total_votos,C1.raza
			from (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total,pais.nombre as p1,region.nombre as r1,raza.tipo as raza
							from detalle_eleccion
							inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
							inner join departamento on municipio.id_departamento = departamento.id_departamento
							inner join region on departamento.id_region = region.id_region
                            inner join raza on detalle_eleccion.id_raza = raza.id_raza
							inner join pais on region.id_pais = pais.id_pais
                            group by pais.nombre,region.nombre,raza.tipo)as C1 
                            group by C1.p1,C1.r1,C1.raza) as C3
	on C2.pais = C3.p1
	and C2.region = C3.r1
    and C2.total_votos = C3.votos
    and C2.raza = 'INDIGENAS'; 
						
/*----------consulta 5 dudosa ---------*/
select C1.pais,C1.departamento,C1.municipio,C1.primaria * 0.25 as primaria,C1.medio * 0.30 as medio,C1.universitario from(
	select pais.nombre as pais, departamento.nombre as departamento,municipio.nombre as municipio,sum(detalle_eleccion.primaria) as primaria,sum(detalle_eleccion.medio) as medio,
			sum(detalle_eleccion.universitario) as universitario
            from detalle_eleccion
				inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
				inner join departamento on municipio.id_departamento = departamento.id_departamento
				inner join region on departamento.id_region = region.id_region
				inner join pais  on region.id_pais = pais.id_pais
                group by pais,departamento,municipio) as C1
                where C1.universitario < (C1.medio)
                and  C1.universitario > (C1.primaria * 0.25)
                order by C1.universitario desc;

/*------------consulta 6----------*/
select C2.dpto as Departamento,round(C1.total /(C1.total + C2.total) *100,2) as porcentaje_mujeres,round(C2.total /(C1.total + C2.total) *100,2) as porcentaje_hombres
	from (select departamento.nombre as dpto,genero.tipo as genero, sum(detalle_eleccion.universitario) as total
			from detalle_eleccion
            inner join genero on detalle_eleccion.id_genero = genero.id_genero
			inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
			inner join departamento on municipio.id_departamento = departamento.id_departamento
			inner join region on departamento.id_region = region.id_region
			inner join pais  on region.id_pais = pais.id_pais
            where upper(genero.tipo) = 'HOMBRES'
            group by departamento.nombre,genero.tipo)C1
		inner join (select departamento.nombre as dpto,genero.tipo as genero, sum(detalle_eleccion.universitario) as total
			from detalle_eleccion
            inner join genero on detalle_eleccion.id_genero = genero.id_genero
			inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
			inner join departamento on municipio.id_departamento = departamento.id_departamento
			inner join region on departamento.id_region = region.id_region
			inner join pais  on region.id_pais = pais.id_pais
            where upper(genero.tipo) = 'MUJERES'
            group by departamento.nombre,genero.tipo)C2
            on C1.dpto = C2.dpto
            and C1.total > C2.total;

/*-----------consulta 7 --------*/
select p.nombre as pais, r.nombre as region,round(sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) / (
		select count(*) from (select  pais.nombre as pais,region.nombre as region ,departamento.nombre as dpto
								from detalle_eleccion
								inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
								inner join departamento on municipio.id_departamento = departamento.id_departamento
								inner join region on departamento.id_region = region.id_region
								inner join pais  on region.id_pais = pais.id_pais
                                where p.nombre = pais.nombre and r.nombre = region.nombre
                                and d.nombre = departamento.nombre
                                group by pais.nombre,region.nombre,departamento.nombre) as C1) / 2,2) as promedio
from detalle_eleccion
inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
inner join departamento d on municipio.id_departamento = d.id_departamento
inner join region r on d.id_region = r.id_region
inner join pais p on r.id_pais = p.id_pais
group by p.nombre,r.nombre;
/*---------consulta 8 ------------*/
select pais.nombre as Pais, sum(detalle_eleccion.primaria) as Voto_primario, sum(detalle_eleccion.medio) as Voto_medio,sum(detalle_eleccion.universitario) as Voto_Universitario
from detalle_eleccion
	inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
	inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
	inner join departamento on municipio.id_departamento = departamento.id_departamento
	inner join region on departamento.id_region = region.id_region
	inner join pais on region.id_pais = pais.id_pais
group by pais.nombre
order by pais.nombre;
/*-------------consulta 9-----------*/
select  C1.pais,C1.raza, round((C1.total/C2.total2 * 100),2) as Porcentaje from 
	(select pais.nombre as pais, raza.tipo as raza, sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total
    from partido,detalle_eleccion,municipio,departamento,region,pais,eleccion,raza
    where detalle_eleccion.id_raza = raza.id_raza
	and detalle_eleccion.id_partido = partido.id_partido
    and detalle_eleccion.id_eleccion = eleccion.id_eleccion
    and detalle_eleccion.id_municipio = municipio.id_municipio
    and departamento.id_departamento = municipio.id_departamento
    and departamento.id_region = region.id_region
    and region.id_pais = pais.id_pais
    group by pais.nombre,raza.tipo
    order by pais.nombre,raza.tipo) as C1
    inner join 
    (select pais.nombre as pais, sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total2
    from partido,detalle_eleccion,municipio,departamento,region,pais,eleccion,raza
    where detalle_eleccion.id_raza = raza.id_raza
	and detalle_eleccion.id_partido = partido.id_partido
    and detalle_eleccion.id_eleccion = eleccion.id_eleccion
    and detalle_eleccion.id_municipio = municipio.id_municipio
    and departamento.id_departamento = municipio.id_departamento
    and departamento.id_region = region.id_region
    and region.id_pais = pais.id_pais
    group by pais.nombre
    order by pais.nombre) as C2
on C1.pais = C2.pais
order by C1.pais;

/*---------------------consulta 10----------------*/
select C4.pais as Pais, C4.resta as Diferencia,round(C4.maximo/2,0)as Maximos,round(C4.minimo/2,0) as Minimo from (
	select C3.pais as pais, round((max(C3.total) - min(C3.total)) / 2,0) as resta, max(C3.total) as maximo, min(C3.total) as minimo from(
    select C1.pais as pais,C1.partido as partido, C1.voto + C2.voto  total from
    (select pais.nombre as pais,partido.nombre as partido,sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as voto
		from detalle_eleccion
			inner join partido on detalle_eleccion.id_partido = partido.id_partido
			inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
			inner join departamento on municipio.id_departamento = departamento.id_departamento
			inner join region on departamento.id_region = region.id_region
			inner join pais on region.id_pais = pais.id_pais
			group by pais.nombre,partido.nombre) as C1
            inner join 
	(select pais.nombre as pais,sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as voto
		from detalle_eleccion
			inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
			inner join departamento on municipio.id_departamento = departamento.id_departamento
			inner join region on departamento.id_region = region.id_region
			inner join pais on region.id_pais = pais.id_pais
            group by pais.nombre) as C2
	on C1.pais = C2.pais
    order by C1.pais) as C3
    group by C3.pais) as C4
    limit 1;
    
select pais.nombre as pais,partido.nombre as partido,sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as voto
		from detalle_eleccion
			inner join partido on detalle_eleccion.id_partido = partido.id_partido
			inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
			inner join departamento on municipio.id_departamento = departamento.id_departamento
			inner join region on departamento.id_region = region.id_region
			inner join pais on region.id_pais = pais.id_pais
			group by pais.nombre,partido.nombre;
            
select pais.nombre as pais,sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as voto
		from detalle_eleccion
			inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
			inner join departamento on municipio.id_departamento = departamento.id_departamento
			inner join region on departamento.id_region = region.id_region
			inner join pais on region.id_pais = pais.id_pais
            group by pais.nombre;


/*-----------consulta 11----------*/
select round(C1.total/2,0) as total_voto_mujeres,C1.pais,
		round(C1.total /C2.total*100,2) as Porcentaje
from (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total,pais.nombre as pais from detalle_eleccion
	inner join genero on detalle_eleccion.id_genero = genero.id_genero
	inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
	inner join departamento on municipio.id_departamento = departamento.id_departamento
	inner join region on departamento.id_region = region.id_region
	inner join pais on region.id_pais = pais.id_pais
    group by pais.nombre)C2
    inner join 
 (select sum(detalle_eleccion.alfabetas) as total , pais.nombre as pais
from detalle_eleccion
	inner join raza on detalle_eleccion.id_raza = raza.id_raza
	inner join genero on detalle_eleccion.id_genero = genero.id_genero
	inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
	inner join departamento on municipio.id_departamento = departamento.id_departamento
	inner join region on departamento.id_region = region.id_region
	inner join pais on region.id_pais = pais.id_pais
where upper(genero.tipo) = 'MUJERES'
and upper (raza.tipo) = 'INDIGENAS'
group by pais.nombre) as C1
on C1.pais = C2.pais;

/*-----------------------consulta 12-----------*/
select C1.pais as pais,C2.total/C1.total * 100 as porcentaje_analfabetas
	from (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total,pais.nombre as pais
			from detalle_eleccion
			inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
			inner join departamento on municipio.id_departamento = departamento.id_departamento
			inner join region on departamento.id_region = region.id_region
			inner join pais on region.id_pais = pais.id_pais
			group by pais.nombre) as C1
	inner join 
		(select sum(detalle_eleccion.analfabetas) as total, pais.nombre as pais
			from detalle_eleccion
			inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
			inner join departamento on municipio.id_departamento = departamento.id_departamento
			inner join region on departamento.id_region = region.id_region
			inner join pais on region.id_pais = pais.id_pais
			group by pais.nombre) as C2
			on  C1.pais = C2.pais
			order by C2.total/C1.total * 100 desc 
			limit 1;

select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total,pais.nombre
		from detalle_eleccion
		inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
		inner join departamento on municipio.id_departamento = departamento.id_departamento
		inner join region on departamento.id_region = region.id_region
		inner join pais on region.id_pais = pais.id_pais
        group by pais.nombre;

/*----------consulta 13------------*/
select C1.departamento,C1.total from
(select departamento.nombre as departamento , round(sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) / 2 ,0) as total
	from detalle_eleccion
		inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
		inner join departamento on municipio.id_departamento = departamento.id_departamento
		inner join region on departamento.id_region = region.id_region
		inner join pais on region.id_pais = pais.id_pais
        where upper(pais.nombre) = 'GUATEMALA'
        group by departamento.nombre) as C1
        inner join (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) / 2 as total
						from detalle_eleccion
						inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
						inner join departamento on municipio.id_departamento = departamento.id_departamento
						inner join region on departamento.id_region = region.id_region
						inner join pais on region.id_pais = pais.id_pais
                        where upper(pais.nombre) = 'GUATEMALA'
                        and upper(departamento.nombre) = 'GUATEMALA'
                        group by pais.nombre,departamento.nombre) as C2
						on  C1.total > C2.total;

