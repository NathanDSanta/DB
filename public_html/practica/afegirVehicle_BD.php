#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Practica PHP: Donar d'alta un Vehicle, inserció a la base de dades</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
  include 'funcions.php';     
  iniciaSessio();
  connecta($conn);
  capcalera("Inserir Vehicle a la base de dades"); 
  $consultaCodi="SELECT codi, descripcio FROM Vehicles WHERE codi=:codiVehicle";
  $comanda = oci_parse($conn, $consultaCodi);
  $codiVehicle = substr($_POST["grupvehicle"], 0, 3) . substr($_POST["descripcio"], 0, 6);
  $codiVehicle = str_replace(' ', '_', $codiVehicle);
  oci_bind_by_name($comanda,":codiVehicle",$codiVehicle);
  $exit = oci_execute($comanda);
  $fila=oci_fetch_array($comanda); // no fem control d'errors 
  while ($fila) {
    $codiVehicle = $codiVehicle . rand(0, 999);
    oci_bind_by_name($comanda,":codiVehicle", $codiVehicle);
    $exit = oci_execute($comanda);
    $fila=oci_fetch_array($comanda); // no fem control d'errors 
  }
  if (!$fila){ // no existeix cap assignatura amb el codi rebut 
    oci_free_statement($comanda);
    $sentenciaSQL = "INSERT INTO Vehicles (codi, descripcio, color, consum, datacompra, preu, grupvehicle, combustible, propietari) 
                     VALUES (:codi, :descripcio, :color, :consum, :datacompra, :preu, :grupvehicle, :combustible, :propietari)";
    $comanda = oci_parse($conn, $sentenciaSQL);
    oci_bind_by_name($comanda, ":codi", $codiVehicle);
    oci_bind_by_name($comanda, ":descripcio", $_POST["descripcio"]);
    oci_bind_by_name($comanda, ":color", $_POST["color"]);
    oci_bind_by_name($comanda, ":consum", $_POST["consum"]);
    oci_bind_by_name($comanda, ":datacompra", $_POST["datacompra"]);
    oci_bind_by_name($comanda, ":preu", $_POST["preu"]);
    oci_bind_by_name($comanda, ":grupvehicle", $_POST["grupvehicle"]);
    oci_bind_by_name($comanda, ":combustible", $_POST["combustible"]);
    oci_bind_by_name($comanda, ":propietari", $_POST["propietari"]);
    $exit = oci_execute($comanda); 
    if ($exit) {
        echo "<p>Nou vehicle amb codi " . $codiVehicle . " inserit a la base de dades</p>\n";
    } else {
        mostraErrorExecucio($comanda);
    }
  } else {
      echo "<strong>COMPTE! Vehicle ".
           $codiVehicle ." no creat</strong>\n";
  }
  oci_free_statement($comanda);
  oci_close($conn);
  peu("Tornar al menú principal","menu.php");;
?>
</body>
</html>
