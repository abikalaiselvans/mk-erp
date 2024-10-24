

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<%
	String sesUserName=""+session.getAttribute("USRID"); 
if(sesUserName.equals("null")) response.sendRedirect("../Login.jsp?loginmsg=Your Login Session has Expired");
%>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(../Image/bg.jpg);
	 
}
-->
</style><table width="100%" border="0" cellpadding="0"
	cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="25" colspan="7" valign="top">
		<table width="100%" height="25" border="0" cellpadding="0"
			cellspacing="0" >

			<tr>
				<td height="25" align="center"  >
				
				<h1> 
				
				<%
				String name[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_NAME from m_institution where INT_ID=1");
				//out.println(compName.toUpperCase()+ " - " +branchName.toUpperCase());
				%> </h1>			  </td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td width="45"  height="35">&nbsp;</td>
		<td width="1139"  valign="top" class="bold1"><h3>Welcome ::		</h3></td>
		 
		<td width="218" align="center"   valign="middle" class="bolddeepgreen"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#202B78"
			frame="lhs">
          <!--DWLayoutTable-->
          <tr>
            <td width="41" height="19" align="center" valign="middle"><a
					href="mailto:software@yahoo.co.in" class="bolddeepred">Mail</a></td>
            <td width="44" align="center" valign="middle"><a href="../Smart Attendance/iframeStaffMain.jsp"
					target="staffMain" class="bolddeepred">Home</a></td>
            <td width="56" align="center" valign="middle"><a
					href="../Logout.jsp" class="bolddeepred">Logout</a></td>
            <td></td>
          </tr>
        </table></td>
		<td width="9"></td>
	</tr>
	<tr>
	  <td  height="35">&nbsp;</td>
	  <td  valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
	  <td align="center"   valign="middle" class="bolddeepgreen"><!--DWLayoutEmptyCell-->&nbsp;</td>
	  <td></td>
  </tr>
	 
</table>
