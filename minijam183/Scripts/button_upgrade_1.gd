extends Button

@onready var upgrade_description_popup: RichTextLabel = $UpgradeDescription_popup

func change_description(description):
		upgrade_description_popup.text = description

func _on_mouse_entered() -> void:
	upgrade_description_popup.visible = true

func _on_mouse_exited() -> void:
	upgrade_description_popup.visible = false
