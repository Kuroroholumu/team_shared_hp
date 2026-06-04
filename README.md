# team_shared_hp

マインクラフトチーム共通体力データパック

## 機能

red / blue 2 チームに対応。

チーム内の全員が体力を共有する。
金リンゴ・エンチャント金リンゴ・不死のトーテムの回復以外の効果もチーム全体に付与する。

### 1 tick 内 複数のプレーヤーが体力変動した場合

稀だが、実行順で最後に処理されたプレイヤーの体力が `sharedHealth` になる。

### scoreboard 一覧

| Objective | Criterion | 用途 |
|---|---|---|
| `firstJoin` | `dummy` | 初参加検出 |
| `leftGame` | `minecraft.custom:leave_game` | 再ログイン検出 |
| `health` | `dummy` | プレイヤー体力 x10 |
| `sharedHealth` | `dummy` | チーム共有体力 x10 |
| `healthDifference` | `dummy` | ダメージ差分計算用 |
| `targetHealth` | `dummy` | 回復目標値 |
| `deathDetected` | `deathCount` | 死亡検出 |
| `awaitingRespawn` | `deathCount` | リスポーン待機 |
| `usedGoldenApple` | `minecraft.used:golden_apple` | 金リンゴ使用 |
| `usedEnchantedGoldenApple` | `minecraft.used:enchanted_golden_apple` | エンチャント金リンゴ使用 |
| `usedTotemOfUndying` | `minecraft.used:totem_of_undying` | 不死のトーテム使用 |
| `logTrigger` | `dummy` | tick log 一回限りトリガー |

### function 構成

```
function/
├── load.mcfunction
├── tick.mcfunction
├── core/
│   ├── prep.mcfunction
│   ├── gethealth.mcfunction
│   ├── process_team.mcfunction
│   ├── synchealth.mcfunction
│   └── cleanup.mcfunction
├── damage/
│   ├── apply_damage.mcfunction
│   └── do_damage.mcfunction
├── heal/
│   ├── apply_heal.mcfunction
│   └── do_heal.mcfunction
├── effects/
│   └── share_effects.mcfunction
└── debug/
    └── reset.mcfunction
```

\#ふじにゃま
