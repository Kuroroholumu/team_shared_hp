# === 体力を回復 ===

# 回復方法
#   max_health を targetHealth に一時設定 -> HPが最大まで満たされる
#   次の tick で max_health がリセットされる

# targetHealth = #SH_$(team) の sharedHealth

$scoreboard players operation @s targetHealth = #SH_$(team) sharedHealth

# スコアボードの値を実体力値に変換して team_shared_hp:temp に格納
#    double 0.1 -> スコア値を 0.1 倍して double 型として保存 (例: 200 -> 20.0d )
execute store result storage team_shared_hp:temp amount double 0.1 run scoreboard players get @s targetHealth

# わーい
function team_shared_hp:heal/do_heal with storage team_shared_hp:temp
