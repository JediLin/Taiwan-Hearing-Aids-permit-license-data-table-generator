<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  extension-element-prefixes="date">
  <xsl:template match="/">
    <html>
    <head>
    <title>助聽器醫療器材許可證字號資料表</title>
    <style>
table thead th, table tbody td {
  padding: 5px;
  max-width: 20em;
}
table tbody tr:nth-child(2n) td {
  background: #ffcccc;
}
table tbody tr:nth-child(2n+1) td {
  background: #ccffff;
}
    </style>
    </head>
    <body>
      <table>
      	<caption>助聽器醫療器材許可證字號暨相關資訊｜製表日期：<xsl:value-of select="date:year()"/> 年 <xsl:value-of select="date:month-in-year()"/> 月 <xsl:value-of select="date:day-in-month()"/> 日</caption>
      	<thead>
      	  <tr><th>許可證字號</th><th>註銷狀態</th><th>有效日期</th><th>品名</th><th>醫器規格</th><th>申請商</th><th>製造商</th></tr>
      	</thead>
      	<tbody>
            <xsl:for-each select="dataList">
              <xsl:for-each select="rows">
              	<xsl:if test="醫器次類別一='G.3300 助聽器'">
                  <tr>
                    <td><xsl:value-of select = "許可證字號" /></td>
            <td><xsl:value-of select = "註銷日期" /><br /><xsl:value-of select = "註銷狀態" /><br /><xsl:value-of select = "註銷理由" /></td>
                    <td><xsl:value-of select = "發證日期" /><br />｜<br /><xsl:value-of select = "有效日期" /></td>
                    <td><xsl:value-of select = "中文品名" /><br /><xsl:value-of select = "英文品名" /></td>
                    <td><xsl:value-of select = "醫療器材級數" /> 級醫材<br /><xsl:value-of select = "醫器規格" /></td>
                    <td><xsl:value-of select = "申請商名稱" /><br />地址：<xsl:value-of select = "申請商地址" /></td>
                    <td><xsl:value-of select = "製造商名稱" /><br />廠址：<xsl:value-of select = "製造廠廠址" /><br /><xsl:value-of select = "製造廠公司地址" /><br />製造廠國別：<xsl:value-of select = "製造廠國別" /></td>
                  </tr>
                </xsl:if>
              </xsl:for-each>
          </xsl:for-each>
        </tbody>
      </table>
      <p>原始資料來源：<a href="https://data.gov.tw/dataset/9576">醫療器材許可證資料集｜政府資料開放平臺</a></p>
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>