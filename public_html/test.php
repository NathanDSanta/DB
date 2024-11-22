#!/usr/bin/php-cgi
<?php

echo ("Usuari: ");
system("whoami");
echo ("<br><br><br>");
echo ("Taules d'Oracle disponibles: <br><br>");

$conn = oci_connect('u1994947', 'PASSWORD', 'ORCLCDB');

$stid = oci_parse($conn, 'select table_name from user_tables');
oci_execute($stid);

echo "<table>\n";
while (($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
    echo "<tr>\n";
    foreach ($row as $item) {
        echo "  <td>".($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;")."</td>\n";
    }
    echo "</tr>\n";
}
echo "</table>\n";

oci_free_statement($stid);
oci_close($conn);

?>
