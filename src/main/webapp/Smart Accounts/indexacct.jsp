<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
.style4 {font-size:45px; font-weight:bold; text-decoration:outerline; font-family: "Times New Roman", "Trebuche MS", Verdana;}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<body  onpaste='return false;'>

<%
	String cpy = (String) session.getAttribute("ACCCOMPANY");
	String bch = (String) session.getAttribute("ACCBRANCH");
	
	String sesUserName=""+session.getAttribute("USRID"); 
	String EMPID=""+session.getAttribute("EMPID"); 
	if(sesUserName.equals("null") ||  sesUserName.equals("")) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
	String acccompanyid=""+session.getAttribute("ACCCOMPANY"); 
	String accbranchid=""+session.getAttribute("ACCBRANCH"); 
	String controlsql = "";
	controlsql ="SELECT CHR_COMPANYNAME FROM com_m_company WHERE INT_COMPANYID ="+acccompanyid;
	String cpyData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(controlsql);
	
	controlsql ="SELECT CHR_BRANCHNAME FROM com_m_branch WHERE INT_COMPANYID ="+acccompanyid +" AND INT_BRANCHID="+accbranchid; 
	String bData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(controlsql);
	if( "S".equals(""+session.getAttribute("USRTYPE"))) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
%>
<table width="100%" height="133" border="0" cellpadding="0"
	cellspacing="0"   class="headerBackground" >
	<!--DWLayoutTable-->
	<tr  class="headerImgBackground" >
    <td height="62" colspan="15"><div align="right"><img src="../images/top_banner.png"  height="62" /></div></td>
  </tr>
	<tr>
		<td width="35" height="14"></td>
		<td width="291"></td>
		<td width="131"></td>
		<td width="160"></td>
		<td width="221"></td>
		<td width="153"></td>
		<td width="9"></td>
	</tr>
	<tr>
		<td height="34" class="bold1">&nbsp;</td>
		<td valign="top" class="bold1">Welcome :: <%= sesUserName+" / "+com.my.org.erp.common.CommonFunctions.employeeName(EMPID)%> </td>
		<td colspan="3" class="bold1"><span class="bold1"><%=cpyData[0][0]%>@ <%=bData[0][0]%></span></td>
		<td valign="top">
		<table width="100%" border="0" cellpadding="3" cellspacing="3"
			frame="lhs" bordercolor="#202B78">
			<!--DWLayoutTable-->
			<tr>
				<td width="41" height="19" align="center" valign="middle"><a
					href="mailto:software@yahoo.co.in">Mail</a></td>
				<td width="44" align="center" valign="middle"><a href="../Home.jsp" target="_parent">Home</a></td>
				<td width="56" align="center" valign="middle"><a
					href="../Logout.jsp" target="_parent">Logout</a></td>
				<td></td>
			</tr>
		</table>		</td>
		<td></td>
	</tr>
	<tr>
	  <td height="23" colspan="7" class="bold1"><%@ include file="menu_Acct.jsp"%></td>
  </tr>
</table>
