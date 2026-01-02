# Obsidian + Claude Code PKM スターターキット 🚀

Obsidianの強力なノート作成機能とClaude CodeのAIアシスタンスを組み合わせた、完全な個人ナレッジマネジメントシステムです。15分以内にゼロから完全に機能するPKMを構築できます。

> **Note:** これは [ballred/obsidian-claude-pkm](https://github.com/ballred/obsidian-claude-pkm) の日本語翻訳版です。

**v2.0** - フック、カスタムエージェント、スキル、モジュール型ルールを追加しました。

## ✨ 機能

### コアPKM
- **🎯 目標連携システム** - 3年ビジョンから日次タスクまでの階層的な目標管理
- **📅 デイリーノートシステム** - 構造化された日次計画と振り返り
- **📱 モバイル対応** - GitHub連携によりあらゆるデバイスでノート管理
- **🔄 バージョン管理** - 自動Gitバックアップで思考を失わない
- **🎨 完全カスタマイズ可能** - テンプレートと構造を自分のニーズに合わせて調整

### AI機能 (v2.0)
- **🪝 フック** - 保存時の自動コミット、セッション初期化
- **🤖 カスタムエージェント** - ノート整理、週次レビュー、目標調整、インボックス処理
- **⚡ スキル** - Vault操作、目標追跡、日次ワークフローの自動検出機能
- **📏 モジュール型ルール** - Markdown、生産性、プロジェクトのパス固有の規約
- **🧠 出力スタイル** - アカウンタビリティのための生産性コーチ
- **📊 ステータスライン** - ターミナルでのVault統計表示（ノート数、インボックス、未コミット変更）

## 🚀 クイックスタート

### 前提条件
- [Obsidian](https://obsidian.md/) がインストール済み
- [Claude Code CLI](https://code.claude.com/docs) がインストール済み
- Git がインストール済み
- GitHubアカウント（オプション、モバイル同期用）

### 15分クイックスタート
```bash
# 1) 前提条件をインストール（初回のみ）
# - Obsidian: https://obsidian.md/
# - Git: https://git-scm.com/
# - Claude Code CLI: https://code.claude.com/docs

# 2) このリポジトリをクローン
git clone https://github.com/ballred/obsidian-claude-pkm.git
cd obsidian-claude-pkm

# 3) セットアップを実行（macOS/Linux）
chmod +x scripts/setup.sh
./scripts/setup.sh

# 3b) Windows
scripts\setup.bat
```

### 手動コピー（代替方法）
```bash
# Vaultテンプレートを任意の場所にコピー
cp -r vault-template ~/Documents/ObsidianPKM
```

### Obsidianで開く
1. Obsidianを起動
2. 「フォルダをVaultとして開く」をクリック
3. Vaultフォルダを選択（例：~/Documents/ObsidianPKM）
4. 今日のデイリーノートから始めましょう！

## 📖 ドキュメント

- **[セットアップガイド](docs/SETUP_GUIDE.md)** - 詳細なインストール手順
- **[カスタマイズ](docs/CUSTOMIZATION.md)** - 自分好みにカスタマイズ
- **[ワークフロー例](docs/WORKFLOW_EXAMPLES.md)** - 日常ルーチンとベストプラクティス
- **[トラブルシューティング](docs/TROUBLESHOOTING.md)** - よくある問題と解決方法

## 🗂️ 構造

```
Your Vault/
├── CLAUDE.md                    # AIコンテキストとナビゲーション
├── CLAUDE.local.md.template     # 個人設定オーバーライド用テンプレート
├── .claude-plugin/
│   └── plugin.json              # プラグインマニフェスト
├── .claude/
│   ├── commands/                # スラッシュコマンド (/daily, /weekly, /push, /onboard)
│   ├── agents/                  # カスタムAIエージェント（新機能）
│   │   ├── note-organizer.md
│   │   ├── weekly-reviewer.md
│   │   ├── goal-aligner.md
│   │   └── inbox-processor.md
│   ├── skills/                  # 自動検出される機能（新機能）
│   │   ├── obsidian-vault-ops/
│   │   ├── goal-tracking/
│   │   └── daily-workflow/
│   ├── hooks/                   # イベント自動化（新機能）
│   │   ├── session-init.sh
│   │   └── auto-commit.sh
│   ├── rules/                   # パス固有の規約（新機能）
│   │   ├── markdown-standards.md
│   │   ├── productivity-workflow.md
│   │   └── project-management.md
│   ├── scripts/
│   │   └── statusline.sh        # ターミナルステータス表示（新機能）
│   ├── output-styles/
│   │   └── coach.md             # 生産性コーチ
│   └── settings.json            # 権限と設定（新機能）
├── Daily Notes/
├── Goals/
├── Projects/
├── Templates/
└── Archives/
```

## 🧠 出力スタイル

このスターターキットには、Claudeをアカウンタビリティパートナーに変える**生産性コーチ**出力スタイルが含まれています。コーチは以下を実行します：

- 真の意図を明確にするよう促す
- 目標と行動の不一致を指摘する
- 前進を促す強力な質問をする
- コミットメントに対する責任を保持する
- 抵抗を特定し克服するのを支援する

Claude Codeでコーチスタイルを使用するには：
1. 出力スタイルは自動的に`.claude/output-styles/`に含まれます
2. Claude Codeを起動し、`/output-style`と入力して利用可能なスタイルから選択
3. または直接アクティブ化：`/output-style coach`
4. スタイル設定はプロジェクトに自動保存されます

[出力スタイルのカスタマイズ](docs/CUSTOMIZATION.md#output-styles)の詳細はこちら。

## 🤖 カスタムエージェント (v2.0)

一般的なPKMタスクのために特化したエージェントを使用するようClaudeに依頼できます：

```bash
# Vaultを整理し、壊れたリンクを修正
claude "note-organizer エージェントを使用してVaultを監査してください"

# 目標に沿った週次レビューを実施
claude "weekly-reviewer エージェントを使用して週次レビューを行ってください"

# 日々の作業が長期目標と一致しているか確認
claude "goal-aligner エージェントを使用して最近のアクティビティを分析してください"

# GTD原則を使用してインボックスアイテムを処理
claude "inbox-processor エージェントを使用してインボックスをクリアしてください"
```

## 🔄 v1.xからのアップグレード

v1.xから既存のVaultがある場合：

```bash
# 1. 新しいディレクトリをVaultにコピー
cp -r vault-template/.claude-plugin your-vault/
cp -r vault-template/.claude/agents your-vault/.claude/
cp -r vault-template/.claude/skills your-vault/.claude/
cp -r vault-template/.claude/hooks your-vault/.claude/
cp -r vault-template/.claude/rules your-vault/.claude/
cp -r vault-template/.claude/scripts your-vault/.claude/
cp vault-template/.claude/settings.json your-vault/.claude/
cp vault-template/CLAUDE.local.md.template your-vault/

# 2. CLAUDE.mdの変更をレビューしてマージ
# カスタマイズは保持され、新機能への参照を追加するだけです

# 3. フックスクリプトを実行可能にする
chmod +x your-vault/.claude/hooks/*.sh
chmod +x your-vault/.claude/scripts/*.sh
```

## 🤝 コントリビュート

バグを見つけた、または機能のアイデアがありますか？Issueを開くか、PRを送信してください！

## 📄 ライセンス

MIT - 個人のナレッジマネジメントに自由にお使いください。

---

**ノート作成を変革する準備はできましたか？** [セットアップガイド](docs/SETUP_GUIDE.md)に従って始めましょう！