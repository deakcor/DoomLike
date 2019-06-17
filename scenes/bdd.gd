extends Node

var weapons=[
{"name":"Fist","bullet_id":0,"fire_rate":0.2,"max_bullet":-1,"reload_time":1,"auto":true,"second_fire":-1,"extra":{"idbullet":1},"anim":preload("res://sprites/weapons/melee_anim.tres")},
{"name":"Revolver","bullet_id":1,"fire_rate":0.5,"max_bullet":6,"reload_time":1.3,"auto":false,"second_fire":0,"extra":{"idbullet":1,"fire_rate":1},"anim":preload("res://sprites/weapons/revolver_anim.tres")},
{"name":"Rifle","bullet_id":1,"fire_rate":0.1,"max_bullet":30,"reload_time":2,"auto":true,"second_fire":0,"extra":{},"anim":preload("res://sprites/weapons/rifle_anim.tres")},
{"name":"Light minigun","bullet_id":1,"fire_rate":0.1,"max_bullet":50,"reload_time":2.1,"auto":true,"second_fire":0,"extra":{},"anim":preload("res://sprites/weapons/lightminigun_anim.tres")}
]

var bullets=[
{"name":"fist","dmg":1,"speed":-3,"time":0.4,"anim":preload("res://sprites/effects/effect_melee.tres")},
{"name":"9mm","dmg":1,"speed":200,"time":1,"anim":preload("res://sprites/effects/effect_rifle.tres")},
{"name":"7mm","dmg":2,"speed":200,"time":1,"anim":preload("res://sprites/effects/effect_rifle.tres")},
{"name":"fire","dmg":1,"speed":50,"time":5,"anim":preload("res://sprites/effects/effect_fire.tres")}
]

var ennemis=[
{"name":"","detect_area":50,"atk_area":20,"cadence":0.5,"vie":3,"speed":10,"idbullet":3,"anim":preload("res://sprites/ennemi/afrit.tres")}
]

var pickup=[
{},
{"anim":preload("res://sprites/weapons/pistol/RVICA0.png")},
{"anim":preload("res://sprites/weapons/rifle/RIFLA0.png")},
{"anim":preload("res://sprites/weapons/light minigun/pickup/LMGLZ0.png")}
]
