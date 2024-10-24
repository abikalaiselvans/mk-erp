<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style><%--<table id="footer" width="100%" border="0" cellspacing="0" cellpadding="0" class="paracopyright" align="center">
	<tr>
		<td height="50" >
		<hr class="linecolor">
		</td>
	</tr>
	<tr>
		<td height="50" align="center" class="paracopyright"></td>
	</tr>  
</table>--%>
 
 <div align="center">&copy; 2007 <a href="<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_WEBSITE FROM m_company")[0][0] %>" target="_blank" style="text-decoration:none" class="style2">  <%=CommonFunctions.QueryExecute("SELECT CHR_NAME FROM m_company  WHERE INT_CPYID=1")[0][0]%>  </a>&nbsp;&nbsp; All rights reserved.</div>