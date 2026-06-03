# === アイテム使用効果をチーム全体に共有 ===

# 再生効果は同期しません

# 金リンゴ

# 衝撃吸収 I 120秒
$execute if entity @a[team=$(team),scores={usedGoldenApple=1..}] run effect give @a[team=$(team)] absorption 120 0
# リセット
$scoreboard players reset @a[team=$(team)] usedGoldenApple

# エンチャント金リンゴ

# 衝撃吸収IV 120秒
$execute if entity @a[team=$(team),scores={usedEnchantedGoldenApple=1..}] run effect give @a[team=$(team)] absorption 120 3
# 耐火 300秒
$execute if entity @a[team=$(team),scores={usedEnchantedGoldenApple=1..}] run effect give @a[team=$(team)] fire_resistance 300
# 耐性 300秒
$execute if entity @a[team=$(team),scores={usedEnchantedGoldenApple=1..}] run effect give @a[team=$(team)] resistance 300
# リセット
$scoreboard players reset @a[team=$(team)] usedEnchantedGoldenApple

# 不死のトーテム
#   トーテム発動 -> HP=1 -> #SH=1 -> チーム全員HP=1

# 衝撃吸収 II 5秒
$execute if entity @a[team=$(team),scores={usedTotemOfUndying=1..}] run effect give @a[team=$(team)] absorption 5 1
# 耐火 40秒
$execute if entity @a[team=$(team),scores={usedTotemOfUndying=1..}] run effect give @a[team=$(team)] fire_resistance 40
# リセット
$scoreboard players reset @a[team=$(team)] usedTotemOfUndying
