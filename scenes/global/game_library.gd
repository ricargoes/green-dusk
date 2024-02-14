extends Node

enum PowerUpType {
	Weapon,
	Passive
}

const POWERUPS = {
	'Pistol': {
		'type': PowerUpType.Weapon,
		'description': 'Basic but reliable weapon, shoots bullets one at a time',
		'icon': preload("res://resources/icon.svg")
	},
	'Sword and shield': {
		'type': PowerUpType.Weapon,
		'description': 'Slash nearby enermies while an orbiting shield protects you',
		'icon': preload("res://resources/icon.svg")
	},
	'Boomerang': {
		'type': PowerUpType.Weapon,
		'description': 'Goes back and forth in a straigh line',
		'icon': preload("res://resources/icon.svg")
	},
	'Shotgun': {
		'type': PowerUpType.Weapon,
		'description': 'Blast in a wide arc to the nearest enemy',
		'icon': preload("res://resources/icon.svg")
	},
	'Rocket launcher': {
		'type': PowerUpType.Weapon,
		'description': 'Slow but powerful attack in an area',
		'icon': preload("res://resources/icon.svg")
	},
	'Mjolnir': {
		'type': PowerUpType.Weapon,
		'description': 'Orbits around you hitting enermies and casting down lightning like the god of thunder you are',
		'icon': preload("res://resources/icon.svg")
	},
	'Antiair bird': {
		'type': PowerUpType.Weapon,
		'description': 'Target airborne enermies and make them bit the dust',
		'icon': preload("res://resources/icon.svg")
	},
	'Hollow point shells': {
		'type': PowerUpType.Passive,
		'description': 'Your bullets shatter on impact, throwing flak to other enemies.',
		'icon': preload("res://resources/icon.svg")
	},
	'Armor': {
		'type': PowerUpType.Passive,
		'description': 'Make yourself harder to kill: HP boost.',
		'icon': preload("res://resources/icon.svg")
	},
	"Invisibility cloak": {
		'type': PowerUpType.Passive,
		'description': 'Your father left it to you. You are harder to see and enemies tend to fail to hit you.',
		'icon': preload("res://resources/icon.svg")
	},
	'Bad coffee': {
		'type': PowerUpType.Passive,
		'description': 'Your are getting nervous rather than alert. Well, everything helps. Reduces cooldowns.',
		'icon': preload("res://resources/icon.svg")
	},
	'Dark Necrogrimoire': {
		'type': PowerUpType.Passive,
		'description': 'Suck the life out of your enermies and onto you. Gross but gets you life steal.',
		'icon': preload("res://resources/icon.svg")
	},
}
