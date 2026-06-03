# === データパック初期化 ===

# チームを作成 (既に存在する場合は何もしない) 
#   プレイヤーは /team join red または /team join blue で参加する

team add red
team add blue

# firstJoin :
#   初参加プレイヤーを検出するためのフラグ (ダミー型) 
#   値がない = 初参加、値が 1 = 参加済み

scoreboard objectives add firstJoin dummy

# leftGame :
#   ゲームを退出したかどうか (minecraft.custom:leave_gameは退出時に自動+1) 
#   退出中や初参加のプレイヤーは #SH を上書きしないようにする

scoreboard objectives add leftGame minecraft.custom:leave_game

# ======

# スコアボードは整数しか扱えないため
#   体力関連のスコアボードはすべて Health×10 の整数値で保持される
#   例: 実際の体力 20.0 -> 200 / 19.5 -> 195
#   体力 0.5 単位の精度を保ったまま整数演算が可能

# health :
#   各プレイヤーの現在体力 (gethealthで毎tick更新) 

scoreboard objectives add health dummy

# sharedHealth :
#   チームの共有体力 (#SH_red | #SH_blue) 
#   同じスコアボードで、異なる仮想プレイヤー名 (#SH_red | #SH_blue) でチームを区別する

scoreboard objectives add sharedHealth dummy

# healthDifference :
#   体力差の計算に使う一時変数

scoreboard objectives add healthDifference dummy

# targetHealth :
#   回復後の目標体力値 (apply_healで使用) 

scoreboard objectives add targetHealth dummy

# ======

# deathDetected :
#   死亡を検出 (deathCountは死亡時に自動+1) 
#   値が 1 以上 = このtickで死亡が発生

scoreboard objectives add deathDetected deathCount

# awaitingRespawn :
#   死亡〜リスポーン直後の状態 (deathCountで自動+1) 
#   この状態のプレイヤーは #SH への書き込みを遮断される

scoreboard objectives add awaitingRespawn deathCount

# ======

# usedGoldenApple :
#   金リンゴを使用したか (minecraft.usedは使用時に自動+1) 

scoreboard objectives add usedGoldenApple minecraft.used:golden_apple

# usedEnchantedGoldenApple :
#   エンチャント金リンゴを使用したか

scoreboard objectives add usedEnchantedGoldenApple minecraft.used:enchanted_golden_apple

# usedTotemOfUndying :
#   不死のトーテムが発動したか

scoreboard objectives add usedTotemOfUndying minecraft.used:totem_of_undying
