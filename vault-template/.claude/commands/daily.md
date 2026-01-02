# デイリーノート作成コマンド

テンプレートから今日のデイリーノートを作成するか、既に存在する場合は開きます。

## インストール

このファイルをvaultルートの`.claude/commands/daily.md`にコピーします。

## 使用方法
```
claude code /daily
```

## 設定
vaultの構造に合わせてこれらのパスをカスタマイズします：

```javascript
// パス設定（カスタマイズしてください）
const DAILY_NOTES_FOLDER = "Daily Notes";
const TEMPLATE_PATH = "Templates/Daily Template.md";
const DATE_FORMAT = "YYYY-MM-DD"; // 異なる形式を希望する場合は変更
```

## このコマンドが行うこと

1. **今日のノートが存在するか確認**
   - 存在する場合：既存のノートを開く
   - 存在しない場合：テンプレートから新しいノートを作成

2. **テンプレート処理**
   - `{{date}}`を今日の日付に置き換え
   - `{{date:format}}`をフォーマットされた日付に置き換え
   - 日付演算を処理（例：`{{date-1}}`は昨日）

3. **自動整理**
   - 正しいフォルダにノートを配置
   - 今日の日付でファイル名を付ける
   - テンプレート構造を保持

## テンプレート変数

デイリーテンプレートで使用できる変数：

- `{{date}}` - デフォルト形式の今日の日付
- `{{date:dddd}}` - 曜日名（例：Monday）
- `{{date:MMMM DD, YYYY}}` - フォーマットされた日付
- `{{date-1:YYYY-MM-DD}}` - 昨日の日付
- `{{date+1:YYYY-MM-DD}}` - 明日の日付
- `{{time}}` - 現在時刻

## ワークフロー例

1. 朝のルーティン：
   ```
   claude code /daily
   ```
   テンプレートで今日のノートを作成

2. 昨日のレビュー：
   テンプレートが自動的に昨日のノートにリンク

3. 明日の計画：
   1日の終わりに、リフレクションで明日の優先事項を設定

## カスタマイズのアイデア

### 異なる日付形式
`DATE_FORMAT`を以下に変更：
- `"YYYY-MM-DD"` - 標準ISO形式（推奨）
- `"MM-DD-YYYY"` - 米国形式
- `"DD-MM-YYYY"` - ヨーロッパ形式
- `"YYYY-MM-DD-ddd"` - 曜日略称を含む

### フォルダ整理
月/年で整理：
```javascript
const year = new Date().getFullYear();
const month = String(new Date().getMonth() + 1).padStart(2, '0');
const DAILY_NOTES_FOLDER = `Daily Notes/${year}/${month}`;
```

### 複数のテンプレート
異なる曜日タイプ用：
```javascript
const dayOfWeek = new Date().getDay();
const TEMPLATE_PATH = dayOfWeek === 1
  ? "Templates/Monday Template.md"  // 特別な月曜日テンプレート
  : "Templates/Daily Template.md";   // 通常のテンプレート
```

## トラブルシューティング

### ノートが作成されない？
- テンプレートパスが存在するか確認
- フォルダの権限を確認
- テンプレートファイルが読み取り可能か確認

### 日付形式が間違っている？
- `DATE_FORMAT`定数を調整
- システムの日付設定を確認

### リンクが機能しない？
- 日付形式が一致しているか確認
- ファイル命名規則を確認

## 関連コマンド
- `/weekly` - 週次レビューの作成
- `/push` - 変更をGitに保存
- `/onboard` - コンテキストのロード

---

*コマンドバージョン: 1.0*
*互換性: Claude Code CLI*

**プロヒント:** 一貫性のために朝のルーティンの一部としてこれを実行しましょう！
