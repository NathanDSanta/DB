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
  $consulta="SELECT nom,inicireal FROM curses WHERE codi=:cursa";
  $comanda = oci_parse($conn, $consulta);
  oci_bind_by_name($comanda,":cursa",$cursa);
  $exit = oci_execute($comanda);
  $fila = oci_fetch_array($comanda);
  $carrera=$fila['NOM'];
  $dataCarrera=$fila['INICIREAL'];
  unset ($_POST['cursa']); // per poder recorrer $_POST amb un foreach per les qualificacions
  capcalera("Temps dels participants de ".$carrera." enregistrades"); 
  oci_free_statement($comanda);
  $actualitzacioTemps="UPDATE participantscurses SET temps=:temps WHERE codi=:participant AND cursa=:cursa";
  $consultaPersonatge="SELET personatge from participantscurses where cursa=:cursa and vehicle=:vehicle";
  $consultaRevisions="SELECT curses, personatge FROM revisions WHERE codiVehicle=:vehicle";
  $afegirRevisio="INSERT INTO revisions (codiVehicle, data, curses, personatge) values (:vehicle, :data, :curses, :personatge)";
  $updateRevisio="UPDATE revisions SET curses = curses + 1, personatge=:personatge where codivehicle = :vehicle and data = (select max(data) from revisions where codivehicle=:vehicle)";
  $comanda = oci_parse($conn, $actualitzacioTemps);
  $comandaRevisions = oci_parse($conn, $consultaRevisions);
  $comandaPersonatge = oci_parse($conn, $consultaPersonatge);
  $comandaAfegirRevisio = oci_parse($conn, $afegirRevisio);
  $comandaUpdateRevisio = oci_parse($conn, $updateRevisio);
  oci_bind_by_name($comanda,":cursa",$cursa);
  foreach($_POST AS $clau => $valor) {
    $claus = explode('-', $clau);
    $participant = trim($claus[0]);
    $vehicle = trim($claus[1]);
    if (!empty($valor)) {
    oci_bind_by_name($comanda,":temps",$valor);
    oci_bind_by_name($comanda,":participant",$participant);
    $exit = oci_execute($comanda);
    if (!$exit) {
      mostraErrorExecucio($comanda);
    }
    }
    oci_bind_by_name($comandaRevisions,":vehicle",$vehicle);
    $exit = oci_execute($comandaRevisions);
    if (!$exit) {
      mostraErrorExecucio($comandaRevisions);
    }
    $filaRevisio = oci_fetch_array($comandaRevisions);
    $exit = oci_execute($comandaPersonatge);
    if (!$exit) {
      mostraErrorExecucio($comandaPersonatge);
    }
    $filaPersonatge = oci_fetch_array($comandaPersonatge);
    oci_bind_by_name($comandaAfegirRevisio,":cursa",$cursa);
    oci_bind_by_name($comandaAfegirRevisio,":vehicle",$vehicle);
    $personatge = $filaPersonatge['PERSONATGE'];
    if (!$filaRevisio || $filaRevisio['CURSES'] >= 3 || empty($valor)) {
    oci_bind_by_name($comandaAfegirRevisio,":vehicle",$vehicle);
    oci_bind_by_name($comandaAfegirRevisio,":data",$dataCarrera);
    oci_bind_by_name($comandaAfegirRevisio,":curses",1);
    oci_bind_by_name($comandaAfegirRevisio,":personatge",$personatge);
    $exit = oci_execute($comandaAfegirRevisio); 
    if (!$exit) {
      mostraErrorExecucio($comandaAfegirRevisio);
    }
    } else if ($filaRevisio && $filaRevisio['CURSES'] < 3) {
    oci_bind_by_name($comandaUpdateRevisio,":vehicle",$vehicle);
    oci_bind_by_name($comandaUpdateRevisio,":personatge",$personatge);
    $exit = oci_execute($comandaUpdateRevisio); 
    if (!$exit) {
      mostraErrorExecucio($comandaUpdateRevisio);
    }
    }
  }
  oci_free_statement($comanda);
  oci_free_statement($comandaRevisions);
  oci_free_statement($comandaAfegirRevisio);
  oci_free_statement($comandaUpdateRevisio);
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
