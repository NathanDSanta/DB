#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Exemple PHP: enregistrar les qualificacions</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
  include 'funcions.php';
  iniciaSessio();
  connecta($conn);
  $cursa=$_POST['cursa'];
  $consulta="SELECT nom FROM curses WHERE codi=:cursa";
  $comanda = oci_parse($conn, $consulta);
  oci_bind_by_name($comanda,":cursa",$cursa);
  $exit = oci_execute($comanda);
  $fila = oci_fetch_array($comanda);
  $carrera=$fila['NOM'];
  unset ($_POST['cursa']); // per poder recorrer $_POST amb un foreach per les qualificacions
  capcalera("Temps dels participants de ".$carrera." enregistrades"); 
  oci_free_statement($comanda);
  $actualitzacioTemps="UPDATE participantscurses SET temps=:temps WHERE codi=:participant AND cursa=:cursa";
  $comanda = oci_parse($conn, $actualitzacioTemps);
  oci_bind_by_name($comanda,":cursa",$cursa);
  foreach($_POST AS $clau => $valor) {
    if (!empty($valor)) {
    oci_bind_by_name($comanda,":temps",$valor);
    oci_bind_by_name($comanda,":participant",$clau);
    oci_execute($comanda); // no fem control d'errors
    }
  }
   oci_free_statement($comanda);
  $millortemps="UPDATE curses SET millortemps=(select min(temps) from participantscurses where cursa=:cursa) where codi=:cursa";
  $comanda = oci_parse($conn, $millortemps);
  oci_bind_by_name($comanda,":cursa",$cursa);
  oci_execute($comanda); // no fem control d'errors
  echo "<p>Temps de participants de <b>". $carrera . "</b> actualitzades</p>\n";
  oci_free_statement($comanda);
  oci_close($conn);
  peu("Actualitzar una altra carrera","seleccionarCursa.php");;
  peu("Tornar al menú principal","menu.php");;
?>
</body>
</html>
