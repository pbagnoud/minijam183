class_name upgrades
extends Resource

var upgrades_list = [{"Name":"Damage+","Id":"damage+", "Description":"Hits harder"},	
	{"Name":"Reload+","Id":"reload+", "Description":"Faster reload"},
	{"Name":"Triple Shot","Id":"triple", "Description":"Fires two additional shots"}
	]

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init():
	pass
