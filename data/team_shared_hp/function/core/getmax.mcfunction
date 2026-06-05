# === プレーヤーの体力変動を集計 ===

scoreboard players operation @s healthDifference = @s health

# 体力変動
$scoreboard players operation @s healthDifference -= .teamHP_$(team) sharedHealth
# 最大値
$scoreboard players operation .maxHeal_$(team) healthDifference > @s healthDifference
# 最小値 | 最大ダメージ
$scoreboard players operation .maxDama_$(team) healthDifference < @s healthDifference
