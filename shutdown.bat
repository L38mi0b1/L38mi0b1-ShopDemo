@echo off
setlocal enabledelayedexpansion

REM ==== 目標時刻を設定（24時間表記） ====
if not "%~1"=="" (
    set TARGET_HOUR=%~1
)
if not "%~2"=="" (
    set TARGET_MIN=%~2
)

REM ==== 現在時刻を取得 ====
for /f "tokens=1-3 delims=/: " %%a in ("%time%") do (
    set NOW_HOUR=%%a
    set NOW_MIN=%%b
    set NOW_SEC=%%c
)

REM ==== 現在時刻を秒に変換 ====
set /a NOW_TOTAL=%NOW_HOUR%*3600 + %NOW_MIN%*60 + %NOW_SEC%

REM ==== 目標時刻を秒に変換 ====
set /a TARGET_TOTAL=%TARGET_HOUR%*3600 + %TARGET_MIN%*60

REM ==== 差分を計算 ====
set /a DIFF=%TARGET_TOTAL% - %NOW_TOTAL%

REM ==== もし目標時刻が過ぎていたら翌日にする ====
if %DIFF% lss 0 (
    set /a DIFF=%DIFF% + 86400
)

echo シャットダウンまで %DIFF% 秒です。
shutdown -s -t %DIFF%