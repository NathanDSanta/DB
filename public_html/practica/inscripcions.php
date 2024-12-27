#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Practica PHP: Inscripcions en una cursa, seleccio cursa</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
    include 'funcions.php';     
    iniciaSessio();
    connecta($conn);
    capcalera("Inscripcions en una cursa"); 
 ?>
  <form action="inscriureParella.php" method="post">
  <p><label>Cursa:</label>
      <select name="cursa">
<?php 
    $consulta = "SELECT codi, nom FROM curses where inicireal is null";
    $comanda = oci_parse($conn, $consulta);
    $exit=oci_execute($comanda);
    if (!$exit){
        mostraErrorExecucio($comanda);
    }
    while (($fila = oci_fetch_array($comanda, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
        echo "      <option value=\"" . $fila['CODI'] . "\">" . $fila['NOM'] . "</option>\n";
    }
    echo "      </select></p>";
  ?>      
  <p><label>Data Inici: </label><input type="date" name="data"> </p>
  <p><label>Hora Inici: </label><input type="time" name="hora"> </p>
  <p><label>&nbsp;</label><input type = "submit" value="Seleccionar"></p>
  </form>
<?php peu("Tornar al menú principal","menu.php");?>
</body>
</html>
