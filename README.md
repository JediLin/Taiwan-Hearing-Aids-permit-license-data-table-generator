# 台灣社政輔具常見醫療器材許可證字號資料表產生器
![GitHub all releases](https://img.shields.io/github/downloads/JediLin/Taiwan-Assistive-Technology-medical-device-permit-license-data-table-generator/total?style=for-the-badge)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/JediLin/Taiwan-Assistive-Technology-medical-device-permit-license-data-table-generator?label=LATEST%20RELEASE&style=for-the-badge)
<br/>
![GitHub commits since tagged version](https://img.shields.io/github/commits-since/JediLin/Taiwan-Assistive-Technology-medical-device-permit-license-data-table-generator/latest?style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/JediLin/Taiwan-Assistive-Technology-medical-device-permit-license-data-table-generator?style=for-the-badge)
![GitHub issues](https://img.shields.io/github/issues/JediLin/Taiwan-Assistive-Technology-medical-device-permit-license-data-table-generator?style=for-the-badge)

台灣衛生福利部食品藥物管理署（食藥署）在政府資料開放平台上，每七天自動發布更新醫療器材許可證資料集。我寫了一小段批次檔，用來自動下載 XML 格式的最新版本資料集，並且利用 [XSL Transformations (XSLT)](https://www.w3.org/TR/xslt/) 技術，從中擷取屬於社政輔具常見的那些醫療器材次類別（詳見[底下清單](#社政輔具常見醫療器材次類別)），以便查詢檢索。

註：如果只需要**助聽器**部分的醫材許可證資料，可以改用[台灣助聽器醫療器材許可證字號資料表產生器](https://github.com/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator)，產製檔案較小的資料表。

## 下載

請下載[最新版套件](https://github.com/JediLin/Taiwan-Assistive-Technology-medical-device-permit-license-data-table-generator/releases/latest)，找 `AT_permit_full_x64.zip` 那個連結，這是對應目前大多數使用者 x64 架構作業系統的整合版本，解壓縮後[可以直接使用](#使用方法)；如果想要自己手動下載第三方工具，例如要用於不同架構的作業系統，也可以用 `AT_permit.zip` 連結並[手動準備相關環境](#安裝手動環境設定)。

使用前記得要解壓縮。

### 安裝‧手動環境設定

這是一個可攜帶、免安裝的工具，只需要把幾個必要的檔案放在同一個資料夾內，就可以使用了。最必要的檔案是 `update.bat` 和 `AT.xsl`，另外還用到幾個開源工具（已經內含於 `AT_permit_full_x64.zip` ，不必另外下載）：

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

- 執行 `update.bat` 即可自動下載最新的醫療器材許可證資料集，擷取資料及轉換檔案，在相同路徑位置儲存成 `AT.html`，然後呼叫瀏覽器開啟。
- 如果不想更新資料，只想單純瀏覽檢視資料表，可以直接用任何網頁瀏覽器開啟 `AT.html` 即可。
- 如果要把資料表傳給別人，只需要提供 `AT.html` 檔案就夠了。
- 只有更新資料的時候需要網路連線，瀏覽、檢視、查詢資料表不需要網路，也可以把 `AT.html` 檔案放在手機或平板電腦上使用（當然，螢幕太小可能不會很好用）。
- 執行 `scheduler.bat` 即可自動管理工作排程，例如設定自動更新資料表、測試工作排程、刪除已設定的排程項目等。

### 手動管理工作排程

- 如果需要排程自動更新資料表，可以使用 `silent_update.bat`
- 建議排程每個月或每季更新一次就可以了，太頻繁更新可能會被當成異常存取
- `silent_update.bat` 同樣會建立檔案備份及自動更新資料表，但過程中不提供任何訊息，操作完成後也不會自動用瀏覽器開啟資料表
- 最後一次執行 `silent_update.bat` 的相關訊息會儲存在 `silent_update.log` 日誌檔（這個檔案會自動建立及覆寫），如果遭遇異常可以用來釐清執行情況

手動在 Windows 設定工作排程的方法，請參考[我的部落格文章說明](https://jedi.org/blog/archives/006434.html#manual_schedule)。

## 社政輔具常見醫療器材次類別

目前這個產生器納入下列醫療器材次類別，如果實務工作上需要增減，請[不吝提出](https://github.com/JediLin/Taiwan-Assistive-Technology-medical-device-permit-license-data-table-generator/issues)。

- D.5273 呼吸道正壓供應系統
- D.5280 呼吸管路支撐物
- D.5330 呼吸氣體混合器
- D.5440 手提式氧氣產生器
- D.5630 噴霧器
- G.0001 人工耳蝸植入器
- G.3300 助聽器
- I.4780 動力式抽吸幫浦
- M.5844 矯正鏡片
- M.5916 硬式透氣隱形眼鏡
- M.5925 軟式隱形眼鏡
- O.3025 義肢及裝具用附件
- O.3075 醫療用手杖
- O.3100 機械椅
- O.3150 醫療用柺杖
- O.3175 浮動坐墊
- O.3410 體外肢體裝具用組件
- O.3420 體外肢體義肢用組件
- O.3450 動力式上肢義肢
- O.3475 肢體裝具
- O.3480 動力式下肢外骨骼肢體裝具
- O.3490 軀幹裝具
- O.3500 體外組裝下肢義肢
- O.3800 醫療用電動代步器
- O.3825 機械式助行器
- O.3850 機械式輪椅
- O.3860 動力式輪椅
- O.3880 特製輪椅
- O.3890 爬梯式輪椅
- O.3900 站立式輪椅
- O.3930 移動式輪椅升降器
- O.5150 動力式病患輸送機
- O.5160 氣流床
- O.5170 動力式氣流漂浮治療床
- O.5180 手動式病人翻身床
- O.5225 動力式病人翻身床

註：整理過程中我發現有少數醫療器材許可資料缺少次類別，這是屬於食藥署的管理問題，在此不做處理；因為這樣的原因，如果遇到這種情況，建議還是要回到食藥署的[醫療器材許可證查詢網站](https://lmspiq.fda.gov.tw/web/MDPIQ/license-search)或食藥署委託工業技術研究院（工研院）建置的[醫療器材許可證資料庫網站](https://mdlicense.itri.org.tw/MDDB/Classification/ClassDB.aspx)查詢確認為宜。

## 版本沿革
### v2026.03.14
- 更新食藥署醫療器材許可證及登錄查詢連結、《醫療器材分類分級管理辦法》及《身心障礙者輔具費用補助辦法》連結
- 範例檔案更新

### v2026.01.17
- 因應食藥署 XML 檔案格式異常，改為先嘗試修正 XML 格式再進行轉換，以免產生空檔案
- 範例檔案更新

### v2024.12.23
- 新增管理工作排程的 `scheduler.bat` 批次腳本
- 範例檔案更新

### v2024.12.07.1
- 修正瑕疵
- 簡化批次腳本
- 資料表新增品名欄位的「快查」功能，可與原本許可證字號、醫材類別的快查功能合併使用
- 範例檔案更新

### v2024.12.07
- 修正瑕疵
- 資料表新增醫材類別欄位的「快查」功能，可與原本許可證字號的快查功能合併使用
- 資料表呈現表格列數較多時，即使捲動內容，各欄標題也會保持在網頁最頂端，以便查詢對照
- 範例檔案更新

### v2024.12.06.2
- 修正瑕疵
- 資料表可根據使用者在作業系統設定的配色偏好，自動切換配色
- 範例檔案更新

### v2024.12.06.1
- 修正瑕疵
- 新增可用於排程自動執行的 `silent_update.bat` 批次腳本，執行過程無訊息，相關執行歷程狀態會自動產生日誌檔
- 範例檔案更新

### v2024.12.06
- 修正瑕疵
- 在 Windows 10 或更新版本的作業系統上，進度訊息內容追加提供彩色顯示跟顏文字圖示
- 自動檢查是否能夠連線到政府開放資料平臺網站
- 範例檔案更新

### v2024.12.05
- 第一個公開版本

## 參考資料

- [《醫療器材分類分級管理辦法》第四條](https://law.moj.gov.tw/LawClass/LawSingle.aspx?pcode=L0030120&flno=4)附表
- [《身心障礙者輔具費用補助辦法》第四條](https://law.moj.gov.tw/LawClass/LawSingle.aspx?pcode=D0050060&flno=4)附表
- [台灣助聽器醫療器材許可證字號資料表產生器](https://github.com/JediLin/Taiwan-Hearing-Aids-permit-license-data-table-generator)
