# トラブルシューティングガイド

よくある問題とその解決策。ここで問題が見つからない場合は、コミュニティフォーラムまたはドキュメントを確認してください。

## クイックフィックス

### 何よりも先に、これらを試してください:

1. **Obsidianを再起動**
   - 完全に閉じて再度開く
   - 多くの問題は新規起動で解決します

2. **ファイル権限を確認**
   ```bash
   ls -la ~/Documents/ObsidianPKM
   # あなたのユーザーが所有者として表示されるはずです
   ```

3. **Claude Codeを確認**
   ```bash
   claude --version
   # バージョン番号が表示されるはずです
   ```

4. **最新の変更を取得**
   ```bash
   git pull origin main
   # 更新を取得
   ```

## よくある問題

### Obsidianの問題

#### 「ボルトを開けません」エラー
**問題**: Obsidianがボルトフォルダを開けない

**解決策**:
1. フォルダが存在することを確認:
   ```bash
   cd ~/Documents/ObsidianPKM
   ls -la
   ```

2. Obsidian設定をリセット:
   ```bash
   # まずバックアップ
   mv .obsidian .obsidian.backup
   # Obsidianを再起動
   ```

3. 破損したファイルを確認:
   ```bash
   # 問題のあるファイルを検索
   find . -name "*.md" -exec file {} \; | grep -v "ASCII text"
   ```

#### テンプレートが動作しない
**問題**: デイリーテンプレートが正しく作成されない

**解決策**:
1. テンプレートの場所を確認:
   ```
   Templates/Daily Template.md が存在するはずです
   ```

2. テンプレート設定を確認:
   - 設定 → テンプレート
   - テンプレートフォルダの場所: "Templates"

3. 日付形式を確認:
   ```markdown
   {{date}} と {{time}} が機能するはずです
   ```

#### リンクが動作しない
**問題**: [[Wikiリンク]]が接続されない

**解決策**:
1. 設定でリンク形式を確認:
   - 設定 → ファイルとリンク
   - [[Wikiリンク]]を使用: オン
   - 新規リンク形式: 相対パス

2. ファイルが存在することを確認:
   - 壊れたリンクは薄く表示されます
   - クリックして欠落ファイルを作成

### Claude Codeの問題

#### 「コマンドが見つかりません: claude」
**問題**: Claude Code CLIがインストールされていないかPATHにない

**解決策**:
1. Claude Codeをインストール:
   ```bash
   # インストールガイドを確認
   # https://code.claude.com/docs
   ```

2. PATHに追加:
   ```bash
   # ~/.bashrc または ~/.zshrc に追加
   export PATH="$PATH:/path/to/claude"
   source ~/.bashrc
   ```

#### コマンドが認識されない
**問題**: /daily、/weekly等が動作しない

**解決策**:
1. コマンドファイルが存在することを確認:
   ```bash
   ls -la .claude/commands/
   # daily.md, weekly.md等が表示されるはずです
   ```

2. 欠落している場合はコマンドをコピー:
   ```bash
   cp claude-commands/* .claude/commands/
   ```

3. ファイル権限を確認:
   ```bash
   chmod 644 .claude/commands/*.md
   ```

#### 「コンテキストが長すぎます」エラー
**問題**: /onboard で読み込むファイルが多すぎる

**解決策**:
1. 特定のコンテキストを読み込む:
   ```bash
   claude code /onboard Projects/CurrentProject
   ```

2. CLAUDE.mdファイルをクリーンアップ:
   - 古い情報を削除
   - 必須のコンテキストのみを保持

3. 選択的読み込みを使用:
   ```bash
   # 古いプロジェクトをスキップ
   claude code /onboard --exclude Archives
   ```

### Gitの問題

#### 「プッシュに失敗しました」エラー
**問題**: GitHubにプッシュできない

**解決策**:
1. まずプル:
   ```bash
   git pull --rebase origin main
   git push
   ```

2. リモートを確認:
   ```bash
   git remote -v
   # origin URLsが表示されるはずです
   ```

3. 認証を修正:
   ```bash
   # 個人アクセストークンを使用
   git remote set-url origin https://TOKEN@github.com/user/repo.git
   ```

#### マージコンフリクト
**問題**: プル/プッシュ時のコンフリクト

**解決策**:
1. コンフリクトを表示:
   ```bash
   git status
   # コンフリクトしているファイルを表示
   ```

2. 手動で解決:
   - コンフリクトしているファイルを開く
   - <<<<<<< マーカーを探す
   - 正しいバージョンを選択
   - マーカーを削除

3. マージを完了:
   ```bash
   git add .
   git commit -m "Resolved conflicts"
   git push
   ```

#### 大きなファイルの問題
**問題**: Gitが大きなファイルを拒否

**解決策**:
1. Git LFSを使用:
   ```bash
   git lfs track "*.pdf"
   git lfs track "*.png"
   git add .gitattributes
   ```

2. .gitignoreに追加:
   ```
   *.pdf
   *.mov
   *.zip
   ```

3. 履歴から削除:
   ```bash
   git filter-branch --tree-filter 'rm -f path/to/large/file' HEAD
   ```

### デイリーノートの問題

#### 誤った日付形式
**問題**: デイリーノートの日付が正しくない

**解決策**:
1. テンプレート変数を確認:
   ```markdown
   {{date:YYYY-MM-DD}}  # 標準形式
   {{date:dddd, MMMM DD, YYYY}}  # 長い形式
   ```

2. システム日付を確認:
   ```bash
   date
   # 正しい日付/時刻が表示されるはずです
   ```

3. タイムゾーンを設定:
   ```bash
   export TZ='Asia/Tokyo'
   ```

#### 重複したデイリーノート
**問題**: 同じ日に複数のノート

**解決策**:
1. 命名規則を確認:
   - YYYY-MM-DD.md であるべき
   - スペースや特殊文字なし

2. 重複をマージ:
   ```bash
   # 重複からコンテンツをコピー
   # メインノートに貼り付け
   # 重複を削除
   ```

3. 今後の重複を防止:
   - 常に/dailyコマンドを使用
   - 手動で作成しない

### GitHub Actionの問題

#### ワークフローがトリガーされない
**問題**: GitHub Actionが実行されない

**解決策**:
1. ワークフローファイルを確認:
   ```yaml
   # .github/workflows/claude.yml が存在するはずです
   ```

2. トリガーを確認:
   ```yaml
   on:
     issues:
       types: [opened, edited]
   ```

3. Actionsが有効になっていることを確認:
   - リポジトリ → Settings → Actions
   - Actions permissions: Allow

#### OAuthトークンが無効
**問題**: CLAUDE_CODE_OAUTH_TOKENが動作しない

**解決策**:
1. トークンを再生成:
   - Claude Codeドキュメントにアクセス
   - OAuth設定ガイドに従う

2. シークレットを更新:
   - リポジトリ → Settings → Secrets
   - CLAUDE_CODE_OAUTH_TOKENを更新

3. トークン権限を確認:
   - repoアクセスが必要
   - workflowアクセスが必要

### パフォーマンスの問題

#### Obsidianが遅い
**問題**: ボルトの読み込みや応答に時間がかかる

**解決策**:
1. ボルトサイズを削減:
   ```bash
   # 古いノートをアーカイブ
   mv "Daily Notes/2023*" Archives/2023/
   ```

2. 未使用のプラグインを無効化:
   - 設定 → コミュニティプラグイン
   - 使用していないものを無効化

3. キャッシュをクリア:
   ```bash
   rm -rf .obsidian/cache
   ```

4. 画像を最適化:
   ```bash
   # 画像を圧縮
   find . -name "*.png" -exec pngquant --ext .png --force {} \;
   ```

#### 検索が動作しない
**問題**: 検索でノートが見つからない

**解決策**:
1. 検索インデックスを再構築:
   - 設定 → About → Reindex vault

2. 検索構文を確認:
   ```
   "完全一致フレーズ"
   tag:#daily
   file:2024-01-15
   ```

3. ファイル名から特殊文字を削除

## プラットフォーム固有の問題

### macOS

#### 「操作が許可されていません」
```bash
# Obsidianにフルディスクアクセスを付与
システム環境設定 → セキュリティとプライバシー → フルディスクアクセス
```

#### iCloud同期の問題
- ボルトをiCloud Driveに置かない
- 代わりにGitで同期を使用
- またはObsidian Syncサービスを使用

### Windows

#### パスが長すぎる
```powershell
# 長いパスを有効化
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force
```

#### 行末の問題
```bash
# Gitを設定
git config --global core.autocrlf true
```

### Linux

#### 権限が拒否されました
```bash
# 権限を修正
chmod -R 755 ~/Documents/ObsidianPKM
chown -R $USER:$USER ~/Documents/ObsidianPKM
```

#### 依存関係の欠落
```bash
# 必要なパッケージをインストール
sudo apt-get update
sudo apt-get install git curl
```

## 復旧手順

### バックアップから復元

#### Gitを使用
```bash
# 履歴を表示
git log --oneline

# 以前のコミットに復元
git reset --hard COMMIT_HASH

# または単一ファイルを復元
git checkout COMMIT_HASH -- path/to/file.md
```

#### ファイルシステムを使用
```bash
# Time Machine (macOS)がある場合
# またはFile History (Windows)
# またはBackups (Linux)
```

### ボルトの再構築

ボルトが破損している場合:
```bash
# 1. 現在のボルトをバックアップ
cp -r ~/Documents/ObsidianPKM ~/Documents/ObsidianPKM.backup

# 2. 新しいボルトを作成
cp -r vault-template ~/NewVault

# 3. ノートをコピー
cp -r ~/Documents/ObsidianPKM.backup/Daily\ Notes/* ~/NewVault/Daily\ Notes/
cp -r ~/Documents/ObsidianPKM.backup/Projects/* ~/NewVault/Projects/

# 4. Gitを再初期化
cd ~/NewVault
git init
git add .
git commit -m "Rebuilt vault"
```

### 緊急アクセス

ロックアウトされた場合:
1. GitHub.com経由でアクセス
2. ブラウザでファイルを編集
3. 必要に応じてZIPとしてダウンロード
4. バックアップとしてモバイルアプリを使用

## 予防措置

### 定期メンテナンス

#### 週次
```bash
# クリーンアップ
claude code "Archive completed tasks and old notes"

# バックアップ
git push origin main
```

#### 月次
```bash
# 最適化
claude code "Identify and remove duplicate content"

# 更新
git pull origin main
```

#### 四半期ごと
```bash
# システムのレビュー
claude code "Analyze vault structure and suggest improvements"

# 依存関係のクリーン
rm -rf node_modules .obsidian/cache
```

### バックアップ戦略

1. **バージョン管理**: 毎日Gitコミット
2. **クラウドバックアップ**: GitHubプライベートリポジトリ
3. **ローカルバックアップ**: Time Machine/ファイル履歴
4. **エクスポートバックアップ**: 月次markdownエクスポート

## ヘルプの取得

### リソース
- [Obsidian Forum](https://forum.obsidian.md/)
- [Claude Code Docs](https://code.claude.com/docs)
- [GitHub Issues](https://github.com/ballred/obsidian-claude-pkm/issues)

### デバッグ情報
ヘルプを求める際に提供する情報:
```bash
# システム情報
uname -a

# Obsidianバージョン
# (設定 → Aboutで確認)

# Claudeバージョン
claude --version

# Gitステータス
git status
git remote -v

# ボルト構造
ls -la ~/Documents/ObsidianPKM
```

### コミュニティサポート
- Discordチャンネル
- Reddit: r/ObsidianMD
- Twitter: #ObsidianMD

---

**覚えておいてください**: ほとんどの問題にはシンプルな解決策があります。落ち着いて、基本を確認し、体系的に取り組んでください。
