@echo off
:start
IF EXIST "G3300.xml" (
  del /F /Q G3300.bak.xml
  copy /Y G3300.xml G3300.bak.xml
)

:download
wget --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:53.0) Gecko/20100101 Firefox/53.0" --output-document=68_1.xml.zip "https://data.fda.gov.tw/opendata/exportDataList.do?method=ExportData&InfoId=68&logType=1"

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
  "C:\Program Files\WinZip\WZUNZIP.EXE" 68_1.xml.zip
)

:cont
perl -i.bak -pe "s|<\?.+\?>|<\?xml version=\"1.0\" encoding=\"UTF-8\"\?>\r<\?xml-stylesheet type=\"text\/xsl\" href=\"G3300.xsl\"\?>|;" 68_1.xml

IF EXIST "68_1.xml" (
  copy /Y 68_1.xml G3300.xml
  del /F /Q 68_1.xml.bak
  del /F /Q 68_1.xml
  del /F /Q 68_1.xml.zip
  GOTO end
) ELSE (
  copy /Y 68_1.xml.bak 68_1.xml
  del /F /Q 68_1.xml.bak
  GOTO cont
)

:end
del /F /Q /Y *.
exit
