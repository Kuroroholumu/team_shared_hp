# === プレイヤーの体力を NBT からスコアボードに読み取る ===

execute store result score @s health run data get entity @s Health 10

# data get entity @s Health 10
#   Health の 10 倍
