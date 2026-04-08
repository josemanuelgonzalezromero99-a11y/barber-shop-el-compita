<?php
header('Content-Type: application/json');
include 'db.php';

$telefono = $_POST['telefono'] ?? null;
$nombre = $_POST['nombre'] ?? null;

if(!$telefono){
    echo json_encode(['success' => false, 'mensaje' => 'El teléfono es obligatorio']);
    exit;
}

// Insertar usuario
$stmt = $conexion->prepare("INSERT INTO usuarios (telefono, nombre) VALUES (?, ?)");
$stmt->bind_param("ss", $telefono, $nombre);

if($stmt->execute()){
    echo json_encode(['success' => true, 'usuario_id' => $stmt->insert_id, 'mensaje' => 'Usuario creado correctamente']);
} else {
    echo json_encode(['success' => false, 'mensaje' => 'Error al crear usuario']);
}

$stmt->close();
?>