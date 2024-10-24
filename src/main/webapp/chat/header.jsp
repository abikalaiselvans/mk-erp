<link href="chat.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style><div align="center">
<center>
<table width="100%" height="82" border="0" cellpadding="0" cellspacing="0">	
	<tr>
		<td width="100%" height="62" align="right" bgcolor="#003466" ><div align="right"><img src="../images/top_banner.png"  height="62" /></div></td>
	</tr>
	<tr>
		<td width="100%" height="50" align="right"   class="headerBackground"    >
		  
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="67%"><h1 align="center">&nbsp;CHAT
			  
			  <%
	String sesUserName=""+session.getAttribute("USRID"); 
	String EMPID=""+session.getAttribute("EMPID"); 
	if(sesUserName.equals("null") ||  sesUserName.equals("")) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
			
			
			
%>
			  </h1> </td>
              <td width="33%"><div align="right"><a href="login.jsp" target="_blank" ><font class="boldEleven"><b>Chat</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			      <a href="mailto:<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILID FROM  m_institution WHERE INT_ID=1")[0][0]%>" ><font class="boldEleven"><b>Mail</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			      
				  <%
				  if( !"S".equals(""+session.getAttribute("USRTYPE"))) 
				  {
				  %>
				   <a href="../Home.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				  <%
				  }
				  else
				  {
				  %>
				  <a href="../Staff/Utilitymain.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				  <%
				  }
				  %>
			 
				 
		      <a href="../Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a> </div></td>
            </tr>
          </table>
		</td>
	</tr>
</table>
</center>
</div>
<br>