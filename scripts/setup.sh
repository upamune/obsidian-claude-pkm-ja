#!/bin/bash

# Obsidian + Claude Code PKM セットアップスクリプト
# PKMシステムの初期セットアップを自動化するスクリプトです

set -e  # エラー時に終了

# 色設定
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# バナー
echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════╗"
echo "║   Obsidian + Claude Code PKM セットアップ        ║"
echo "║   Version 1.0                                     ║"
echo "╚═══════════════════════════════════════════════════╝"
echo -e "${NC}"

# カラーメッセージ出力関数
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# コマンド存在確認関数
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ステップ 1: 前提条件のチェック
echo -e "\n${BLUE}ステップ 1: 前提条件のチェック${NC}"
echo "================================"

# Git のチェック
if command_exists git; then
    print_success "Git がインストールされています ($(git --version))"
else
    print_error "Git がインストールされていません"
    echo "Git をインストールしてください: https://git-scm.com/"
    exit 1
fi

# Claude Code のチェック
if command_exists claude; then
    print_success "Claude Code がインストールされています ($(claude --version 2>/dev/null || echo 'バージョン確認失敗'))"
else
    print_warning "Claude Code CLI が見つかりません"
    echo "インストール先: https://code.claude.com/docs"
    read -p "Claude Code なしで続行しますか？ (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# ステップ 2: Vault の場所選択
echo -e "\n${BLUE}ステップ 2: Vault の場所選択${NC}"
echo "================================"

# デフォルトの場所
DEFAULT_VAULT="$HOME/Documents/ObsidianPKM"
read -p "Vault を作成する場所 [$DEFAULT_VAULT]: " VAULT_PATH
VAULT_PATH=${VAULT_PATH:-$DEFAULT_VAULT}

# チルダを展開
VAULT_PATH="${VAULT_PATH/#\~/$HOME}"

# ディレクトリの存在確認
if [ -d "$VAULT_PATH" ]; then
    print_warning "ディレクトリが既に存在します: $VAULT_PATH"
    read -p "既存のディレクトリを使用しますか？ファイルが上書きされる可能性があります (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "セットアップをキャンセルしました"
        exit 1
    fi
else
    mkdir -p "$VAULT_PATH"
    print_success "Vault ディレクトリを作成しました: $VAULT_PATH"
fi

# ステップ 3: Vault テンプレートのコピー
echo -e "\n${BLUE}ステップ 3: Vault 構造のセットアップ${NC}"
echo "====================================="

# スクリプトディレクトリの取得
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="$SCRIPT_DIR/../vault-template"

# テンプレートファイルのコピー
print_info "テンプレートファイルをコピー中..."
cp -r "$TEMPLATE_DIR"/* "$VAULT_PATH/" 2>/dev/null || true
cp -r "$TEMPLATE_DIR"/.* "$VAULT_PATH/" 2>/dev/null || true
print_success "Vault 構造を作成しました"

# ステップ 4: Claude コマンドのセットアップ
echo -e "\n${BLUE}ステップ 4: Claude コマンドのセットアップ${NC}"
echo "======================================"

if command_exists claude; then
    # コマンドは既に vault-template/.claude/commands/ にあります
    # Claude を初期化するだけでよい
    cd "$VAULT_PATH"

    # コマンドがコピーされたか確認
    if [ -d "$VAULT_PATH/.claude/commands" ]; then
        print_success "Claude コマンドは既に配置されています"
    else
        print_warning "Claude コマンドディレクトリが見つかりません"
    fi

    # Vault 内で Claude を初期化
    if claude init >/dev/null 2>&1; then
        print_success "Vault 内で Claude Code を初期化しました"
    else
        print_warning "Claude Code の初期化が完了しませんでした。後で '$VAULT_PATH' 内で 'claude init' を実行できます。"
    fi
else
    print_warning "Claude Code のセットアップをスキップ（インストールされていません）"
fi

# ステップ 5: Git の初期化
echo -e "\n${BLUE}ステップ 5: Git リポジトリのセットアップ${NC}"
echo "==============================="

cd "$VAULT_PATH"

if [ -d .git ]; then
    print_warning "Git リポジトリは既に存在します"
else
    git init
    print_success "Git リポジトリを初期化しました"
fi

# Git の設定
read -p "Git コミット用の名前を入力: " GIT_NAME
read -p "Git コミット用のメールアドレスを入力: " GIT_EMAIL

if [ -n "$GIT_NAME" ]; then
    git config user.name "$GIT_NAME"
    print_success "Git ユーザー名を設定しました"
fi

if [ -n "$GIT_EMAIL" ]; then
    git config user.email "$GIT_EMAIL"
    print_success "Git メールアドレスを設定しました"
fi

# 初回コミット
git add .
git commit -m "Initial PKM setup" 2>/dev/null || print_warning "コミットするものがありません"

# ステップ 6: GitHub セットアップ（オプション）
echo -e "\n${BLUE}ステップ 6: GitHub 連携（オプション）${NC}"
echo "========================================="

read -p "GitHub 連携をセットアップしますか？ (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "GitHub リポジトリの URL を入力（スキップする場合は Enter）: " GITHUB_URL

    if [ -n "$GITHUB_URL" ]; then
        git remote add origin "$GITHUB_URL" 2>/dev/null || git remote set-url origin "$GITHUB_URL"
        print_success "GitHub リモートを設定しました"

        read -p "今すぐ GitHub にプッシュしますか？ (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git push -u origin main 2>/dev/null || git push -u origin master
            print_success "GitHub にプッシュしました"
        fi

        # GitHub Action のセットアップ
        mkdir -p "$VAULT_PATH/.github/workflows"
        cp "$SCRIPT_DIR/../github-actions/claude.yml" "$VAULT_PATH/.github/workflows/"
        print_success "GitHub Action ワークフローをコピーしました"
        print_warning "リポジトリのシークレットに CLAUDE_CODE_OAUTH_TOKEN を追加することを忘れないでください"
    fi
fi

# ステップ 7: パーソナライゼーション
echo -e "\n${BLUE}ステップ 7: 初期パーソナライゼーション${NC}"
echo "===================================="

print_info "システムをパーソナライズしましょう..."

# 個人的なミッションを取得
echo -e "\nあなたの個人的なミッションや人生の目的は何ですか？"
echo "（例: 「バランスを保ちながら意味のあるテクノロジーを構築する」）"
read -p "あなたのミッション: " MISSION

if [ -n "$MISSION" ]; then
    # CLAUDE.md を更新
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/\[CUSTOMIZE THIS: Add your personal mission statement or life purpose here\]/$MISSION/" "$VAULT_PATH/CLAUDE.md"
    else
        # Linux
        sed -i "s/\[CUSTOMIZE THIS: Add your personal mission statement or life purpose here\]/$MISSION/" "$VAULT_PATH/CLAUDE.md"
    fi
    print_success "個人的なミッションを追加しました"
fi

# 現在のフォーカスを取得
echo -e "\n今の主なフォーカスは何ですか？"
read -p "現在のフォーカス: " FOCUS

# 最初のデイリーノートを作成
TODAY=$(date +%Y-%m-%d)
DAILY_NOTE="$VAULT_PATH/Daily Notes/$TODAY.md"

if [ ! -f "$DAILY_NOTE" ]; then
    print_info "最初のデイリーノートを作成中..."
    cp "$VAULT_PATH/Templates/Daily Template.md" "$DAILY_NOTE"

    # デイリーノートにフォーカスを追加
    if [ -n "$FOCUS" ]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s/\*\*Today's Priority:\*\*/\*\*今日の優先事項:\*\* $FOCUS/" "$DAILY_NOTE"
        else
            sed -i "s/\*\*Today's Priority:\*\*/\*\*今日の優先事項:\*\* $FOCUS/" "$DAILY_NOTE"
        fi
    fi

    print_success "最初のデイリーノートを作成しました: $TODAY.md"
fi

# ステップ 8: 最終セットアップ
echo -e "\n${BLUE}ステップ 8: セットアップの完了${NC}"
echo "==========================="

# セットアップ完了マーカーを作成
echo "Setup completed on $(date)" > "$VAULT_PATH/.setup_complete"

# パーソナライゼーションをコミット
cd "$VAULT_PATH"
git add .
git commit -m "Personalized PKM setup" 2>/dev/null || true

# サマリー
echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✨ セットアップ完了！${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo "PKM システムの準備ができました: $VAULT_PATH"
echo ""
echo "次のステップ:"
echo "1. Obsidian を開いて Vault フォルダを選択"
echo "2. Goals フォルダを確認して目標を設定"
echo "3. デイリーノートを使い始める: claude code /daily"
echo "4. ウィークリーレビューを実行: claude code /weekly"
echo ""
echo "クイックコマンド:"
echo "  cd \"$VAULT_PATH\"     # Vault に移動"
echo "  claude code /onboard  # Claude にコンテキストをロード"
echo "  claude code /daily    # 今日のノートを作成"
echo "  claude code /push     # Git に変更を保存"
echo ""
print_info "詳細なガイダンスは docs/ 内のドキュメントをお読みください"
print_success "Happy note-taking! 🚀"

# Obsidian を開く
if [[ "$OSTYPE" == "darwin"* ]]; then
    if [ -d "/Applications/Obsidian.app" ]; then
        read -p "今すぐ Obsidian を開きますか？ (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # obsidian URL 経由で直接この vault を開こうとする
            if command_exists python3; then
                ENCODED_PATH=$(python3 -c "import urllib.parse,sys;print(urllib.parse.quote(sys.argv[1]))" "$VAULT_PATH")
                open "obsidian://open?path=$ENCODED_PATH" || open -a Obsidian
            else
                open -a Obsidian
            fi
            print_success "Obsidian を起動しました"
        fi
    fi
elif command_exists obsidian; then
    read -p "今すぐ Obsidian を開きますか？ (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Linux の場合、xdg-open が利用可能であれば obsidian URL を試す
        if command_exists xdg-open && command_exists python3; then
            ENCODED_PATH=$(python3 -c "import urllib.parse,sys;print(urllib.parse.quote(sys.argv[1]))" "$VAULT_PATH")
            xdg-open "obsidian://open?path=$ENCODED_PATH" >/dev/null 2>&1 || obsidian &
        else
            obsidian &
        fi
        print_success "Obsidian を起動しました"
    fi
fi
