# === メインループ ===

# フェーズ 1
#   準備段階

function team_shared_hp:core/prep

# フェーズ 2
#   スペシャルエフェクト共有

function team_shared_hp:effects/share_effects {team: "red"}
function team_shared_hp:effects/share_effects {team: "blue"}

# フェーズ 3
#   共有体力の同期

function team_shared_hp:core/process_team {team: "red"}
function team_shared_hp:core/process_team {team: "blue"}

# フェーズ 4
#   一時タグの削除

function team_shared_hp:core/cleanup

# ======
execute if score #DEBUG logTrigger matches 1 run say tick OK
# ======

# Turn off
scoreboard players set #DEBUG logTrigger 0
