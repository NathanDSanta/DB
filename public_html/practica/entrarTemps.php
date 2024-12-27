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
  $consulta="SELECT nom FROM curses WHERE codi=:cursa";
  $comanda = oci_parse($conn, $consulta);
  oci_bind_by_name($comanda,":cursa",$_POST['cursa']);
  $exit = oci_execute($comanda);
  $fila= oci_fetch_array($comanda);
  capcalera("Entrar temps cursa ".$fila['NOM']); 
?>
  <form action="entrarTemps_BD.php" method="post">
<?php 
      $consulta = "select p.codi, u.alias, p.personatge, v.descripcio, p.temps
      from participantscurses p
      join vehicles v on p.vehicle=v.codi
      join usuaris u on v.propietari=u.alias where p.cursa=:cursa";
  $comanda = oci_parse($conn, $consulta);
  oci_bind_by_name($comanda,":cursa",$_POST['cursa']);
  $exit=oci_execute($comanda);
  if (!$exit){
      mostraErrorExecucio($comanda);
  }
  while (($fila = oci_fetch_array($comanda, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
      echo "    <p><label>".$fila['ALIAS']." - ".$fila['PERSONATGE'].", " .$fila['DESCRIPCIO'] .": </label>";
      echo ' <input type="number" step="0.01" value="'.$fila['TEMPS'].'" name="'.$fila['CODI'].'"></p>'."\n";
  }
  echo '    <p><input type = "hidden" name="cursa" value="'.$_POST['cursa'].'"></p>';
?>      
    <p><label>&nbsp;</label><input type = "submit" value="Actualitzar"></p>
  </form>
<?php peu("Tornar al menú principal","menu.php");?>
</body>
</html>
