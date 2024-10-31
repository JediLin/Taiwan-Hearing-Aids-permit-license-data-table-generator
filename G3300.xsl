<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
    <head>
    <link rel="Stylesheet" href="G3300.css" type="text/css" />
    <title>助聽器醫療器材許可證字號</title>
    </head>
    <body>
      <table>
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
                    <td><xsl:value-of select = "醫療器材級數" />級醫材<br /><xsl:value-of select = "醫器規格" /></td>
                    <td><xsl:value-of select = "申請商名稱" /><br /><xsl:value-of select = "申請商地址" /></td>
                    <td><xsl:value-of select = "製造商名稱" /><br /><xsl:value-of select = "製造廠廠址" /><br /><xsl:value-of select = "製造廠公司地址" /><br /><xsl:value-of select = "製造廠國別" /></td>
                  </tr>
                </xsl:if>
              </xsl:for-each>
          </xsl:for-each>
        </tbody>
      </table>
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>