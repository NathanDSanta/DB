#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Practica PHP: Donar d'alta un vehicle, entrada de dades</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
    include 'funcions.php';     
    iniciaSessio();
    connecta($conn);
    capcalera("Donar d'alta un vehicle"); 
 ?>
  <form action="afegirVehicle_BD.php" method="post">
  <p><label>Descripcio: </label><input type="text" name="descripcio"> </p>
  <p><label>Color: </label><input type="text" name="color"></p>
  <p><label>Consum: </label><input type="number" name="consum"></p>
  <p><label>Data: </label><input type="date" name="data"></p>
  <p><label>Preu: </label><input type="number" min="0" name="semestre"></p>
  <p><label>Grup Vehicles:</label>
      <select name="vehicle">
      <option value="">--sense especificar--</option>
<?php 
    $vehicles = "SELECT codi, descripcio 
                     FROM grupsvehicles order by descripcio";
    $comanda = oci_parse($conn, $vehicles);
    $exit=oci_execute($comanda);
    if (!$exit){
        mostraErrorExecucio($comanda);
    }
    while (($fila = oci_fetch_array($comanda, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
        echo "      <option value=\"" . $fila['CODI'] . "\">" . $fila['DESCRIPCIO'] . "</option>\n";
    }
    echo "      </select></p>";
  ?>      
  <p><label>Combustible:</label>
      <select name="combustible">
      <option value="">--sense especificar--</option>
<?php 
    $vehicles = "SELECT descripcio 
                     FROM combustibles order by descripcio";
    $comanda = oci_parse($conn, $vehicles);
    $exit=oci_execute($comanda);
    if (!$exit){
        mostraErrorExecucio($comanda);
    }
    while (($fila = oci_fetch_array($comanda, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
        echo "      <option value=\"" . $fila['DESCRIPCIO'] . "\">" . $fila['DESCRIPCIO'] . "</option>\n";
    }
    echo "      </select></p>";
  ?>      
  <p><label>Propietari:</label>
      <select name="propietari">
      <option value="">--sense especificar--</option>
<?php 
    $vehicles = "SELECT alias, nom || ' ' || cognoms as nom 
                     FROM usuaris order by nom";
    $comanda = oci_parse($conn, $vehicles);
    $exit=oci_execute($comanda);
    if (!$exit){
        mostraErrorExecucio($comanda);
    }
    while (($fila = oci_fetch_array($comanda, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
        echo "      <option value=\"" . $fila['ALIAS'] . "\">" . $fila['NOM'] . "</option>\n";
    }
    echo "      </select></p>";
  ?>      
  <p><label>&nbsp;</label><input type = "submit" value="Donar d'alta"></p>
  </form>
<?php peu("Tornar al menú principal","menu.php");?>
</body>
</html>
