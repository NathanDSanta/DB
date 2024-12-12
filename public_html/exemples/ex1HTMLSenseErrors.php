#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
   <title>Exemple molt simple PHP i Oracle</title>
   <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<h1>Contingut de la taula d'assignatures</h1>
<?php
    // canviar uxxxxxxx pel vostre usuari i password pel vostre password 
    // ... és una bestiesa de seguretat però només ho farem aquest cop :-)
    $usuari='u1994947';
    $password='';
    $BD='ORCLCDB';
    echo "<p>Dades agafades de la base de dades [<b>" . $BD . 
         "</b>] des de l'usuari [<b>" . $usuari . "</b>]</p>\n";
    $conn = oci_connect($usuari, $password, $BD);
	$consulta="SELECT codi, nom, credits FROM Assignatures";
	$comanda = oci_parse($conn, $consulta);
	$exit=oci_execute($comanda);
	$numColumnes=oci_num_fields($comanda);
	// mostrem les capceleres
	echo "<table>\n";
	echo "  <tr>";
	for ($i=1;$i<=$numColumnes; $i++) {
		echo "<th>".oci_field_name($comanda,$i) . "</th>"; 
	}
	echo "</tr>\n";
	// recorrem les files
	while (($row = oci_fetch_array($comanda, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
		echo "  <tr>";
		foreach ($row as $element) {
			echo "<td>".$element . "</td>";
		}
		echo "</tr>\n";
	}
	echo "</table>\n";
	oci_free_statement($comanda);
	oci_close($conn);
?>
</body>
</html>
