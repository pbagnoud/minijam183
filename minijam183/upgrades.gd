class_name upgrades
extends Resource

var upgrades_list = [{"Name":"Damage+","Id":"damage+", "Description":"Hits harder", "rarity":"common"},	
	{"Name":"Reload+","Id":"reload+", "Description":"Faster reload",  "rarity":"common"},
	{"Name":"Specialized","Id":"special", "Description":"Deals even more damage to enemies of the tower's color", "rarity":"common"},
	{"Name":"Paint Balls","Id":"paint", "Description":"Changes color of hit enemies", "rarity":"medium"},
	{"Name":"Fire Bullets","Id":"fire", "Description":"Sets enemies on fire, dealing damage over time", "rarity":"medium"},
	{"Name":"Piercing Shot","Id":"pierce", "Description":"Projectiles pierce and hit an additional enemy even harder", "rarity":"medium"},
	{"Name":"Pushing Bullets","Id":"push", "Description":"Hit enemies are pushed back", "rarity":"medium"},
	{"Name":"Freezing Shot","Id":"freeze", "Description":"Hit enemies are slowed for a while", "rarity":"rare"},
	{"Name":"Triple Shot","Id":"triple", "Description":"Fires two additional shots", "rarity":"rare"},
	{"Name":"Sniper","Id":"sniper", "Description":"Very slow reload but enormous damage and very long range", "rarity":"rare"},
	{"Name":"Gatling","Id":"gatling", "Description":"Reduces damage but greatly reduces reload time", "rarity":"rare"},
	{"Name":"The Fifth Tower","Id":"addTower", "Description":"Add a fifth, extremely powerful turret", "rarity":"legendary"},
	]

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
