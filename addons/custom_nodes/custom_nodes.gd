tool
extends EditorPlugin

func _enter_tree():
    add_custom_type("Brick2D", "StaticBody2D", preload("brick2d/brick2d.gd"), preload("brick2d/brick2d.png"))

func _exit_tree():
    remove_custom_type("Brick2D")
