#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Practica PHP: Consultar revisions en un període</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php 
    include 'funcions.php';     
    iniciaSessio();
    connecta($conn);
    capcalera("Consultar revisions en un període"); 
 ?>
  <form action="revisioData_BD.php" method="post">
  <p><label>Data Inici: </label><input type="date" name="dataInici"> </p>
  <p><label>Data Final: </label><input type="date" name="dataFinal"> </p>
  <p><label>&nbsp;</label><input type = "submit" value="Consultar"></p>
  </form>
<?php peu("Tornar al menú principal","menu.php");?>
</body>
</html>
