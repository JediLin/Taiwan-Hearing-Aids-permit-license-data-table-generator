@echo off
:start
chcp 65001
cls

IF NOT EXIST "G3300.xsl" (
  echo 缺少 G3300.xsl 檔案，無法處理資料表。請把 G3300.xsl 跟 update.bat 放在同一個資料夾內，然後再試一次。請按任意鍵結束……
  pause > nul
  exit
)
IF NOT EXIST "wget.exe" (
  echo 請先取得 GNU Wget 執行檔。現在即將使用預設瀏覽器帶您前往 GNU Wget 下載網頁，請按任意鍵繼續……
  pause > nul
  start "" "https://eternallybored.org/misc/wget/"
  exit
)
IF NOT EXIST "unzip.exe" (
  echo 請先取得 UnZip 執行檔。現在即將使用預設瀏覽器下載 UnZip，請按任意鍵繼續……
  pause > nul
  start "" "https://gnuwin32.sourceforge.net/downlinks/unzip-bin-zip.php"
  exit
)
IF NOT EXIST "xml.exe" (
  echo 請先取得 XMLStarlet 工具執行檔。現在即將使用預設瀏覽器下載 XMLStarlet，請按任意鍵繼續……
  pause > nul
  start "" "https://sourceforge.net/projects/xmlstar/files/latest/download"
  exit
)
IF EXIST "G3300.html" (
  del /F /Q G3300.bak.html
  copy /Y G3300.html G3300.bak.html
)

:download
wget.exe --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:53.0) Gecko/20100101 Firefox/53.0" --output-document=68_1.xml.zip "https://data.fda.gov.tw/opendata/exportDataList.do?method=ExportData&InfoId=68&logType=1"

IF EXIST "68_1.xml.zip" (
  GOTO unzip
) ELSE (
  GOTO download
)

:unzip
IF %@FILESIZE["68_1.xml.zip"] == 0 (
  del /F /Q 68_1.xml.zip
  GOTO download
) ELSE (
  unzip.exe 68_1.xml.zip
)

:cont
xml.exe tr G3300.xsl 68_1.xml > G3300.html

IF EXIST "G3300.html" (
  del /F /Q 68_1.xml
  del /F /Q 68_1.xml.zip
  GOTO end
) ELSE (
  GOTO cont
)

:end
del /F /Q *.
cls
echo 資料表產生完成。現在即將使用預設瀏覽器開啟資料表 (G3300.html)，請按任意鍵繼續……
pause > nul
start "" "G3300.html"
exit
