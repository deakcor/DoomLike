extends Node

var weapons=[
{"name":"Fist","bullet_id":0,"fire_rate":0.2,"max_bullet":-1,"reload_time":1,"auto":true,"second_fire":-1,"extra":{"idbullet":1},"anim":preload("res://sprites/weapons/melee_anim.tres")},
{"name":"Revolver","bullet_id":1,"fire_rate":0.5,"max_bullet":6,"reload_time":1.3,"auto":false,"second_fire":0,"extra":{"idbullet":2,"fire_rate":1},"anim":preload("res://sprites/weapons/revolver_anim.tres")},
{"name":"Rifle","bullet_id":1,"fire_rate":0.1,"max_bullet":30,"reload_time":2,"auto":true,"second_fire":0,"extra":{},"anim":preload("res://sprites/weapons/rifle_anim.tres")},
{"name":"Light minigun","bullet_id":2,"fire_rate":0.1,"max_bullet":50,"reload_time":2.1,"auto":true,"second_fire":0,"extra":{},"anim":preload("res://sprites/weapons/lightminigun_anim.tres")},
{"name":"Plasma","bullet_id":4,"fire_rate":0.1,"max_bullet":10000,"reload_time":0.1,"auto":true,"second_fire":0,"extra":{"idbullet":5,"fire_rate":1},"anim":preload("res://sprites/weapons/plasma.tres")}
]

var bullets=[
{"name":"fist","dmg":1,"speed":-3,"time":0.4,"anim":preload("res://sprites/effects/effect_melee.tres"),"sound":preload("res://sounds/DSPUNCH.wav")},
{"name":"9mm","dmg":1,"speed":200,"time":1,"anim":preload("res://sprites/effects/effect_rifle.tres"),"sound":preload("res://sounds/DSPISTOL.wav")},
{"name":"7mm","dmg":2,"speed":200,"time":1,"anim":preload("res://sprites/effects/effect_rifle.tres"),"sound":preload("res://sounds/DSSHOTGN.wav")},
{"name":"fire","dmg":1,"speed":50,"time":5,"anim":preload("res://sprites/effects/effect_fire.tres"),"sound":preload("res://sounds/bouledefeu.wav")},
{"name":"plasma","dmg":2,"speed":100,"time":2,"anim":preload("res://sprites/effects/plasma.tres"),"sound":preload("res://sounds/DSPLASMA.wav")},
{"name":"giga plasma","dmg":4,"speed":50,"time":5,"anim":preload("res://sprites/effects/plasma2.tres"),"sound":preload("res://sounds/DSPLASMA.wav")},
{"name":"gigafire","dmg":4,"speed":25,"time":10,"anim":preload("res://sprites/effects/gigafire.tres"),"sound":preload("res://sounds/gigabouledefeu.wav")}
]

var ennemis=[
{"name":"Afrit","light":true,"detect_area":50,"atk_area":20,"cadence":0.5,"vie":4,"speed":10,"idbullet":3,"anim":preload("res://sprites/ennemi/afrit.tres")},
{"name":"Zombie","light":false,"detect_area":50,"atk_area":2,"cadence":0.1,"vie":2,"speed":20,"idbullet":0,"anim":preload("res://sprites/ennemi/zombie.tres")},
{"name":"Dark imp","light":false,"detect_area":50,"atk_area":30,"cadence":0.5,"vie":3,"speed":5,"idbullet":5,"anim":preload("res://sprites/ennemi/darkimp.tres")},
{"name":"Pyro baron","light":true,"detect_area":100,"atk_area":100,"cadence":1,"vie":20,"speed":5,"idbullet":6,"anim":preload("res://sprites/ennemi/pyrobaron.tres")}
]

var pickup=[
{},
{"anim":preload("res://sprites/weapons/pistol/RVICA0.png"),"anim2":preload("res://sprites/items/equipement/AMOKA0.png")},
{"anim":preload("res://sprites/weapons/rifle/RIFLA0.png"),"anim2":preload("res://sprites/items/equipement/9TCKA0.png")},
{"anim":preload("res://sprites/weapons/light minigun/pickup/LMGLZ0.png"),"anim2":preload("res://sprites/items/equipement/9TCKA0.png")},
{"anim":preload("res://sprites/weapons/plasma/0P1LA0.png"),"anim2":preload("res://sprites/items/equipement/CELLA0.png")}
]
