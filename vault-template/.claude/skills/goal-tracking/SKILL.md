---
name: goal-tracking
description: Track progress toward 3-year, yearly, monthly, and weekly goals. Calculate completion percentages, surface stalled goals, connect daily tasks to objectives. Use for goal reviews and progress tracking.
allowed-tools: Read, Grep, Glob, Edit, TaskCreate, TaskUpdate, TaskList, TaskGet
---

# 目標トラッキングスキル

長期ビジョンから日々のタスクまでのカスケード目標システムを追跡・管理します。

## 目標階層

```
Goals/0. Three Year Goals.md   <- ビジョン（ライフエリア）
    ↓
Goals/1. Yearly Goals.md       <- 年間目標
    ↓
Goals/2. Monthly Goals.md      <- 今月のフォーカス
    ↓
Goals/3. Weekly Review.md      <- 週次計画
    ↓
Daily Notes/*.md               <- デイリータスクとアクション
```

## 目標ファイル形式

### 3年目標
```markdown
## ライフエリア
- キャリア：[ビジョンステートメント]
- 健康：[ビジョンステートメント]
- 人間関係：[ビジョンステートメント]
- 金融：[ビジョンステートメント]
- 学習：[ビジョンステートメント]
- 個人：[ビジョンステートメント]
```

### 年間目標
```markdown
## 2024年の目標
- [ ] 目標1（XX%完了）
- [ ] 目標2（XX%完了）
- [x] 目標3（100%完了）
```

### 月次目標
```markdown
## 今月のフォーカス
1. **主要：** [メインフォーカス]
2. **副次的：** [サポート目標]
3. **ストレッチ：** [時間があれば]

### 主要結果
- [ ] 測定可能な成果1
- [ ] 測定可能な成果2
```

## 進捗計算

### チェックリストベースの目標
```
進捗 = （完了したチェックボックス / 全チェックボックス） * 100
```

### メトリックベースの目標
```
進捗 = （現在の値 / 目標値） * 100
```

### 時間ベースの目標
```
進捗 = （経過日数 / 全日数） * 100
```

## 一般的な操作

### 目標進捗の表示
1. すべての目標ファイルを読む
2. チェックボックスの完了率を解析
3. 全体および目標ごとの進捗を計算
4. 停滞またはリスクのある目標を特定

### 目標ステータスの更新
1. 適切なファイルで目標を検索
2. チェックボックスまたは進捗率を更新
3. 重要なマイルストーンに日付スタンプを追加
4. 関連する週次レビューを更新

### タスクを目標に接続
デイリーノートにタスクを追加する際：
1. タスクがサポートする目標を特定
2. 目標参照を追加：`サポート: [[1. Yearly Goals#目標名]]`
3. 適切な優先度タグを使用

### 停滞している目標を表示
1. 各目標の最終活動日をチェック
2. 14日以上進捗がない目標をフラグ
3. 勢いを再開するアクションを提案

## 進捗レポート形式

```markdown
## 目標進捗レポート

### 全体：XX%

### 目標別
| 目標 | 進捗 | 最終活動 | ステータス |
|------|----------|---------------|--------|
| 目標1 | 75% | 2日前 | 順調 |
| 目標2 | 30% | 14日前 | 停滞 |

### 今週の貢献
- [タスク] -> [[目標1]]
- [タスク] -> [[目標2]]

### 推奨フォーカス
1. [停滞している目標は注意が必要]
2. [ほぼ完了の目標 - 完了させる]
```

## Task-Based Progress Tracking

The goal tracking skill uses session tasks when generating comprehensive progress reports.

### Progress Report Tasks

Create tasks at skill start:

```
TaskCreate:
  subject: "Read three-year goals"
  description: "Load vision statements from Goals/0. Three Year Goals.md"
  activeForm: "Reading three-year goals..."

TaskCreate:
  subject: "Read yearly goals"
  description: "Load annual objectives from Goals/1. Yearly Goals.md"
  activeForm: "Reading yearly goals..."

TaskCreate:
  subject: "Read monthly goals"
  description: "Load current month focus from Goals/2. Monthly Goals.md"
  activeForm: "Reading monthly goals..."

TaskCreate:
  subject: "Scan recent daily notes"
  description: "Find task completions and goal contributions from past week"
  activeForm: "Scanning recent daily notes..."

TaskCreate:
  subject: "Calculate completion percentages"
  description: "Compute progress for each goal based on checkboxes and metrics"
  activeForm: "Calculating completion percentages..."

TaskCreate:
  subject: "Identify stalled goals"
  description: "Flag goals with no progress in 14+ days"
  activeForm: "Identifying stalled goals..."
```

### Dependencies

Goal file reads can run in parallel, but analysis depends on having all data:
```
TaskUpdate: "Scan recent daily notes", addBlockedBy: [read-monthly-goals-id]
TaskUpdate: "Calculate completion percentages", addBlockedBy: [scan-recent-daily-notes-id]
TaskUpdate: "Identify stalled goals", addBlockedBy: [calculate-completion-percentages-id]
```

Mark each task `in_progress` when starting, `completed` when done using TaskUpdate.

Task tools are session-scoped and don't persist—your actual goal progress is tracked through markdown checkboxes and percentages in your goal files.

## Integration Points

- 週次レビュー：完全な進捗評価
- 日次計画：関連する目標を表示
- 月次レビュー：必要に応じて目標を調整
- 四半期レビュー：3年ビジョンからカスケード
