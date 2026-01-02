# Onboard コマンド

Claude Codeがインテリジェントな支援を提供するために、vaultからすべてのCLAUDE.mdファイルをロードして包括的なコンテキストを提供します。

## インストール

このファイルをvaultルートの`.claude/commands/onboard.md`にコピーします。

## 使用方法
```
claude code /onboard
```

特定のプロジェクトコンテキスト用：
```
claude code /onboard Projects/MyProject
```

## 設定
コンテキストの読み込みをカスタマイズ：

```javascript
// 設定
const CLAUDE_FILE_NAME = "CLAUDE.md";
const MAX_DEPTH = 5; // CLAUDE.mdファイルを検索する深さ
const INCLUDE_TEMPLATES = false; // テンプレートファイルも読み込む
const LOAD_RECENT_NOTES = true; // 過去7日間のデイリーノートを含める
```

## このコマンドが行うこと

1. **コンテキストファイルの発見**
   - すべてのCLAUDE.mdファイルを検索
   - プロジェクトディレクトリを走査
   - 深さの制限を尊重

2. **階層的コンテキストの読み込み**
   - ルートCLAUDE.mdが最初（グローバルコンテキスト）
   - プロジェクト固有のCLAUDE.mdファイル
   - 現在の状態のための最近のデイリーノート

3. **理解の構築**
   - あなたの個人的なミッション/目標
   - プロジェクト構造と状態
   - ワークフローの好み
   - カスタム規約

## コンテキスト階層

```
vault/
├── CLAUDE.md                 # [1] グローバルコンテキスト - 最初に読み込み
├── Projects/
│   ├── Project A/
│   │   └── CLAUDE.md         # [2] プロジェクトコンテキスト - 2番目に読み込み
│   └── Project B/
│       └── CLAUDE.md         # [3] 別のプロジェクトコンテキスト
└── Areas/
    └── Health/
        └── CLAUDE.md         # [4] エリア固有のコンテキスト
```

## CLAUDE.mdファイル構造

### ルートCLAUDE.mdに含めるべき内容
```markdown
# Claudeのためのシステムコンテキスト

## 個人的なミッション
[あなたの人生のミッション/目的]

## 現在のフォーカス
[現在取り組んでいること]

## 好み
- 文体：[フォーマル/カジュアル/技術的]
- 詳細レベル：[高/中/低]
- 意思決定：[協調的/指示的]

## 規約
- ファイル命名：[あなたのパターン]
- タグシステム：[あなたのタグ]
- ワークフロー：[あなたのプロセス]
```

### プロジェクトCLAUDE.mdに含めるべき内容
```markdown
# プロジェクト: [名前]

## 概要
[このプロジェクトについて]

## 現在の状態
[物事がどこにあるか]

## 重要な決定
[行われた重要な選択]

## 次のステップ
[何が起こる必要があるか]

## Claudeのためのコンテキスト
[Claudeが知っておくべき特定の事項]
```

## スマートコンテキスト読み込み

### 最近の活動
自動的に以下を含めます：
```javascript
// 過去7日間のデイリーノート
const recentNotes = getDailyNotes(7);
// 現在の週のレビュー
const weeklyReview = getCurrentWeekReview();
// アクティブなプロジェクトの更新
const activeProjects = getModifiedProjects(3); // 日数
```

### 選択的読み込み
集中的な支援のために：
```bash
# 特定のプロジェクトのみ読み込み
claude code /onboard Projects/WebApp

# 特定のエリアのみ読み込み
claude code /onboard Areas/Health

# 完全なコンテキスト読み込み
claude code /onboard all
```

## ユースケース

### プロジェクト作業
```bash
claude code /onboard Projects/MyApp
claude code "認証モジュールのリファクタリングを手伝って"
```

### 日次計画
```bash
claude code /onboard
claude code "目標をレビューして今日の優先事項を提案して"
```

### 週次レビュー
```bash
claude code /onboard Goals
claude code "今週を分析して改善を提案して"
```

## コンテキスト変数

CLAUDE.mdファイルに変数を含めることができます：

```markdown
## Claudeのための変数
- DEFAULT_LANGUAGE: JavaScript
- TIMEZONE: America/New_York
- WORK_HOURS: 9am-5pm
- PREFERRED_FRAMEWORKS: React, Node.js
- COMMUNICATION_STYLE: 直接的で簡潔
```

Claudeはこれらをより良い支援のために使用します。

## 高度な機能

### 条件付きコンテキスト
```markdown
## 曜日別のコンテキスト
<!-- IF: Monday -->
週次計画と目標設定に焦点を当てる
<!-- IF: Friday -->
レビューとクロージャーに焦点を当てる
<!-- ENDIF -->
```

### プロジェクトテンプレート
```markdown
## 新しいプロジェクトを作成する際
この構造を使用：
1. プロジェクトフォルダを作成
2. CLAUDE.mdを追加
3. 初期ファイルをセットアップ
4. テンプレートからプロジェクトノートを作成
```

### ワークフロートリガー
```markdown
## 自動化されたワークフロー
「朝のルーティン」と言ったとき：
1. デイリーノートを作成
2. 昨日のタスクをレビュー
3. 今日の優先事項を設定
4. カレンダーを確認
```

## パフォーマンス最適化

### 大きなVault
多くのファイルがあるvaultの場合：
```javascript
// コンテキスト読み込みを制限
const OPTIONS = {
  maxFiles: 10,
  maxSizePerFile: 50000, // 文字数
  prioritize: ["Goals", "Active Projects"]
};
```

### キャッシング
コンテキストはセッション用にキャッシュされます：
```javascript
// キャッシュ期間
const CACHE_DURATION = 3600000; // 1時間
// 強制更新
claude code /onboard --refresh
```

## プライバシーとセキュリティ

### 機密情報
CLAUDE.mdに含めてはいけないもの：
- パスワードや認証情報
- 個人識別番号
- 金融口座の詳細
- 個人的なプライベート情報

### 安全なコンテキストの例
✅ "私はヘルスケア技術で働いています"
✅ "私のプロジェクトはWeb開発に関係しています"
✅ "朝の作業セッションを好みます"

❌ "私のSSNは..."
❌ "私の銀行口座..."
❌ "私のプライベートAPIキー..."

## ベストプラクティス

### コンテキストを最新に保つ
- CLAUDE.mdファイルを月次でレビュー
- 主要な決定の後に更新
- 古い情報を削除
- 新しい学びを追加

### 具体的に
- 明確なプロジェクト説明
- 具体的な好み
- 具体的な例
- 定義された規約

### 階層的情報
- グローバル → エリア → プロジェクト → タスク
- 一般的 → 具体的
- 戦略的 → 戦術的

## トラブルシューティング

### コンテキストが読み込まれない？
- ファイル名を確認（正確にCLAUDE.md）
- ファイル権限を確認
- 有効なmarkdownであることを確認
- ファイルエンコーディングを確認（UTF-8）

### コンテキストが多すぎる？
- 選択的読み込みを使用
- MAX_DEPTHを減らす
- 古いプロジェクトをアーカイブ
- CLAUDE.mdファイルをクリーンアップ

### 指示が矛盾している？
- より具体的なものが一般的なものを上書き
- プロジェクトがグローバルを上書き
- 最近のものが古いものを上書き

## 統合例

### Dailyコマンドとの統合
```bash
claude code /onboard
claude code /daily
# Claudeは今、デイリーノートのための完全なコンテキストを知っています
```

### Pushコマンドとの統合
```bash
claude code /onboard
# Claudeの助けを借りて変更を行う
claude code /push "Claudeによって導かれた変更"
```

## 関連コマンド
- `/daily` - デイリーノートの作成
- `/weekly` - 週次レビューの実行
- `/push` - Gitへの保存

---

*コマンドバージョン: 1.0*
*最適化: 素早いコンテキスト読み込み*

**覚えておいてください：** 良いコンテキストはより良い支援につながります。CLAUDE.mdファイルを最新に保ちましょう！
