
2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.

select "title" as "Películas"
from "film"
where "rating" = 'R';

3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40.

select "first_name" , "last_name"
from "actor"
where "actor_id" between 30 and 40;

4. Obtén las películas cuyo idioma coincide con el idioma original.

select "title" as "Películas"
from "film"
where "language_id" = "original_language_id";

5. Ordena las películas por duración de forma ascendente.

select "title" as "Películas"
from "film"
order by "length" ASC;

6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido.

select "first_name" , "last_name"
from "actor"
where "last_name" LIKE '%ALLEN%'; 

7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento.

select "rating" as "Clasificación", COUNT(*)as "Total_Películas"
from "film" 
group by "rating";

8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.

select "title" , "rating" , "length"
from "film"
where "rating" = 'PG-13'
OR "length" > '180';

9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select VARIANCE("replacement_cost")
from "film";

10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select MAX("length") as "Mayor Duración" , MIN(length) as "Menor Duración"
from "film" ; 

11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select "rental_id", "amount"
from "payment"
order by "payment_date" desc
limit '1'
offset	'2';

12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-
17’ ni ‘G’ en cuanto a su clasificación.

select "title"
from "film"
where "rating" not in ('NC-17' ,'G') ;

13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.

select "rating" , AVG(length) as "Promedio_Duración"
from "film"
group by "rating" ; 

14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.

select "title"
from "film"
where "length" > '180';

15. ¿Cuánto dinero ha generado en total la empresa?

select sum(amount)as "Total_Ingresos"
from "payment" ; 

16. Muestra los 10 clientes con mayor valor de id.

select "customer_id" as "Valor_Id", "first_name" , "last_name"
from "customer" 
order by "customer_id" desc
limit '10' ; 

17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’.

select "first_name", "last_name"
from "film_actor" as fa
inner join "film" as f
on fa."film_id"=f."film_id"
inner join "actor" as a
on fa."actor_id"=a."actor_id"
where "title" = 'EGG IGBY';

18. Selecciona todos los nombres de las películas únicos.

select distinct "title"
from "film" ;


19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.

select "title"
from "film_category" as fc
inner join "category" as c
on c."category_id" = fc."category_id"
inner join "film" as f
on f."film_id" = fc."film_id"
where "name" = 'Comedy' and "length" > '180' ;

20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.

select "name"
from "film_category" as fc
inner join "category" as c
on c."category_id" = fc."category_id"
inner join "film" as f
on f.film_id = fc.film_id
group by "name"
having AVG(LENGTH) > 110;

21. ¿Cuál es la media de duración del alquiler de las películas?

select AVG("rental_duration") as "Media_duración"
from "film" ;

22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.

select concat("first_name" , ' ' , "last_name") as "Nombre"
from "actor" ;

23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.

select date ("rental_date") as "fecha" , COUNT(*) as "Alquileres"
from "rental" 
group by DATE("rental_date")
order by "Alquileres" desc ;


24. Encuentra las películas con una duración superior al promedio.

select "title" , "length"
from "film"
where "length" > (select AVG("length") from "film") ;

25. Averigua el número de alquileres registrados por mes.

select extract(month from "rental_date") as mes , count (*) as "Total_Alquileres"
from "rental"
group by "mes"
order by "mes" ;

26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.

select AVG ("amount") as "Promedio" , stddev("amount") as "Desviación" , variance("amount") as "Varianza"
from "payment" ;

27. ¿Qué películas se alquilan por encima del precio medio?

select "title"
from "film" as f
inner join "inventory" as i
on f."film_id" = i."film_id"
inner join "rental" as r
on i."inventory_id" = r."inventory_id"
inner join "payment" as p
on r."rental_id" = p."rental_id"
where p."amount" > (select AVG(amount) from "payment") ;

28. Muestra el id de los actores que hayan participado en más de 40
películas.

select "actor_id"
from "film_actor"
group by  "actor_id"
having COUNT(film_id) > '40' ;

29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.

SELECT title as "Título" , COUNT(i.inventory_id) AS "Cantidad_Disponible"
FROM film as f 
LEFT JOIN inventory i 
ON f.film_id = i.film_id 
GROUP BY f.title;


30. Obtener los actores y el número de películas en las que ha actuado.

select "first_name" , "last_name" , count (fa.film_id) as "Películas"
from "film_actor" as fa
inner join "film" as f
on fa.film_id = f.film_id
inner join "actor" as a
on fa.actor_id = a.actor_id 
group by a."actor_id",  a."first_name" , a."last_name";
 

31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.

select "title" , "first_name" , "last_name"
from "film_actor" as fa
left join "film" as f
on fa.film_id = f.film_id
left join "actor" as a
on fa.actor_id = a.actor_id 
order by "title" Asc;


32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.

select  "first_name" , "last_name" ,"title" 
from "actor" as a
left join "film_actor" as fa
on fa.actor_id = a.actor_id
left join "film" as f
on f.film_id = fa.film_id
order by "last_name";



33. Obtener todas las películas que tenemos y todos los registros de
alquiler.

select "title" , "rental_id" , "rental_date" , "return_date"
from "film" as f
inner join "inventory" as i
on f.film_id = i.film_id
inner join "rental" as r
on r.inventory_id = i.inventory_id 
order by "title";


34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select "first_name" , "last_name" ,  SUM("amount") as "total_gastado"
from "customer" as c
inner join payment as p
on c.customer_id = p.customer_id 
group by c.customer_id, c.first_name , p.customer_id
order by "total_gastado" desc 
limit '5';

35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select "first_name" , "last_name"
from  "actor" 
where "first_name" = 'JOHNNY' ;

36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.

select "first_name" as "Nombre" , "last_name" as "Apellido" 
from "actor"; 

37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select MAX("actor_id") , MIN("actor_id")
from "actor" ;

38. Cuenta cuántos actores hay en la tabla “actor”.

select count("first_name") as "numero de actores"
from "actor" ;

39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.

select *
from "actor"
order by "last_name" ASC;

40. Selecciona las primeras 5 películas de la tabla “film”.

select "title" 
from "film"
where "film_id" <=5 ;

41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido? 

select "first_name" , count(actor_id)
from "actor"
group by "first_name" 
order by count(actor_id) desc;

--Los actores con el nombre más repetido son: Kennet, Penelope y Julia

42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.

select "rental_id" as "Alquiler", "first_name" as "Nombre", "last_name" as "Apellido"
from "rental" as r
inner join "customer" as c
on r.customer_id = c.customer_id ;


43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.

select "first_name" , "last_name" , "rental_id" , "rental_date" , "return_date"
from "customer" as c
left join "rental" as r
on r.customer_id = c.customer_id 
order by "last_name";


44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.

select *
from "film" as f
cross join "category" as c ;

--No, porque crea miles de filas redundantes sin valor real

45. Encuentra los actores que han participado en películas de la categoría
'Action'.

select "first_name" , "last_name" 
from "film_category" as fc
inner join "category" as c
on c.category_id = fc.category_id 
inner join "film" as f
on f.film_id = fc.film_id 
inner join "film_actor" as fa
on fa."film_id"=f."film_id"
inner join "actor" as a
on fa."actor_id"=a."actor_id"
where "name" = 'Action' ;

46. Encuentra todos los actores que no han participado en películas.
 
select "first_name" , "last_name"
from "actor" as a
left join "film_actor" as fa
on a.actor_id = fa.actor_id
where fa.film_id is null;


47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.

select a.first_name  , a.last_name , COUNT(f."film_id") as "Total_Películas"
from "film_actor" as fa
inner join "film" as f
on fa.film_id = f.film_id
inner join "actor" as a
on fa.actor_id = a.actor_id 
group by a.actor_id  , a.first_name , a.last_name; 



48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.

create view "actor_num_películas" as
select "first_name" , "last_name" , "title" 
from "film_actor" as fa
inner join "film" as f
on fa.film_id = f.film_id
inner join "actor" as a
on fa.actor_id = a.actor_id ;

49. Calcula el número total de alquileres realizados por cada cliente.

select "customer_id" ,  COUNT("rental_id") as "Total_alquileres"
from "rental" 
group by "customer_id" ;
 
50. Calcula la duración total de las películas en la categoría 'Action'.

select "name" , SUM("length") as "total duración"
from "film_category" as fc
inner join "category" as c
on c.category_id = fc.category_id
inner join "film" as f
on f.film_id = fc.film_id
where "name" = 'Action'
group by "name" ;

51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.

CREATE TEMPORARY TABLE cliente_rentas_temporal AS
select  "customer_id" , COUNT("rental_id") as "Total_Rentas"
from "rental" as r
group by "customer_id" ;

52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.

CREATE TEMPORARY TABLE peliculas_alquiladas AS 
SELECT f.film_id, COUNT(rental_id) AS total_alquileres
FROM film as f
inner join inventory as i
on f.film_id = i.film_id
inner join "rental" as r
on i.inventory_id = r.inventory_id 
GROUP BY f."film_id"
HAVING count(r."rental_id") >= '10' ;


53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.

select "title" 
from "film" as f
inner join "inventory" as i
on f.film_id = i.film_id
inner join "rental" as r
on r.inventory_id = i.inventory_id
inner join "customer" as c
on c.customer_id = r.customer_id
where "first_name" like '%TAMMY%' and "last_name" like '%SANDERS%' and "return_date" is null
order by "title" asc;


54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.

select distinct "first_name" , "last_name"
from "film_category" as fc
inner join "category" as c
on c.category_id = fc.category_id
inner join "film" as f
on f.film_id = fc.film_id
inner join "film_actor" as fa
on fa.film_id = f.film_id
inner join "actor" as a
on a.actor_id = fa.actor_id 
where  "name" = 'Sci-Fi' 
order by "last_name";


55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.


select "first_name" , "last_name",r."rental_date"
from "actor" as a
inner join film_actor as fa
on a.actor_id = fa.actor_id
inner join rental as r
on fa.film_id = r.inventory_id
where r."rental_date" > (
select MIN("rental_date")
from "film" as f
inner join "inventory" as i
on f.film_id = i.film_id 
inner join "rental" as r
on r.inventory_id = i.inventory_id 
WHERE "title" = 'SPARTACUS CHEAPER')
order by a."last_name"  ;



56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.

select "first_name" , "last_name"
from "actor" as a
where a.actor_id not in (
select distinct fa.actor_id 
from film_actor as fa
inner join film_category as fc
on fa.film_id = fc.film_id 
inner join category as c
on fc.category_id = c.category_id
where c.name ='Music') ;



57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.

select "title"
from "rental" as r
inner join "inventory" as i
on r.inventory_id = i.inventory_id
inner join "film" as f
on i.film_id = f.film_id
where ("return_date" - "rental_date") > interval  '8 DAYS';


58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.

select "title" as "Título"
from "film_category" as fc
inner join "category" as c
on c.category_id = fc.category_id
inner join "film" as f
on f.film_id = fc.film_id
where "name" = 'Animation' ;


59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.

select "title" , "length"
from "film" 
where "length" = (
select "length"
from "film"
where "title" = 'DANCING FEVER') 
order by "title" ;


60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.

select "first_name" , "last_name"
from customer as c 
inner join  "rental" as r
on r.customer_id = c.customer_id
inner join "inventory" as i
on r.inventory_id = i.inventory_id
inner join "film" as f
on f.film_id = i.film_id 
group by c."customer_id"
having COUNT(distinct f.film_id) >= '7' 
order by c."last_name" ;


61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.

select "name" , count("rental_id") as "recuento_de_alquileres"
from "rental" as r
inner join "inventory" as i
on r.inventory_id = i.inventory_id
inner join "film" as f
on i.film_id = f.film_id
inner join  "film_category" as fc
on fc.film_id = f.film_id
inner join "category" as c 
on c.category_id = fc.category_id 
group by "name";

62. Encuentra el número de películas por categoría estrenadas en 2006.

select "name"
from "film_category" as fc
inner join "film" as f
on fc.film_id = f.film_id
inner join "category" as c
on c.category_id = fc.category_id
where "release_year" = '2006'
group by "name" ;

63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.

SELECT s."store_id", s."manager_staff_id", st."staff_id", st."first_name", st."last_name"
FROM "store" as s 
CROSS JOIN staff as st;

64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.

select c."customer_id" , "first_name" , "last_name" , count("rental_id") as "Películas_Alquiladas"
from "rental" as r
inner join "customer" as c
on r.customer_id = c.customer_id
group by c."customer_id" , c."first_name" , c."last_name" ;
