---
name: sync-upstream
description: upstream (ballred/obsidian-claude-pkm) の main ブランチに追従し、変更されたファイルを日本語化
args:
  - name: strategy
    description: マージ戦略 (theirs=アップストリーム優先, ours=現在の変更優先)
    default: theirs
---

# Upstream 追従コマンド

このコマンドは `ballred/obsidian-claude-pkm` の main ブランチに追従し、変更されたファイルを自動的に日本語化します。

## 実行手順

1. **upstream の最新変更を取得**
   ```bash
   git fetch upstream
   ```

2. **現在のブランチを確認し、main でない場合は警告**
   - main ブランチで実行することを推奨

3. **upstream/main との差分を確認**
   ```bash
   git log HEAD..upstream/main --oneline
   ```
   - 取り込む変更の概要をユーザーに表示
   - 変更がない場合は処理を終了

4. **ユーザーに確認を求める**
   - AskUserQuestion ツールを使用して、マージを続行するか確認

5. **マージ実行**
   - 引数 `strategy` が `theirs` の場合（デフォルト）:
     ```bash
     git merge upstream/main -X theirs
     ```
   - 引数 `strategy` が `ours` の場合:
     ```bash
     git merge upstream/main -X ours
     ```
   - コンフリクトが発生した場合は、手動解決の指示を表示

6. **変更されたファイルを特定**
   ```bash
   git diff HEAD@{1} HEAD --name-only
   ```
   - マージで変更されたファイルのリストを取得

7. **Markdown ファイルの日本語化**
   - 変更されたファイルの中から `.md` ファイルを抽出
   - 各 `.md` ファイルに対して `english-to-japanese-translator` エージェントを使用して翻訳
   - Task ツールを使用してエージェントを起動:
     ```
     subagent_type: english-to-japanese-translator
     prompt: "次のファイルを日本語に翻訳してください: [ファイルパス]"
     ```

8. **翻訳後の確認**
   - 翻訳されたファイルの差分を表示
   - ユーザーに変更内容を確認してもらう

9. **コミット作成（オプション）**
   - ユーザーに翻訳結果をコミットするか確認
   - コミットする場合は、適切なコミットメッセージを生成

## 注意事項

- このコマンドは main ブランチで実行することを推奨します
- マージ前に必ず現在の作業をコミットまたはスタッシュしてください
- デフォルトでは upstream の変更を優先します（`-X theirs` 戦略）
- コンフリクトが発生した場合は、手動で解決する必要があります

## 使用例

```bash
# デフォルト（upstream 優先）でマージと翻訳を実行
/sync-upstream

# 現在の変更を優先してマージと翻訳を実行
/sync-upstream ours
```

## 翻訳後の品質チェック

翻訳が完了したら、以下の項目を確認してください:

### 1. コマンド表記の確認
- [ ] `claude code` が誤って使われていないか確認（正しくは `claude`）
  - ✅ 正しい例: `claude /daily`, `claude "プロンプト"`
  - ❌ 誤った例: `claude code /daily`, `claude code "プロンプト"`
- [ ] ただし、固有名詞としての「Claude Code CLI」「Claude Code統合」などはそのまま

### 2. プロンプトの日本語化確認
- [ ] `claude` コマンドに渡すプロンプトが英語のままになっていないか確認
  - ✅ 正しい例: `claude "デイリーノートを作成して"`
  - ❌ 誤った例: `claude "Create daily note"`

### 3. 用語の統一
- [ ] 「Vault」は英語表記を使用する（「ボルト」や「保管庫」などに訳さない）
  - ✅ 正しい例: 「Vaultを監査」「Vault構造」
  - ❌ 誤った例: 「ボルトを監査」「保管庫を監査」など

### 4. 確認コマンド
翻訳後に以下のコマンドで問題がないか確認:
```bash
# "claude code" の誤記がないか確認（固有名詞を除く）
grep -n "claude code /" docs/*.md

# 英語のプロンプトが残っていないか確認
grep -n 'claude "[A-Z]' docs/*.md

# 「ボルト」が残っていないか確認（正しくは「Vault」）
grep -n "ボルト" docs/*.md
```
