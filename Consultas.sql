use Proyecto2;

/*--------------consulta 1-----------*/
select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total, pais.nombre as pais,departamento.nombre as depa from detalle_eleccion
						inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
						inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
						inner join departamento on municipio.id_departamento = departamento.id_departamento
						inner join region on departamento.id_region = region.id_region
						inner join pais on region.id_pais = pais.id_pais
						inner join genero on detalle_eleccion.id_genero = genero.id_genero
						where upper(genero.tipo ) = 'MUJERES'
                        group by pais.nombre,departamento.nombre;

/*-------------consulta 2--------------*/
select (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) from detalle_eleccion) as Total_votos, C2.depa,C2.pais,round(C2.total/C1.total*100,2) as porcentaje
from (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total, pais.nombre as pais from detalle_eleccion
						inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
						inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
						inner join departamento on municipio.id_departamento = departamento.id_departamento
						inner join region on departamento.id_region = region.id_region
						inner join pais on region.id_pais = pais.id_pais
						inner join genero on detalle_eleccion.id_genero = genero.id_genero
						where upper(genero.tipo ) = 'MUJERES'
                        group by pais.nombre)as C1,
(select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total, pais.nombre as pais,departamento.nombre as depa from detalle_eleccion
						inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
						inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
						inner join departamento on municipio.id_departamento = departamento.id_departamento
						inner join region on departamento.id_region = region.id_region
						inner join pais on region.id_pais = pais.id_pais
						inner join genero on detalle_eleccion.id_genero = genero.id_genero
						where upper(genero.tipo) = 'MUJERES'
                        group by pais.nombre,departamento.nombre) as C2
                        where C1.pais = C2.pais
                        order by C2.pais,C2.depa;
                        
/*----------------Consulta 3------------------*/

/*----------------Consulta 4-----------------*/
select C2.pais, C2.region, C2.raza,C2.total_votos
	from (select pais.nombre as pais,region.nombre as region,raza.tipo as raza, pais.id_pais as p, region.id_region as r,
    sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total_votos
		from detalle_eleccion
		inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
		inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
		inner join departamento on municipio.id_departamento = departamento.id_departamento
		inner join region on departamento.id_region = region.id_region
		inner join pais  on region.id_pais = pais.id_pais
		inner join raza on detalle_eleccion.id_raza = raza.id_raza
        group by pais.nombre,region.nombre,raza.tipo,pais.id_pais,region.id_region) as C2,
		(select MAX(C1.total),C1.p1 as p1,C1.r1 as r1,C1.total as total_votos  from (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas) as total,pais.id_pais as p1,region.id_region as r1 
							from detalle_eleccion
							inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion
							inner join municipio on detalle_eleccion.id_municipio = municipio.id_municipio
							inner join departamento on municipio.id_departamento = departamento.id_departamento
							inner join region on departamento.id_region = region.id_region
							inner join pais on region.id_pais = pais.id_pais) C1 )C3
	where C2.p = C3.p1
	and C2.r = C3.r1
    and C2.raza = 'INDIGENAS'; 




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
    order by pais.nombre,raza.tipo) as C1,
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
where C1.pais = C2.pais
order by C1.pais;


/*-----------consulta 11----------*/

select (select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas)
												from detalle_eleccion
                                                inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion) as Total_Votos,
		round(C1.total/(select sum(detalle_eleccion.alfabetas + detalle_eleccion.analfabetas)
												from detalle_eleccion
                                                inner join eleccion on detalle_eleccion.id_eleccion = eleccion.id_eleccion)*100,2) as Porcentaje
from (select sum(detalle_eleccion.analfabetas) as total from detalle_eleccion
inner join raza on detalle_eleccion.id_raza = raza.id_raza
inner join genero on detalle_eleccion.id_genero = genero.id_genero
where upper(genero.tipo) = 'MUJERES'
and upper (raza.tipo) = 'INDIGENAS') as C1;

/*----------consulta 13------------*/

