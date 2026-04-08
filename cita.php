<?php
header('Content-Type: application/json');
include 'db.php';

// Recibir datos desde POST
$usuario_id = $_POST['usuario_id'] ?? null;
$servicio_id = $_POST['servicio_id'] ?? null;
$fecha = $_POST['fecha'] ?? null;

if(!$usuario_id || !$servicio_id || !$fecha){
    echo json_encode(['success' => false, 'mensaje' => 'Faltan datos requeridos']);
    exit;
}

// Insertar cita en DB
$stmt = $conexion->prepare("INSERT INTO citas (usuario_id, servicio_id, fecha) VALUES (?, ?, ?)");
$stmt->bind_param("iis", $usuario_id, $servicio_id, $fecha);

if($stmt->execute()){
    echo json_encode(['success' => true, 'mensaje' => 'Cita agendada correctamente']);
} else {
    echo json_encode(['success' => false, 'mensaje' => 'Error al agendar la cita']);
}

$stmt->close();
?>