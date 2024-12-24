# 台灣助聽器醫療器材許可證字號資料表產生器
![GitHub all releases](https://img.shields.io/github/downloads/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator/total?style=for-the-badge)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator?label=LATEST%20RELEASE&style=for-the-badge)
<br/>
![GitHub commits since tagged version](https://img.shields.io/github/commits-since/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator/latest?style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator?style=for-the-badge)
![GitHub issues](https://img.shields.io/github/issues/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator?style=for-the-badge)

台灣衛生福利部食品藥物管理署（食藥署）在政府資料開放平台上，每七天自動發布更新醫療器材許可證資料集。我寫了一小段批次檔，用來自動下載 XML 格式的最新版本資料集，並且利用 [XSL Transformations (XSLT)](https://www.w3.org/TR/xslt/) 技術，從中擷取屬於助聽器（次類別為 `G.3300 助聽器` 的那些），以便查詢檢索。

註：如果需要各種身心障礙者輔具費用補助項目（**社政輔具**）的醫材許可證資料，請用[台灣社政輔具常見醫療器材許可證字號資料表產生器](https://github.com/JediLin/Taiwan-Assistive-Technology-medical-device-permit-license-data-table-generator)，產製涵蓋更多醫材類別的資料表。

## 下載

請下載[最新版套件](https://github.com/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator/releases/latest)，找 `G3300_full_x64.zip` 那個連結，這是對應目前大多數使用者 x64 架構作業系統的整合版本，解壓縮後[可以直接使用](#使用方法)；如果想要自己手動下載第三方工具，例如要用於不同架構的作業系統，也可以用 `G3300.zip` 連結並[手動準備相關環境](#安裝手動環境設定)。

使用前記得要解壓縮。

### 安裝‧手動環境設定

這是一個可攜帶、免安裝的工具，只需要把幾個必要的檔案放在同一個資料夾內，就可以使用了。最必要的檔案是 `update.bat` 和 `G3300.xsl`，另外還用到幾個開源工具（已經內含於 `G3300_full_x64.zip` ，不必另外下載）：

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

如果缺少必要的檔案，執行 `update.bat` 的時候會加以提示，並且自動開啟預設瀏覽器到對應工具的下載網頁，依上述說明把相關第三方工具放置到資料夾內，未來就可以持續使用。上述開源工具中，除了 Wget 還有在更新之外，另外兩個都已經很久沒更新了。

## 使用方法

- 執行 `update.bat` 即可自動下載最新的醫療器材許可證資料集，擷取資料及轉換檔案，在相同路徑位置儲存成 `G3300.html`，然後呼叫瀏覽器開啟。
- 如果不想更新資料，只想單純瀏覽檢視資料表，可以直接用任何網頁瀏覽器開啟 `G3300.html` 即可。
- 如果要把資料表傳給別人，只需要提供 `G3300.html` 檔案就夠了。
- 只有更新資料的時候需要網路連線，瀏覽、檢視、查詢資料表不需要網路，也可以把 `G3300.html` 檔案放在手機或平板電腦上使用（當然，螢幕太小可能不會很好用）。
- 執行 `scheduler.bat` 即可自動管理工作排程，例如設定自動更新資料表、測試工作排程、刪除已設定的排程項目等。

### 手動管理工作排程

- 如果需要排程自動更新資料表，可以使用 `silent_update.bat`
- 建議排程每個月或每季更新一次就可以了，太頻繁更新可能會被當成異常存取
- `silent_update.bat` 同樣會建立檔案備份及自動更新資料表，但過程中不提供任何訊息，操作完成後也不會自動用瀏覽器開啟資料表
- 最後一次執行 `silent_update.bat` 的相關訊息會儲存在 `silent_update.log` 日誌檔（這個檔案會自動建立及覆寫），如果遭遇異常可以用來釐清執行情況

手動在 Windows 設定工作排程的方法，不妨參考[我的部落格文章說明](https://jedi.org/blog/archives/006434.html#manual_schedule)，雖略有不同但大同小異。

## 版本沿革
### v2024.12.23
- 新增管理工作排程的 `scheduler.bat` 批次腳本
- 範例檔案更新

### v2024.12.07
- 修正瑕疵
- 簡化批次腳本
- 資料表新增許可證字號及品名欄位的「快查」功能，可合併使用
- 資料表呈現表格列數較多時，即使捲動內容，各欄標題也會保持在網頁最頂端，以便查詢對照
- 範例檔案更新

### v2024.12.06.2
- 修正瑕疵
- 資料表可根據使用者在作業系統設定的配色偏好，自動切換配色
- 新增可用於排程自動執行的 silent_update.bat 批次腳本，執行過程無訊息，相關執行歷程狀態會自動產生日誌檔
- 範例檔案更新

### v2024.12.06
- 修正瑕疵
- 在 Windows 10 或更新版本的作業系統上，進度訊息內容追加提供彩色顯示跟顏文字圖示
- 自動檢查是否能夠連線到政府開放資料平臺網站
- 範例檔案更新

### v2024.12.05
- 修正瑕疵
- 執行更新期間提供進度說明訊息
- 資料表底端提供下載最新版產生器、意見回饋等相關連結
- 資料表排版調整
- 範例檔案更新

### v2024.11.11-1
- 修正瑕疵
- 提供包含第三方工具的完整套件壓縮檔下載

### v2024.11.11
- 修正瑕疵
- 明確提供整個套件的壓縮檔下載
- 資料表新增許可證字號欄位「快查」功能
- 資料表排版調整
- 範例檔案更新

### v2024.11.01
- 修正瑕疵
- 執行更新時，會自動備份前一次產生的檔案
- 資料表標註製表日期及原始資料來源
- 範例檔案更新

### v2024.10.31-2
- 修正瑕疵
- 自動檢查有沒有漏掉 `G3300.xsl` 檔案
- 範例檔案更新

### v2024.10.31-1
- 不再依賴 Perl 或 WinZip Command Line 工具
- 自動檢查是否已經有完整的第三方工具 (Wget, UnZip, XMLStarlet)；如果沒有找到，就會用預設瀏覽器連到對應工具的下載網頁
- 輸出產製 HTML 格式的資料表
- 整合 CSS 樣式規則
- 執行更新成功後，自動用預設瀏覽器開啟資料表

### v2024.10.31
- 第一個公開版本

## 參考資料

- [《醫療器材分類分級管理辦法》第四條](https://law.moj.gov.tw/LawClass/LawSingle.aspx?pcode=L0030120&flno=4)附表
- [《身心障礙者輔具費用補助辦法》第四條](https://law.moj.gov.tw/LawClass/LawSingle.aspx?pcode=D0050060&flno=4)附表
- 《[助聽器醫療器材許可字號](https://jedi.org/blog/archives/006216.html)》部落格文章
