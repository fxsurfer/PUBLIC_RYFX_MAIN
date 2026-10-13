# EA Deploy Sets

MT4用EAの配布セット集です。各フォルダが1セットで、MT4データフォルダと同じ構造になっています。

## 導入 (PowerShell)

```powershell
git clone <このリポジトリのURL>
cd <リポジトリ>
.\install.ps1 -List
.\install.ps1 -Set <セット名> -DataFolder "C:\Users\<user>\AppData\Roaming\MetaQuotes\Terminal\<ID>"
```

更新は `git pull` してから再度 `install.ps1` を実行します。

## 注意

- 本リポジトリのEAは自己責任でご利用ください。投資成果を保証するものではありません。
- 設定ファイル(`MQL4\Presets\*.set`)は推奨値です。運用資金・口座に合わせて見直してください。

## 必須設定: ニュースフィルター用のURL許可

EAは経済指標カレンダーを `https://nfs.faireconomy.media` から取得します。
MT4の「ツール → オプション → エキスパートアドバイザ」で「WebRequestを許可するURL」に追加してください。
**未設定でもエラーにはならず、ニュースフィルターなしで動作します。**
取得できているかは、「エキスパート」タブに `[NEWS]` の行が出るかで確認できます(`WebRequest失敗` と出たら未許可)。

サーバー時刻の補正値(`NewsServerGMTOffset`)は、XMの冬時間(GMT+2)に合わせてあります。
他のブローカーや夏時間では、指標の時刻が1時間ずれることがあります。
