---
paths: "**/*.md"
---

# Vaultのためのマークダウン標準

これらの規約はvault内のすべてのマークダウンファイルに適用されます。

## ファイル命名

- **デイリーノート:** `YYYY-MM-DD.md`（例：`2024-01-15.md`）
- **プロジェクトフォルダ:** PascalCase（例：`MyProject/`）
- **一般ノート:** kebab-case（例：`meeting-notes.md`）
- **テンプレート:** スペースを含むタイトルケース（例：`Daily Template.md`）

## 見出し構造

- H1（`#`）はノートタイトルのみ - 1ファイルに1つ
- H2（`##`）は主要なセクション用
- H3（`###`）はサブセクション用
- 見出しレベルをスキップしない（H1 -> H3は不可）

## リンク

### 内部リンク（Wiki形式）
```markdown
[[ノート名]]                    # ノートへのリンク
[[ノート名|表示テキスト]]       # エイリアス付きリンク
[[ノート名#セクション]]         # 見出しへのリンク
[[フォルダ/ノート名]]           # パス付きリンク
```

### 外部リンク
```markdown
[表示テキスト](https://url.com)
```

## タグ

### 標準タグ階層
```
#priority/high
#priority/medium
#priority/low

#status/active
#status/waiting
#status/completed
#status/archived

#context/work
#context/personal
#context/health
#context/learning
#context/family
```

### タグの配置
- YAMLフロントマター内：`tags: [tag1, tag2]`
- インライン：関連する行または段落の最後

## タスク形式

```markdown
- [ ] 未完了タスク
- [x] 完了タスク
- [ ] コンテキスト付きタスク #work @home
- [ ] 期限付きタスク 📅 2024-01-20
```

## YAMLフロントマター

すべてのノートにフロントマターを含めるべき：
```yaml
---
date: YYYY-MM-DD
tags: [relevant, tags]
status: active|completed|archived
---
```

## テキスト装飾

- **太字**は強調と重要な用語用
- *斜体*は控えめな強調用
- `コード`はコマンド、パス、技術用語用
- > 引用ブロックは重要な注意事項用

## リスト

- 順序なしリストには`-`を使用
- 順序ありリストには`1.`を使用
- ネストされた項目は2スペースでインデント

## コードブロック

言語を指定したフェンスコードブロックを使用：
```javascript
const example = "code";
```

## ベストプラクティス

1. 1つの段落に1つのアイデア
2. セクション間に空白行を使用
3. 可能な限り行を100文字以下に保つ
4. 関連ノートへのリンクを含める
5. 意味のあるフロントマターを追加
