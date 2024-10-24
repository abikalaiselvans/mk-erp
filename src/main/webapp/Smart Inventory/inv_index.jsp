<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
%>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<table width="100%"  border="0" cellpadding="0" cellspacing="0"  id ="header"> 
  <tr  class="headerImgBackground" >
    <td><div align="right"><img src="../images/top_banner.png"  height="62" /></div></td>
  </tr>
  <tr>
    <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
          <tr   class="headerBackground" >
            <td width="198" height="25" align="center" valign="middle"><span class="boldgre">INVENTORY </span></td>
            <td width="228" class="text_0">&nbsp;
			<%
	String sesUserName=""+session.getAttribute("USRID"); 
	String EMPID=""+session.getAttribute("EMPID"); 
	if(sesUserName.equals("null") ||  sesUserName.equals("")) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
	String invcompanyid=""+session.getAttribute("INVCOMPANY"); 
	String invbranchid=""+session.getAttribute("INVBRANCH"); 
	if(invbranchid.equals("null") ||  invbranchid.equals("")) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
	
	
	String controlsql = "";
	controlsql ="SELECT CHR_COMPANYNAME FROM com_m_company WHERE INT_COMPANYID ="+invcompanyid;
	String cpyData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(controlsql);
	
	controlsql ="SELECT CHR_BRANCHNAME FROM com_m_branch WHERE INT_COMPANYID ="+invcompanyid +" AND INT_BRANCHID="+invbranchid; 
	String bData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(controlsql);
	
          
	if( "S".equals(""+session.getAttribute("USRTYPE"))) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");	  
		  
		      %>
            <span class="bold1">Welcome :: <%=com.my.org.erp.common.CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%>
            </span></td>
            <td width="246" align="right"   class="headerBackground" ><div align="center"><span class="bold1">
               <%=cpyData[0][0]%> @ <%=bData[0][0]%>
           </span> </div></td>
            <td width="303" align="right">
			 <font class="boldEleven"><a href="javascript:openCalc()" style="text-decoration:none"><img src="../Image/report/calculator.png" width="16" height="16" border="0" /></a></font>
			 
			 &nbsp;&nbsp;|&nbsp;&nbsp;<a href="../chat/login.jsp" target="_blank" > <b>Chat</b></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="../Smart Help/helpmain.jsp" target="_blank" ><font class="boldEleven"><b>Help</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="mailto:<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILID FROM  m_institution WHERE INT_ID=1")[0][0]%>" ><font class="boldEleven"><b>Mail</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Home.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a> </td>
        </tr>
        </table></td>
  </tr>
   <tr   class="headerBackground" >
    <td height="30"  id="menutd"><%@ include file="Inventory_menu.jsp"%></td>
  </tr>
</table>

 <script language="javascript">
 
function openCalc(query)
{  
	 
	 
	var width="300", height="270";
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left=50,top=50,screenX=50,screenY=50';
	newWindow = window.open('../Calculator/Calculator.html',"subWind",styleStr);
	newWindow.focus( );
}
 </script>
  