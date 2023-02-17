# Send Slack Message
コマンドプロンプトから簡単にSlackにメッセージを送信するためのバッチファイルです。

# 必要事項
- Incoming Webhookを使えるようにしたSlack Appを作成し、Webhook URLを発行していること

# 使用方法
## メッセージを送信する
コマンドプロンプトで`start_projection.bat`を実行します。
```
send_slack_msg [オプション] <message> <webhook_url>
```

`send_slack_msg`は2つの引数を必要とします。

- `<message>`     : メッセージの内容
- `<webhook_url>` : Slack AppのIncoming Webhookで設定されたURL

オプション
  - `-h, --help` 使用方法を表示します

例："PCは正常に稼働しています"というメッセージを`https://hooks.slack.com/services/example/example/example`に送信する場合
```
send_slack_msg PCは正常に稼働しています https://hooks.slack.com/services/example/example/example
```