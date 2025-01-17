#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Exemple PHP: qualificar una assignatura, posar notes</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
  include 'funcions.php';     
  iniciaSessio();
  connecta($conn);
  if(isset($_POST['cursa'])) $_SESSION['cursa'] = $_POST['cursa'];
  if(isset($_POST['inici'])) $_SESSION['inici'] = $_POST['data'] . " " . $_POST['hora'];
  $actualitzarData = "update curses set inicireal=TO_DATE(:inici, 'YYYY-MM-DD HH:MI') where codi=:cursa";
  $comanda = oci_parse($conn, $actualitzarData);
    if (!$comanda) {
      mostraErrorParser($comanda);
    }
  oci_bind_by_name($comanda,":cursa",$_SESSION['cursa']);
  oci_bind_by_name($comanda,":inici",$_SESSION['inici']);
  $exit = oci_execute($comanda);
  if (!$exit) {
    mostraErrorExecucio($exit);
  }

  $consulta="SELECT nom FROM curses WHERE codi=:cursa";
  $comanda = oci_parse($conn, $consulta);
  oci_bind_by_name($comanda,":cursa",$_SESSION['cursa']);
  $exit = oci_execute($comanda);
  $fila= oci_fetch_array($comanda);
  capcalera("Inscriure parella cursa: " . $fila['NOM']); 
?>
  <form action="inscriureParella_BD.php" method="post">
  <p><label>Personatge</label>
      <select name="personatge">
      <option value=""> -- sense especificar -- </option>
<?php 
    $personatge = "select alias,usuari from personatges";
    $comanda = oci_parse($conn, $personatge);
    $exit=oci_execute($comanda);
    if (!$exit){
        mostraErrorExecucio($comanda);
    }
    while (($fila = oci_fetch_array($comanda, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
        echo "      <option value=\"" . $fila['ALIAS'] . "\">" . $fila['ALIAS']. " - " . $fila['USUARI'] . "</option>\n";
    }
    echo "      </select></p>";
  ?>      
  <p><label>Vehicle</label>
      <select name="vehicle">
      <option value=""> -- sense especificar -- </option>
<?php 
    $vehicle = "select codi, descripcio, propietari from vehicles";
    $comanda = oci_parse($conn, $vehicle);
    $exit=oci_execute($comanda);
    if (!$exit){
        mostraErrorExecucio($comanda);
    }
    while (($fila = oci_fetch_array($comanda, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
        echo "      <option value=\"" . $fila['CODI'] . "\">" . $fila['DESCRIPCIO'] . " - " . $fila['PROPIETARI'] . "</option>\n";
    }
    echo "      </select></p>";
  ?>      
  <p><label>&nbsp;</label><input type = "submit" value="Inscriure"></p>
<?php peu("Tornar al menú principal","menu.php");?>
</body>
</html>
