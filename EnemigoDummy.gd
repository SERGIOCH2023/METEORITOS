extends Node2D

var hitpoinsts:float = 10.0

func recibir_danio(danio: float) -> void:
	hitpoinsts -= danio
	if hitpoinsts <= 0.0:
		queue_free()

func _process(_delta: float) -> void:
	$Canion.set_esta_disparando(true)

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		body.destruir()
		
