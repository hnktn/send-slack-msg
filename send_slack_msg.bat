@chcp 65001 > nul


:: コマンドプロンプトから簡単にSlackにメッセージを送信するためのバッチファイル 

:: 使用方法 : send_slack_msg [オプション] <message> <webhook_url> 
::  -h, --help 使用方法を表示します 
:: <message>     : メッセージの内容 
:: <webhook_url> : SlackのIncoming Webhookで設定されたurl 


@echo off
setlocal

set selfname=%~n0

:: 引数無し、もしくは--helpオプションが使用された際は使用方法を表示する 
if "%1"=="" (
    call :usage
    exit /b 0
)

if "%1"=="-h" (
    call :usage
    exit /b 0
)

if "%1"=="--help" (
    call :usage
    exit /b 0
)

:: 引数が不足している、もしくは多い時にエラーメッセージを出力しバッチファイルを終了する 
set expected_args=2

set arg_count=0
for %%x in (%*) do set /a arg_count+=1

if %arg_count% lss %expected_args% (
    echo エラー: 引数が不足しています 
    echo "%selfname% --help" で使用方法を確認できます 
    exit /b 1
) else if %arg_count% gtr %expected_args% (
    echo エラー: 不要な引数が渡されました 
    echo "%selfname% --help" で使用方法を確認できます 
    exit /b 1
)

:: 変数に引数を代入 
set message=%1
set webhook_url=%2

:: メッセージの内容をファイルに出力 (UTF-8で出力するため) 
echo {"text":"%message%"} > data.json

if %errorlevel%==1 (
    echo 一時ファイルの出力に失敗しました 
    exit /b 1
)

:: curlでSlackにメッセージを送信 
curl -X POST -H "Content-type: application/json" --data @data.json %webhook_url%

if %errorlevel%==0 (
    echo メッセージの送信に成功しました

    :: 出力した一時ファイルを削除 
    del data.json

    exit /b 0
) else (
    echo メッセージの送信に失敗しました
    echo 引数の内容が正しいか確認してください

    :: 出力した一時ファイルを削除 
    del data.json

    exit /b 1
)


:: サブルーチン 

:usage
echo 使用方法 : send_slack_msg [オプション] ^<message^> ^<webhook_url^> 
echo  -h, --help 使用方法を表示します 
echo ^<message^>     : メッセージの内容 
echo ^<webhook_url^> : SlackのIncoming Webhookで設定されたurl 