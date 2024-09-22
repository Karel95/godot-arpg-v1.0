extends Control

var isOpen:bool = false

func _ready():
	visible = isOpen


func open():
	visible = true
	isOpen = true
	

func close():
	visible = false
	isOpen = false
	
