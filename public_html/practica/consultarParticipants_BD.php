#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Practica PHP: Mostrar participants d'una cursa, inserció a la base de dades</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
  include 'funcions.php';     
  iniciaSessio();
  connecta($conn);
  $consultaCodi="SELECT codi, millortemps FROM curses WHERE codi=:codiVehicle and millortemps is not null";
  $comanda = oci_parse($conn, $consultaCodi);
  oci_bind_by_name($comanda,":codiVehicle",$codiVehicle);
  $exit = oci_execute($comanda);
  $temps=oci_fetch_array($comanda); // no fem control d'errors 
  if ($temps){ // no existeix cap assignatura amb el codi rebut 
    capcalera("Classificacio de la cursa"); 
    $consulta="select v.codi, v.descripcio, p.personatge, coalesce(cast(p.temps as varchar(9)), 'Abandonat') as temps 
    from participantscurses p 
    join vehicles v on p.vehicle = v.codi 
    where p.cursa='Rally2020' 
    order by temps";
  } else {
    capcalera("Llistat de participants"); 
    $consulta="select v.codi, v.descripcio, p.personatge 
    from participantscurses p 
    join vehicles v on p.vehicle=v.codi 
    where p.cursa =:cursa";
  }
  $comanda = oci_parse($conn, $consulta);
  if (!$comanda) { mostraErrorParser($conn,$consulta);} // mostrem error i avortem
  oci_bind_by_name($comanda, ":cursa", $_POST["cursa"]);
  $exit=oci_execute($comanda);
  if (!$exit) { mostraErrorExecucio($comanda);} // mostrem error i avortem
  $numColumnes=oci_num_fields($comanda);
  // mostrem les capceleres
  echo "<table>\n";
  echo "  <tr>";
  for ($i=1;$i<=$numColumnes; $i++) {
  echo "<th>".htmlentities(oci_field_name($comanda, $i), ENT_QUOTES) . "</th>"; 
  }
  echo "</tr>\n";
  // recorrem les files
  while (($row = oci_fetch_array($comanda, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
  echo "  <tr>";
  foreach ($row as $element) {
  echo "<td>".($element !== null ? 
  htmlentities($element, ENT_QUOTES) : 
  "&nbsp;") . "</td>";
  }
  echo "</tr>\n";
  }
  echo "</table>\n";
  oci_free_statement($comanda);
  oci_close($conn);
  peu("Tornar al menú principal","menu.php");;
?>
</body>
</html>
