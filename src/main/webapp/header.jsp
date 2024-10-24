 <%@ include file="JavaScript/dynamicStylesheet.jsp" %><style type="text/css">
 <%
			// class="headerImgBackground"  
	 String sesUserName=(""+session.getAttribute("USRID")).trim(); 
	 String EMPID=""+session.getAttribute("EMPID"); 
	if("null".equalsIgnoreCase(sesUserName) ||  sesUserName.equals("")) 
	{
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
 	}
             
	 
	if( "S".equals(""+session.getAttribute("USRTYPE"))) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
	          %>	
			  
 <!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

<%-- /*<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="header"> 
  <tr bgcolor="#41bc81"  >
    <td bgcolor="#41bc81"><div align="right"><img src="images/top_banner.png"  height="62" /></div></td>
  </tr>
  <tr>
    <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
          <tr   class="headerBackground" >
            <td width="14%"   height="25" align="center" valign="middle"> ERP </span> </td>
            <td width="22%"   class="text_0">&nbsp;
			  
			  
            <span class="bold1">Welcome :: <%=com.my.org.erp.common.CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%>
            </span></td>
            <td width="24%"   align="right"   class="headerBackground" ><div align="center"><span class="bold1">
               
           </span> </div></td>
            <td width="40%"  align="right">
			 
			 </td>
        </tr>
        </table></td>
  </tr>
   
</table> 
 */ --%>