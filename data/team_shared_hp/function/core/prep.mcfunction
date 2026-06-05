# === 前処理 ===

# 全プレイヤーの現在体力をNBTからスコアボードにコピー
#   gethealth は Health を 10 倍して保存する (例: 19.5 -> 195, 20.0 -> 200)

execute as @a run function team_shared_hp:core/gethealth

# 初参加プレイヤー (firstJoinの値が1ではない) に leftGame=1 を設定

#   理由: 初参加プレイヤーが自分の体力を .teamHP に上書きするのを防ぐ (ログイン直後のHPでチーム共有値が書き換えられないようにするため)
#         leftGame=1 の間は process_team 内で canChangeHealth タグが付与されず、.teamHP への書き込みが遮断される (チームからの同期は受ける)

execute as @a unless score @s firstJoin matches 1.. run scoreboard players set @s leftGame 1

# 初参加プレイヤーに firstJoin=1 を付与 (次tickからは初参加ではなくなる)
#   これにより next tick では leftGame=1 に設定されず、.teamHP 同期に参加できる

execute as @a unless score @s firstJoin matches 1.. run scoreboard players set @s firstJoin 1

# 全プレイヤーの最大体力を 20 にリセット

#   理由: 前tickの heal 同期 (do_heal) で max_health がチーム共有値 (例: 12.5) に変更されている可能性がある。
#         毎tick 20 に戻す。プレーヤーの現在体力 (Health) は変更されない。

execute as @a run attribute @s minecraft:max_health base set 20

# awaitingRespawn 初期化
#   ここは add 、reset はだめ
#   reset はすでに team_shared_hp:core/process_team 内処理済み

scoreboard players add @a awaitingRespawn 0
