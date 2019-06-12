extends Node

var weapons=[
{"name":"Fist","bullet_id":0,"fire_rate":0.2,"max_bullet":-1,"reload_time":1,"auto":true,"second_fire":-1,"extra":[],"anim":preload("res://sprites/weapons/melee_anim.tres")},
{"name":"Rifle","bullet_id":1,"fire_rate":0.1,"max_bullet":30,"reload_time":2,"auto":true,"second_fire":0,"extra":[],"anim":preload("res://sprites/weapons/rifle_anim.tres")}
]

var bullets=[
{"name":"","speed":-3,"time":0.4,"anim":preload("res://sprites/effects/effect_melee.tres")},
{"name":"","speed":200,"time":1,"anim":preload("res://sprites/effects/effect_rifle.tres")}
]
