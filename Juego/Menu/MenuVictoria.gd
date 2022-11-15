extends Node


func _ready() -> void:
	#OS.set_window_fullscreen(true)
	MusicaJuego.play_musica(MusicaJuego.get_lista_musicas().menu_principal)



func _on_BotonSalir_pressed() -> void:
	get_tree().quit()
