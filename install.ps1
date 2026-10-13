# 使い方:
#   .\install.ps1 -Set <セット名> [-DataFolder "C:\Users\...\MetaQuotes\Terminal\<ID>"]
#   .\install.ps1 -List
# DataFolder 省略時は MT4 の「ファイル→データフォルダを開く」の場所を入力してください。
param(
    [string]$Set,
    [string]$DataFolder,
    [switch]$List
)
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$sets = Get-ChildItem $root -Directory | Where-Object { Test-Path (Join-Path $_.FullName "MQL4") }

if ($List -or -not $Set) {
    "利用可能なセット:"; $sets | ForEach-Object { "  " + $_.Name }; return
}
$src = Join-Path $root $Set
if (-not (Test-Path $src)) { throw "セットが見つかりません: $Set" }
if (-not $DataFolder) { $DataFolder = Read-Host "MT4データフォルダのパス" }
if (-not (Test-Path (Join-Path $DataFolder "MQL4"))) { throw "MQL4 フォルダが見つかりません: $DataFolder" }

Copy-Item (Join-Path $src "MQL4") $DataFolder -Recurse -Force
$tpl = Join-Path $root "templates"
if (Test-Path $tpl) { Copy-Item $tpl $DataFolder -Recurse -Force }
"導入完了: $Set → $DataFolder"
"MT4を再起動し、.ex4/.mq4 はナビゲーターのエキスパートアドバイザに表示されます。"
"設定は MQL4\Presets\*.set をEAのプロパティ→読み込むで適用してください。"
"ニュースフィルター使用時: ツール→オプション→エキスパートアドバイザ で https://nfs.faireconomy.media を許可。"
