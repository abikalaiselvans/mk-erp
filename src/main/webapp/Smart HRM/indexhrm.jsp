
 
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<table width="100%" height="106" border="0" cellpadding="0" cellspacing="0"  id="header"> 
  <tr  class="headerImgBackground">
    <td height="62"><div align="right"><img src="../images/top_banner.png"  height="62" /></div></td>
  </tr>
  <tr>
    <td bgcolor="#F4BAAA"><table width="100%" height="20" border="0" cellpadding="0" cellspacing="0" class="headerBackground" >
          <tr >
            <td width="180" height="20" align="center" valign="middle"><span class="boldgre">HRM </span></td>
            <td width="279" class="text_0">&nbsp;
<%
	String sesUserName=""+session.getAttribute("USRID"); 
	if(sesUserName.equals("null") ) 
		response.encodeRedirectURL("../Login.jsp?loginmsg=Your Login Session has Expired");
		

%>
            <span class="bold1">Welcome :: <%=com.my.org.erp.common.CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%>
            </span></td>
            <td width="357" align="right"><div align="center"><span class="bold1">
              
           </span> </div></td>
            <td width="435" align="right">
			 <a href="../chat/login.jsp" target="_blank" ><font class="boldEleven"><b>Chat</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="../Smart Help/helpmain.jsp" target="_blank" ><font class="boldEleven"><b>Help</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="mailto:<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILID FROM  m_institution WHERE INT_ID=1")[0][0]%>" ><font class="boldEleven"><b>Mail</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Home.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a> </td>
        </tr>
    </table></td>
  </tr>
  <tr class="headerBackground"  >
    <td width="50"  id="menutd"><%@ include file="menu_hrm.jsp"%>&nbsp;</td>
  </tr>
</table>
   



