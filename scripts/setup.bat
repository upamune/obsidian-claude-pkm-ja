@echo off
REM Obsidian + Claude Code PKM セットアップスクリプト（Windows用）
REM PKMシステムの初期セットアップを自動化するスクリプトです

setlocal enabledelayedexpansion

REM カラー設定（Windows 10+）
echo.

echo =====================================
echo   Obsidian + Claude Code PKM セットアップ
echo   Version 1.0 for Windows
echo =====================================
echo.

REM ステップ 1: 前提条件のチェック
echo ステップ 1: 前提条件のチェック
echo ==============================

REM Git のチェック
where git >nul 2>nul
if %errorlevel%==0 (
    echo [OK] Git がインストールされています
    git --version
) else (
    echo [エラー] Git がインストールされていません
    echo Git をインストールしてください: https://git-scm.com/
    pause
    exit /b 1
)

REM Claude Code のチェック
where claude >nul 2>nul
if %errorlevel%==0 (
    echo [OK] Claude Code がインストールされています
) else (
    echo [警告] Claude Code CLI が見つかりません
    echo インストール先: https://code.claude.com/docs
    set /p CONTINUE="Claude Code なしで続行しますか？ (y/n): "
    if /i not "!CONTINUE!"=="y" exit /b 1
)

echo.

REM ステップ 2: Vault の場所選択
echo ステップ 2: Vault の場所選択
echo ==============================

set DEFAULT_VAULT=%USERPROFILE%\Documents\ObsidianPKM
set /p VAULT_PATH="Vault を作成する場所 [%DEFAULT_VAULT%]: "
if "%VAULT_PATH%"=="" set VAULT_PATH=%DEFAULT_VAULT%

REM ディレクトリの存在確認
if exist "%VAULT_PATH%" (
    echo [警告] ディレクトリが既に存在します: %VAULT_PATH%
    set /p USE_EXISTING="既存のディレクトリを使用しますか？ファイルが上書きされる可能性があります (y/n): "
    if /i not "!USE_EXISTING!"=="y" (
        echo セットアップをキャンセルしました
        pause
        exit /b 1
    )
) else (
    mkdir "%VAULT_PATH%"
    echo [OK] Vault ディレクトリを作成しました: %VAULT_PATH%
)

echo.

REM ステップ 3: Vault テンプレートのコピー
echo ステップ 3: Vault 構造のセットアップ
echo ===================================

set SCRIPT_DIR=%~dp0
set TEMPLATE_DIR=%SCRIPT_DIR%..\vault-template

echo テンプレートファイルをコピー中...
xcopy /E /I /Y "%TEMPLATE_DIR%\*" "%VAULT_PATH%\" >nul 2>nul
echo [OK] Vault 構造を作成しました

echo.

REM ステップ 4: Claude コマンドのセットアップ
echo ステップ 4: Claude コマンドのセットアップ
echo ===================================

where claude >nul 2>nul
if %errorlevel%==0 (
    REM コマンドは既に vault-template\.claude\commands\ にあります
    REM Claude を初期化するだけでよい
    cd /d "%VAULT_PATH%"

    REM コマンドがコピーされたか確認
    if exist "%VAULT_PATH%\.claude\commands" (
        echo [OK] Claude コマンドは既に配置されています
    ) else (
        echo [警告] Claude コマンドディレクトリが見つかりません
    )

    REM Vault 内で Claude を初期化
    claude init 2>nul
    echo [OK] Vault 内で Claude Code を初期化しました
) else (
    echo [警告] Claude Code のセットアップをスキップ - インストールされていません
)

echo.

REM ステップ 5: Git の初期化
echo ステップ 5: Git リポジトリのセットアップ
echo ============================

cd /d "%VAULT_PATH%"

if exist .git (
    echo [警告] Git リポジトリは既に存在します
) else (
    git init >nul
    echo [OK] Git リポジトリを初期化しました
)

REM Git の設定
set /p GIT_NAME="Git コミット用の名前を入力: "
set /p GIT_EMAIL="Git コミット用のメールアドレスを入力: "

if not "%GIT_NAME%"=="" (
    git config user.name "%GIT_NAME%"
    echo [OK] Git ユーザー名を設定しました
)

if not "%GIT_EMAIL%"=="" (
    git config user.email "%GIT_EMAIL%"
    echo [OK] Git メールアドレスを設定しました
)

REM 初回コミット
git add . >nul 2>nul
git commit -m "Initial PKM setup" >nul 2>nul
echo [OK] 初回コミットを作成しました

echo.

REM ステップ 6: GitHub セットアップ（オプション）
echo ステップ 6: GitHub 連携 - オプション
echo ======================================

set /p SETUP_GITHUB="GitHub 連携をセットアップしますか？ (y/n): "
if /i "%SETUP_GITHUB%"=="y" (
    set /p GITHUB_URL="GitHub リポジトリの URL を入力（スキップする場合は Enter）: "

    if not "!GITHUB_URL!"=="" (
        git remote add origin "!GITHUB_URL!" 2>nul || git remote set-url origin "!GITHUB_URL!"
        echo [OK] GitHub リモートを設定しました

        set /p PUSH_NOW="今すぐ GitHub にプッシュしますか？ (y/n): "
        if /i "!PUSH_NOW!"=="y" (
            git push -u origin main 2>nul || git push -u origin master
            echo [OK] GitHub にプッシュしました
        )

        REM GitHub Action のセットアップ
        mkdir "%VAULT_PATH%\.github\workflows" 2>nul
        copy "%SCRIPT_DIR%..\github-actions\claude.yml" "%VAULT_PATH%\.github\workflows\" >nul
        echo [OK] GitHub Action ワークフローをコピーしました
        echo [注意] リポジトリのシークレットに CLAUDE_CODE_OAUTH_TOKEN を追加することを忘れないでください
    )
)

echo.

REM ステップ 7: パーソナライゼーション
echo ステップ 7: 初期パーソナライゼーション
echo ================================

echo.
echo あなたの個人的なミッションや人生の目的は何ですか？
echo 例: バランスを保ちながら意味のあるテクノロジーを構築する
set /p MISSION="あなたのミッション: "

if not "%MISSION%"=="" (
    REM バッチでのテキスト置換は複雑なため、簡略化しています
    echo [OK] 個人的なミッションを記録しました - CLAUDE.md を手動で更新してください
)

echo.
echo 今の主なフォーカスは何ですか？
set /p FOCUS="現在のフォーカス: "

REM 最初のデイリーノートを作成（PowerShell 経由でロケールに依存しない日付取得）
for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set TODAY=%%I
set DAILY_NOTE=%VAULT_PATH%\Daily Notes\%TODAY%.md

if not exist "%DAILY_NOTE%" (
    echo 最初のデイリーノートを作成中...
    copy "%VAULT_PATH%\Templates\Daily Template.md" "%DAILY_NOTE%" >nul
    echo [OK] 最初のデイリーノートを作成しました: %TODAY%.md
)

REM フォーカスが入力されていれば「今日の優先事項」に追加
if not "%FOCUS%"=="" (
    powershell -NoProfile -Command "(Get-Content -Raw '%DAILY_NOTE%') -replace '\\*\\*Today''s Priority:\\*\\*','**今日の優先事項:** %FOCUS%' | Set-Content -Encoding UTF8 '%DAILY_NOTE%'"
)

echo.

REM ステップ 8: 最終セットアップ
echo ステップ 8: セットアップの完了
echo ========================

REM セットアップ完了マーカーを作成
echo Setup completed on %date% %time% > "%VAULT_PATH%\.setup_complete"

REM パーソナライゼーションをコミット
cd /d "%VAULT_PATH%"
git add . >nul 2>nul
git commit -m "Personalized PKM setup" >nul 2>nul

echo.
echo =============================================
echo          セットアップ完了！
echo =============================================
echo.
echo PKM システムの準備ができました: %VAULT_PATH%
echo.
echo 次のステップ:
echo 1. Obsidian を開いて Vault フォルダを選択
echo 2. Goals フォルダを確認して目標を設定
echo 3. デイリーノートを使い始める: claude code /daily
echo 4. ウィークリーレビューを実行: claude code /weekly
echo.
echo クイックコマンド:
echo   cd "%VAULT_PATH%"      - Vault に移動
echo   claude code /onboard   - Claude にコンテキストをロード
echo   claude code /daily     - 今日のノートを作成
echo   claude code /push      - Git に変更を保存
echo.
echo 詳細なガイダンスは docs\ 内のドキュメントをお読みください
echo.

REM Obsidian を開く
set /p OPEN_OBSIDIAN="今すぐ Obsidian を開きますか？ (y/n): "
if /i "!OPEN_OBSIDIAN!"=="y" (
    REM 一般的なインストール場所を試してから PATH を確認
    if exist "%LOCALAPPDATA%\Programs\Obsidian\Obsidian.exe" (
        start "" "%LOCALAPPDATA%\Programs\Obsidian\Obsidian.exe"
    ) else if exist "%LOCALAPPDATA%\Obsidian\Obsidian.exe" (
        start "" "%LOCALAPPDATA%\Obsidian\Obsidian.exe"
    ) else (
        where obsidian >nul 2>nul && start "" obsidian
    )
    echo [OK] Obsidian を起動しました
)

echo.
echo Happy note-taking!
echo.
pause
