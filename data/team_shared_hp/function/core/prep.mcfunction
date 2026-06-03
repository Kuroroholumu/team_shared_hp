# === 前処理 ===

# 全プレイヤーの現在体力をNBTからスコアボードにコピー
# gethealth は Health を 10 倍して保存する (例: 19.5 -> 195, 20.0 -> 200) 

execute as @a run function team_shared_hp:core/gethealth

# 初参加プレイヤー (firstJoinの値が1ではない) に leftGame=1 を設定
#
#   理由: 初参加プレイヤーが自分の体力を #SH に上書きするのを防ぐ
#        (ログイン直後のHPでチーム共有値が書き換えられないようにするため) 
#
#         leftGame=1 の間は process_team 内で canChangeHealth タグが付与されず、
#         #SH への書き込みが遮断される (チームからの同期は受ける) 

execute as @a unless score @s firstJoin matches 1.. run scoreboard players set @s leftGame 1

# 全プレイヤーにfirstJoin=1を付与 (次tickからは初参加ではなくなる) 
# これにより次tickではleftGame=1に設定されず、#SH 同期に参加できる

scoreboard players set @a firstJoin 1

# 全プレイヤーの最大体力を 20 にリセット
#
#   理由: 前tickの heal 同期 (do_heal) で max_health がチーム共有値 (例: 12.5) に変更されている可能性がある。
#         毎tick 20 に戻す。プレーヤーの現在体力 (Health) は変更されない。

execute as @a run attribute @s minecraft:max_health base set 20

# awaitingRespawn 初期化
scoreboard players add @a awaitingRespawn 0
