# Git Push コマンド

意味のあるコミットメッセージでノートを保存し、リモートリポジトリにプッシュするGitワークフローを自動化します。

## インストール

このファイルをvaultルートの`.claude/commands/push.md`にコピーします。

## 使用方法
```
claude code /push
```

またはカスタムメッセージと共に：
```
claude code /push "プロジェクト計画完了"
```

## 設定
これらの設定をカスタマイズします：

```javascript
// 設定
const DEFAULT_REMOTE = "origin";
const DEFAULT_BRANCH = "main";
const AUTO_PULL_FIRST = true; // プッシュ前にプルして競合を避ける
const INCLUDE_TIMESTAMP = true; // コミットメッセージにタイムスタンプを追加
```

## このコマンドが行うこと

1. **すべての変更をステージング**
   - すべての変更されたファイルを追加
   - 新しいファイルを含む
   - 削除されたファイルを削除

2. **スマートなコミットメッセージを作成**
   - 提供されたメッセージを使用、または
   - 変更から自動生成
   - 日付/時刻スタンプを含む
   - 主要な変更を要約

3. **リモートと同期**
   - 最新の変更をプル（有効な場合）
   - リモートリポジトリにプッシュ
   - マージ競合を適切に処理

## コミットメッセージ形式

### 自動メッセージ
変更に基づいて：
```
2024-01-15のデイリーノート + 3つのプロジェクト更新
- 追加: Daily Notes/2024-01-15.md
- 変更: Projects/Learning Spanish/notes.md
- 変更: Goals/2. Monthly Goals.md
```

### タイムスタンプ付き
```
[2024-01-15 09:30] 週次レビュー完了
```

### 手動メッセージ
```
claude code /push "主要なプロジェクトマイルストーンに到達"
```

## スマート機能

### 競合防止
```javascript
// 常にプッシュ前にプル
if (AUTO_PULL_FIRST) {
  git pull --rebase origin main
}
```

### 変更サマリー
変更を分析：
- 追加されたデイリーノート
- 変更されたプロジェクト
- 更新された目標
- 変更されたテンプレート

### 安全性チェック
- Gitリポジトリの存在を確認
- コミットされていない変更をチェック
- リモートが設定されていることを確認
- ブランチが存在することを検証

## ワークフロー統合

### 朝のルーティン
```bash
claude code /daily          # デイリーノートを作成
# ... ノートで作業 ...
claude code /push "朝の計画完了"
```

### 1日の終わり
```bash
# デイリーリフレクションを完了
claude code /push           # サマリー付き自動メッセージ
```

### 週次レビュー後
```bash
claude code /weekly         # 週次レビューを実行
claude code /push "週次レビュー - 第3週"
```

## 高度なオプション

### 複数のリモート
```javascript
// 複数のリモートにプッシュ
const REMOTES = ["origin", "backup"];
REMOTES.forEach(remote => {
  git push remote main
});
```

### ブランチベースのワークフロー
```javascript
// プロジェクト用のフィーチャーブランチを作成
const project = "new-feature";
git checkout -b project
git add .
git commit -m message
git push -u origin project
```

### 自動バックアップ
```javascript
// 自動プッシュをスケジュール
const BACKUP_INTERVAL = 3600000; // 1時間
setInterval(() => {
  git add .
  git commit -m "自動バックアップ"
  git push
}, BACKUP_INTERVAL);
```

## Git設定

### 初期セットアップ
```bash
# リポジトリを初期化
git init

# リモートを追加
git remote add origin https://github.com/username/vault.git

# ユーザー情報を設定
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### 推奨される.gitignore
```
.obsidian/workspace*
.obsidian/cache
.trash/
.DS_Store
```

## コミットメッセージのベストプラクティス

### 良いメッセージ
- ✅ "Q1計画とプロジェクトキックオフ完了"
- ✅ "デイリーノート: 認証のバグ修正"
- ✅ "週次レビュー - 月次目標を調整"

### 避けるべき
- ❌ "更新"
- ❌ "変更"
- ❌ "WIP"

## 競合の処理

競合が発生した場合：

1. **自動解決の試み**
   - ノートのローカル変更を優先
   - 可能な場合は両方のバージョンをマージ

2. **手動解決が必要**
   - 競合マーカーを開く
   - 解決を促す
   - プロセスをガイド

## GitHub経由のモバイル同期

これにより以下が可能になります：
- GitHubモバイルアプリでノートを表示
- タスク用のIssueを作成
- 任意のデバイスで変更をレビュー
- 任意のブラウザから緊急アクセス

## セキュリティに関する考慮事項

### プライベートリポジトリ
個人ノートには常にプライベートリポジトリを使用：
```bash
# GitHub CLI
gh repo create vault --private

# または設定経由
# Repository Settings > Make Private
```

### 機密情報
コミットしてはいけないもの：
- パスワード
- APIキー
- 個人識別情報
- 金融情報

機密ファイルには`.gitignore`を使用：
```
private/
credentials.md
.env
```

## トラブルシューティング

### プッシュが拒否された？
```bash
# まずプル
git pull --rebase origin main
# 再度プッシュ
git push origin main
```

### Gitリポジトリではない？
```bash
# 初期化
git init
# リモートを追加
git remote add origin [URL]
```

### 大きなファイルの問題？
```bash
# 画像/添付ファイルにGit LFSを使用
git lfs track "*.png"
git lfs track "*.pdf"
```

## 関連コマンド
- `/daily` - デイリーノートの作成
- `/weekly` - 週次レビューの実行
- `/onboard` - コンテキストのロード

---

*コマンドバージョン: 1.0*
*要件: Gitがインストールされ設定されていること*

**プロヒント:** 早めに頻繁にコミットしましょう - 未来の自分が感謝します！
