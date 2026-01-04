# 完全セットアップガイド

このガイドでは、Obsidian + Claude Code PKMシステムのセットアップを段階的に説明します。前提条件がインストール済みであれば所要時間は約15分です。

## 前提条件チェックリスト

開始前に、以下が揃っていることを確認してください:

- [ ] **Obsidian** のインストール ([ダウンロードはこちら](https://obsidian.md/))
- [ ] **Git** のインストール ([ダウンロードはこちら](https://git-scm.com/))
- [ ] **Claude Code CLI** のインストール ([手順はこちら](https://code.claude.com/docs))
- [ ] **GitHubアカウント** (オプション、同期用) ([サインアップはこちら](https://github.com))
- [ ] **テキストエディタ** (設定ファイル編集用)

### 前提条件の確認

ターミナル/コマンドプロンプトを開いて以下を実行:
```bash
# Gitの確認
git --version

# Claude Codeの確認
claude --version
```

## フェーズ1: 初期セットアップ (5分)

### ステップ1: リポジトリのクローン

```bash
# オプションA: gitがある場合
git clone https://github.com/ballred/obsidian-claude-pkm.git
cd obsidian-claude-pkm

# オプションB: ZIPダウンロード
# 1. GitHubからダウンロード
# 2. 希望する場所に展開
```

### ステップ2: セットアップスクリプトの実行

```bash
# スクリプトを実行可能にする (Mac/Linux)
chmod +x scripts/setup.sh

# セットアップの実行
./scripts/setup.sh

# Windowsの場合:
# scripts\setup.bat
```

セットアップスクリプトは以下を行います:
1. Vaultの保存場所を尋ねます
2. Vaultテンプレートをコピーします
3. Claudeコマンドをセットアップします
4. gitを初期化します(希望する場合)

### ステップ3: 手動セットアップ (スクリプトが失敗した場合)

```bash
# Vaultテンプレートを希望する場所にコピー
cp -r vault-template ~/Documents/ObsidianPKM

# .claude/commandsディレクトリはテンプレートに既に含まれています
# コマンドが存在することを確認
ls ~/Documents/ObsidianPKM/.claude/commands/

# gitの初期化
cd ~/Documents/ObsidianPKM
git init
```

## フェーズ2: Obsidianで開く (5分)

### ステップ1: Obsidianを開く
1. Obsidianを起動
2. 「フォルダをVaultとして開く」をクリック
3. Vaultフォルダに移動
4. 「選択」をクリック

### ステップ2: 信頼と有効化
プロンプトが表示されたら:
- 「作者を信頼してプラグインを有効にする」をクリック (コミュニティプラグインを追加した場合)
- テンプレートVaultでは安全です

### ステップ3: 初期探索
1. ルートにある `CLAUDE.md` を開く
2. 構造を読み通す
3. Goalsフォルダを探索
4. サンプルのデイリーノートを確認

### ステップ4: 基本設定 (オプション)
1. 設定 → 外観 → テーマを選択
2. 設定 → エディタ → 好みを設定
3. 設定 → ファイルとリンク → 以下の設定を確認:
   - 新規ノートのデフォルト保存場所: "Daily Notes"
   - 新規リンクの形式: "ファイルへの相対パス"

## フェーズ3: Claude Code統合 (10分)

### v2.0の新機能: プラグイン機能

Vaultには、高度な機能を持つ完全なClaude Codeプラグインが含まれています:

| 機能 | 説明 |
|---------|-------------|
| **フック** | ファイル変更時の自動コミット、セッション初期化 |
| **エージェント** | ノート整理、週次レビュー、目標整合性のための専門AIアシスタント |
| **スキル** | Vault操作、目標追跡、日次ワークフローの自動検出機能 |
| **ルール** | Markdown、生産性、プロジェクトのパス固有の規則 |
| **ステータスライン** | Vault統計のターミナル表示(ノート数、インボックス、未コミット変更) |

これらはVaultのセットアップが完了すると自動的に動作します。

### ステップ1: Claude Codeの設定

```bash
# Vaultに移動
cd ~/Documents/ObsidianPKM

# Claude Codeの初期化
claude init

# 接続のテスト
claude "こんにちは、PKMシステムをセットアップしています"
```

### ステップ2: コマンドのセットアップ

```bash
# コマンドは既に.claude/commands/にあるはずです
# 存在を確認:
ls .claude/commands/

# 以下が表示されるはずです:
# daily.md  weekly.md  push.md  onboard.md
```

### ステップ3: コマンドのテスト

```bash
# コンテキストを読み込む
claude /onboard

# 最初のデイリーノートを作成
claude /daily

# Daily Notes/に新しいファイルが表示されるはずです
```

### ステップ4: 出力スタイルの設定

Vaultには、Claudeをより責任重視にする「Productivity Coach」出力スタイルが含まれています:

```bash
# Claude Codeを起動
claude

# 次に出力スタイルコマンドを使用:
/output-style              # インタラクティブメニューを開いてスタイルを選択
/output-style coach        # コーチスタイルを直接有効化

# コーチは次のような質問であなたに挑戦します:
# - 「他の全てを簡単にする唯一のことは何ですか?」
# - 「実行する代わりに整理することで何を避けていますか?」
```

スタイルの設定は `.claude/settings.local.json` に自動保存されます。出力スタイルファイルは `.claude/output-styles/coach.md` にあり、カスタマイズできます。

### ステップ5: エージェントの使用 (v2.0の新機能)

Vaultには一般的なPKMタスク用の4つの専門エージェントが含まれています:

```bash
# Vaultを整理し、壊れたリンクを修正
claude "note-organizerエージェントを使ってVaultを監査して"

# ガイド付き週次レビューを実行
claude "weekly-reviewerエージェントを使って週次レビューを手伝って"

# 目標の整合性を確認
claude "goal-alignerエージェントを使って最近の活動を分析して"

# インボックスを処理
claude "inbox-processorエージェントを使ってインボックスを処理して"
```

### ステップ6: コンテキストのカスタマイズ

Vaultのルートにある `CLAUDE.md` を編集:
1. 個人のミッションステートメントを追加
2. 作業の好みを定義
3. 現在の焦点領域を設定
4. Claude向けの具体的な指示を追加

個人的な上書き設定には、`CLAUDE.local.md.template` を `CLAUDE.local.md` にコピーしてください(gitignore済み)。

## フェーズ4: Git設定 (5分)

### ステップ1: リポジトリの初期化

```bash
# まだ初期化していない場合
git init

# gitの設定
git config user.name "Your Name"
git config user.email "your.email@example.com"

# 全ファイルを追加
git add .

# 最初のコミット
git commit -m "Initial PKM setup"
```

### ステップ2: GitHubリポジトリの作成

```bash
# GitHub CLI使用(インストール済みの場合)
gh repo create my-pkm --private

# または GitHub.com で手動作成
# その後リモートを追加:
git remote add origin https://github.com/ballred/my-pkm.git

# GitHubにプッシュ
git push -u origin main
```

### ステップ3: GitHub Actionのセットアップ (オプション)

1. ワークフローファイルをコピー:
```bash
mkdir -p .github/workflows
cp github-actions/claude.yml .github/workflows/
```

2. Claude Code OAuthトークンを取得:
   - アクセス: https://code.claude.com/docs/en/github-actions
   - 手順に従ってトークンを取得

3. トークンをGitHubに追加:
   - GitHubのリポジトリに移動
   - Settings → Secrets and variables → Actions
   - New repository secret
   - Name: `CLAUDE_CODE_OAUTH_TOKEN`
   - Value: [取得したトークン]

## フェーズ5: パーソナライゼーション (10分)

### ステップ1: ミッションのカスタマイズ

`vault-template/CLAUDE.md` を編集:
```markdown
## 🎯 System Purpose
[個人のミッションに置き換えてください]
```

### ステップ2: 目標の設定

1. `Goals/0. Three Year Goals.md` を開く
2. プレースホルダーの目標を実際の3年ビジョンに置き換える
3. `Goals/1. Yearly Goals.md` を開く
4. 年間目標を設定
5. `Goals/2. Monthly Goals.md` を開く
6. 今月の優先事項を定義

### ステップ3: デイリーテンプレートのカスタマイズ

`Templates/Daily Template.md` を編集:
1. 冒頭に個人のミッションステートメントを追加
2. スケジュールに合わせてタイムブロックを調整
3. 生活に合わせてタスクカテゴリを修正
4. 必要に応じてセクションを追加/削除

### ステップ4: 最初のプロジェクトの作成

```bash
# Claudeを使用
claude "新しいプロジェクトフォルダを [プロジェクト名] で作成して"

# または手動で
1. Projects/にフォルダを作成
2. CLAUDE.mdテンプレートをコピー
3. プロジェクト目標を定義
```

## 検証チェックリスト

全てが正常に動作していることを確認するため、このチェックリストを実行してください:

- [ ] ObsidianがエラーなくVaultを開ける
- [ ] CLAUDE.mdに個人のコンテンツが設定されている
- [ ] `/daily` コマンドで今日のノートが作成される
- [ ] `/onboard` コマンドでコンテキストが読み込まれる
- [ ] Gitコミットがローカルで動作する
- [ ] GitHubリモートが接続されている(使用する場合)
- [ ] Goalsファイルに目標が設定されている
- [ ] デイリーテンプレートがカスタマイズされている

## 日次ワークフロー

### 朝のルーティン (5分)
```bash
# 1日を開始
claude /onboard
claude /daily

# Claudeが実行すること:
# - 今日のノートを作成
# - 昨日のタスクをレビュー
# - 今日の計画を支援
```

### 夜のルーティン (5分)
```bash
# 終業時
# デイリーノートに振り返りを記入
claude /push

# これによりgitに全てが保存されます
```

### 週次レビュー (30分)
```bash
# 日曜日の夜または月曜日の朝
claude /weekly

# ガイド付きレビュープロセスに従う
```

## トラブルシューティング

### ObsidianがVaultを開かない
- フォルダの権限を確認
- パスに特殊文字が含まれていないことを確認
- 新しいVaultを作成してファイルをコピーしてみる

### Claudeコマンドが動作しない
```bash
# Claude Codeのインストールを確認
claude --version

# コマンドファイルが存在することを確認
ls -la .claude/commands/

# 直接実行してみる
claude < .claude/commands/daily.md
```

### Gitの問題
```bash
# プッシュが失敗した場合
git pull --rebase origin main
git push

# 大きなファイルが問題を引き起こす場合
git lfs track "*.pdf"
git lfs track "*.png"
```

### デイリーノートが作成されない
- テンプレートの日付形式を確認
- Templatesフォルダが存在することを確認
- テンプレートファイル名が正しいことを確認

## 次のステップ

1. **読む** [CUSTOMIZATION.md](CUSTOMIZATION.md) で高度な設定を確認
2. **探索** [WORKFLOW_EXAMPLES.md](WORKFLOW_EXAMPLES.md) で使用パターンを学ぶ
3. **参加** コミュニティ(利用可能な場合)でヒントやサポートを得る
4. **反復** システムを改善 - あなたと共に進化するべきです

## ヘルプの取得

- **ドキュメント**: docs/フォルダを確認
- **Claude Codeヘルプ**: `claude --help`
- **Obsidianヘルプ**: [Obsidian Forum](https://forum.obsidian.md/)
- **Gitヘルプ**: [Git Documentation](https://git-scm.com/doc)

---

おめでとうございます! PKMシステムの準備が整いました。覚えておいてください: 最良のシステムは、実際に使うシステムです。シンプルに始め、一貫性を保ち、必要に応じて進化させましょう。

**プロのヒント**: 最初の週はデイリーノートだけを使用してください。習慣が形成されるにつれて、徐々に複雑さを追加しましょう。
