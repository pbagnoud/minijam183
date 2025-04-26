class_name upgrades
extends Resource

var upgrades_list = [{"Name":"Damage+","Id":"damage+", "Description":"Hits harder", "rarity":"common"},	
	{"Name":"Reload+","Id":"reload+", "Description":"Faster reload",  "rarity":"common"},
	{"Name":"Triple Shot","Id":"triple", "Description":"Fires two additional shots", "rarity":"rare"},
	{"Name":"Paint Balls","Id":"paint", "Description":"Changes color of hit enemies", "rarity":"medium"},
	{"Name":"Fire Bullets","Id":"fire", "Description":"Sets enemies on fire, dealing damage over time", "rarity":"medium"}
	]

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init():
	pass
