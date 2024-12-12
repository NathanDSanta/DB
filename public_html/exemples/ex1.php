#!/usr/bin/php-cgi
<?php
// canviar uxxxxxxx pel vostre usuari i password pel vostre password 
// ... és una bestiesa de seguretat però només ho farem aquest cop :-)
$conn = oci_connect('uxxxxxxx', 'password', 'ORCLCDB');
if (!$conn){
  echo "Error establint connexió\n";
} else {
	$consulta="SELECT codi, nom, credits FROM Assignatures";
	$comanda = oci_parse($conn, $consulta);
	if (!$comanda){
	  echo "Error amb el parser de la consulta\n";
	} else {
		$exit=oci_execute($comanda);
		if (!$exit){
		  echo "Error executant la comanda\n";
		} else {
			$numColumnes=oci_num_fields($comanda);
			// mostrem es capceleres
			echo " | ";
			for ($i=1;$i<=$numColumnes; $i++) {
				echo oci_field_name($comanda,$i) . " | "; 
			}
			echo "\n";
      // recorrem les files. El while comentat és equivalent al que no ho està
      // while (($row = oci_fetch_assoc($comanda)) != false) {
			while (($row = oci_fetch_array($comanda, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
				echo " | ";
				foreach ($row as $element) {
					echo $element . " | ";
				}
				echo "\n";
		   }
       }
	}
	oci_free_statement($comanda);
	oci_close($conn);
}

?>
