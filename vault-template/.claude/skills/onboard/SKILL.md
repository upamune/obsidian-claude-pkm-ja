---
name: onboard
description: VaultからCLAUDE.mdコンテキストファイルを読み込み、包括的な理解を提供します。階層的なコンテキスト、最近のノート、プロジェクト状態を発見します。セッション開始時、またはClaudeがVault全体のコンテキストを必要とする際に使用します。
allowed-tools: Read, Glob, Grep
user-invocable: true
---

# Onboard スキル

Vaultからすべての CLAUDE.md ファイルを読み込み、インテリジェントなアシスタンスのための包括的なコンテキストを提供します。

## 使い方

`/onboard` で呼び出すか、ClaudeにVaultについて学ぶように依頼します。

### 完全なコンテキスト読み込み
```
/onboard
```

### 特定のプロジェクトコンテキスト
```
/onboard Projects/MyProject
```

## このスキルが行うこと

1. **コンテキストファイルの発見**
   - すべての CLAUDE.md ファイルを検索
   - プロジェクトディレクトリを走査
   - 深さ制限を尊重

2. **階層的なコンテキストの読み込み**
   - ルート CLAUDE.md を最初に（グローバルコンテキスト）
   - プロジェクト固有の CLAUDE.md ファイル
   - 現在の状態を把握するための最近のデイリーノート

3. **理解の構築**
   - あなたの個人的なミッション/目標
   - プロジェクトの構造とステータス
   - ワークフローの設定
   - カスタム規約

## コンテキスト階層

```
vault/
├── CLAUDE.md                 # [1] グローバルコンテキスト - 最初に読み込み
├── Projects/
│   ├── Project A/
│   │   └── CLAUDE.md         # [2] プロジェクトコンテキスト
│   └── Project B/
│       └── CLAUDE.md         # [3] 別のプロジェクトコンテキスト
└── Areas/
    └── Health/
        └── CLAUDE.md         # [4] エリア固有のコンテキスト
```

## CLAUDE.md ファイル構造

### ルート CLAUDE.md に含めるべき内容
```markdown
# System Context for Claude

## Personal Mission
[あなたの人生のミッション/目的]

## Current Focus
[現在取り組んでいること]

## Preferences
- Writing style: [フォーマル/カジュアル/技術的]
- Detail level: [高/中/低]

## Conventions
- File naming: [あなたのパターン]
- Tag system: [あなたのタグ]
```

### プロジェクト CLAUDE.md に含めるべき内容
```markdown
# Project: [名前]

## Overview
[このプロジェクトについて]

## Current Status
[現在の状況]

## Key Decisions
[行われた重要な選択]

## Next Steps
[次に必要なこと]
```

## スマートなコンテキスト読み込み

### 最近のアクティビティ
自動的に考慮される内容：
- 過去7日間のデイリーノート
- 今週のレビュー
- 最近変更されたプロジェクト

### 選択的な読み込み
集中的なアシスタンスのために：
```
/onboard Projects/WebApp      # 特定のプロジェクトのみ
/onboard Goals                # 目標コンテキストのみ
```

## ユースケース

### セッション開始時
```
/onboard
「目標に基づいて今日の計画を立てるのを手伝って」
```

### プロジェクト作業
```
/onboard Projects/MyApp
「認証モジュールのリファクタリングを手伝って」
```

### 週次計画
```
/onboard Goals
「今週を分析して改善提案をして」
```

## コンテキスト変数

CLAUDE.md ファイルには設定を含めることができます：

```markdown
## Variables for Claude
- DEFAULT_LANGUAGE: JavaScript
- TIMEZONE: America/New_York
- COMMUNICATION_STYLE: Direct and concise
```

## ベストプラクティス

### コンテキストを最新に保つ
- CLAUDE.md ファイルを月次でレビュー
- 重要な決定後に更新
- 古い情報を削除
- 新しい学びを追加

### 具体的に記述する
- 明確なプロジェクト説明
- 具体的な設定
- 具体例
- 定義された規約

### 階層的な情報
- グローバル → エリア → プロジェクト → タスク
- 一般的 → 具体的
- 戦略的 → 戦術的

## プライバシーとセキュリティ

### CLAUDE.md に絶対に含めてはいけないもの
- パスワードや認証情報
- 個人識別番号
- 金融口座の詳細
- プライベート API キー

### 安全なコンテキストの例
- 「ヘルステクノロジー分野で働いています」
- 「私のプロジェクトはWeb開発を含みます」
- 「午前中の作業セッションを好みます」

## 統合

次のものと連携：
- すべての他のスキル（コンテキストを提供）
- `/daily` - コンテキストによるより良い日次計画
- `/weekly` - 情報に基づいた週次レビュー
- 目標追跡 - 目標カスケードの理解
