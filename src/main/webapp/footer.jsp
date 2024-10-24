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
</style><table id="footer" width="100%" border="0" cellspacing="0" cellpadding="0" class="paracopyright" align="center">
	<tr>
		<td height="50" >
		<hr class="linecolor">
		</td>
	</tr>
	<tr>
		<td height="50" align="center" class="paracopyright"><div align="center">&copy; 2007 <a href="<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_WEBSITE FROM m_company")[0][0] %>" target="_blank" style="text-decoration:none" class="style2">  <%=CommonFunctions.QueryExecute("SELECT CHR_NAME FROM m_company  WHERE INT_CPYID=1")[0][0]%>  </a>&nbsp;&nbsp; All rights reserved.</div></td>
	</tr>  
</table>
 
 
 <% 
 
	response.setHeader("Cache-Control","no-cache");//HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching 
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1 
	System.out.println("=============="+"SELECT CHR_ALERT_REQUIRED FROM m_user  WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'");
	if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ALERT_REQUIRED FROM m_user  WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'")[0][0]))
	{
		out.println("<center>");
		out.println("<font class='bolddeepred'>");
		out.println(CommonFunctions.QueryExecute("SELECT CHR_MESSAGE FROM  m_alertmessage WHERE INT_ROWID = 1")[0][0]);
		out.println("<br>Do not show again Please <a href=\"javascript:messageHide('"+session.getAttribute("USRID")+"')\">Clik me</a> ");
		out.println("</font>");
		out.println("<center>");
		out.println("<br /><br /><br />");
	}
	 
%>

<script language="javascript">
function messageHide(userid)
{
	var f ="../SmartLoginAuth?filename=PasswordReSet&actionS=UTIMessageHide&userid="+userid;
	newWindow = window.open(f,"subWind",",,height=300,width=450,top=0,left=0");
	newWindow.focus( );
}	
	</script>