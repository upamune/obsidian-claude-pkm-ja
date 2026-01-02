---
name: obsidian-vault-ops
description: Obsidian vaultファイルの読み書き、wikiリンクの管理、YAMLフロントマター付きマークダウンの処理。vaultファイル操作、ノート作成、リンク管理の際に使用します。
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Obsidian Vault操作スキル

Obsidian vault内のファイルの読み取り、書き込み、管理のためのコア操作。

## Vault構造

```
vault-root/
├── CLAUDE.md           # メインコンテキスト（常に最初に読む）
├── Daily Notes/        # YYYY-MM-DD.md形式
├── Goals/              # 目標カスケードファイル
├── Projects/           # CLAUDE.md付きプロジェクトフォルダ
├── Templates/          # 再利用可能なノート構造
└── Archives/           # 完了/非アクティブコンテンツ
```

## ファイル操作

### ノートの読み取り
- Globでファイルを検索：`*.md`、`Daily Notes/*.md`
- vaultコンテキストのためにまずCLAUDE.mdを読む
- 関連ノートへのwikiリンクをチェック

### ノートの作成
1. ノートがすでに存在するかチェック
2. 利用可能な場合は適切なテンプレートを使用
3. 日付とタグを含むYAMLフロントマターを追加
4. 関連ノートへのwikiリンクを挿入

### ノートの編集
- YAMLフロントマター構造を保持
- 既存のwikiリンクを維持
- 一貫した見出し階層を使用
- 標準タグ形式を適用

## WikiリンクUSD形式

```markdown
[[ノート名]]                    # シンプルなリンク
[[ノート名|表示テキスト]]       # エイリアス付きリンク
[[ノート名#セクション]]         # セクションへのリンク
```

## YAMLフロントマター

標準的なフロントマター構造：
```yaml
---
date: 2024-01-15
tags: [tag1, tag2]
status: active
---
```

## テンプレート変数

テンプレートを処理する際に置換：
- `{{date}}` - 今日の日付（YYYY-MM-DD）
- `{{date:format}}` - フォーマットされた日付
- `{{date-1}}` - 昨日
- `{{date+1}}` - 明日
- `{{time}}` - 現在時刻

## 一般的なパターン

### デイリーノート作成
1. YYYY-MM-DD形式で今日の日付を計算
2. `Daily Notes/{date}.md`が存在するかチェック
3. 存在しない場合、`Templates/Daily Template.md`を読む
4. テンプレート変数を置換
5. `Daily Notes/{date}.md`に書き込み

### 関連ノートの検索
1. 現在のノートから重要な用語を抽出
2. マッチングコンテンツをvaultで検索
3. 関連ノートへのwikiリンクを提案

### タグ操作
- 優先度：`#priority/high`、`#priority/medium`、`#priority/low`
- ステータス：`#active`、`#waiting`、`#completed`、`#archived`
- コンテキスト：`#work`、`#personal`、`#health`、`#learning`

## ベストプラクティス

1. vault固有の規約については常にCLAUDE.mdをチェック
2. 編集時に既存の構造を保持
3. 内部リンクには相対パスを使用
4. 新しいノートにフロントマターを追加
5. タスクを作成する際は関連する目標にリンク
