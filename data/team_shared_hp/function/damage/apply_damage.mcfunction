# === ダメージを食らう ===

# 対象プレーヤーの体力 health をコピーして
#   healthDifference = health

scoreboard players operation @s healthDifference = @s health

# ダメージのを計算
#   healthDifference = healthDifference - sharedHealth

$scoreboard players operation @s healthDifference -= .teamHP_$(team) sharedHealth

# スコアボードの値を実ダメージ量に変換して team_shared_hp:temp に格納
#    double 0.1 -> スコア値を 0.1 倍して double 型として保存 (例: 5 -> 0.5d )
#    これにより team_shared_hp:damage/do_damage の /damage コマンドに小数ダメージを渡せる

execute store result storage team_shared_hp:temp amount double 0.1 run scoreboard players get @s healthDifference

# いたい
function team_shared_hp:damage/do_damage with storage team_shared_hp:temp
