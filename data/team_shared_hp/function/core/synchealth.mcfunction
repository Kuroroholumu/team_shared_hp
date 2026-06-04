# === プレーヤーの体力をチーム共有体力に合わせる ===

# プレーヤーの体力が .teamHP より大きい -> ダメージを食らう
$execute if score @s health > .teamHP_$(team) sharedHealth run function team_shared_hp:damage/apply_damage {team: "$(team)"}
# プレーヤーの体力が .teamHP より小さい -> 回復する
$execute if score @s health < .teamHP_$(team) sharedHealth run function team_shared_hp:heal/apply_heal {team: "$(team)"}
