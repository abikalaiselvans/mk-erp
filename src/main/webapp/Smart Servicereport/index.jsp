<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
%>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %><table width="100%" border="0" cellspacing="0" cellpadding="0"  id="header"  class="headerImgBackground" > 
  <tr  class="headerImgBackground" >
    <td  class="headerImgBackground"  align="right"> <img src="../images/top_banner.png"  height="62" /> </td>
  </tr>
  <tr>
    <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
          <tr   class="headerBackground" >
            <td width="258" height="25" align="center" valign="middle"><span class="boldgre">SERVICEREPORT </span></td>
            <td width="354" class="text_0">&nbsp;
			<%
	String sesUserName=""+session.getAttribute("USRID"); 
	String EMPID=""+session.getAttribute("EMPID"); 
	if(sesUserName.equals("null") ||  sesUserName.equals("")) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
			
	if( "S".equals(""+session.getAttribute("USRTYPE"))) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");		
%>
			 
            <span class="bold1">Welcome :: <%=com.my.org.erp.common.CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%>
            </span></td>
             
            <td width="639" align="right">
			 <a href="../chat/login.jsp" target="_blank" ><font class="boldEleven"><b>Chat</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="../Smart Help/helpmain.jsp" target="_blank" ><font class="boldEleven"><b>Help</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="mailto:<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILID FROM  m_institution WHERE INT_ID=1")[0][0]%>" ><font class="boldEleven"><b>Mail</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Home.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a> </td>
        </tr>
        </table></td>
  </tr>
  <tr   class="headerBackground" >
    <td height="27"   class="headerBackground"   id="menutd"><%@ include file="ServiceReport_menu.jsp"%></td>
  </tr>
</table>
