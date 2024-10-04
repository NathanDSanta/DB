select
  nom || ' ' || cognoms as "NomCognoms",
  email,
  dd_lat,
  dd_long
from
  usuaris
where
  (
    nom like 'A%'
    or nom like 'M%'
  )
  and (dd_long between 0 and 5);

select
  codi,
  descripcio,
  combustible,
  consum,
  preu
from
  Vehicles
where
  color = 'blanc'
  and preu < 20000;