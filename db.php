<?php
$host = "localhost";
$usuario = "root";   // tu usuario MySQL
$contrasena = "";    // tu contraseña MySQL
$base_de_datos = "barbershop";

$conexion = new mysqli($host, $usuario, $contrasena, $base_de_datos);

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}
?>