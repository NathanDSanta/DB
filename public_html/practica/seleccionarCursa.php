#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Practica PHP: Entrar temps de tots els participants, seleccio cursa</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
    include 'funcions.php';     
    iniciaSessio();
    connecta($conn);
    capcalera("Entrar temps de tots els participants"); 
 ?>
  <form action="entrarTemps.php" method="post">
  <p><label>Cursa:</label>
      <select name="cursa">
<?php 
    $consulta = "SELECT codi, nom FROM curses WHERE inicireal IS NULL";
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
  <p><label>&nbsp;</label><input type = "submit" value="Seleccionar cursa"></p>
  </form>
<?php peu("Tornar al menú principal","menu.php");?>
</body>
</html>
