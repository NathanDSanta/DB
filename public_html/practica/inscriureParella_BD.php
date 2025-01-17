#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Practica PHP: Inscriure una parella Vehicle-Personatge a una cursa, inserció a la base de dades</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
  include 'funcions.php';     
  iniciaSessio();
  connecta($conn);
  $consultaPersonatge="SELECT usuari FROM personatges WHERE alias=:personatge";
  $consultaVehicle="SELECT propietari FROM vehicles WHERE codi=:vehicle";
  $comandaPersonatge = oci_parse($conn, $consultaPersonatge);
  $comandaVehicle = oci_parse($conn, $consultaVehicle);
  oci_bind_by_name($comandaPersonatge,":personatge",$_POST["personatge"]);
  oci_bind_by_name($comandaVehicle,":vehicle",$_POST["vehicle"]);
  $exitPersonatge = oci_execute($comandaPersonatge);
  $exitVehicle = oci_execute($comandaVehicle);
  $filaPersonatge=oci_fetch_array($comandaPersonatge); // no fem control d'errors 
  $filaVehicle=oci_fetch_array($comandaVehicle); // no fem control d'errors 
  if ($filaPersonatge['USUARI'] != $filaVehicle['PROPIETARI']){ // no existeix cap assignatura amb el codi rebut 
    echo "<p> 
    El Personatge i el vehicle no pertanyen al mateix usuari (" .
    $_POST["personatge"] . " -> " . $filaPersonatge["USUARI"] . ", " .
    $_POST["vehicle"] . " -> " . $filaVehicle["PROPIETARI"] .
    ")</p>";
  } else {
    $consulta = "select * from participantscurses where cursa=:cursa and vehicle=:vehicle and personatge=:personatge";
    $comanda = oci_parse($conn, $consulta);
    if (!$comanda) { mostraErrorParser($conn,$consulta);} // mostrem error i avortem
    oci_bind_by_name($comanda, ":cursa", $_SESSION["cursa"]);
    oci_bind_by_name($comanda, ":vehicle", $_POST["vehicle"]);
    oci_bind_by_name($comanda, ":personatge", $_POST["personatge"]);
    $exit=oci_execute($comanda);
    if (!$exit) { mostraErrorExecucio($comanda);} // mostrem error i avortem
    $fila=oci_fetch_array($comanda); // no fem control d'errors 
    if($fila){
    echo "<p> 
    Aquest usuari (" . $filaPersonatge["USUARI"] . ") ja esta inscrit:" .
    "Personatge -> " . $fila["PERSONATGE"] .
    ", Vehicle -> " . $fila["VEHICLE"] .
    "</p>";
    }
    else{
    oci_free_statement($comanda);
    $insercio = "insert into participantscurses (cursa,vehicle,personatge)
                  values (:cursa, :vehicle, :personatge)";
    $comanda = oci_parse($conn, $insercio);
    if (!$comanda) { mostraErrorParser($conn,$insercio);} // mostrem error i avortem
    oci_bind_by_name($comanda, ":cursa", $_SESSION["cursa"]);
    oci_bind_by_name($comanda, ":vehicle", $_POST["vehicle"]);
    oci_bind_by_name($comanda, ":personatge", $_POST["personatge"]);
    $exit=oci_execute($comanda);
    if (!$exit) { mostraErrorExecucio($comanda);} // mostrem error i avortem
    }
    echo "<p> La parella personatge/vehicle s'ha inserit correctament </p>";

    oci_free_statement($comanda);
  }
    oci_free_statement($comandaPersonatge);
    oci_free_statement($comandaVehicle);
  oci_close($conn);
  peu("Inscriu una altra parella personatge/vehicle","inscriureParella.php");;
  peu("Acaba les inscripcions","menu.php");;
?>
</body>
</html>
