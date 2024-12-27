#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Practica PHP: Mostrar participants d'una cursa, entrada de dades</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
    include 'funcions.php';     
    iniciaSessio();
    connecta($conn);
    capcalera("Mostrar participants d'una cursa"); 
 ?>
  <form action="consultarParticipants_BD.php" method="post">
  <p><label>Cursa:</label>
      <select name="cursa">
      <option value="">--sense especificar--</option>
<?php 
    $vehicles = "SELECT codi, nom 
          FROM curses 
          where inicireal is not null
          order by nom";
    $comanda = oci_parse($conn, $vehicles);
    $exit=oci_execute($comanda);
    if (!$exit){
        mostraErrorExecucio($comanda);
    }
    while (($fila = oci_fetch_array($comanda, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
        echo "      <option value=\"" . $fila['CODI'] . "\">" . $fila['NOM'] . "</option>\n";
    }
    echo "      </select></p>";
  ?>      
  <p><label>&nbsp;</label><input type = "submit" value="Consultar"></p>
  </form>
<?php peu("Tornar al menú principal","menu.php");?>
</body>
</html>
