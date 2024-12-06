@echo off
:start
echo Start at %date% %time% > silent_update.log

IF NOT EXIST "G3300.xsl" (
  echo %time% No G3300.xsl available >> silent_update.log
  exit
)
IF NOT EXIST "wget.exe" (
  echo %time% No wget.exe available >> silent_update.log
  exit
)
IF NOT EXIST "unzip.exe" (
  echo %time% No unzip.exe available >> silent_update.log
  exit
)
IF NOT EXIST "xml.exe" (
  echo %time% no xml.exe available >> silent_update.log
  exit
)

:checkconnection
wget.exe -O NUL --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:53.0) Gecko/20100101 Firefox/53.0" "https://data.fda.gov.tw/" >> silent_update.log 2>&1
IF ERRORLEVEL 1 (
  echo %time% No connection available >> silent_update.log
  exit
)

IF EXIST "G3300.html" (
  echo %time% Backup G3300.html >> silent_update.log
  del /F /Q G3300.bak.html >> silent_update.log 2>&1
  copy /Y G3300.html G3300.bak.html >> silent_update.log 2>&1
)

:download
echo %time% Download XML >> silent_update.log
wget.exe --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:53.0) Gecko/20100101 Firefox/53.0" --output-document=68_1.xml.zip "https://data.fda.gov.tw/opendata/exportDataList.do?method=ExportData&InfoId=68&logType=1" >> silent_update.log 2>&1

IF EXIST "68_1.xml.zip" (
  GOTO unzip
) ELSE (
  GOTO download
)

:unzip
IF %@FILESIZE["68_1.xml.zip"] == 0 (
  del /F /Q 68_1.xml.zip >> silent_update.log 2>&1
  GOTO download
) ELSE (
  echo %time% Unzip file >> silent_update.log
  unzip.exe 68_1.xml.zip >> silent_update.log 2>&1
)

:cont
echo %time% Process XML >> silent_update.log
xml.exe tr G3300.xsl 68_1.xml > G3300.html

IF EXIST "G3300.html" (
  echo %time% Clean-up >> silent_update.log
  del /F /Q 68_1.xml >> silent_update.log 2>&1
  del /F /Q 68_1.xml.zip >> silent_update.log 2>&1
  GOTO end
) ELSE (
  GOTO cont
)

:end
del /F /Q *. >> silent_update.log 2>&1
echo %time% Finished. >> silent_update.log
exit
