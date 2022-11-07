class_name Escudo
extends Area2D

#Variables
var esta_activado:bool = false setget ,get_esta_activado
var energia_original:float

#Variables export
export var energia: float=8.0
export var radio_desgaste: float =-1.6

func _process(delta: float) -> void:
	controlar_energia(radio_desgaste*delta)

func desactivar() -> void:
	set_process(false)
	esta_activado = false
	controlar_colisionador(true)
	$AnimationPlayer.play_backwards("activandose")
	
## Setters y Getters
func get_esta_activado() -> bool:
	return esta_activado
	
#Metodos
func _ready() -> void:
	energia_original=energia
	set_process(false)
	controlar_colisionador(true)

##Metodos Custom
func controlar_energia(consumo:float)-> void:
	energia += consumo
	if energia > energia_original:
		energia=energia_original
	elif energia <= 0.0:
		Eventos.emit_signal("ocultar_energia_escudo")
		desactivar()
		return
	Eventos.emit_signal("cambio_energia_escudo",energia_original, energia)

func controlar_colisionador(esta_desactivado: bool)-> void:
	$CollisionShape2D.set_deferred("disabled", esta_desactivado)
	
func activar()-> void:
	if energia <=0.0:
		return
	
	esta_activado=true
	controlar_colisionador(false)
	$AnimationPlayer.play("activandose")
	
#Señales Internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "activandose" and esta_activado:
		$AnimationPlayer.play("activado")
		set_process(true)


func _on_body_entered(body: Node) -> void:
	body.queue_free()
