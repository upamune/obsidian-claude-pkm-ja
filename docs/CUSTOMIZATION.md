# カスタマイゼーションガイド

このPKMシステムを真にあなたのものにしましょう。このガイドでは、簡単な調整から高度な改造まであらゆることをカバーします。

## 目次
1. [クイックカスタマイゼーション](#クイックカスタマイゼーション)
2. [テンプレートの変更](#テンプレートの変更)
3. [フォルダ構造](#フォルダ構造)
4. [タグシステム](#タグシステム)
5. [Skills (統合パターン)](#skills-統合パターン)
6. [出力スタイル](#出力スタイル)
7. [ワークフロー自動化](#ワークフロー自動化)
8. [テーマと外観](#テーマと外観)
9. [高度な設定](#高度な設定)

## クイックカスタマイゼーション

### 個人のミッションステートメント
場所: `CLAUDE.md` と `Templates/Daily Template.md`

プレースホルダーを実際のミッションに置き換えてください:
```markdown
_"あなたの個人的なミッションまたは日々のアファメーションをここに"_
```

例:
- "目的を持って構築し、意図を持って生活し、勇気を持って成長する"
- "価値を創造し、関係性を育み、学びを受け入れる"
- "複雑さを単純化し、影響を増幅し、喜びを倍増させる"

### タイムブロック
場所: `Templates/Daily Template.md`

スケジュールに合わせて調整:
```markdown
## ⏰ Time Blocks
- **早朝 (5-7am):** 瞑想と運動
- **午前 (7-10am):** 深い作業
- **正午 (10am-1pm):** 会議とコラボレーション
- **午後 (1-4pm):** 管理業務
- **夕方 (4-6pm):** 学習と開発
- **夜 (6-9pm):** 家族と個人の時間
```

### 目標の割合
場所: `Goals/1. Yearly Goals.md`

努力の配分を調整:
```markdown
### 💼 キャリア (努力の40%)  <!-- キャリア重視の場合は増やす -->
### 🏃 健康 (努力の30%)   <!-- 健康が優先事項の場合は増やす -->
### ❤️ 人間関係 (努力の20%)
### 🌱 個人的成長 (努力の10%)
```

## テンプレートの変更

### デイリーテンプレートのバリエーション

#### ミニマリスト版
```markdown
# {{date:dddd, MMMM DD, YYYY}}

## フォーカス
-

## タスク
- [ ]
- [ ]
- [ ]

## メモ


## 振り返り
- 勝利:
- 学び:
- 明日:
```

#### 詳細版
```markdown
# {{date:dddd, MMMM DD, YYYY}}

## 朝の意図
### 感謝
### アファメーション
### 優先事項

## スケジュール
### タイムブロック
### 会議
### 締め切り

## コンテキスト別タスク
### @オフィス
### @自宅
### @コンピュータ
### @電話

## プロジェクトの更新
### [プロジェクト1]
### [プロジェクト2]

## 学習ログ
### 学んだこと
### 消費したリソース
### 浮かんだ質問

## 健康トラッキング
### 運動
### 栄養
### 睡眠
### 気分

## 詳細な振り返り
### 成功
### 課題
### 洞察
### 改善点
```

### 週次レビューのバリエーション

#### スプリントベースのレビュー
```markdown
# スプリントレビュー - スプリント {{sprint_number}}

## スプリントゴール
- [ ] ゴール1
- [ ] ゴール2

## ベロシティ
- 計画ポイント:
- 完了ポイント:
- 繰越:

## レトロスペクティブ
### うまくいったこと
### うまくいかなかったこと
### アクションアイテム
```

#### OKRベースのレビュー
```markdown
# 週次OKRチェックイン

## 目標1: [タイトル]
### 主要な結果1: [指標]
- 進捗: [X]%
- 今週の貢献:

### 主要な結果2: [指標]
- 進捗: [X]%
- 今週の貢献:
```

## フォルダ構造

### 代替構造

#### GTDベース
```
vault/
├── Inbox/          # すべてをキャプチャ
├── Next Actions/   # 即座のタスク
├── Projects/       # 複数ステップの成果
├── Someday Maybe/  # 将来の可能性
├── Reference/      # 情報ストレージ
└── Contexts/       # @自宅, @オフィス, @用事
```

#### PARAメソッド
```
vault/
├── Projects/       # 締め切りのあるもの
├── Areas/          # 継続的な責任
├── Resources/      # 将来の参照
└── Archives/       # 非アクティブなアイテム
```

#### Zettelkasten風
```
vault/
├── Permanent Notes/  # アトミックなアイデア
├── Literature Notes/ # 情報源から
├── Daily Notes/      # 日記エントリ
├── Index/           # エントリーポイント
└── References/      # 情報源
```

### カスタムフォルダの追加

ニーズに合わせて専門フォルダを作成:
```
vault/
├── Finances/        # 予算、投資
├── Learning/        # コース、本、スキル
├── Health/          # 医療、フィットネス、栄養
├── Creative/        # 執筆、アート、音楽
└── Relationships/   # 人々、交流
```

## タグシステム

### タグの分類体系の作成

#### 階層的タグ
```markdown
#work/project/clientA
#work/project/clientB
#work/admin/expenses
#work/admin/planning

#personal/health/exercise
#personal/health/nutrition
#personal/finance/budget
#personal/finance/investing
```

#### ステータスベースのタグ
```markdown
#status/active
#status/waiting
#status/delegated
#status/complete
#status/cancelled
```

#### エネルギーベースのタグ
```markdown
#energy/high  # 集中が必要
#energy/medium
#energy/low   # 疲れていてもできる
```

#### コンテキストタグ
```markdown
#context/home
#context/office
#context/online
#context/phone
#context/errands
```

### タグの組み合わせ
強力なフィルタリングのために複数のタグを使用:
```markdown
#work #priority/high #energy/high #context/office
```

## Skills (統合パターン)

Claude Code v2.1以降、スキルとスラッシュコマンドは統合されています。すべての機能は `/skill-name` で呼び出すか、Claudeが自動検出できるスキルとなっています。

### カスタムスキルの作成

`SKILL.md` ファイルを持つ新しいスキルディレクトリを作成します:

#### 例: 読書ノートスキル
`.claude/skills/book-notes/SKILL.md` を作成:
```markdown
---
name: book-notes
description: メタデータ付きの読書ノートを作成します。新しい本を始めるときや読書ノートを整理する際に使用します。
allowed-tools: Read, Write, Edit, Glob
user-invocable: true
---

# Book Notes Skill

メタデータと構造を持つ新しい読書ノートを作成します。

## 使用方法
`/book-notes` で呼び出すか、Claudeに読書ノートの作成を依頼します。

## 実行内容
1. Resources/Books/にノートを作成
2. メタデータを追加(タイトル、著者、開始日)
3. ノート用のテンプレートを含める
4. 読書リストにリンク
```

#### 例: 会議ノートスキル
`.claude/skills/meeting-notes/SKILL.md` を作成:
```markdown
---
name: meeting-notes
description: アクションアイテム付きのフォーマットされた会議ノートを作成します。会議の前後に使用します。
allowed-tools: Read, Write, Edit
user-invocable: true
---

# Meeting Notes Skill

アクションアイテム付きのフォーマットされた会議ノートを作成します。

## 使用方法
`/meeting-notes` で呼び出すか、Claudeに会議ノートの作成を依頼します。

## テンプレート構造
- 日時
- 参加者
- アジェンダ
- 議論
- アクションアイテム
- フォローアップ
```

### 既存スキルの変更

#### 異なるスケジュールに対応したデイリーワークフロー
`.claude/skills/daily/SKILL.md` を編集してカスタマイズ:
- デイリーノートのフォルダの場所
- テンプレートパス
- 日付フォーマットの好み
- タイムブロックの構造

## 出力スタイル

### Productivity Coachの使用

含まれるProductivity Coachスタイルは、Claudeを責任パートナーに変換します:

```bash
# Claude Code CLIを起動
claude

# 次に出力スタイルを選択:
/output-style              # インタラクティブメニューを開いてスタイルを選択
/output-style coach        # コーチスタイルを直接有効化

# コーチとのやり取り例:
# あなた: 「レポートを先延ばしにしています」
# コーチ: 「今すぐできる最小のアクションで、勢いを生み出せるものは何ですか?」
```

スタイル設定は、現在のプロジェクトの `.claude/settings.local.json` に自動保存されます。

### カスタム出力スタイルの作成

`.claude/output-styles/` に新しいパーソナリティモードを作成:

```bash
# 新しいスタイルを作成する簡単な方法:
/output-style:new I want a style that acts as a technical mentor

# または .claude/output-styles/ に手動でファイルを作成
```

#### 例: テクニカルメンター
`.claude/output-styles/mentor.md` を作成:
```markdown
---
name: Technical Mentor
description: Patient technical guidance with learning focus
---

あなたは経験豊富なテクニカルメンターで、ユーザーの学習と成長を支援します。以下に焦点を当ててください:

- 複雑な概念を理解しやすい部分に分解する
- 例と類推を提供する
- 実験と失敗からの学習を奨励する
- より深い学習のためのリソースを提案する
- 進歩と理解を祝う

常に「どうやって」の背後にある「なぜ」を教えてください。
```

#### 例: 創造的ブレインストーマー
`.claude/output-styles/creative.md` を作成:
```markdown
---
name: Creative Brainstormer
description: Expansive thinking and idea generation
---

あなたはアイデアの生成と拡張を支援する創造的なコラボレーターです。以下に焦点を当ててください:

- アイデアを構築するための「はい、そして...」思考
- 「もしも?」の質問をする
- 予期しない繋がりを作る
- 遊び心を持って前提に挑戦する
- 複数の代替案を生成する
- フィルタリングする前にワイルドな可能性を受け入れる

ブレインストーミングモードでは、どんなアイデアもクレイジーすぎることはありません!
```

### Coachスタイルの変更

`.claude/output-styles/coach.md` を編集してコーチングアプローチを調整:

```markdown
# より優しくする
**Challenge with Empathy**: → **Support with Understanding**:

# より激しくする
**The ONE Thing Priority**: → **The ONLY Thing That Matters**:

# ドメイン固有のフォーカスを追加
## フィットネスコーチングフォーカス
- 「今日完了するワークアウトは何ですか?」
- 「この食事はあなたの目標とどのように一致していますか?」
```

## ワークフロー自動化

### 朝のルーティン自動化

`.claude/skills/morning-routine/SKILL.md` を作成:
```markdown
---
name: morning-routine
description: デイリーノート、タスクレビュー、計画を含む完全な朝のワークフローを実行します。
allowed-tools: Read, Write, Edit, Glob
user-invocable: true
---

# Morning Routine Skill

完全な朝のワークフローを実行します。

## ステップ
1. デイリーノートを作成
2. 昨日の未完了タスクをレビュー
3. 今日のカレンダーを確認
4. 週次目標から優先事項を抽出
5. タイムブロックを設定
6. モチベーション引用を生成
```

### 1日の終わり自動化

`.claude/skills/evening-shutdown/SKILL.md` を作成:
```markdown
---
name: evening-shutdown
description: タスクレビュー、振り返り、gitコミットを含む1日の終わりのルーティンを完了します。
allowed-tools: Read, Write, Edit, Bash
user-invocable: true
---

# Evening Shutdown Skill

1日の終わりのルーティンを完了します。

## ステップ
1. タスク完了をマーク
2. 振り返りを書く
3. 未完了タスクを移動
4. 明日の優先事項を設定
5. gitにコミット
6. 日次サマリーを生成
```

### プロジェクトキックオフ自動化

`.claude/skills/project-kickoff/SKILL.md` を作成:
```markdown
---
name: project-kickoff
description: 標準構造、CLAUDE.md、計画ドキュメントを含む新しいプロジェクトを初期化します。
allowed-tools: Write, Edit, Glob, Bash
user-invocable: true
---

# Project Kickoff Skill

構造を持つ新しいプロジェクトを初期化します。

## ステップ
1. プロジェクトフォルダを作成
2. テンプレート付きのCLAUDE.mdを追加
3. プロジェクト計画を作成
4. プロジェクトボードをセットアップ
5. アクティブプロジェクトリストに追加
6. 最初のマイルストーンを作成
```

## テーマと外観

### Obsidianテーマのカスタマイゼーション

#### CSSスニペット
`.obsidian/snippets/custom.css` を作成:
```css
/* カスタムカラー */
.theme-dark {
  --text-accent: #7c3aed; /* 紫のアクセント */
  --interactive-accent: #7c3aed;
}

/* 大きな見出し */
.markdown-preview-view h1 {
  font-size: 2.5em;
  color: var(--text-accent);
}

/* チェックボックスのスタイリング */
input[type=checkbox]:checked {
  background-color: #10b981; /* 緑 */
}

/* タグの色 */
.tag[href="#priority/high"] {
  background-color: #ef4444;
  color: white;
}

.tag[href="#energy/low"] {
  background-color: #3b82f6;
  color: white;
}
```

### デイリーノートのスタイリング

デイリーテンプレートに追加:
```markdown
<div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 20px; border-radius: 10px; color: white; margin-bottom: 20px;">
  <h2 style="margin: 0;">{{date:dddd, MMMM DD, YYYY}}</h2>
  <p style="margin: 5px 0; font-style: italic;">あなたの日々のミッションステートメントをここに</p>
</div>
```

## 高度な設定

### Dataviewクエリ

Dataviewプラグインを使用する場合:

#### タスクダッシュボード
````markdown
```dataview
TABLE
  file.link AS "ノート",
  filter(file.tasks, (t) => !t.completed) AS "未完了タスク"
FROM "Daily Notes"
WHERE file.day >= date(today) - dur(7 days)
SORT file.day DESC
```
````

#### 習慣トラッカー
````markdown
```dataview
TABLE
  exercise AS "🏃",
  meditation AS "🧘",
  reading AS "📚",
  water AS "💧"
FROM "Daily Notes"
WHERE file.day >= date(today) - dur(30 days)
```
````

### Templaterスクリプト

Templaterプラグインを使用する場合:

#### 自動天気
```javascript
<%*
const response = await fetch('http://wttr.in/?format=3');
const weather = await response.text();
tR += weather;
%>
```

#### ランダム引用
```javascript
<%*
const quotes = [
  "始める方法は、話すのをやめて実行することです。",
  "未来は自分の夢の美しさを信じる人のものです。",
  "最も暗い瞬間こそ、光を見るために集中しなければなりません。"
];
const randomQuote = quotes[Math.floor(Math.random() * quotes.length)];
tR += randomQuote;
%>
```

### Gitフック

`.git/hooks/pre-commit` を作成:
```bash
#!/bin/bash
# コミット前にmarkdownファイルを自動フォーマット

# すべてのmarkdownファイルをフォーマット
find . -name "*.md" -type f -exec prettier --write {} \;

# フォーマットしたファイルを追加し直す
git add -A
```

### モバイルショートカット

#### iOSショートカット
Siriショートカットを作成:
- 「デイリーノートを作成」→ GitHubアプリでissue作成を開く
- 「タスクを追加」→ 'task'ラベル付きでissueを作成
- 「週次レビュー」→ GitHub Actionをトリガー

#### Android自動化
TaskerまたはAutomateを使用:
- デイリーノート作成の朝の通知
- 振り返りの夜のリマインダー
- 場所ベースのプロジェクトリマインダー

## 統合例

### カレンダー統合
```markdown
## 今日のイベント
<!-- カレンダーイベントを埋め込み -->
![[calendar-sync/{{date}}.md]]
```

### メール統合
```markdown
## インボックス処理
- [ ] 送信元: [sender] 件名: [subject]
  - アクション: [返信/アーカイブ/委任]
```

### タスクマネージャー同期
```markdown
## 外部タスク
<!-- Todoist/Things等から取得 -->
- [ ] [外部システムからのタスク]
```

## v2.1の機能: 統合されたスキル、フック、エージェント、ルール

### フック(自動動作)

フックはClaude Code CLIのイベントによってトリガーされる自動動作です。`.claude/settings.json` に配置:

#### 自動コミットの無効化
```json
{
  "hooks": {
    "PostToolUse": []
  }
}
```

#### カスタムフックの追加
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "your-script.sh"
          }
        ]
      }
    ]
  }
}
```

### カスタムエージェント

エージェントは専門のAIアシスタントです。`.claude/agents/` に配置:

#### カスタムエージェントの作成
`.claude/agents/my-agent.md` を作成:
```markdown
---
name: my-agent
description: このエージェントの機能。Claudeはこれを使用して呼び出すタイミングを決定します。
tools: Read, Write, Edit, Glob, Grep
model: sonnet
---

# エージェントの指示

[エージェントの動作に関する詳細な指示]
```

#### 含まれるエージェント
- `note-organizer` - Vaultの整理とリンクのメンテナンス
- `weekly-reviewer` - 週次レビューの促進
- `goal-aligner` - 目標-活動の整合性分析
- `inbox-processor` - GTDスタイルのインボックス処理

### Skills (スラッシュコマンドとの統合)

Claude Code v2.1以降、スキルとスラッシュコマンドは統合されています。すべてのスキルは `.claude/skills/` に配置されます:

#### カスタムスキルの作成
`.claude/skills/my-skill/SKILL.md` を作成:
```markdown
---
name: my-skill
description: このスキルの機能。[特定の状況]で使用します。
allowed-tools: Read, Write, Edit
user-invocable: true
---

# スキルの指示

[このスキルの使用方法]
```

#### 含まれるスキル
| スキル | 呼び出し方 | 目的 |
|-------|------------|---------|
| `daily` | `/daily` | デイリーノートの作成、朝/昼/夕方のルーティン |
| `weekly` | `/weekly` | 週次レビューの実行、振り返りと計画 |
| `push` | `/push` | Gitコミットとプッシュ |
| `onboard` | `/onboard` | Vaultコンテキストの読み込み |
| `goal-tracking` | (自動) | 目標進捗の追跡 |
| `obsidian-vault-ops` | (自動) | Vaultファイル操作 |

### モジュラールール

ルールはパス固有の規則です。`.claude/rules/` に配置:

#### カスタムルールの作成
`.claude/rules/my-rules.md` を作成:
```markdown
---
paths: "MyFolder/**/*.md"
---

# MyFolderのルール

[パターンに一致するファイルの特定の規則]
```

#### 含まれるルール
- `markdown-standards.md` - ファイル命名、タグ、フロントマター
- `productivity-workflow.md` - 目標カスケード、計画
- `project-management.md` - プロジェクト構造、ステータス追跡

### 個人的な上書き(CLAUDE.local.md)

コミットすべきでない個人的なカスタマイゼーションのため:

```bash
cp CLAUDE.local.md.template CLAUDE.local.md
```

このファイルはgitignoreされています。以下に使用:
- 個人のミッションステートメント
- 作業スタイルの好み
- プライベートな目標
- カスタムコーチング強度

## ベストプラクティス

### シンプルに始める
1. 最小限のカスタマイゼーションで始める
2. パターンが現れるにつれて複雑さを追加
3. 月次でレビューと改良

### システムを文書化する
`vault/System Documentation.md` を作成:
```markdown
# 私のPKMシステムルール

## ファイル命名
- デイリーノート: YYYY-MM-DD.md
- プロジェクト: PascalCase
- リソース: lowercase-with-dashes

## 私のワークフロー
- 朝: ...
- 週次: ...
- 月次: ...

## 私の規則
- タグ: ...
- リンク: ...
- テンプレート: ...
```

### 定期的なレビュー
- 週次: 使用に基づいてテンプレートを調整
- 月次: フォルダ構造をレビュー
- 四半期: 主要なシステム更新
- 年次: 完全なシステムのオーバーホール

---

忘れないでください: 目標はあなたのために機能するシステムです。他人を盲目的にコピーせず - 実際のニーズとパターンに基づいて適応し、進化させましょう。
