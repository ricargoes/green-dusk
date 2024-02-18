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
	'Sword': {
		'type': PowerUpType.Weapon,
		'description': 'Slash nearby enermies with a mighty sword.',
		'icon': preload("res://resources/ui/icons/sword.png"),
		'scene': preload("res://scenes/powerups/sword.tscn")
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
	#'Rocket launcher': {
		#'type': PowerUpType.Weapon,
		#'description': 'Slow but powerful attack in an area',
		#'icon': preload("res://resources/ui/icons/rocketlauncher.png"),
		#'scene': preload("res://scenes/powerups/shotgun.tscn")
	#},
	'Mjolnir': {
		'type': PowerUpType.Weapon,
		'description': 'Orbits around you hitting enermies and casting down lightning like the god of thunder you are',
		'icon': preload("res://resources/ui/icons/mjolnir.png"),
		'scene': preload("res://scenes/powerups/mjolnir.tscn")
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
		'icon': preload("res://resources/ui/icons/armour.png"),
		'levels': {1: 50, 2: 100, 3: 170, 4: 250, 5: 350}
	},
	"Invisibility cloak": {
		'type': PowerUpType.Passive,
		'description': 'Your father left it to you. You are harder to see and enemies tend to fail to hit you.',
		'icon': preload("res://resources/ui/icons/cloak.png"),
		'levels': {1: 10, 2: 20, 3: 35, 4: 50, 5: 65}
	},
	'Bad coffee': {
		'type': PowerUpType.Passive,
		'description': 'Your are getting nervous rather than alert. Well, everything helps. Reduces cooldowns.',
		'icon': preload("res://resources/ui/icons/badCoffee.png"),
		'levels': {1: 120, 2: 140, 3: 160, 4: 180, 5: 200}
	},
	'Dark Necrogrimoire': {
		'type': PowerUpType.Passive,
		'description': 'Suck the life out of your enermies and onto you. Gross but gets you life steal.',
		'icon': preload("res://resources/ui/icons/necrogrimorio.png"),
		'levels': {1: 15, 2: 20, 3: 25, 4: 30, 5: 40}
	},
}
