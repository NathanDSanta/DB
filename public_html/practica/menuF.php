#!/usr/bin/php-cgi
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <title>Practica PHP: Consultar revisions</title>
  <link rel="stylesheet" href="exemple.css" type="text/css"> 
</head>
<body>
<?php
  include 'funcions.php';
  iniciaSessio();
  // emmagatzem usuari i password en una sessió per tenir-los disponibles 
  if (!empty($_POST['username'])) { // Hem arribat des de index.html
    $_SESSION['usuari'] = $_POST['username'];
    $_SESSION['password'] = $_POST['password'];
    // ara comprovem usuari i password intentant establir connexió amb Oracle    
    connecta($conn);
   }
?>
  <h1>Consultar Revisions</h1>
  <h2>Operacions disponibles</h2>
  <p> <a class="menu" href="revisioData.php">f1) Consulta dels vehicles revisats entre dues dates</a></p>
  <p> <a class="menu" href="revisioUsuari.php">f2) Consulta de les revisions fetes en els vehicles d'un usuari</a></p>
  <?php peu("Tornar a la pàgina de login","practicaPHP.html");?>
</body>
</html>
