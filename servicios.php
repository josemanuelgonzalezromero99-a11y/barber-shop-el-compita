<?php
header('Content-Type: application/json');
include 'db.php';

$resultado = $conexion->query("SELECT * FROM servicios ORDER BY nombre ASC");
$servicios = [];

while($row = $resultado->fetch_assoc()){
    $servicios[] = $row;
}

echo json_encode($servicios);
?>