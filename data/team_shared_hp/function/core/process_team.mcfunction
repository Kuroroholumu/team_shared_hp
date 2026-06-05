# === チーム共有体力のメイン処理 ===

# $(team) = チーム名

# 各チーム:
#      .teamHP_$(team)    チームの現在の共有体力値
#   #deathFlag_$(team)    処理状態フラグ (死亡検出の重複防止用 )

# 死亡検出 - 後始末
#   前tickで死亡処理済みで、まだ deathDetected が残っている場合に一括リセット

#   条件 1
#      $(team) 内 #deathFlag_$(team) の deathDetected >= 1
#   条件 2
#      $(team) 内 だれか の deathDetected >= 1
#   結果
#      死亡を発生した $(team) 内 プレーヤー の deathDetected をリセット

$execute if score #deathFlag_$(team) deathDetected matches 1.. if entity @a[team=$(team),scores={deathDetected=1..}] run scoreboard players reset @a[team=$(team)] deathDetected

# 死亡検出 - フラグ初期化
#   ここで $(team) 内 #deathFlag_$(team) の deathDetected をリセット

$scoreboard players set #deathFlag_$(team) deathDetected 0

# 死亡検出 - 初回検出
#   プレイヤーが死亡 かつ まだ処理していない場合、.teamHP を 0 に設定 -> 後続の synchealth でチーム全員の体力が0になる

#   条件 1
#      $(team) 内 だれか の deathDetected >= 1 (やられた)
#   条件 2
#      #deathFlag_$(team) の deathDetected >= 1 ではない (チーム全滅イベントをまだ処理していない)
#   結果
#      $(team) 内 .teamHP_$(team) の sharedHealth が 0 になる

$execute if entity @a[team=$(team),scores={deathDetected=1..}] unless score #deathFlag_$(team) deathDetected matches 1.. run scoreboard players set .teamHP_$(team) sharedHealth 0

# 死亡検出 - 処理済み

#   ⇑と同じ条件で結果
#      $(team) 内 #deathFlag_$(team) の deathDetected が 1 になる

$execute if entity @a[team=$(team),scores={deathDetected=1..}] unless score #deathFlag_$(team) deathDetected matches 1.. run scoreboard players set #deathFlag_$(team) deathDetected 1

# ======

# チーム初期化 (初回起動時のみ)

#   条件
#      $(team) 内 #deathFlag_$(team) の firstJoin が 1 ではない

$execute unless score #deathFlag_$(team) firstJoin matches 1 run function team_shared_hp:core/teaminit {team: "$(team)"}

# ======

# 書き込み権限

#   条件 1
#       leftGame < 1 (退出していない、初参加ではない)
#   条件 2
#       awaitingRespawn = 0 (リスポーン待ちではない)
#   結果
#       条件をすべて満たすプレイヤーにタグ canChangeHealth を付与

$execute as @a[team=$(team)] unless score @s leftGame matches 1.. unless score @s awaitingRespawn matches 1.. run tag @s add canChangeHealth

# 書き込み権限の判定 - 全滅イベント

#   条件
#      $(team) 内 awaitingRespawn < 1 のプレーヤーが一人にもいない（誰にもリスポーンしていない時）
#   結果
#      $(team) 内 リスポーン待ちのすべてのプレーヤーに canChangeHealth を付与して、最初にリスポーンしたものの体力がチームの .teamHP になる

$execute unless entity @a[team=$(team),scores={awaitingRespawn=..0}] run tag @a[team=$(team),scores={awaitingRespawn=1..}] add canChangeHealth

# ======

# 体力変動の検出

#   ターゲット
#       $(team) 内 canChangeHealth のプレーヤー
#   条件
#       このプレーヤーの体力 health が .teamHP の sharedHealth と異なる
#   結果
#       条件をすべて満たすプレイヤーにタグ changeHealth を付与

$execute as @a[tag=canChangeHealth,team=$(team)] unless score @s health = .teamHP_$(team) sharedHealth run tag @s add changeHealth

# tick 内体力変動の定義

#   チーム内各のプレーヤーが受けた回復量の中の最大値
#       .maxHeal_$(team)
#   チーム内各のプレーヤーが受けたダメージの中の最大値
#       .maxDama_$(team)
#
#   体力変動 = .maxHeal_$(team) + .maxDama_$(team)

$scoreboard players set .maxHeal_$(team) healthDifference 0
$scoreboard players set .maxDama_$(team) healthDifference 0

# 体力変動の処理

#   ターゲット
#       $(team) 内 changeHealth のプレーヤー
#   結果
#       team_shared_hp:core/getmax を呼び出す

$execute as @a[tag=changeHealth,team=$(team)] run function team_shared_hp:core/getmax {team: "$(team)"}

# 共有体力 .teamHP sharedHealth のアップデート

$scoreboard players operation .teamHP_$(team) sharedHealth += .maxHeal_$(team) healthDifference
$scoreboard players operation .teamHP_$(team) sharedHealth += .maxDama_$(team) healthDifference

# チーム内体力同期化
#    チーム全員に対して team_shared_hp:core/synchealth を実行

$execute as @a[team=$(team)] run function team_shared_hp:core/synchealth {team: "$(team)"}

# ======

# チーム全員の deathDetected をリセット
$scoreboard players reset @a[team=$(team)] deathDetected

# リスポーンの処理
#   体力が .teamHP と一致したら awaitingRespawn をリセット
$execute as @e[type=player,team=$(team)] if score @s health = .teamHP_$(team) sharedHealth run scoreboard players reset @s awaitingRespawn

# 再ログインの処理
#   体力が .teamHP と一致したら leftGame をリセット
$execute as @a[team=$(team),scores={leftGame=1..}] if score @s health = .teamHP_$(team) sharedHealth run scoreboard players reset @s leftGame
