# 台灣助聽器醫療器材許可證字號資料表產生器
![GitHub all releases](https://img.shields.io/github/downloads/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator/total?style=for-the-badge)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator?label=LATEST%20RELEASE&style=for-the-badge)
<br/>
![GitHub commits since tagged version](https://img.shields.io/github/commits-since/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator/latest?style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator?style=for-the-badge)
![GitHub issues](https://img.shields.io/github/issues/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator?style=for-the-badge)

台灣衛生福利部食品藥物管理署在政府資料開放平台上，每七天會發布更新醫療器材許可證資料集。我寫了一小段批次檔，用來自動下載 XML 格式的資料集，並且利用 [XSL Transformations (XSLT)](https://www.w3.org/TR/xslt/) 技術，從中擷取屬於助聽器（次類別為 `G.3300 助聽器` 的那些），以便查詢檢索。

## 使用方法

- 首先要把 Perl 裝起來。
- 我還用到 [WinZip Command Line](https://www.winzip.com/en/download/command-line/) 工具來處理解壓縮……比較新的 Windows 版本已經內建可以解壓縮 zip 格式的 tar 工具，另外也有許多開源工具（例如 7-zip）可以做這件事，有需要可以自己修改 `update.bat` 內的指令。
- 執行 `update.bat` 即可自動下載（或更新）資料庫，做必要的編輯修改，然後在相同路徑位置儲存成 `G3300.xml`。
- 把 `G3300.xml`, `G3300.xsl`, `G3300.css` 三個檔案放在可以透過 http 或 https 通訊協定取用的地方，然後用網頁瀏覽器開啟 `G3300.xml` 即可。
  - 單純放在自己的硬碟上然後用瀏覽器開啟會有問題，因為 file 協定的安全性等級不同。
  - `G3300.xml` 檔案大小通常超過 200mb，瀏覽器載入到顯示要花一陣子，請有耐心。

## 相關說明

請參考我的部落格文章：《[助聽器醫療器材許可字號](https://jedi.org/blog/archives/006216.html)》
