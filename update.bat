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

IF NOT EXIST "G3300.xsl" (
  IF %colorSupport%==Yes (
    echo [31m⚠[0m  缺少 [32mG3300.xsl[0m 檔案，無法處理資料表。請把 G3300.xsl 跟 update.bat 放在同一個資料夾內，然後再試一次。請按任意鍵結束……
  ) ELSE (
    echo 錯誤：缺少 G3300.xsl 檔案，無法處理資料表。請把 G3300.xsl 跟 update.bat 放在同一個資料夾內，然後再試一次。請按任意鍵結束……
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

:checkconnection
wget.exe -q -O NUL "https://data.fda.gov.tw/"
IF ERRORLEVEL 1 (
  IF %colorSupport%==Yes (
    echo [31m⚠[0m  無法連上政府資料開放平臺網站。請按任意鍵結束……
  ) ELSE (
    echo 無法連上政府資料開放平臺網站。請按任意鍵結束……
  )
  pause > nul
  exit
)

IF EXIST "G3300.html" (
  IF %colorSupport%==Yes (
    echo ○○○○[0/4][35m💾[0m 發現先前製作的資料表，自動備份為 [32mG3300.bak.html[0m
  ) ELSE (
    echo ○○○○[0/4] 發現先前製作的資料表，自動備份為 G3300.bak.html
  )
  echo:
  del /F /Q G3300.bak.html > nul 2>&1
  copy /Y G3300.html G3300.bak.html > nul
  timeout /t 2 > nul
)

cls
:download
IF %colorSupport%==Yes (
  echo [1;32m●[0m○○○[1/4][34m📦[0m 正在從政府資料開放平臺下載醫療器材許可證資料集……
) ELSE (
  echo ●○○○[1/4] 正在從政府資料開放平臺下載醫療器材許可證資料集……
)
echo:
wget.exe --output-document=68_1.xml.zip "https://data.fda.gov.tw/opendata/exportDataList.do?method=ExportData&InfoId=68&logType=1"

IF EXIST "68_1.xml.zip" (
  GOTO unzip
) ELSE (
  echo:
  IF %colorSupport%==Yes (
    echo [33m⟲[0m  檔案下載出了問題，正在重試……
  ) ELSE (
    echo 檔案下載出了問題，正在重試……
  )
  echo:
  GOTO download
)

:unzip
IF %@FILESIZE["68_1.xml.zip"] == 0 (
  del /F /Q 68_1.xml.zip
  echo:
  IF %colorSupport%==Yes (
    echo [33m⟲[0m  檔案下載出了問題，正在重試……
  ) ELSE (
    echo 檔案下載出了問題，正在重試……
  )
  echo:
  GOTO download
) ELSE (
  cls
  IF %colorSupport%==Yes (
    echo [1;32m●●[0m○○[2/4][36m📖[0m 資料集已下載，正在解壓縮……
  ) ELSE (
    echo ●●○○[2/4] 資料集已下載，正在解壓縮……
  )
  echo:
  unzip.exe 68_1.xml.zip
  timeout /t 1 > nul
)

:cont
cls
IF %colorSupport%==Yes (
  echo [1;32m●●●[0m○[3/4][35m🦻[0m 正在轉換產製資料表，這個步驟可能耗時約一分鐘，請耐心等候……
) ELSE (
  echo ●●●○[3/4] 正在轉換產製資料表，這個步驟可能耗時約一分鐘，請耐心等候……
)
echo:
xml.exe tr G3300.xsl 68_1.xml > G3300.html

IF EXIST "G3300.html" (
  del /F /Q 68_1.xml
  del /F /Q 68_1.xml.zip
  GOTO end
) ELSE (
  echo:
  IF %colorSupport%==Yes (
    echo [33m⟲[0m  轉換產製資料表出了問題，正在重試……
  ) ELSE (
    echo 轉換產製資料表出了問題，正在重試……
  )
  echo:
  GOTO cont
)

:end
del /F /Q *.
cls
IF %colorSupport%==Yes (
  echo [1;32m●●●●[0m[4/4][32m✅[0m 資料表產生完成。即將使用預設瀏覽器開啟資料表 ^([32mG3300.html[0m^)，請按任意鍵繼續……
) ELSE (
  echo ●●●●[4/4] 資料表產生完成。即將使用預設瀏覽器開啟資料表 ^(G3300.html^)，請按任意鍵繼續……
)
pause > nul
start "" "G3300.html"
exit
