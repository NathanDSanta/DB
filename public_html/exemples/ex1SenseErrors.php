#!/usr/bin/php-cgi
<?php
    // canviar uxxxxxxx pel vostre usuari i password pel vostre password 
    // ... és una bestiesa de seguretat però només ho farem aquest cop :-)
    $conn = oci_connect('uxxxxxxx', 'password', 'ORCLCDB');
	$consulta="SELECT codi, nom, credits FROM Assignatures";
	$comanda = oci_parse($conn, $consulta);
	$exit=oci_execute($comanda);
	$numColumnes=oci_num_fields($comanda);
	// mostrem les capceleres
	echo " | ";
	for ($i=1;$i<=$numColumnes; $i++) {
		echo oci_field_name($comanda,$i) . " | "; 
	}
	echo "\n";
	// recorrem les files
	while (($row = oci_fetch_array($comanda, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
		echo " | ";
		foreach ($row as $element) {
			echo $element . " | ";
		}
		echo "\n";
	}
	oci_free_statement($comanda);
	oci_close($conn);
?>
