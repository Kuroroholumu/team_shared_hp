# team_shared_hp

マインクラフトチーム共通体力データパック

## 機能

red / blue 2 チームに対応。

チーム内の全員が体力を共有する。
金リンゴ・エンチャント金リンゴ・不死のトーテムの回復以外の効果もチーム全体に付与する。

### 1 tick 内 複数のプレーヤーが体力変動した場合

各プレーヤーの体力変動 `Δᵢ = healthᵢ − sharedHealth` を集計する。
`ΔHᵢ > 0` は回復、`ΔDᵢ < 0` はダメージ。

- `maxHeal = max(0, ΔH₁, ..., ΔHₙ)` —— MAX体力回復：正の差分の最大値（回復がない場合は 0）
- `maxDama = min(0, ΔD₁, ..., ΔDₙ)` —— MAXダメージ：負の差分の最小値（ダメージがない場合は 0）

この tick 内チームの体力変動は `sharedHealth += maxHeal + maxDama` にする

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
│   ├── teaminit.mcfunction
│   ├── process_team.mcfunction
│   ├── getmax.mcfunction
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
