
 
 <%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
%>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
 <table width="100%" border="0" cellspacing="0" cellpadding="0"  id="header"> 
  <tr  class="headerImgBackground" >
    <td align="right"><img src="../images/top_banner.png"  height="62" /></td>
  </tr>
  <tr>
    <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
          <tr   class="headerBackground" >
            <td  height="25" align="center" valign="middle"><span class="boldgre">ATTENDANCE </span></td>
            <td  class="text_0">&nbsp;
			<%
	
	String sesUserName=(""+session.getAttribute("USRID")).trim(); 
	String EMPID=""+session.getAttribute("EMPID"); 
	
	


	
	if("null".equalsIgnoreCase(sesUserName) ||  sesUserName.equals("")) 
	{
	
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
			//RequestDispatcher dispatchers = request.getRequestDispatcher("../Login.jsp?loginmsg=Login Expired");
    		//dispatchers.forward(request, response); 
			 
	
	}
	
	
	if( "S".equals(""+session.getAttribute("USRTYPE"))) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
			
			
              %>
            
			 
			<span class="bold1">Welcome :: <%=com.my.org.erp.common.CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%>
            </span></td>
            <td align="right"   class="headerBackground" ><div align="center"><span class="bold1">
               
           </span> </div></td>
            <td 
			 align="right">
			 <a href="../chat/login.jsp" target="_blank" ><font class="boldEleven"><b>Chat</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="../Smart Help/helpmain.jsp" target="_blank" ><font class="boldEleven"><b>Help</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="mailto:<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILID FROM  m_institution WHERE INT_ID=1")[0][0]%>" ><font class="boldEleven"><b>Mail</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Home.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a> </td>
        </tr>
        </table></td>
  </tr>
  <tr   class="headerBackground" >
    <td height="30" bgcolor="#FFFFFF"    class="headerBackground"   id="menutd"><%@ include file="atten_menu.jsp"%></td>
  </tr>
</table>

 
  