<?php
header('Content-Type: application/json');
include 'db.php';

$usuario_id = $_GET['usuario_id'] ?? null;

if(!$usuario_id){
    echo json_encode(['success' => false, 'mensaje' => 'Falta usuario_id']);
    exit;
}

// Obtener citas con información del servicio
$stmt = $conexion->prepare("
    SELECT c.id, s.nombre AS servicio, s.duracion, s.precio, c.fecha, c.estado
    FROM citas c
    INNER JOIN servicios s ON c.servicio_id = s.id
    WHERE c.usuario_id = ?
    ORDER BY c.fecha ASC
");
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$result = $stmt->get_result();

$citas = [];
while($row = $result->fetch_assoc()){
    $citas[] = $row;
}

echo json_encode($citas);

$stmt->close();
?>