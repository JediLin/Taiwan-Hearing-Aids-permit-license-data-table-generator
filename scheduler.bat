@echo off
:start
cd "%~dp0"
chcp 65001
FOR /f "tokens=3-7 delims=[.] " %%i in ('ver') do @(if %%i==XP (set os_ver_org=%%k.%%l) else (if %%j geq 10 (set os_ver_org=%%j.%%k.%%l) else (set os_ver_org=%%j.%%k)))
set os_ver=%os_ver_org%
IF %os_ver_org:~0,1% gtr 3 set os_ver=0%os_ver_org%
set colorSupport=No
IF %os_ver% GEQ 10.0.10586 set colorSupport=Yes
IF %colorSupport%==Yes color
cls

IF NOT EXIST "silent_update.bat" (
  IF %colorSupport%==Yes (
    echo [31m⚠[0m  缺少 [32msilent_update.bat[0m 檔案，請檢查資料表產生器檔案是否完整。現在即將使用預設瀏覽器帶您前往資料表產生器下載網頁，請按任意鍵繼續……
  ) ELSE (
    echo 錯誤：缺少 silent_update.bat 檔案，請檢查資料表產生器檔案是否完整。現在即將使用預設瀏覽器帶您前往資料表產生器下載網頁，請按任意鍵繼續……
  )
  pause > nul
  start "" "https://github.com/JediLin/Taiwan-Assistive-Technology-medical-device-permit-license-data-table-generator/releases/latest"
  exit
)
IF NOT EXIST "G3300.xsl" (
  IF %colorSupport%==Yes (
    echo [31m⚠[0m  缺少 [32mG3300.xsl[0m 檔案，無法處理資料表。請把 G3300.xsl 跟 silent_update.bat 放在同一個資料夾內，然後再試一次。請按任意鍵結束……
  ) ELSE (
    echo 錯誤：缺少 G3300.xsl 檔案，無法處理資料表。請把 G3300.xsl 跟 silent_update.bat 放在同一個資料夾內，然後再試一次。請按任意鍵結束……
  )
  pause > nul
  exit
)
IF NOT EXIST "wget.exe" (
  IF %colorSupport%==Yes (
    echo [36m🔰[0m 請先取得 [32mGNU Wget[0m 執行檔。現在即將使用預設瀏覽器帶您前往 GNU Wget 下載網頁，請按任意鍵繼續……
  ) ELSE (
    echo 請先取得 GNU Wget 執行檔。現在即將使用預設瀏覽器帶您前往 GNU Wget 下載網頁，請按任意鍵繼續……
  )
  pause > nul
  start "" "https://eternallybored.org/misc/wget/"
  exit
)
IF NOT EXIST "unzip.exe" (
  IF %colorSupport%==Yes (
    echo [36m🔰[0m 請先取得 [32mUnZip[0m 執行檔。現在即將使用預設瀏覽器下載 UnZip，請按任意鍵繼續……
  ) ELSE (
    echo 請先取得 UnZip 執行檔。現在即將使用預設瀏覽器下載 UnZip，請按任意鍵繼續……
  )
  pause > nul
  start "" "https://gnuwin32.sourceforge.net/downlinks/unzip-bin-zip.php"
  exit
)
IF NOT EXIST "xml.exe" (
  IF %colorSupport%==Yes (
    echo [36m🔰[0m 請先取得 [32mXMLStarlet[0m 工具執行檔。現在即將使用預設瀏覽器下載 XMLStarlet，請按任意鍵繼續……
  ) ELSE (
    echo 請先取得 XMLStarlet 工具執行檔。現在即將使用預設瀏覽器下載 XMLStarlet，請按任意鍵繼續……
  )
  pause > nul
  start "" "https://sourceforge.net/projects/xmlstar/files/latest/download"
  exit
)
IF NOT EXIST "G3300.html" (
  IF %colorSupport%==Yes (
    echo [36m🔰[0m 未發現 [32mG3300.html[0m 檔案，無法確認是否已能正確處理資料表。現在即將執行 [33mupdate.bat[0m，請在確認成功後再嘗試加入排程自動執行。
  ) ELSE (
    echo 未發現 G3300.html 檔案，無法確認是否已能正確處理資料表。現在即將執行 update.bat，請在確認成功後再嘗試加入排程自動執行。
  )
  echo.
  echo 請按任意鍵繼續……
  pause > nul
  IF NOT EXIST "update.bat" (
    IF %colorSupport%==Yes (
      echo [31m⚠[0m  缺少 [32mupdate.bat[0m 檔案，請檢查資料表產生器檔案是否完整。現在即將使用預設瀏覽器帶您前往資料表產生器下載網頁，請按任意鍵繼續……
    ) ELSE (
      echo 錯誤：缺少 update.bat 檔案，請檢查資料表產生器檔案是否完整。現在即將使用預設瀏覽器帶您前往資料表產生器下載網頁，請按任意鍵繼續……
    )
    pause > nul
    start "" "https://github.com/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator/releases/latest"
    exit
  )
  cls
  call update.bat
  exit
)

:menu
cls
IF %colorSupport%==Yes (
  echo ^[[33m助聽器醫材字號資料表產生器[0m^] 排程管理
  echo.
  echo. [32m1[0m. 自動設定排程
  echo. [32m2[0m. 測試排程
  echo. [32m3[0m. 刪除排程
  echo. [32m4[0m. 手動排程
  echo. [32m5[0m. 結束
  echo.
) ELSE (
  echo ^[助聽器醫材字號資料表產生器^] 排程管理
  echo.
  echo. 1. 自動設定排程
  echo. 2. 測試排程
  echo. 3. 刪除排程
  echo. 4. 手動排程
  echo. 5. 結束
  echo.
)
choice /C 12345 /N /M "請輸入操作選項 [1-5]： "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO manual
IF ERRORLEVEL 3 GOTO remove
IF ERRORLEVEL 2 GOTO try
IF ERRORLEVEL 1 GOTO update
IF ERRORLEVEL 0 GOTO end
GOTO end

:update
echo.
echo 即將採用下列參數，自動設定排程項目：
echo.
IF %colorSupport%==Yes (
  echo [32m名稱[0m
) ELSE (
  echo 名稱
)
echo.    自動更新助聽器醫材字號資料表
echo.
IF %colorSupport%==Yes (
  echo [32m觸發程序[0m
) ELSE (
  echo 觸發程序
)
echo.    在每季（一月、四月、七月、十月）的第二個星期三，下午兩點半左右執行
echo.
IF %colorSupport%==Yes (
  echo [32m動作[0m
) ELSE (
  echo 動作
)
echo.   cmd /C start "自動更新助聽器醫材字號資料表" /D "%cd%" "%~dp0silent_update.bat" 
echo.
IF %colorSupport%==Yes (
  echo [31m⚠[0m  請注意：如果已經存在相同名稱的排程項目，會以上述參數覆蓋。
) ELSE (
  echo 請注意：如果已經存在相同名稱的排程項目，會以上述參數覆蓋。
)
echo.
choice /C YN /N /M "請問是否要設定排程項目？是 (Y)／否 (N) "
IF ERRORLEVEL 2 GOTO menu
IF ERRORLEVEL 1 GOTO doupdate
IF ERRORLEVEL 0 GOTO end
GOTO end

:doupdate
echo.
schtasks /Create /SC MONTHLY /M JAN,APR,JUL,OCT /MO SECOND /D WED /ST 14:30 /TN "自動更新助聽器醫材字號資料表" /TR "cmd /C start '自動更新助聽器醫材字號資料表' /D '%cd%' '%~dp0silent_update.bat'" /F
echo.
echo 設定完成。
echo.
choice /C YN /N /M "請問是否要啟動工作排程器，確認排程詳情？是 (Y)／否 (N) "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO manual
IF ERRORLEVEL 0 GOTO end
GOTO end

:try
echo.
schtasks /Run /TN "自動更新助聽器醫材字號資料表"
echo.
echo 測試完成，請按任意鍵繼續……
pause > nul
GOTO menu

:remove
echo.
IF %colorSupport%==Yes (
  echo [31m⚠[0m  警告：本操作將刪除任何名稱為「[32m自動更新助聽器醫材字號資料表[0m」的排程項目。
) ELSE (
  echo 警告：本操作將刪除任何名稱為「自動更新助聽器醫材字號資料表」的排程項目。
)
echo.
choice /C YN /N /M "請問是否要刪除排程項目？是 (Y)／否 (N) "
IF ERRORLEVEL 2 GOTO menu
IF ERRORLEVEL 1 GOTO doremove
IF ERRORLEVEL 0 GOTO end
GOTO end

:doremove
echo.
schtasks /Delete /TN "自動更新助聽器醫材字號資料表" /F
echo.
echo 排程已刪除。
echo.
choice /C YN /N /M "請問是否要啟動工作排程器，確認刪除結果？是 (Y)／否 (N) "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO manual
IF ERRORLEVEL 0 GOTO end
GOTO end

:manual
taskschd.msc
GOTO end

:end
exit
