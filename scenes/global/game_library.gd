extends Node

enum PowerUpType {
	Weapon,
	Passive
}

const POWERUPS = {
	'Pistol': {
		'type': PowerUpType.Weapon,
		'description': 'Basic but reliable weapon, shoots bullets one at a time',
		'icon': preload("res://resources/ui/icons/pistol.png"),
		'scene': preload("res://scenes/powerups/pistol.tscn")
	},
	'Sword and shield': {
		'type': PowerUpType.Weapon,
		'description': 'Slash nearby enermies while an orbiting shield protects you',
		'icon': preload("res://resources/ui/icons/sword.png"),
		'scene': preload("res://scenes/powerups/boomerang.tscn")
	},
	'Boomerang': {
		'type': PowerUpType.Weapon,
		'description': 'Goes back and forth in a straigh line',
		'icon': preload("res://resources/ui/icons/boomerang.png"),
		'scene': preload("res://scenes/powerups/boomerang.tscn")
	},
	'Shotgun': {
		'type': PowerUpType.Weapon,
		'description': 'Blast in a wide arc to the nearest enemy',
		'icon': preload("res://resources/ui/icons/shotgun.png"),
		'scene': preload("res://scenes/powerups/shotgun.tscn")
	},
	'Rocket launcher': {
		'type': PowerUpType.Weapon,
		'description': 'Slow but powerful attack in an area',
		'icon': preload("res://resources/ui/icons/rocketlauncher.png"),
		'scene': preload("res://scenes/powerups/shotgun.tscn")
	},
	'Mjolnir': {
		'type': PowerUpType.Weapon,
		'description': 'Orbits around you hitting enermies and casting down lightning like the god of thunder you are',
		'icon': preload("res://resources/ui/icons/mjolnir.png"),
		'scene': preload("res://scenes/powerups/shotgun.tscn")
	},
	'Antiair bird': {
		'type': PowerUpType.Weapon,
		'description': 'Target airborne enermies and make them bit the dust',
		'icon': preload("res://resources/ui/icons/antiair.png"),
		'scene': preload("res://scenes/powerups/antiair_bird.tscn")
	},
	'Armor': {
		'type': PowerUpType.Passive,
		'description': 'Make yourself harder to kill: HP boost.',
		'icon': preload("res://resources/icon.svg"),
		'levels': {1: 20, 2: 20, 3: 30, 4: 30, 5: 50}
	},
	"Invisibility cloak": {
		'type': PowerUpType.Passive,
		'description': 'Your father left it to you. You are harder to see and enemies tend to fail to hit you.',
		'icon': preload("res://resources/icon.svg"),
		'levels': {1: 5, 2: 15, 3: 25, 4: 35, 5: 50}
	},
	'Bad coffee': {
		'type': PowerUpType.Passive,
		'description': 'Your are getting nervous rather than alert. Well, everything helps. Reduces cooldowns.',
		'icon': preload("res://resources/icon.svg"),
		'levels': {1: 10, 2: 30, 3: 60, 4: 100, 5: 150}
	},
	'Dark Necrogrimoire': {
		'type': PowerUpType.Passive,
		'description': 'Suck the life out of your enermies and onto you. Gross but gets you life steal.',
		'icon': preload("res://resources/icon.svg"),
		'levels': {1: 5, 2: 10, 3: 20, 4: 30, 5: 50}
	},
}
