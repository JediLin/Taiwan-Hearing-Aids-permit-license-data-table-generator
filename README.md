# 台灣助聽器醫療器材許可證字號資料表產生器
![GitHub all releases](https://img.shields.io/github/downloads/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator/total?style=for-the-badge)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator?label=LATEST%20RELEASE&style=for-the-badge)
<br/>
![GitHub commits since tagged version](https://img.shields.io/github/commits-since/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator/latest?style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator?style=for-the-badge)
![GitHub issues](https://img.shields.io/github/issues/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator?style=for-the-badge)

台灣衛生福利部食品藥物管理署在政府資料開放平台上，每七天會發布更新醫療器材許可證資料集。我寫了一小段批次檔，用來自動下載 XML 格式的資料集，並且利用 [XSL Transformations (XSLT)](https://www.w3.org/TR/xslt/) 技術，從中擷取屬於助聽器（次類別為 `G.3300 助聽器` 的那些），以便查詢檢索。

## 下載

請下載[最新版套件](https://github.com/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator/releases/latest)，找 `G3300.zip` 那個連結。

使用前記得要解壓縮。

## 安裝‧環境設定

這是一個可攜帶、免安裝的工具，只需要把幾個必要的檔案放在同一個資料夾內，就可以使用了。最必要的檔案是 `update.bat` 和 `G3300.xsl`，另外還有幾個開源工具要分別下載：

- [Windows binaries of GNU Wget](https://eternallybored.org/misc/wget/)
  - 根據系統架構 (x86, x64, ARM64) 下載最新版的 EXE 檔案即可
  - 您應該會獲得一個 `wget.exe` 執行檔
  - 把 `wget.exe` 執行檔放到跟 `update.bat`, `G3300.xsl` 同一個資料夾
- [UnZip for Windows](https://gnuwin32.sourceforge.net/packages/unzip.htm)
  - 下載[最新版本的 Binaries](https://gnuwin32.sourceforge.net/downlinks/unzip-bin-zip.php)
  - 您應該會從 SourceForge 獲得 `unzip-5.51-1-bin.zip` 壓縮檔
  - 解壓縮 `unzip-5.51-1-bin.zip`
  - 從 `bin` 資料夾裡面找到 `unzip.exe` 執行檔
  - 把 `unzip.exe` 執行檔放到跟 `update.bat`, `G3300.xsl` 同一個資料夾
- [XMLStarlet command line XML toolkit](https://sourceforge.net/projects/xmlstar/)
  - 下載[最新版本](https://sourceforge.net/projects/xmlstar/files/latest/download)
  - 您應該會從 SourceForge 獲得 `xmlstarlet-1.6.1-win32.zip` 壓縮檔
  - 解壓縮 `xmlstarlet-1.6.1-win32.zip`
  - 從 `xmlstarlet-1.6.1` 資料夾裡面找到 `xml.exe` 執行檔
  - 把 `xml.exe` 執行檔放到跟 `update.bat`, `G3300.xsl` 同一個資料夾

這個步驟只需要做一次。上述開源工具中，除了 Wget 還有在更新之外，另外兩個都已經很久沒更新了。

如果缺少必要的檔案，在執行 `update.bat` 的時候也會提示，並且自動開啟預設瀏覽器到對應工具的下載網頁。

## 使用方法

- 執行 `update.bat` 即可自動下載最新的醫療器材許可證資料集，擷取資料及轉換檔案，在相同路徑位置儲存成 `G3300.html`，然後呼叫瀏覽器開啟。
- 如果不想更新資料，只想單純瀏覽檢視資料表，可以直接用任何網頁瀏覽器開啟 `G3300.html` 即可。
- 如果要把資料表傳給別人，只需要提供 `G3300.html` 檔案就夠了。

## 相關說明

請參考我的部落格文章：《[助聽器醫療器材許可字號](https://jedi.org/blog/archives/006216.html)》
